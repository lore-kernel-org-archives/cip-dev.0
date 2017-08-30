From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:18 +0200
Subject: [cip-dev] [PATCH 21/25] gpio: exar: Fix iomap request
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <fd45681a3498c6d33055da38f5f45158d05c413d.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 8847f5f9ef554269d2a06100b311d363b9727da6 upstream.

The UART driver already maps the resource for us. Trying to do this here
only fails and leaves us with a non-working device.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-exar.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 0a79436d8ba7..fdb1b1491a18 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -125,14 +125,10 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	int index, ret;
 
 	/*
-	 * Map the pci device to get the register addresses.
-	 * We will need to read and write those registers to control
-	 * the GPIO pins.
-	 * Using managed functions will save us from unmaping on exit.
-	 * As the device is enabled using managed functions by the
-	 * UART driver we can also use managed functions here.
+	 * The UART driver must have mapped region 0 prior to registering this
+	 * device - use it.
 	 */
-	p = pcim_iomap(pcidev, 0, 0);
+	p = pcim_iomap_table(pcidev)[0];
 	if (!p)
 		return -ENOMEM;
 
-- 
2.12.3
