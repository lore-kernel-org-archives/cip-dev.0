Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E0C3DA7F
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 16:44:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.12824.1722876257681924282
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 09:44:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,265,1716217200"; 
   d="scan'208";a="218711342"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Aug 2024 01:44:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.197])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E26D040213EE;
	Tue,  6 Aug 2024 01:44:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 20/30] media: platform: rzg2l-cru: rzg2l-csi2: Restructure vclk handling
Date: Mon,  5 Aug 2024 17:43:13 +0100
Message-ID: <20240805164342.211857-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 16:44:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16742

commit fdc7bd5b3a64277c9427576a596df572d563dc3d upstream.

As per section 35.3.1 Starting Reception for the MIPI CSI-2 Input on the
latest hardware manual (R01UH0914EJ0145 Rev.1.45) we need to disable the
vclk before enabling the LINK reception and enable the vclk after enabling
the link Reception. So restructure vclk handling as per the HW manual.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20240213181233.242316-5-biju.das.jz@bp.renesas.com
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  3 --
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 28 +++++++++++--------
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     | 15 ++--------
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 10 -------
 4 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 0b682cbae3eb..9fb70d73266a 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -133,9 +133,6 @@ struct rzg2l_cru_dev {
 	struct v4l2_pix_format format;
 };
 
-void rzg2l_cru_vclk_unprepare(struct rzg2l_cru_dev *cru);
-int rzg2l_cru_vclk_prepare(struct rzg2l_cru_dev *cru);
-
 int rzg2l_cru_start_image_processing(struct rzg2l_cru_dev *cru);
 void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru);
 
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 3e9c43d59e29..bd06cdb27ec9 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -109,6 +109,7 @@ struct rzg2l_csi2 {
 	struct reset_control *presetn;
 	struct reset_control *cmn_rstb;
 	struct clk *sysclk;
+	struct clk *vclk;
 	unsigned long vclk_rate;
 
 	struct v4l2_subdev subdev;
@@ -362,7 +363,7 @@ static int rzg2l_csi2_dphy_setting(struct v4l2_subdev *sd, bool on)
 	return rzg2l_csi2_dphy_disable(csi2);
 }
 
-static void rzg2l_csi2_mipi_link_enable(struct rzg2l_csi2 *csi2)
+static int rzg2l_csi2_mipi_link_enable(struct rzg2l_csi2 *csi2)
 {
 	unsigned long vclk_rate = csi2->vclk_rate / HZ_PER_MHZ;
 	u32 frrskw, frrclk, frrskw_coeff, frrclk_coeff;
@@ -387,11 +388,15 @@ static void rzg2l_csi2_mipi_link_enable(struct rzg2l_csi2 *csi2)
 	rzg2l_csi2_write(csi2, CSI2nDTEL, 0xf778ff0f);
 	rzg2l_csi2_write(csi2, CSI2nDTEH, 0x00ffff1f);
 
+	clk_disable_unprepare(csi2->vclk);
+
 	/* Enable LINK reception */
 	rzg2l_csi2_write(csi2, CSI2nMCT3, CSI2nMCT3_RXEN);
+
+	return clk_prepare_enable(csi2->vclk);
 }
 
-static void rzg2l_csi2_mipi_link_disable(struct rzg2l_csi2 *csi2)
+static int rzg2l_csi2_mipi_link_disable(struct rzg2l_csi2 *csi2)
 {
 	unsigned int timeout = VSRSTS_RETRIES;
 
@@ -410,18 +415,21 @@ static void rzg2l_csi2_mipi_link_disable(struct rzg2l_csi2 *csi2)
 
 	if (!timeout)
 		dev_err(csi2->dev, "Clearing CSI2nRTST.VSRSTS timed out\n");
+
+	return 0;
 }
 
 static int rzg2l_csi2_mipi_link_setting(struct v4l2_subdev *sd, bool on)
 {
 	struct rzg2l_csi2 *csi2 = sd_to_csi2(sd);
+	int ret;
 
 	if (on)
-		rzg2l_csi2_mipi_link_enable(csi2);
+		ret = rzg2l_csi2_mipi_link_enable(csi2);
 	else
-		rzg2l_csi2_mipi_link_disable(csi2);
+		ret = rzg2l_csi2_mipi_link_disable(csi2);
 
-	return 0;
+	return ret;
 }
 
 static int rzg2l_csi2_s_stream(struct v4l2_subdev *sd, int enable)
@@ -729,7 +737,6 @@ static const struct media_entity_operations rzg2l_csi2_entity_ops = {
 static int rzg2l_csi2_probe(struct platform_device *pdev)
 {
 	struct rzg2l_csi2 *csi2;
-	struct clk *vclk;
 	int ret;
 
 	csi2 = devm_kzalloc(&pdev->dev, sizeof(*csi2), GFP_KERNEL);
@@ -755,12 +762,11 @@ static int rzg2l_csi2_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->sysclk),
 				     "Failed to get system clk\n");
 
-	vclk = clk_get(&pdev->dev, "video");
-	if (IS_ERR(vclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(vclk),
+	csi2->vclk = devm_clk_get(&pdev->dev, "video");
+	if (IS_ERR(csi2->vclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(csi2->vclk),
 				     "Failed to get video clock\n");
-	csi2->vclk_rate = clk_get_rate(vclk);
-	clk_put(vclk);
+	csi2->vclk_rate = clk_get_rate(csi2->vclk);
 
 	csi2->dev = &pdev->dev;
 
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index bbb3d8e93c64..3433a831aef3 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -80,20 +80,9 @@ static int rzg2l_cru_ip_s_stream(struct v4l2_subdev *sd, int enable)
 			return ret;
 		}
 
-		rzg2l_cru_vclk_unprepare(cru);
-
 		ret = v4l2_subdev_call(cru->ip.remote, video, s_stream, enable);
-		if (ret == -ENOIOCTLCMD)
-			ret = 0;
-		if (!ret) {
-			ret = rzg2l_cru_vclk_prepare(cru);
-			if (!ret)
-				return 0;
-		} else {
-			/* enable back vclk so that s_stream in error path disables it */
-			if (rzg2l_cru_vclk_prepare(cru))
-				dev_err(cru->dev, "Failed to enable vclk\n");
-		}
+		if (!ret || ret == -ENOIOCTLCMD)
+			return 0;
 
 		s_stream_ret = ret;
 
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 6d03b3a2af5e..c2038face539 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -461,16 +461,6 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_dev *cru)
 	return 0;
 }
 
-void rzg2l_cru_vclk_unprepare(struct rzg2l_cru_dev *cru)
-{
-	clk_disable_unprepare(cru->vclk);
-}
-
-int rzg2l_cru_vclk_prepare(struct rzg2l_cru_dev *cru)
-{
-	return clk_prepare_enable(cru->vclk);
-}
-
 static int rzg2l_cru_set_stream(struct rzg2l_cru_dev *cru, int on)
 {
 	struct media_pipeline *pipe;
-- 
2.43.0


