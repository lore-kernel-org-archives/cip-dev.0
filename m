Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA8CFCEEAF
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 12:10:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43747.1772021423471547198
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 04:10:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: djmGKxFrTFm8loq3n64lFQ==
X-CSE-MsgGUID: eWpJUZtgSKqSMp81YDq/+g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Feb 2026 21:10:34 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 01ACB41A8278;
	Wed, 25 Feb 2026 21:10:32 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 15/25] drm: renesas: rz-du: mipi_dsi: Use mHz for D-PHY frequency calculations
Date: Wed, 25 Feb 2026 12:09:53 +0000
Message-ID: <20260225121003.129467-16-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
References: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 12:10:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21946

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7c3fecdd12d6487e1229f00bfeffccabd1f011f8 upstream.

Pass the HSFREQ in milli-Hz to the `dphy_init()` callback to improve
precision, especially for the RZ/V2H(P) SoC, where PLL dividers require
high accuracy.

These changes prepare the driver for upcoming RZ/V2H(P) SoC support.

Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250609225630.502888-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 49b9d40ea3e6..2b4442798f83 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -32,7 +32,7 @@
 struct rzg2l_mipi_dsi;
 
 struct rzg2l_mipi_dsi_hw_info {
-	int (*dphy_init)(struct rzg2l_mipi_dsi *dsi, unsigned long hsfreq);
+	int (*dphy_init)(struct rzg2l_mipi_dsi *dsi, u64 hsfreq_millihz);
 	void (*dphy_exit)(struct rzg2l_mipi_dsi *dsi);
 	u32 phy_reg_offset;
 	u32 link_reg_offset;
@@ -201,8 +201,9 @@ static u32 rzg2l_mipi_dsi_link_read(struct rzg2l_mipi_dsi *dsi, u32 reg)
  */
 
 static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
-				    unsigned long hsfreq)
+				    u64 hsfreq_millihz)
 {
+	unsigned long hsfreq = DIV_ROUND_CLOSEST_ULL(hsfreq_millihz, MILLI);
 	const struct rzg2l_mipi_dsi_timings *dphy_timings;
 	unsigned int i;
 	u32 dphyctrl0;
@@ -275,6 +276,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 				  const struct drm_display_mode *mode)
 {
 	unsigned long hsfreq, vclk_rate;
+	u64 hsfreq_millihz;
 	unsigned int bpp;
 	u32 txsetr;
 	u32 clstptsetr;
@@ -306,9 +308,9 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 	 * hsclk(bit) = hsclk(byte) * 8 = hsfreq
 	 */
 	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
-	hsfreq = DIV_ROUND_CLOSEST_ULL(vclk_rate * bpp, dsi->lanes);
+	hsfreq_millihz = DIV_ROUND_CLOSEST_ULL(mul_u32_u32(vclk_rate, bpp * MILLI), dsi->lanes);
 
-	ret = dsi->info->dphy_init(dsi, hsfreq);
+	ret = dsi->info->dphy_init(dsi, hsfreq_millihz);
 	if (ret < 0)
 		goto err_phy;
 
@@ -316,6 +318,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 	txsetr = TXSETR_DLEN | TXSETR_NUMLANEUSE(dsi->lanes - 1) | TXSETR_CLEN;
 	rzg2l_mipi_dsi_link_write(dsi, TXSETR, txsetr);
 
+	hsfreq = DIV_ROUND_CLOSEST_ULL(hsfreq_millihz, MILLI);
 	/*
 	 * Global timings characteristic depends on high speed Clock Frequency
 	 * Currently MIPI DSI-IF just supports maximum FHD@60 with:
@@ -778,7 +781,7 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 	 * mode->clock and format are not available. So initialize DPHY with
 	 * timing parameters for 80Mbps.
 	 */
-	ret = dsi->info->dphy_init(dsi, 80000000);
+	ret = dsi->info->dphy_init(dsi, 80000000ULL * MILLI);
 	if (ret < 0)
 		goto err_phy;
 
-- 
2.34.1


