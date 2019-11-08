From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 8 Nov 2019 13:18:30 +0000
Subject: [cip-dev] [PATCH] gpiolib: Support 'gpio-reserved-ranges'
 property
In-Reply-To: <HK0PR01MB35212249E99AB47FA9830B6CFA7B0@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
References: <HK0PR01MB35212249E99AB47FA9830B6CFA7B0@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
Message-ID: <TY1PR01MB1770B2AC0DCF960F29247C38C07B0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Johnson,

Thank you for reporting this.

> From: Johnson CH Chen (???) <JohnsonCH.Chen@moxa.com>
> Subject: [cip-dev] [PATCH] gpiolib: Support 'gpio-reserved-ranges' property
> 
> Hi Fabrizio Castro,
> 
> 
> 
> I find a kernel panic issue by gpio when I upgrade kernel to 4.4.182-cip34 with Freescale LS1021A (gpiochip is mpc8xxx series):
> 
> 
> 
> Kernel log shows ?Unable to handle kernel NULL pointer dereference at virtual address 000000b4.?
> 
> 
> 
> Subsequently, I find the commit baff4777cdb80256cd24dede2a3d0af761356307 (gpiolib: Support 'gpio-reserved-ranges' property)
> could result in kernel panic because the code ?*np= chip->dev->of_node? is executed when chip->dev is NULL:
> 
> 
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> 
> index 5fe34a9df3e6..ec642bf1d976 100644
> 
> --- a/drivers/gpio/gpiolib-of.c
> 
> +++ b/drivers/gpio/gpiolib-of.c
> 
> 
> 
> +static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
> 
> +{
> 
> +      int len, i;
> 
> +      u32 start, count;
> 
> +      struct device_node *np = chip->dev->of_node;
> 
> +
> 
> +      len = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
> 
> +      if (len < 0 || len % 2 != 0)
> 
> +              return;
> 
> +
> 
> +      for (i = 0; i < len; i += 2) {
> 
> +              of_property_read_u32_index(np, "gpio-reserved-ranges",
> 
> +                                         i, &start);
> 
> +              of_property_read_u32_index(np, "gpio-reserved-ranges",
> 
> +                                         i + 1, &count);
> 
> +              if (start >= chip->ngpio || start + count >= chip->ngpio)
> 
> +                      continue;
> 
> +
> 
> +              bitmap_clear(chip->valid_mask, start, count);
> 
> +      }
> 
> +};
> 
> +
> 
> 
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> 
> index adb474089733..487a86495163 100644
> 
> --- a/drivers/gpio/gpiolib.c
> 
> +++ b/drivers/gpio/gpiolib.c
> 
> @@ -292,6 +292,43 @@ static unsigned long *gpiochip_allocate_mask(struct gpio_chip *chip)
> 
>       return p;
> 
> }
> 
> 
> 
> +static int gpiochip_init_valid_mask(struct gpio_chip *gpiochip)
> 
> +{
> 
> +#ifdef CONFIG_OF_GPIO
> 
> +      int size;
> 
> +      struct device_node *np = gpiochip->dev->of_node;
> 
> +
> 
> +      size = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
> 
> +      if (size > 0 && size % 2 == 0)
> 
> +              gpiochip->need_valid_mask = true;
> 
> +#endif
> 
> +
> 
> +      if (!gpiochip->need_valid_mask)
> 
> +              return 0;
> 
> +
> 
> +      gpiochip->valid_mask = gpiochip_allocate_mask(gpiochip);
> 
> +      if (!gpiochip->valid_mask)
> 
> +              return -ENOMEM;
> 
> +
> 
> +      return 0;
> 
> +}
> 
> +
> 
> 
> 
> Could you help me understand why we need to replaced chip->of_node with chip->dev->of_node?

It looks like that solved the issues I was seeing, but it was short sighted as some drivers don't
initialize that.

I think I need to make some adjustments to this patch, and I also think I need to backport patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.4-rc6&id=6ff0497402ef7269ee6a72f62eb85adaa7a4768e

I need to make a couple of experiments, and I'll send something across for you to try if you don't
mind.

Thanks,
Fab

> 
> 
> 
> The following two items I try have no kernel panic:
> 
> 
> 
> 1. For gpio drivers:
> 
> 
> 
> It?s fine and no kernel panic issue if probe(struct platform_device *pdev) in gpio drivers executes the following codes:
> 
> 
> 
> struct cpio_chip *gc;
> 
> gc->dev = &pdev->dev; //Put platform?s dev to gpiochip?s dev, and of_node info in pdev->dev->of_node also put in gpiochip
> structure.
> 
> 
> 
> But some gpio drivers doesn?t do this, such as gpio-mpc8xxx.c (mpc8xxx series), and result in kernel panic when use this commit.
> 
> 
> 
> 2. For gpiolib:
> 
> 
> 
> //set the following code in gpiolib.c and gpiolib-of.c
> 
> struct device_node *np = gpiochip->of_node;
> 
> 
> 
> Device node of platform will put in gpio chip when of_mm_gpiochip_add() is executed:
> 
> 
> 
> int of_mm_gpiochip_add(struct device_node *np,
> 
>                        struct of_mm_gpio_chip *mm_gc)
> 
> {
> 
>         int ret = -ENOMEM;
> 
>         struct gpio_chip *gc = &mm_gc->gc;
> 
> ?..
> 
>         mm_gc->gc.of_node = np;
> 
> }
> 
> 
> 
> It?s seems chip->of_node is good.
> 
> 
> 
> Thanks,
> 
> Johnson
