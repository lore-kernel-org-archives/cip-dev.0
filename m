From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 15 May 2018 12:19:56 +0100
Subject: [cip-dev] [PATCH 6/7] gpio: rcar: use gpiochip data pointer
In-Reply-To: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1526383197-5913-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Linus Walleij <linus.walleij@linaro.org>

This makes the driver use the data pointer added to the gpio_chip
to store a pointer to the state container instead of relying on
container_of().

Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
(cherry picked from commit c7b6f457cb53bceece484f4c528d1c149995e6c7)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/gpio/gpio-rcar.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 22c8517..75b2f2c 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -84,8 +84,7 @@ static void gpio_rcar_modify_bit(struct gpio_rcar_priv *p, int offs,
 static void gpio_rcar_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
-						gpio_chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
 
 	gpio_rcar_write(p, INTMSK, ~BIT(irqd_to_hwirq(d)));
 }
@@ -93,8 +92,7 @@ static void gpio_rcar_irq_disable(struct irq_data *d)
 static void gpio_rcar_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
-						gpio_chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
 
 	gpio_rcar_write(p, MSKCLR, BIT(irqd_to_hwirq(d)));
 }
@@ -137,8 +135,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
-						gpio_chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
 	unsigned int hwirq = irqd_to_hwirq(d);
 
 	dev_dbg(&p->pdev->dev, "sense irq = %d, type = %d\n", hwirq, type);
@@ -175,8 +172,7 @@ static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
 static int gpio_rcar_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
-						gpio_chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
 	int error;
 
 	if (p->irq_parent) {
@@ -218,16 +214,11 @@ static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
 	return irqs_handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static inline struct gpio_rcar_priv *gpio_to_priv(struct gpio_chip *chip)
-{
-	return container_of(chip, struct gpio_rcar_priv, gpio_chip);
-}
-
 static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 						       unsigned int gpio,
 						       bool output)
 {
-	struct gpio_rcar_priv *p = gpio_to_priv(chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	unsigned long flags;
 
 	/* follow steps in the GPIO documentation for
@@ -251,7 +242,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 
 static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
 {
-	struct gpio_rcar_priv *p = gpio_to_priv(chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	int error;
 
 	error = pm_runtime_get_sync(&p->pdev->dev);
@@ -267,7 +258,7 @@ static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
 
 static void gpio_rcar_free(struct gpio_chip *chip, unsigned offset)
 {
-	struct gpio_rcar_priv *p = gpio_to_priv(chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 
 	pinctrl_free_gpio(chip->base + offset);
 
@@ -291,15 +282,15 @@ static int gpio_rcar_get(struct gpio_chip *chip, unsigned offset)
 
 	/* testing on r8a7790 shows that INDT does not show correct pin state
 	 * when configured as output, so use OUTDT in case of output pins */
-	if (gpio_rcar_read(gpio_to_priv(chip), INOUTSEL) & bit)
-		return !!(gpio_rcar_read(gpio_to_priv(chip), OUTDT) & bit);
+	if (gpio_rcar_read(gpiochip_get_data(chip), INOUTSEL) & bit)
+		return !!(gpio_rcar_read(gpiochip_get_data(chip), OUTDT) & bit);
 	else
-		return !!(gpio_rcar_read(gpio_to_priv(chip), INDT) & bit);
+		return !!(gpio_rcar_read(gpiochip_get_data(chip), INDT) & bit);
 }
 
 static void gpio_rcar_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	struct gpio_rcar_priv *p = gpio_to_priv(chip);
+	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	unsigned long flags;
 
 	spin_lock_irqsave(&p->lock, flags);
@@ -466,7 +457,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	irq_chip->irq_set_wake = gpio_rcar_irq_set_wake;
 	irq_chip->flags	= IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
 
-	ret = gpiochip_add(gpio_chip);
+	ret = gpiochip_add_data(gpio_chip, p);
 	if (ret) {
 		dev_err(dev, "failed to add GPIO controller\n");
 		goto err0;
-- 
2.7.4
