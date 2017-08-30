From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:11 +0200
Subject: [cip-dev] [PATCH 14/25] gpio: Add devm_ apis for gpiochip_add_data
	and gpiochip_remove
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <c10a94a06fb18f22177a081be10df142735103d9.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laxman Dewangan <ldewangan@nvidia.com>

commit 0cf3292cde22f8843ae5d1eeb8466d8121243c1a upstream.

Add device managed APIs devm_gpiochip_add_data() and
devm_gpiochip_remove() for the APIs gpiochip_add_data()
and gpiochip_remove().

This helps in reducing code in error path and sometimes
removal of .remove callback for driver unbind.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpiolib.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/gpio/driver.h |  4 +++
 2 files changed, 78 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 66fa17615d7c..c96dd9af9b2e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -433,6 +433,80 @@ void gpiochip_remove(struct gpio_chip *chip)
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
 
+static void devm_gpio_chip_release(struct device *dev, void *res)
+{
+	struct gpio_chip *chip = *(struct gpio_chip **)res;
+
+	gpiochip_remove(chip);
+}
+
+static int devm_gpio_chip_match(struct device *dev, void *res, void *data)
+
+{
+	struct gpio_chip **r = res;
+
+	if (!r || !*r) {
+		WARN_ON(!r || !*r);
+		return 0;
+	}
+
+	return *r == data;
+}
+
+/**
+ * devm_gpiochip_add_data() - Resource manager piochip_add_data()
+ * @dev: the device pointer on which irq_chip belongs to.
+ * @chip: the chip to register, with chip->base initialized
+ * Context: potentially before irqs will work
+ *
+ * Returns a negative errno if the chip can't be registered, such as
+ * because the chip->base is invalid or already associated with a
+ * different chip.  Otherwise it returns zero as a success code.
+ *
+ * The gpio chip automatically be released when the device is unbound.
+ */
+int devm_gpiochip_add_data(struct device *dev, struct gpio_chip *chip,
+			   void *data)
+{
+	struct gpio_chip **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_gpio_chip_release, sizeof(*ptr),
+			     GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = gpiochip_add_data(chip, data);
+	if (ret < 0) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = chip;
+	devres_add(dev, ptr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_gpiochip_add_data);
+
+/**
+ * devm_gpiochip_remove() - Resource manager of gpiochip_remove()
+ * @dev: device for which which resource was allocated
+ * @chip: the chip to remove
+ *
+ * A gpio_chip with any GPIOs still requested may not be removed.
+ */
+void devm_gpiochip_remove(struct device *dev, struct gpio_chip *chip)
+{
+	int ret;
+
+	ret = devres_release(dev, devm_gpio_chip_release,
+			     devm_gpio_chip_match, chip);
+	if (!ret)
+		WARN_ON(ret);
+}
+EXPORT_SYMBOL_GPL(devm_gpiochip_remove);
+
 /**
  * gpiochip_find() - iterator for locating a specific gpio_chip
  * @data: data to pass to match function
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 424d11f4fa05..de502c7e4171 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -174,6 +174,10 @@ static inline int gpiochip_add(struct gpio_chip *chip)
 	return gpiochip_add_data(chip, NULL);
 }
 extern void gpiochip_remove(struct gpio_chip *chip);
+extern int devm_gpiochip_add_data(struct device *dev, struct gpio_chip *chip,
+				  void *data);
+extern void devm_gpiochip_remove(struct device *dev, struct gpio_chip *chip);
+
 extern struct gpio_chip *gpiochip_find(void *data,
 			      int (*match)(struct gpio_chip *chip, void *data));
 
-- 
2.12.3
