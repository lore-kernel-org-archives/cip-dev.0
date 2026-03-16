Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B97F506FF
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 15:00:06 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52469.1773673205403344636
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 08:00:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: KLtbxMCeT2uqkVcKwOeuxw==
X-CSE-MsgGUID: 77XUFhTvRnmw1yDU/DXWOg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Mar 2026 00:00:04 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8CE3841B783A;
	Tue, 17 Mar 2026 00:00:03 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 27/35] net: pcs: rzn1-miic: Add support to handle resets
Date: Mon, 16 Mar 2026 14:59:04 +0000
Message-ID: <20260316145915.8580-28-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 15:00:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22419

commit 882a8bb0706c0c3af6b33858bcad630cf61fe894 upstream.

Add reset-line handling to the RZN1 MIIC driver and move reset
configuration into the SoC/OF data. Introduce MIIC_MAX_NUM_RSTS (= 2),
add storage for reset_control_bulk_data in struct miic and add
reset_ids and reset_count fields to miic_of_data.

When reset_ids are present in the OF data, the driver obtains the reset
lines with devm_reset_control_bulk_get_exclusive(), deasserts them during
probe and registers a devres action to assert them on remove or on error.

This change is preparatory work to support the RZ/T2H SoC, which exposes
two reset lines for the ETHSS IP. The driver remains backward compatible
for platforms that do not provide reset lines.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20250910204132.319975-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 56 +++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 7c591536e4fe..765d6ca4e4ca 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/device/devres.h>
 #include <linux/mdio.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -17,6 +18,7 @@
 #include <linux/phylink.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <dt-bindings/net/pcs-rzn1-miic.h>
 
@@ -52,6 +54,8 @@
 #define MIIC_MODCTRL_CONF_CONV_MAX	6
 #define MIIC_MODCTRL_CONF_NONE		-1
 
+#define MIIC_MAX_NUM_RSTS		2
+
 /**
  * struct modctrl_match - Matching table entry for  convctrl configuration
  *			  See section 8.2.1 of manual.
@@ -126,12 +130,14 @@ static const char * const index_to_string[] = {
  * @base: base address of the MII converter
  * @dev: Device associated to the MII converter
  * @lock: Lock used for read-modify-write access
+ * @rsts: Reset controls for the MII converter
  * @of_data: Pointer to OF data
  */
 struct miic {
 	void __iomem *base;
 	struct device *dev;
 	spinlock_t lock;
+	struct reset_control_bulk_data rsts[MIIC_MAX_NUM_RSTS];
 	const struct miic_of_data *of_data;
 };
 
@@ -147,6 +153,8 @@ struct miic {
  * @miic_port_start: MIIC port start number
  * @miic_port_max: Maximum MIIC supported
  * @sw_mode_mask: Switch mode mask
+ * @reset_ids: Reset names array
+ * @reset_count: Number of entries in the reset_ids array
  */
 struct miic_of_data {
 	struct modctrl_match *match_table;
@@ -159,6 +167,8 @@ struct miic_of_data {
 	u8 miic_port_start;
 	u8 miic_port_max;
 	u8 sw_mode_mask;
+	const char * const *reset_ids;
+	u8 reset_count;
 };
 
 /**
@@ -532,6 +542,48 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 	return ret;
 }
 
+static void miic_reset_control_bulk_assert(void *data)
+{
+	struct miic *miic = data;
+	int ret;
+
+	ret = reset_control_bulk_assert(miic->of_data->reset_count, miic->rsts);
+	if (ret)
+		dev_err(miic->dev, "failed to assert reset lines\n");
+}
+
+static int miic_reset_control_init(struct miic *miic)
+{
+	const struct miic_of_data *of_data = miic->of_data;
+	struct device *dev = miic->dev;
+	int ret;
+	u8 i;
+
+	if (!of_data->reset_count)
+		return 0;
+
+	for (i = 0; i < of_data->reset_count; i++)
+		miic->rsts[i].id = of_data->reset_ids[i];
+
+	ret = devm_reset_control_bulk_get_exclusive(dev, of_data->reset_count,
+						    miic->rsts);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get bulk reset lines\n");
+
+	ret = reset_control_bulk_deassert(of_data->reset_count, miic->rsts);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to deassert reset lines\n");
+
+	ret = devm_add_action_or_reset(dev, miic_reset_control_bulk_assert,
+				       miic);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add reset action\n");
+
+	return 0;
+}
+
 static int miic_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -555,6 +607,10 @@ static int miic_probe(struct platform_device *pdev)
 	if (IS_ERR(miic->base))
 		return PTR_ERR(miic->base);
 
+	ret = miic_reset_control_init(miic);
+	if (ret)
+		return ret;
+
 	ret = devm_pm_runtime_enable(dev);
 	if (ret < 0)
 		return ret;
-- 
2.43.0


