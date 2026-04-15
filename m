Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBA3F4212F
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 18:18:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1945.1776277096286510704
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 11:18:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: t8a8E8f/TEWBx/XJWdSZFQ==
X-CSE-MsgGUID: 9nnCEuWsRBORmZgB9oLroA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Apr 2026 03:18:18 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5D3E2405BF70;
	Thu, 16 Apr 2026 03:18:17 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 5.10.y-cip 04/10] drm: renesas: rz-du: mipi_dsi: Set DSI divider
Date: Wed, 15 Apr 2026 14:18:03 -0400
Message-ID: <20260415181810.4073807-5-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260415181810.4073807-1-chris.brandt@renesas.com>
References: <20260415181810.4073807-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 18:18:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22724

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
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index ddb18767754c..415143bb00be 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -7,6 +7,7 @@

 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/clk/renesas.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
@@ -652,6 +653,7 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 				      struct mipi_dsi_device *device)
 {
 	struct rzg2l_mipi_dsi *dsi = host_to_rzg2l_mipi_dsi(host);
+	int bpp;

 	if (device->lanes > dsi->num_data_lanes) {
 		dev_err(dsi->dev,
@@ -660,7 +662,8 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 		return -EINVAL;
 	}

-	switch (mipi_dsi_pixel_format_to_bpp(device->format)) {
+	bpp = mipi_dsi_pixel_format_to_bpp(device->format);
+	switch (bpp) {
 	case 24:
 	case 18:
 		break;
@@ -673,6 +676,18 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->format = device->format;
 	dsi->mode_flags = device->mode_flags;

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


