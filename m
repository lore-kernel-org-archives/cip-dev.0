From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 11 Nov 2019 09:49:17 +0000
Subject: [cip-dev] [RFT/RFC linux-4.4.y-cip v2] gpiolib: Fix bad of_node
 pointer
In-Reply-To: <1573231609-25023-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1573231609-25023-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TY1PR01MB177031AE5F473C0A0B0D9FBAC0740@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi guys,

We have got a good feedback from Johnson, what do you think
about this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 08 November 2019 16:47
> Subject: [cip-dev][RFT/RFC linux-4.4.y-cip v2] gpiolib: Fix bad of_node pointer
> 
> Not every driver initialises of_node from struct gpio_chip,
> therefore the replacement of of_node from struct gpio_chip
> with dev->of_node in the below commit won't work on every
> platform:
> baff4777cdb8 ("gpiolib: Support 'gpio-reserved-ranges' property")
> The final result is that on some platforms the kernel will
> try to dereference a NULL pointer, with obvious consequences.
> 
> This patch makes sure the pointer gets initialised before its
> first usage.
> 
> Fixes: baff4777cdb8 ("gpiolib: Support 'gpio-reserved-ranges' property")
> Reported-by: Johnson CH Chen <JohnsonCH.Chen@moxa.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> ---
> v1->v2:
> * v1 was for testing purposes only, but no point in sending
>   out a dirty patch, therefore cleaned it up
> ---
>  drivers/gpio/gpiolib-of.c | 2 +-
>  drivers/gpio/gpiolib.c    | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index ec642bf..6fa1818 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -338,7 +338,7 @@ static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
>  {
>  	int len, i;
>  	u32 start, count;
> -	struct device_node *np = chip->dev->of_node;
> +	struct device_node *np = chip->of_node;
> 
>  	len = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
>  	if (len < 0 || len % 2 != 0)
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index d72218f..820e3e3d 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -296,7 +296,7 @@ static int gpiochip_init_valid_mask(struct gpio_chip *gpiochip)
>  {
>  #ifdef CONFIG_OF_GPIO
>  	int size;
> -	struct device_node *np = gpiochip->dev->of_node;
> +	struct device_node *np = gpiochip->of_node;
> 
>  	size = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
>  	if (size > 0 && size % 2 == 0)
> @@ -360,6 +360,9 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
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
