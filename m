From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:31 +0100
Subject: [cip-dev] [PATCH v2 19/52] gpiolib: Support 'gpio-reserved-ranges'
	property
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-20-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Stephen Boyd <sboyd@codeaurora.org>

commit 726cb3ba49692bdae6caff457755e7cdb432efa4 upstream.

Some qcom platforms make some GPIOs or pins unavailable for use by
non-secure operating systems, and thus reading or writing the registers
for those pins will cause access control issues. Add support for a DT
property to describe the set of GPIOs that are available for use so that
higher level OSes are able to know what pins to avoid reading/writing.
Non-DT platforms can add support by directly updating the
chip->valid_mask.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Timur Tabi <timur@codeaurora.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[fab: replaced chip->of_node with chip->dev->of_node, and removed
err_remove_irqchip_mask]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* No change
---
 drivers/gpio/gpiolib-of.c   | 24 ++++++++++++++++++++++++
 drivers/gpio/gpiolib.c      | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/gpio/driver.h | 18 ++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 5fe34a9d..ec642bf 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -334,6 +334,28 @@ void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc)
 }
 EXPORT_SYMBOL(of_mm_gpiochip_remove);
 
+static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
+{
+	int len, i;
+	u32 start, count;
+	struct device_node *np = chip->dev->of_node;
+
+	len = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
+	if (len < 0 || len % 2 != 0)
+		return;
+
+	for (i = 0; i < len; i += 2) {
+		of_property_read_u32_index(np, "gpio-reserved-ranges",
+					   i, &start);
+		of_property_read_u32_index(np, "gpio-reserved-ranges",
+					   i + 1, &count);
+		if (start >= chip->ngpio || start + count >= chip->ngpio)
+			continue;
+
+		bitmap_clear(chip->valid_mask, start, count);
+	}
+};
+
 #ifdef CONFIG_PINCTRL
 static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 {
@@ -434,6 +456,8 @@ int of_gpiochip_add(struct gpio_chip *chip)
 		chip->of_xlate = of_gpio_simple_xlate;
 	}
 
+	of_gpiochip_init_valid_mask(chip);
+
 	status = of_gpiochip_add_pin_range(chip);
 	if (status)
 		return status;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index adb4740..487a864 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -292,6 +292,43 @@ static unsigned long *gpiochip_allocate_mask(struct gpio_chip *chip)
 	return p;
 }
 
+static int gpiochip_init_valid_mask(struct gpio_chip *gpiochip)
+{
+#ifdef CONFIG_OF_GPIO
+	int size;
+	struct device_node *np = gpiochip->dev->of_node;
+
+	size = of_property_count_u32_elems(np,  "gpio-reserved-ranges");
+	if (size > 0 && size % 2 == 0)
+		gpiochip->need_valid_mask = true;
+#endif
+
+	if (!gpiochip->need_valid_mask)
+		return 0;
+
+	gpiochip->valid_mask = gpiochip_allocate_mask(gpiochip);
+	if (!gpiochip->valid_mask)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void gpiochip_free_valid_mask(struct gpio_chip *gpiochip)
+{
+	kfree(gpiochip->valid_mask);
+	gpiochip->valid_mask = NULL;
+}
+
+bool gpiochip_line_is_valid(const struct gpio_chip *gpiochip,
+				unsigned int offset)
+{
+	/* No mask means all valid */
+	if (likely(!gpiochip->valid_mask))
+		return true;
+	return test_bit(offset, gpiochip->valid_mask);
+}
+EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
+
 /**
  * gpiochip_add_data() - register a gpio_chip
  * @chip: the chip to register, with chip->base initialized
@@ -370,6 +407,10 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
 	if (status)
 		goto err_remove_from_list;
 
+	status = gpiochip_init_valid_mask(chip);
+	if (status)
+		goto err_remove_from_list;
+
 	status = of_gpiochip_add(chip);
 	if (status)
 		goto err_remove_chip;
@@ -390,6 +431,7 @@ err_remove_chip:
 	acpi_gpiochip_remove(chip);
 	gpiochip_free_hogs(chip);
 	of_gpiochip_remove(chip);
+	gpiochip_free_valid_mask(chip);
 err_remove_from_list:
 	spin_lock_irqsave(&gpio_lock, flags);
 	list_del(&chip->list);
@@ -427,6 +469,7 @@ void gpiochip_remove(struct gpio_chip *chip)
 	gpiochip_remove_pin_ranges(chip);
 	gpiochip_free_hogs(chip);
 	of_gpiochip_remove(chip);
+	gpiochip_free_valid_mask(chip);
 
 	spin_lock_irqsave(&gpio_lock, flags);
 	for (id = 0; id < chip->ngpio; id++) {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index de502c7..c0fc8ef 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -143,6 +143,21 @@ struct gpio_chip {
 	struct lock_class_key	*lock_key;
 #endif
 
+	/**
+	 * @need_valid_mask:
+	 *
+	 * If set core allocates @valid_mask with all bits set to one.
+	 */
+	bool need_valid_mask;
+
+	/**
+	 * @valid_mask:
+	 *
+	 * If not %NULL holds bitmask of GPIOs which are valid to be used
+	 * from the chip.
+	 */
+	unsigned long *valid_mask;
+
 #if defined(CONFIG_OF_GPIO)
 	/*
 	 * If CONFIG_OF is enabled, then all GPIO controllers described in the
@@ -185,6 +200,9 @@ extern struct gpio_chip *gpiochip_find(void *data,
 int gpiochip_lock_as_irq(struct gpio_chip *chip, unsigned int offset);
 void gpiochip_unlock_as_irq(struct gpio_chip *chip, unsigned int offset);
 
+/* */
+bool gpiochip_line_is_valid(const struct gpio_chip *chip, unsigned int offset);
+
 /* get driver data */
 static inline void *gpiochip_get_data(struct gpio_chip *chip)
 {
-- 
2.7.4
