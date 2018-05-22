From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 22 May 2018 16:41:33 +0000
Subject: [cip-dev] [PATCH 7/7] gpio: rcar: Add Runtime PM handling for
 interrupts
In-Reply-To: <1526383197-5913-8-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1526383197-5913-8-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TY1PR01MB1770F43F7952056F40F2C223C0940@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

I would like to drop this patch. I am preparing a new version of this patch suitable for 4.4 stable to send to Greg. I'll put you in copy.

Thanks,
Fab

> -----Original Message-----
> From: Fabrizio Castro [mailto:fabrizio.castro at bp.renesas.com]
> Sent: 15 May 2018 12:20
> To: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Cc: cip-dev at lists.cip-project.org; Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>; Fabrizio
> Castro <fabrizio.castro@bp.renesas.com>
> Subject: [cip-dev][PATCH 7/7] gpio: rcar: Add Runtime PM handling for interrupts
>
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> The R-Car GPIO driver handles Runtime PM for requested GPIOs only.
>
> When using a GPIO purely as an interrupt source, no Runtime PM handling
> is done, and the GPIO module's clock may not be enabled.
>
> To fix this:
>   - Add .irq_request_resources() and .irq_release_resources() callbacks
>     to handle Runtime PM when an interrupt is requested,
>   - Add irq_bus_lock() and sync_unlock() callbacks to handle Runtime PM
>     when e.g. disabling/enabling an interrupt, or configuring the
>     interrupt type.
>
> Fixes: d5c3d84657db57bd "net: phy: Avoid polling PHY with PHY_IGNORE_INTERRUPTS"
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> (cherry picked from commit b26a719bdba9aa926ceaadecc66e07623d2b8a53)
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  drivers/gpio/gpio-rcar.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index 75b2f2c..e38d97d 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -196,6 +196,44 @@ static int gpio_rcar_irq_set_wake(struct irq_data *d, unsigned int on)
>  return 0;
>  }
>
> +static void gpio_rcar_irq_bus_lock(struct irq_data *d)
> +{
> +struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +struct gpio_rcar_priv *p = gpiochip_get_data(gc);
> +
> +pm_runtime_get_sync(&p->pdev->dev);
> +}
> +
> +static void gpio_rcar_irq_bus_sync_unlock(struct irq_data *d)
> +{
> +struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +struct gpio_rcar_priv *p = gpiochip_get_data(gc);
> +
> +pm_runtime_put(&p->pdev->dev);
> +}
> +
> +
> +static int gpio_rcar_irq_request_resources(struct irq_data *d)
> +{
> +struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +struct gpio_rcar_priv *p = gpiochip_get_data(gc);
> +int error;
> +
> +error = pm_runtime_get_sync(&p->pdev->dev);
> +if (error < 0)
> +return error;
> +
> +return 0;
> +}
> +
> +static void gpio_rcar_irq_release_resources(struct irq_data *d)
> +{
> +struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +struct gpio_rcar_priv *p = gpiochip_get_data(gc);
> +
> +pm_runtime_put(&p->pdev->dev);
> +}
> +
>  static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
>  {
>  struct gpio_rcar_priv *p = dev_id;
> @@ -455,6 +493,10 @@ static int gpio_rcar_probe(struct platform_device *pdev)
>  irq_chip->irq_unmask = gpio_rcar_irq_enable;
>  irq_chip->irq_set_type = gpio_rcar_irq_set_type;
>  irq_chip->irq_set_wake = gpio_rcar_irq_set_wake;
> +irq_chip->irq_bus_lock = gpio_rcar_irq_bus_lock;
> +irq_chip->irq_bus_sync_unlock = gpio_rcar_irq_bus_sync_unlock;
> +irq_chip->irq_request_resources = gpio_rcar_irq_request_resources;
> +irq_chip->irq_release_resources = gpio_rcar_irq_release_resources;
>  irq_chip->flags= IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
>
>  ret = gpiochip_add_data(gpio_chip, p);
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
