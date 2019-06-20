From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 20 Jun 2019 13:37:46 +0100
Subject: [cip-dev] [PATCH 4.4-cip] spi: pxa2xx: Fix build error because of
 missing header
Message-ID: <20190620123746.4boosxdwr2vapgu4@xylophone.i.decadent.org.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 089bd46d8bc1fe5a28351e82e4adcaa5a40121b5 upstream.

Kbuild test robot reports:

  drivers/spi/spi-pxa2xx.c: In function ?setup_cs?:
  drivers/spi/spi-pxa2xx.c:1190:20: error: implicit declaration of function ?desc_to_gpio?
  ...

Reason for this is the fact that those functions are declared in
linux/gpio/consumer.h which is not included in the driver. Fix this by
including it.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
This fixes a build regression for some configurations since I applied
the backport of commit 3d3bc50700ba "spi: pxa2xx: Add support for GPIO
descriptor chip selects".

Ben.

 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 9233a1cb4dee..02685ccaa97b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
