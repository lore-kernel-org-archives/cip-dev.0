From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:42 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 13/83] mmc: sh_mobile_sdhi: Add UHS-I
	mode support
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-14-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 057a4592e6dbad0e571628968f3e20a3706e4701 upstream.

Implement voltage switch, supporting modes up to SDR-50.

Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  3 ++
 drivers/mmc/host/sh_mobile_sdhi.c                  | 52 ++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index cbf9135..1d23a43 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -27,3 +27,6 @@ Required properties:
 
 Optional properties:
 - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
+- pinctrl-names: should be "default", "state_uhs"
+- pinctrl-0: should contain default/high speed pin ctrl
+- pinctrl-1: should contain uhs mode pin ctrl
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 51e49eb..d6035b4 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -32,6 +32,9 @@
 #include <linux/mfd/tmio.h>
 #include <linux/sh_dma.h>
 #include <linux/delay.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinctrl-state.h>
+#include <linux/regulator/consumer.h>
 
 #include "tmio_mmc.h"
 
@@ -98,6 +101,8 @@ struct sh_mobile_sdhi {
 	struct clk *clk;
 	struct tmio_mmc_data mmc_data;
 	struct tmio_mmc_dma dma_priv;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default, *pins_uhs;
 };
 
 static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
@@ -206,6 +211,44 @@ static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
 	clk_disable_unprepare(priv->clk);
 }
 
+static int sh_mobile_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
+						      struct mmc_ios *ios)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct sh_mobile_sdhi *priv = host_to_priv(host);
+	struct pinctrl_state *pin_state;
+	int ret;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		pin_state = priv->pins_default;
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		pin_state = priv->pins_uhs;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * If anything is missing, assume signal voltage is fixed at
+	 * 3.3V and succeed/fail accordingly.
+	 */
+	if (IS_ERR(priv->pinctrl) || IS_ERR(pin_state))
+		return ios->signal_voltage ==
+			MMC_SIGNAL_VOLTAGE_330 ? 0 : -EINVAL;
+
+	ret = mmc_regulator_set_vqmmc(host->mmc, ios);
+	if (ret)
+		return ret;
+
+	ret = pinctrl_select_state(priv->pinctrl, pin_state);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
 {
 	int timeout = 1000;
@@ -296,6 +339,14 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eprobe;
 	}
 
+	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR(priv->pinctrl)) {
+		priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
+						PINCTRL_STATE_DEFAULT);
+		priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl,
+						"state_uhs");
+	}
+
 	host = tmio_mmc_host_alloc(pdev);
 	if (!host) {
 		ret = -ENOMEM;
@@ -319,6 +370,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	host->clk_update	= sh_mobile_sdhi_clk_update;
 	host->clk_disable	= sh_mobile_sdhi_clk_disable;
 	host->multi_io_quirk	= sh_mobile_sdhi_multi_io_quirk;
+	host->start_signal_voltage_switch = sh_mobile_sdhi_start_signal_voltage_switch;
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
 	if (!host->bus_shift && resource_size(res) > 0x100) /* old way to determine the shift */
-- 
2.7.4
