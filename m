From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:21 +0200
Subject: [cip-dev] [PATCH 24/25] gpio-exar/8250-exar: Make set of exported
	GPIOs configurable
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <fc42536c94949531f525bb6c213059e1ef227474.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 380b1e2f3a2f32bfe9c0aa85a68629eb99b043c0 upstream.

On the SIMATIC, IOT2040 only a single pin is exportable as GPIO, the
rest is required to operate the UART. To allow modeling this case,
expand the platform device data structure to specify a (consecutive) pin
subset for exporting by the gpio-exar driver.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
[Jan: replace unavailable platform dev properties with pdata for 4.4]
---
 drivers/gpio/gpio-exar.c                | 48 +++++++++++++++++----------------
 drivers/tty/serial/8250/8250_exar.c     | 14 +++++++---
 include/linux/platform_data/gpio-exar.h | 21 +++++++++++++++
 3 files changed, 57 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/platform_data/gpio-exar.h

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 0ee6d5735d0c..749f62821492 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/gpio-exar.h>
 
 #define EXAR_OFFSET_MPIOLVL_LO 0x90
 #define EXAR_OFFSET_MPIOSEL_LO 0x93
@@ -31,6 +32,7 @@ struct exar_gpio_chip {
 	int index;
 	void __iomem *regs;
 	char name[20];
+	unsigned int first_pin;
 };
 
 static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
@@ -51,11 +53,12 @@ static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
 static int exar_set_direction(struct gpio_chip *chip, int direction,
 			      unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
+		EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
+	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
 
-	addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
-	exar_update(chip, addr, direction, offset % 8);
+	exar_update(chip, addr, direction, bit);
 	return 0;
 }
 
@@ -73,36 +76,33 @@ static int exar_get(struct gpio_chip *chip, unsigned int reg)
 
 static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
-	int val;
-
-	addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
-	val = exar_get(chip, addr) & BIT(offset % 8);
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
+		EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
+	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
 
-	return !!val;
+	return !!(exar_get(chip, addr) & BIT(bit));
 }
 
 static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
-	int val;
-
-	addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
-	val = exar_get(chip, addr) & BIT(offset % 8);
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
+		EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
+	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
 
-	return !!val;
+	return !!(exar_get(chip, addr) & BIT(bit));
 }
 
 static void exar_set_value(struct gpio_chip *chip, unsigned int offset,
 			   int value)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
+	struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
+	unsigned int addr = (offset + exar_gpio->first_pin) / 8 ?
+		EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
+	unsigned int bit  = (offset + exar_gpio->first_pin) % 8;
 
-	addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
-	exar_update(chip, addr, value, offset % 8);
+	exar_update(chip, addr, value, bit);
 }
 
 static int exar_direction_output(struct gpio_chip *chip, unsigned int offset,
@@ -119,6 +119,7 @@ static int exar_direction_input(struct gpio_chip *chip, unsigned int offset)
 
 static int gpio_exar_probe(struct platform_device *pdev)
 {
+	const struct gpio_exar_pdata *pdata = pdev->dev.platform_data;
 	struct pci_dev *pcidev = to_pci_dev(pdev->dev.parent);
 	struct exar_gpio_chip *exar_gpio;
 	void __iomem *p;
@@ -149,9 +150,10 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	exar_gpio->gpio_chip.get = exar_get_value;
 	exar_gpio->gpio_chip.set = exar_set_value;
 	exar_gpio->gpio_chip.base = -1;
-	exar_gpio->gpio_chip.ngpio = 16;
+	exar_gpio->gpio_chip.ngpio = pdata->ngpios;
 	exar_gpio->regs = p;
 	exar_gpio->index = index;
+	exar_gpio->first_pin = pdata->first_pin;
 
 	ret = devm_gpiochip_add_data(&pdev->dev,
 				     &exar_gpio->gpio_chip, exar_gpio);
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index fd721097f179..8a4864825915 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -20,6 +20,7 @@
 #include <linux/string.h>
 #include <linux/tty.h>
 #include <linux/8250_pci.h>
+#include <linux/platform_data/gpio-exar.h>
 
 #include <asm/byteorder.h>
 
@@ -188,7 +189,8 @@ static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
 }
 
 static void *
-__xr17v35x_register_gpio(struct pci_dev *pcidev)
+__xr17v35x_register_gpio(struct pci_dev *pcidev,
+			 const struct gpio_exar_pdata *pdata)
 {
 	struct platform_device *pdev;
 
@@ -199,7 +201,8 @@ __xr17v35x_register_gpio(struct pci_dev *pcidev)
 	pdev->dev.parent = &pcidev->dev;
 	ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pcidev->dev));
 
-	if (platform_device_add(pdev) < 0) {
+	if (platform_device_add_data(pdev, pdata, sizeof(*pdata)) < 0 ||
+	    platform_device_add(pdev) < 0) {
 		platform_device_put(pdev);
 		return NULL;
 	}
@@ -207,12 +210,17 @@ __xr17v35x_register_gpio(struct pci_dev *pcidev)
 	return pdev;
 }
 
+static const struct gpio_exar_pdata exar_gpio_pdata = {
+	.first_pin = 0,
+	.ngpios = 16,
+};
+
 static int xr17v35x_register_gpio(struct pci_dev *pcidev,
 				  struct uart_8250_port *port)
 {
 	if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
 		port->port.private_data =
-			__xr17v35x_register_gpio(pcidev);
+			__xr17v35x_register_gpio(pcidev, &exar_gpio_pdata);
 
 	return 0;
 }
diff --git a/include/linux/platform_data/gpio-exar.h b/include/linux/platform_data/gpio-exar.h
new file mode 100644
index 000000000000..9e98780e5938
--- /dev/null
+++ b/include/linux/platform_data/gpio-exar.h
@@ -0,0 +1,21 @@
+/*
+ * GPIO handling for Exar XR17V35X chip
+ *
+ * Copyright (c) 2017 Siemens AG
+ *
+ * Written by Jan Kiszka <jan.kiszka@siemens.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __GPIO_EXAR_PDATA_H
+#define __GPIO_EXAR_PDATA_H
+
+struct gpio_exar_pdata {
+	unsigned int first_pin;
+	unsigned int ngpios;
+};
+
+#endif /* __GPIO_EXAR_PDATA_H */
-- 
2.12.3
