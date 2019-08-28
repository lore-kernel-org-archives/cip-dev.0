From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:31:58 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 11/57] gpio: rcar: reference device
	instead of platform device
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-12-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Vladimir Zapolskiy <vz@mleia.com>

commit a53f79534f4ef418640b0f5c61500069de442e16 upstream.

The change simplifies dereferences to the mediated struct device, also
it allows to limit the scope of the platform device usage to probe and
remove functions only.

Non-functional change.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpio/gpio-rcar.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 55cc610..3aad2b5 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -43,7 +43,7 @@ struct gpio_rcar_bank_info {
 struct gpio_rcar_priv {
 	void __iomem *base;
 	spinlock_t lock;
-	struct platform_device *pdev;
+	struct device *dev;
 	struct gpio_chip gpio_chip;
 	struct irq_chip irq_chip;
 	unsigned int irq_parent;
@@ -148,7 +148,7 @@ static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
 	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
 	unsigned int hwirq = irqd_to_hwirq(d);
 
-	dev_dbg(&p->pdev->dev, "sense irq = %d, type = %d\n", hwirq, type);
+	dev_dbg(p->dev, "sense irq = %d, type = %d\n", hwirq, type);
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_LEVEL_HIGH:
@@ -188,8 +188,7 @@ static int gpio_rcar_irq_set_wake(struct irq_data *d, unsigned int on)
 	if (p->irq_parent) {
 		error = irq_set_irq_wake(p->irq_parent, on);
 		if (error) {
-			dev_dbg(&p->pdev->dev,
-				"irq %u doesn't support irq_set_wake\n",
+			dev_dbg(p->dev, "irq %u doesn't support irq_set_wake\n",
 				p->irq_parent);
 			p->irq_parent = 0;
 		}
@@ -252,13 +251,13 @@ static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
 	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	int error;
 
-	error = pm_runtime_get_sync(&p->pdev->dev);
+	error = pm_runtime_get_sync(p->dev);
 	if (error < 0)
 		return error;
 
 	error = pinctrl_gpio_request(chip->base + offset);
 	if (error)
-		pm_runtime_put(&p->pdev->dev);
+		pm_runtime_put(p->dev);
 
 	return error;
 }
@@ -275,7 +274,7 @@ static void gpio_rcar_free(struct gpio_chip *chip, unsigned offset)
 	 */
 	gpio_rcar_config_general_input_output_mode(chip, offset, false);
 
-	pm_runtime_put(&p->pdev->dev);
+	pm_runtime_put(p->dev);
 }
 
 static int gpio_rcar_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -403,21 +402,20 @@ MODULE_DEVICE_TABLE(of, gpio_rcar_of_table);
 
 static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
 {
-	struct device_node *np = p->pdev->dev.of_node;
+	struct device_node *np = p->dev->of_node;
 	const struct gpio_rcar_info *info;
 	struct of_phandle_args args;
 	int ret;
 
-	info = of_device_get_match_data(&p->pdev->dev);
+	info = of_device_get_match_data(p->dev);
 
 	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
 	*npins = ret == 0 ? args.args[2] : RCAR_MAX_GPIO_PER_BANK;
 	p->has_both_edge_trigger = info->has_both_edge_trigger;
 
 	if (*npins == 0 || *npins > RCAR_MAX_GPIO_PER_BANK) {
-		dev_warn(&p->pdev->dev,
-			 "Invalid number of gpio lines %u, using %u\n", *npins,
-			 RCAR_MAX_GPIO_PER_BANK);
+		dev_warn(p->dev, "Invalid number of gpio lines %u, using %u\n",
+			 *npins, RCAR_MAX_GPIO_PER_BANK);
 		*npins = RCAR_MAX_GPIO_PER_BANK;
 	}
 
@@ -439,7 +437,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	if (!p)
 		return -ENOMEM;
 
-	p->pdev = pdev;
+	p->dev = dev;
 	spin_lock_init(&p->lock);
 
 	/* Get device configuration from DT node */
-- 
2.7.4
