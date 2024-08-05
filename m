Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1934C3DA4A
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 16:44:38 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.12769.1722876265945965968
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 09:44:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,265,1716217200"; 
   d="scan'208";a="214739932"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Aug 2024 01:44:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.197])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F410B40213EE;
	Tue,  6 Aug 2024 01:44:27 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 21/30] media: platform: rzg2l-cru: rzg2l-video: Fix start reception procedure
Date: Mon,  5 Aug 2024 17:43:14 +0100
Message-ID: <20240805164342.211857-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 16:44:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16743

commit 6bcff5f958e45a21f74d140c58e061999e97cd50 upstream.

As per section 35.3.1 Starting Reception for the MIPI CSI-2 Input on the
latest hardware manual (R01UH0914EJ0145 Rev.1.45) we need to supply all
the clocks and then release the CRU resets. Currently we are releasing
the resets and then supplying the clocks. So, fix the start reception
procedure.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20240213181233.242316-6-biju.das.jz@bp.renesas.com
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 59 +++++++++----------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index c2038face539..96ccc0edfa70 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -489,39 +489,24 @@ static int rzg2l_cru_set_stream(struct rzg2l_cru_dev *cru, int on)
 
 		video_device_pipeline_stop(&cru->vdev);
 
-		pm_runtime_put_sync(cru->dev);
-		clk_disable_unprepare(cru->vclk);
-
 		return stream_off_ret;
 	}
 
-	ret = pm_runtime_resume_and_get(cru->dev);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(cru->vclk);
-	if (ret)
-		goto err_pm_put;
-
 	ret = rzg2l_cru_mc_validate_format(cru, sd, pad);
 	if (ret)
-		goto err_vclk_disable;
+		return ret;
 
 	pipe = media_entity_pipeline(&sd->entity) ? : &cru->vdev.pipe;
 	ret = video_device_pipeline_start(&cru->vdev, pipe);
 	if (ret)
-		goto err_vclk_disable;
+		return ret;
 
 	ret = v4l2_subdev_call(sd, video, pre_streamon, 0);
-	if (ret == -ENOIOCTLCMD)
-		ret = 0;
-	if (ret)
+	if (ret && ret != -ENOIOCTLCMD)
 		goto pipe_line_stop;
 
 	ret = v4l2_subdev_call(sd, video, s_stream, 1);
-	if (ret == -ENOIOCTLCMD)
-		ret = 0;
-	if (ret)
+	if (ret && ret != -ENOIOCTLCMD)
 		goto err_s_stream;
 
 	return 0;
@@ -532,12 +517,6 @@ static int rzg2l_cru_set_stream(struct rzg2l_cru_dev *cru, int on)
 pipe_line_stop:
 	video_device_pipeline_stop(&cru->vdev);
 
-err_vclk_disable:
-	clk_disable_unprepare(cru->vclk);
-
-err_pm_put:
-	pm_runtime_put_sync(cru->dev);
-
 	return ret;
 }
 
@@ -636,25 +615,33 @@ static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq, unsigned int count
 	struct rzg2l_cru_dev *cru = vb2_get_drv_priv(vq);
 	int ret;
 
+	ret = pm_runtime_resume_and_get(cru->dev);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(cru->vclk);
+	if (ret)
+		goto err_pm_put;
+
 	/* Release reset state */
 	ret = reset_control_deassert(cru->aresetn);
 	if (ret) {
 		dev_err(cru->dev, "failed to deassert aresetn\n");
-		return ret;
+		goto err_vclk_disable;
 	}
 
 	ret = reset_control_deassert(cru->presetn);
 	if (ret) {
 		reset_control_assert(cru->aresetn);
 		dev_err(cru->dev, "failed to deassert presetn\n");
-		return ret;
+		goto assert_aresetn;
 	}
 
 	ret = request_irq(cru->image_conv_irq, rzg2l_cru_irq,
 			  IRQF_SHARED, KBUILD_MODNAME, cru);
 	if (ret) {
 		dev_err(cru->dev, "failed to request irq\n");
-		goto assert_resets;
+		goto assert_presetn;
 	}
 
 	/* Allocate scratch buffer. */
@@ -686,10 +673,18 @@ static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq, unsigned int count
 free_image_conv_irq:
 	free_irq(cru->image_conv_irq, cru);
 
-assert_resets:
+assert_presetn:
 	reset_control_assert(cru->presetn);
+
+assert_aresetn:
 	reset_control_assert(cru->aresetn);
 
+err_vclk_disable:
+	clk_disable_unprepare(cru->vclk);
+
+err_pm_put:
+	pm_runtime_put_sync(cru->dev);
+
 	return ret;
 }
 
@@ -704,9 +699,11 @@ static void rzg2l_cru_stop_streaming_vq(struct vb2_queue *vq)
 			  cru->scratch, cru->scratch_phys);
 
 	free_irq(cru->image_conv_irq, cru);
-	reset_control_assert(cru->presetn);
-
 	return_unused_buffers(cru, VB2_BUF_STATE_ERROR);
+
+	reset_control_assert(cru->presetn);
+	clk_disable_unprepare(cru->vclk);
+	pm_runtime_put_sync(cru->dev);
 }
 
 static const struct vb2_ops rzg2l_cru_qops = {
-- 
2.43.0


