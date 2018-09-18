From: kazuhiro3.hayashi@toshiba.co.jp (Kazuhiro Hayashi)
Date: Tue, 18 Sep 2018 04:10:10 +0000
Subject: [cip-dev] [PATCH] spi: pxa2xx: Fix build error because of missing
	header
Message-ID: <1537243810-2074-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
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
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 5e2ed7d..dd7b5b4 100644
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
2.1.4
