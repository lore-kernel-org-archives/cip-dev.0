Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCC7C46CA3
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:20:43 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.34967.1702041633696983190
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:20:33 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,260,1695654000"; 
   d="scan'208";a="189673970"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Dec 2023 22:20:32 +0900
Received: from localhost.localdomain (unknown [10.226.92.254])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5689E40065A7;
	Fri,  8 Dec 2023 22:20:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip v2 10/25] drm: rcar-du: rzg2l_mipi_dsi: Enhance device lanes check
Date: Fri,  8 Dec 2023 13:19:52 +0000
Message-Id: <20231208132007.108762-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
References: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:20:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13953

commit 418bb3a69e1355c8977c528f8f3896a0aaaecb80 upstream.

Enhance device lanes check by reading TXSETR register at probe(),
and enforced in rzg2l_mipi_dsi_host_attach().

As per HW manual, we can read TXSETR register only after
DPHY initialization.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c | 122 ++++++++++++++++-------
 1 file changed, 88 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
index 8579208db218..aa95b85a2964 100644
--- a/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
@@ -171,6 +171,11 @@ static void rzg2l_mipi_dsi_link_write(struct rzg2l_mipi_dsi *dsi, u32 reg, u32 d
 	iowrite32(data, dsi->mmio + LINK_REG_OFFSET + reg);
 }
 
+static u32 rzg2l_mipi_dsi_phy_read(struct rzg2l_mipi_dsi *dsi, u32 reg)
+{
+	return ioread32(dsi->mmio + reg);
+}
+
 static u32 rzg2l_mipi_dsi_link_read(struct rzg2l_mipi_dsi *dsi, u32 reg)
 {
 	return ioread32(dsi->mmio + LINK_REG_OFFSET + reg);
@@ -180,19 +185,11 @@ static u32 rzg2l_mipi_dsi_link_read(struct rzg2l_mipi_dsi *dsi, u32 reg)
  * Hardware Setup
  */
 
-static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
-				  const struct drm_display_mode *mode)
+static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
+				    unsigned long hsfreq)
 {
 	const struct rzg2l_mipi_dsi_timings *dphy_timings;
-	unsigned long hsfreq;
-	unsigned int i, bpp;
-	u32 txsetr;
-	u32 clstptsetr;
-	u32 lptrnstsetr;
-	u32 clkkpt;
-	u32 clkbfht;
-	u32 clkstpt;
-	u32 golpbkt;
+	unsigned int i;
 	u32 dphyctrl0;
 	u32 dphytim0;
 	u32 dphytim1;
@@ -200,19 +197,6 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 	u32 dphytim3;
 	int ret;
 
-	/*
-	 * Relationship between hsclk and vclk must follow
-	 * vclk * bpp = hsclk * 8 * lanes
-	 * where vclk: video clock (Hz)
-	 *       bpp: video pixel bit depth
-	 *       hsclk: DSI HS Byte clock frequency (Hz)
-	 *       lanes: number of data lanes
-	 *
-	 * hsclk(bit) = hsclk(byte) * 8
-	 */
-	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
-	hsfreq = (mode->clock * bpp * 8) / (8 * dsi->lanes);
-
 	/* All DSI global operation timings are set with recommended setting */
 	for (i = 0; i < ARRAY_SIZE(rzg2l_mipi_dsi_global_timings); ++i) {
 		dphy_timings = &rzg2l_mipi_dsi_global_timings[i];
@@ -220,12 +204,6 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 			break;
 	}
 
-	ret = pm_runtime_resume_and_get(dsi->dev);
-	if (ret < 0)
-		return ret;
-
-	clk_set_rate(dsi->vclk, mode->clock * 1000);
-
 	/* Initializing DPHY before accessing LINK */
 	dphyctrl0 = DSIDPHYCTRL0_CAL_EN_HSRX_OFS | DSIDPHYCTRL0_CMN_MASTER_EN |
 		    DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR;
@@ -259,10 +237,62 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 
 	ret = reset_control_deassert(dsi->rstc);
 	if (ret < 0)
-		goto err_pm_put;
+		return ret;
 
 	udelay(1);
 
+	return 0;
+}
+
+static void rzg2l_mipi_dsi_dphy_exit(struct rzg2l_mipi_dsi *dsi)
+{
+	u32 dphyctrl0;
+
+	dphyctrl0 = rzg2l_mipi_dsi_phy_read(dsi, DSIDPHYCTRL0);
+
+	dphyctrl0 &= ~(DSIDPHYCTRL0_EN_LDO1200 | DSIDPHYCTRL0_EN_BGR);
+	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
+
+	reset_control_assert(dsi->rstc);
+}
+
+static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
+				  const struct drm_display_mode *mode)
+{
+	unsigned long hsfreq;
+	unsigned int bpp;
+	u32 txsetr;
+	u32 clstptsetr;
+	u32 lptrnstsetr;
+	u32 clkkpt;
+	u32 clkbfht;
+	u32 clkstpt;
+	u32 golpbkt;
+	int ret;
+
+	/*
+	 * Relationship between hsclk and vclk must follow
+	 * vclk * bpp = hsclk * 8 * lanes
+	 * where vclk: video clock (Hz)
+	 *       bpp: video pixel bit depth
+	 *       hsclk: DSI HS Byte clock frequency (Hz)
+	 *       lanes: number of data lanes
+	 *
+	 * hsclk(bit) = hsclk(byte) * 8
+	 */
+	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
+	hsfreq = (mode->clock * bpp * 8) / (8 * dsi->lanes);
+
+	ret = pm_runtime_resume_and_get(dsi->dev);
+	if (ret < 0)
+		return ret;
+
+	clk_set_rate(dsi->vclk, mode->clock * 1000);
+
+	ret = rzg2l_mipi_dsi_dphy_init(dsi, hsfreq);
+	if (ret < 0)
+		goto err_phy;
+
 	/* Enable Data lanes and Clock lanes */
 	txsetr = TXSETR_DLEN | TXSETR_NUMLANEUSE(dsi->lanes - 1) | TXSETR_CLEN;
 	rzg2l_mipi_dsi_link_write(dsi, TXSETR, txsetr);
@@ -301,7 +331,8 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 
 	return 0;
 
-err_pm_put:
+err_phy:
+	rzg2l_mipi_dsi_dphy_exit(dsi);
 	pm_runtime_put(dsi->dev);
 
 	return ret;
@@ -309,7 +340,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 
 static void rzg2l_mipi_dsi_stop(struct rzg2l_mipi_dsi *dsi)
 {
-	reset_control_assert(dsi->rstc);
+	rzg2l_mipi_dsi_dphy_exit(dsi);
 	pm_runtime_put(dsi->dev);
 }
 
@@ -666,7 +697,9 @@ static const struct dev_pm_ops rzg2l_mipi_pm_ops = {
 
 static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 {
+	unsigned int num_data_lanes;
 	struct rzg2l_mipi_dsi *dsi;
+	u32 txsetr;
 	int ret;
 
 	dsi = devm_kzalloc(&pdev->dev, sizeof(*dsi), GFP_KERNEL);
@@ -681,7 +714,7 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 		return dev_err_probe(dsi->dev, ret,
 				     "missing or invalid data-lanes property\n");
 
-	dsi->num_data_lanes = ret;
+	num_data_lanes = ret;
 
 	dsi->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dsi->mmio))
@@ -710,6 +743,24 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dsi->dev);
 
+	ret = pm_runtime_resume_and_get(dsi->dev);
+	if (ret < 0)
+		goto err_pm_disable;
+
+	/*
+	 * TXSETR register can be read only after DPHY init. But during probe
+	 * mode->clock and format are not available. So initialize DPHY with
+	 * timing parameters for 80Mbps.
+	 */
+	ret = rzg2l_mipi_dsi_dphy_init(dsi, 80000);
+	if (ret < 0)
+		goto err_phy;
+
+	txsetr = rzg2l_mipi_dsi_link_read(dsi, TXSETR);
+	dsi->num_data_lanes = min(((txsetr >> 16) & 3) + 1, num_data_lanes);
+	rzg2l_mipi_dsi_dphy_exit(dsi);
+	pm_runtime_put(dsi->dev);
+
 	/* Initialize the DRM bridge. */
 	dsi->bridge.funcs = &rzg2l_mipi_dsi_bridge_ops;
 	dsi->bridge.of_node = dsi->dev->of_node;
@@ -723,6 +774,9 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_phy:
+	rzg2l_mipi_dsi_dphy_exit(dsi);
+	pm_runtime_put(dsi->dev);
 err_pm_disable:
 	pm_runtime_disable(dsi->dev);
 	return ret;
-- 
2.25.1


