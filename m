From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:14 +0200
Subject: [cip-dev] [PATCH 17/25] gpio-exar/8250-exar: Fix passing in of
	parent PCI device
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <adec17790cbf5add4bb8661546303eaf4cc42aef.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit d3936d7437e388f3a91995e8f07fb82affff2f0d upstream.

This fixes reloading of the GPIO driver for the same platform device
instance as created by the exar UART driver: First of all, the driver
sets drvdata to its own value during probing and does not restore the
original value on exit. But this won't help anyway as the core clears
drvdata after the driver left.

Set the platform device parent instead.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-exar.c            | 2 +-
 drivers/tty/serial/8250/8250_exar.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 866302332373..f956b8fd67ca 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -119,7 +119,7 @@ static int exar_direction_input(struct gpio_chip *chip, unsigned int offset)
 
 static int gpio_exar_probe(struct platform_device *pdev)
 {
-	struct pci_dev *pcidev = platform_get_drvdata(pdev);
+	struct pci_dev *pcidev = to_pci_dev(pdev->dev.parent);
 	struct exar_gpio_chip *exar_gpio;
 	void __iomem *p;
 	int index, ret;
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index e78ed54a696b..6cab7b0512f3 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -190,7 +190,8 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
 	if (!pdev)
 		return NULL;
 
-	platform_set_drvdata(pdev, pcidev);
+	pdev->dev.parent = &pcidev->dev;
+
 	if (platform_device_add(pdev) < 0) {
 		platform_device_put(pdev);
 		return NULL;
-- 
2.12.3
