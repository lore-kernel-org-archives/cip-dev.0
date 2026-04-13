Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02558F34C7D
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 17:18:44 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.278275.1776100714896898936
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Apr 2026 10:18:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: Z3u1f9v6RIS3Ktt7nJA9Fg==
X-CSE-MsgGUID: hFcwFknsQ4e8hTxIJPCL9A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Apr 2026 02:18:38 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4755E4037DB0;
	Tue, 14 Apr 2026 02:18:37 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 6.1.y-cip 4/7] drm: renesas: rz-du: mipi_dsi: Set DSI divider
Date: Mon, 13 Apr 2026 13:18:28 -0400
Message-ID: <20260413171831.3091144-4-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171831.3091144-1-chris.brandt@renesas.com>
References: <20260413171831.3091144-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 17:18:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22692

commit fb797a70108f3fda83fde6dea30bee4be7d5df8b upstream.

Before the MIPI DSI clock source can be configured, the target divide
ratio needs to be set.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Fixes: 5a4326f2e3b1 ("clk: renesas: rzg2l: Remove DSI clock rate restrictions")
Link: https://patch.msgid.link/20260227015216.2721504-1-chris.brandt@renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index d3aae2501b9e..bb56548fafa1 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1123,6 +1123,7 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 				      struct mipi_dsi_device *device)
 {
 	struct rzg2l_mipi_dsi *dsi = host_to_rzg2l_mipi_dsi(host);
+	int bpp;
 	int ret;

 	if (device->lanes > dsi->num_data_lanes) {
@@ -1132,7 +1133,8 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 		return -EINVAL;
 	}

-	switch (mipi_dsi_pixel_format_to_bpp(device->format)) {
+	bpp = mipi_dsi_pixel_format_to_bpp(device->format);
+	switch (bpp) {
 	case 24:
 		break;
 	case 18:
@@ -1163,6 +1165,18 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,

 	drm_bridge_add(&dsi->bridge);

+	/*
+	 * Report the required division ratio setting for the MIPI clock dividers.
+	 *
+	 * vclk * bpp = hsclk * 8 * num_lanes
+	 *
+	 * vclk * DSI_AB_divider = hsclk * 16
+	 *
+	 *   which simplifies to...
+	 * DSI_AB_divider = bpp * 2 / num_lanes
+	 */
+	rzg2l_cpg_dsi_div_set_divider(bpp * 2 / dsi->lanes, PLL5_TARGET_DSI);
+
 	return 0;
 }

--
2.52.0


