From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 5 Dec 2019 18:51:34 +0000
Subject: [cip-dev] [PATCH linux-4.4.y-cip v3] gpiolib: Fix bad of_node
 pointer
In-Reply-To: <1575553177-23044-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1575553177-23044-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TYAPR01MB2285A3EC80223FE434CEBC4EB75C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello,

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 05 December 2019 13:40
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
> Hi guys,
> 
> sorry for the trouble.
> v2 broke Intel builds (thank you Chris for spotting this), v3 fixes that.

I've tested v3 (current linux-v4.4.y-cip 7b4a8ef7 + a revert for v2) and all builds pass:
https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/100999517

> Are you happy to replace v2 with v3 on linux-4.4.y-cip?

I guess this depends on CIP's rules on force-pushing ??

Kind regards, Chris

> 
> Thanks,
> Fab
> 
> v2->v3:
> * v2 was accessing chip->of_node regardless of CONFIG_OF_GPIO
>   being enabled or not. v3 compiles that out in case CONFIG_OF_GPIO
>   is not enabled.
> v1->v2:
> * v1 was for testing purposes only, but no point in sending
>   out a dirty patch, therefore cleaned it up
> ---
>  drivers/gpio/gpiolib-of.c | 2 +-
>  drivers/gpio/gpiolib.c    | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index ec642bf..6fa1818 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -338,7 +338,7 @@ static void of_gpiochip_init_valid_mask(struct
> gpio_chip *chip)
>  {
>  	int len, i;
>  	u32 start, count;
> -	struct device_node *np = chip->dev->of_node;
> +	struct device_node *np = chip->of_node;
> 
>  	len = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
>  	if (len < 0 || len % 2 != 0)
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index d72218f..516498e 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -296,7 +296,7 @@ static int gpiochip_init_valid_mask(struct gpio_chip
> *gpiochip)
>  {
>  #ifdef CONFIG_OF_GPIO
>  	int size;
> -	struct device_node *np = gpiochip->dev->of_node;
> +	struct device_node *np = gpiochip->of_node;
> 
>  	size = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
>  	if (size > 0 && size % 2 == 0)
> @@ -360,6 +360,11 @@ int gpiochip_add_data(struct gpio_chip *chip, void
> *data)
> 
>  	chip->data = data;
> 
> +#ifdef CONFIG_OF_GPIO
> +	if ((!chip->of_node) && (chip->dev))
> +		chip->of_node = chip->dev->of_node;
> +#endif
> +
>  	spin_lock_irqsave(&gpio_lock, flags);
> 
>  	if (base < 0) {
> --
> 2.7.4
