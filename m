From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:17 +0200
Subject: [cip-dev] [PATCH 20/25] gpio-exar/8250-exar: Do not even
	instantiate a GPIO device for Commtech cards
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <4d2ea125b453a8a17540d941cc07eb33d707c8bd.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit a39f2fe7165647c2cd7bdbebb3d04061035e520f upstream.

Commtech adapters need the MPIOs for internal purposes, and the
gpio-exar driver already refused to pick them up. But there is actually
no point in even creating the underlying platform device.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-exar.c            | 3 ---
 drivers/tty/serial/8250/8250_exar.c | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 5e0f16738e26..0a79436d8ba7 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -124,9 +124,6 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	void __iomem *p;
 	int index, ret;
 
-	if (pcidev->vendor != PCI_VENDOR_ID_EXAR)
-		return -ENODEV;
-
 	/*
 	 * Map the pci device to get the register addresses.
 	 * We will need to read and write those registers to control
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 6cab7b0512f3..e907f79b4766 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -233,7 +233,9 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		/* Setup Multipurpose Input/Output pins. */
 		setup_gpio(pcidev, p);
 
-		port->port.private_data = xr17v35x_register_gpio(pcidev);
+		if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
+			port->port.private_data =
+				xr17v35x_register_gpio(pcidev);
 	}
 
 	return 0;
-- 
2.12.3
