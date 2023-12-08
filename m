Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE93CC46CC5
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:20:43 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.35262.1702041614073951457
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:20:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,260,1695654000"; 
   d="scan'208";a="185800360"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Dec 2023 22:20:35 +0900
Received: from localhost.localdomain (unknown [10.226.92.254])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 95C0340065A7;
	Fri,  8 Dec 2023 22:20:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip v2 11/25] drm: rcar-du: rzg2l_mipi_dsi: Reorder bridge attach
Date: Fri,  8 Dec 2023 13:19:53 +0000
Message-Id: <20231208132007.108762-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
References: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:20:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13954

Add the drm_bridge_add() in probe and update rzg2l_mipi_dsi_attach()
to find the next bridge and attach the bridge. This allows DU to probe
with all the connected devices on 5.10 cip kernel.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
index aa95b85a2964..50777ed767a7 100644
--- a/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
@@ -527,6 +527,15 @@ static int rzg2l_mipi_dsi_attach(struct drm_bridge *bridge,
 				 enum drm_bridge_attach_flags flags)
 {
 	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
+	int ret;
+
+	dsi->next_bridge = devm_drm_of_get_bridge(dsi->dev, dsi->dev->of_node,
+						  1, 0);
+	if (IS_ERR(dsi->next_bridge)) {
+		ret = PTR_ERR(dsi->next_bridge);
+		dev_err(dsi->dev, "failed to get next bridge: %d\n", ret);
+		return ret;
+	}
 
 	return drm_bridge_attach(bridge->encoder, dsi->next_bridge, bridge,
 				 flags);
@@ -607,7 +616,6 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 				      struct mipi_dsi_device *device)
 {
 	struct rzg2l_mipi_dsi *dsi = host_to_rzg2l_mipi_dsi(host);
-	int ret;
 
 	if (device->lanes > dsi->num_data_lanes) {
 		dev_err(dsi->dev,
@@ -629,16 +637,6 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->format = device->format;
 	dsi->mode_flags = device->mode_flags;
 
-	dsi->next_bridge = devm_drm_of_get_bridge(dsi->dev, dsi->dev->of_node,
-						  1, 0);
-	if (IS_ERR(dsi->next_bridge)) {
-		ret = PTR_ERR(dsi->next_bridge);
-		dev_err(dsi->dev, "failed to get next bridge: %d\n", ret);
-		return ret;
-	}
-
-	drm_bridge_add(&dsi->bridge);
-
 	return 0;
 }
 
@@ -772,6 +770,8 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_pm_disable;
 
+	drm_bridge_add(&dsi->bridge);
+
 	return 0;
 
 err_phy:
-- 
2.25.1


