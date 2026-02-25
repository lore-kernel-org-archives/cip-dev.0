Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815CFFCEEA9
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 12:10:42 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43850.1772021412384374918
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 04:10:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: t/GPYc89R7aofBvIOO4YOA==
X-CSE-MsgGUID: WZsFoiW+TVSmbfdw2zFHGw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Feb 2026 21:10:39 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 528FC41A8298;
	Wed, 25 Feb 2026 21:10:38 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 18/25] drm: renesas: rz-du: mipi_dsi: Add function pointers for configuring VCLK and mode validation
Date: Wed, 25 Feb 2026 12:09:56 +0000
Message-ID: <20260225121003.129467-19-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
References: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 12:10:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21949

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit e2944dc6587f39c3eefb15ee607e700314230a0b upstream.

Introduce `dphy_conf_clks` and `dphy_mode_clk_check` callbacks in
`rzg2l_mipi_dsi_hw_info` to configure the VCLK and validate
supported display modes.

On the RZ/V2H(P) SoC, the DSI PLL dividers need to be as accurate as
possible. To ensure compatibility with both RZ/G2L and RZ/V2H(P) SoCs,
function pointers are introduced.

Modify `rzg2l_mipi_dsi_startup()` to use `dphy_conf_clks` for clock
configuration and `rzg2l_mipi_dsi_bridge_mode_valid()` to invoke
`dphy_mode_clk_check` for mode validation.

This change ensures proper operation across different SoC variants
by allowing fine-grained control over clock configuration and mode
validation.

Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250609225630.502888-10-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 65 +++++++++++++------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index e465dd913fab..df6be6629758 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -37,6 +37,10 @@ struct rzg2l_mipi_dsi_hw_info {
 	int (*dphy_init)(struct rzg2l_mipi_dsi *dsi, u64 hsfreq_millihz);
 	void (*dphy_startup_late_init)(struct rzg2l_mipi_dsi *dsi);
 	void (*dphy_exit)(struct rzg2l_mipi_dsi *dsi);
+	int (*dphy_conf_clks)(struct rzg2l_mipi_dsi *dsi, unsigned long mode_freq,
+			      u64 *hsfreq_millihz);
+	unsigned int (*dphy_mode_clk_check)(struct rzg2l_mipi_dsi *dsi,
+					    unsigned long mode_freq);
 	u32 phy_reg_offset;
 	u32 link_reg_offset;
 	unsigned long min_dclk;
@@ -276,12 +280,39 @@ static void rzg2l_mipi_dsi_dphy_exit(struct rzg2l_mipi_dsi *dsi)
 	reset_control_assert(dsi->rstc);
 }
 
+static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_freq,
+				u64 *hsfreq_millihz)
+{
+	unsigned long vclk_rate;
+	unsigned int bpp;
+
+	clk_set_rate(dsi->vclk, mode_freq * KILO);
+	vclk_rate = clk_get_rate(dsi->vclk);
+	if (vclk_rate != mode_freq * KILO)
+		dev_dbg(dsi->dev, "Requested vclk rate %lu, actual %lu mismatch\n",
+			mode_freq * KILO, vclk_rate);
+	/*
+	 * Relationship between hsclk and vclk must follow
+	 * vclk * bpp = hsclk * 8 * lanes
+	 * where vclk: video clock (Hz)
+	 *       bpp: video pixel bit depth
+	 *       hsclk: DSI HS Byte clock frequency (Hz)
+	 *       lanes: number of data lanes
+	 *
+	 * hsclk(bit) = hsclk(byte) * 8 = hsfreq
+	 */
+	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
+	*hsfreq_millihz = DIV_ROUND_CLOSEST_ULL(mul_u32_u32(vclk_rate, bpp * MILLI),
+						dsi->lanes);
+
+	return 0;
+}
+
 static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 				  const struct drm_display_mode *mode)
 {
-	unsigned long hsfreq, vclk_rate;
+	unsigned long hsfreq;
 	u64 hsfreq_millihz;
-	unsigned int bpp;
 	u32 txsetr;
 	u32 clstptsetr;
 	u32 lptrnstsetr;
@@ -295,24 +326,9 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 	if (ret < 0)
 		return ret;
 
-	clk_set_rate(dsi->vclk, mode->clock * KILO);
-	vclk_rate = clk_get_rate(dsi->vclk);
-	if (vclk_rate != mode->clock * KILO)
-		dev_dbg(dsi->dev, "Requested vclk rate %lu, actual %lu mismatch\n",
-			mode->clock * KILO, vclk_rate);
-
-	/*
-	 * Relationship between hsclk and vclk must follow
-	 * vclk * bpp = hsclk * 8 * lanes
-	 * where vclk: video clock (Hz)
-	 *       bpp: video pixel bit depth
-	 *       hsclk: DSI HS Byte clock frequency (Hz)
-	 *       lanes: number of data lanes
-	 *
-	 * hsclk(bit) = hsclk(byte) * 8 = hsfreq
-	 */
-	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
-	hsfreq_millihz = DIV_ROUND_CLOSEST_ULL(mul_u32_u32(vclk_rate, bpp * MILLI), dsi->lanes);
+	ret = dsi->info->dphy_conf_clks(dsi, mode->clock, &hsfreq_millihz);
+	if (ret < 0)
+		goto err_phy;
 
 	ret = dsi->info->dphy_init(dsi, hsfreq_millihz);
 	if (ret < 0)
@@ -620,6 +636,14 @@ rzg2l_mipi_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 	if (mode->clock < dsi->info->min_dclk)
 		return MODE_CLOCK_LOW;
 
+	if (dsi->info->dphy_mode_clk_check) {
+		enum drm_mode_status status;
+
+		status = dsi->info->dphy_mode_clk_check(dsi, mode->clock);
+		if (status != MODE_OK)
+			return status;
+	}
+
 	return MODE_OK;
 }
 
@@ -839,6 +863,7 @@ static int rzg2l_mipi_dsi_remove(struct platform_device *pdev)
 static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
 	.dphy_init = rzg2l_mipi_dsi_dphy_init,
 	.dphy_exit = rzg2l_mipi_dsi_dphy_exit,
+	.dphy_conf_clks = rzg2l_dphy_conf_clks,
 	.link_reg_offset = 0x10000,
 	.min_dclk = 5803,
 	.max_dclk = 148500,
-- 
2.34.1


