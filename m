From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:19 +0200
Subject: [cip-dev] [PATCH 22/25] gpio-exar/8250-exar: Rearrange gpiochip
	parenthood
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <d17bab00c857c0a43e3ed822a537a2c0bbb325a5.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 4076cf08ac7673aca7d4dd9ddf18045d08dbc292 upstream.

Set the parent of the exar gpiochip to its platform device, like other
gpiochips are doing it. In order to keep the relationship discoverable
for ACPI systems, set the platform device companion to the PCI device.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-exar.c            | 2 +-
 drivers/tty/serial/8250/8250_exar.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index fdb1b1491a18..0ee6d5735d0c 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -142,7 +142,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 
 	sprintf(exar_gpio->name, "exar_gpio%d", index);
 	exar_gpio->gpio_chip.label = exar_gpio->name;
-	exar_gpio->gpio_chip.dev = &pcidev->dev;
+	exar_gpio->gpio_chip.dev = &pdev->dev;
 	exar_gpio->gpio_chip.direction_output = exar_direction_output;
 	exar_gpio->gpio_chip.direction_input = exar_direction_input;
 	exar_gpio->gpio_chip.get_direction = exar_get_direction;
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index e907f79b4766..477d1b8af107 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -9,6 +9,7 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License.
  */
+#include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -191,6 +192,7 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
 		return NULL;
 
 	pdev->dev.parent = &pcidev->dev;
+	ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pcidev->dev));
 
 	if (platform_device_add(pdev) < 0) {
 		platform_device_put(pdev);
-- 
2.12.3
