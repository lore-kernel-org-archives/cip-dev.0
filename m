From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 11 Nov 2019 09:48:04 +0000
Subject: [cip-dev] [RFT/RFC linux-4.4.y-cip] gpiolib: Fix bad of_node
 pointer
In-Reply-To: <HK0PR01MB35215EB8C89C5B0B23F876D5FA740@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
References: <1573231008-24239-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<HK0PR01MB35215EB8C89C5B0B23F876D5FA740@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
Message-ID: <TY1PR01MB17709E977269C93BC79A1866C0740@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Thank you for testing!

Cheers,
Fab

> -----Original Message-----
> From: Johnson CH Chen (???) <JohnsonCH.Chen@moxa.com>
> Sent: 11 November 2019 03:36
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>; cip-dev at lists.cip-project.org
> Cc: nobuhiro1.iwamatsu at toshiba.co.jp; pavel at denx.de; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>
> Subject: RE: [cip-dev][RFT/RFC linux-4.4.y-cip] gpiolib: Fix bad of_node pointer
> 
> Hi Fab,
> 
> This patch is good for my system (ls1021a), so many thanks!
> 
> Thanks,
> Johnson
> 
> -----Original Message-----
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: Saturday, November 9, 2019 12:37 AM
> To: cip-dev at lists.cip-project.org
> Cc: nobuhiro1.iwamatsu at toshiba.co.jp; pavel at denx.de; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>; Fabrizio Castro <fabrizio.castro@bp.renesas.com>; Johnson CH Chen (???)
> <JohnsonCH.Chen@moxa.com>
> Subject: [cip-dev][RFT/RFC linux-4.4.y-cip] gpiolib: Fix bad of_node pointer
> 
> Not every driver initialises of_node from struct gpio_chip, therefore the replacement of of_node from struct gpio_chip with dev-
> >of_node in the below commit won't work on every
> platform:
> baff4777cdb8 ("gpiolib: Support 'gpio-reserved-ranges' property") The final result is that on some platforms the kernel will try to
> dereference a NULL pointer, with obvious consequences.
> 
> This patch makes sure the pointer gets initialised before its first usage.
> 
> Fixes: baff4777cdb8 ("gpiolib: Support 'gpio-reserved-ranges' property")
> Reported-by: Johnson CH Chen <JohnsonCH.Chen@moxa.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
> 
> Hi Johnson,
> 
> could you please test this patch on your system?
> 
> Thanks,
> Fab
> 
> 
>  drivers/gpio/gpiolib-of.c | 4 +++-
>  drivers/gpio/gpiolib.c    | 6 +++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c index ec642bf..36b60dd 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -338,7 +338,7 @@ static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)  {
>  	int len, i;
>  	u32 start, count;
> -	struct device_node *np = chip->dev->of_node;
> +	struct device_node *np = chip->of_node;
> 
>  	len = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
>  	if (len < 0 || len % 2 != 0)
> @@ -445,8 +445,10 @@ int of_gpiochip_add(struct gpio_chip *chip)  {
>  	int status;
> 
> +	/*
>  	if ((!chip->of_node) && (chip->dev))
>  		chip->of_node = chip->dev->of_node;
> +	*/
> 
>  	if (!chip->of_node)
>  		return 0;
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c index d72218f..0fd443a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -296,7 +296,7 @@ static int gpiochip_init_valid_mask(struct gpio_chip *gpiochip)  {  #ifdef CONFIG_OF_GPIO
>  	int size;
> -	struct device_node *np = gpiochip->dev->of_node;
> +	struct device_node *np = gpiochip->of_node;
> 
>  	size = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
>  	if (size > 0 && size % 2 == 0)
> @@ -354,12 +354,16 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
>  	int		base = chip->base;
>  	struct gpio_desc *descs;
> 
> +
>  	descs = kcalloc(chip->ngpio, sizeof(descs[0]), GFP_KERNEL);
>  	if (!descs)
>  		return -ENOMEM;
> 
>  	chip->data = data;
> 
> +	if ((!chip->of_node) && (chip->dev))
> +		chip->of_node = chip->dev->of_node;
> +
>  	spin_lock_irqsave(&gpio_lock, flags);
> 
>  	if (base < 0) {
> --
> 2.7.4
