Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E88EC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:47:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.83979.1701956852224363063
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:47:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189544064"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 22:47:30 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 22E4B42B1D15;
	Thu,  7 Dec 2023 22:47:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 14/18] media: renesas: vsp1: Add support for RZ/G2L VSPD
Date: Thu,  7 Dec 2023 13:46:53 +0000
Message-Id: <20231207134657.371420-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
References: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:47:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13857

commit 882bda188f691320a001c6adc738c4a7ec102a8d upstream.

The RZ/G2L VSPD provides a single VSPD instance. It has the following
sub modules MAU, CTU, RPF, DPR, LUT, BRS, WPF and LIF.

The VSPD block on RZ/G2L SoCs does not have a version register, so
added a new compatible string "renesas,r9a07g044-vsp2" with a data
pointer containing the info structure. Also the reset line is shared
with the DU module.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/platform/vsp1/vsp1_drv.c  | 13 +++++++++++++
 drivers/media/platform/vsp1/vsp1_lif.c  |  9 +++++----
 drivers/media/platform/vsp1/vsp1_regs.h |  5 +++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index b30f2a0ef285..805b868e8c55 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -811,6 +811,18 @@ static const struct vsp1_device_info vsp1_device_infos[] = {
 	},
 };
 
+static const struct vsp1_device_info rzg2l_vsp2_device_info = {
+	.version = VI6_IP_VERSION_MODEL_VSPD_RZG2L,
+	.model = "VSP2-D",
+	.soc = VI6_IP_VERSION_SOC_RZG2L,
+	.gen = 3,
+	.features = VSP1_HAS_BRS | VSP1_HAS_WPF_VFLIP | VSP1_HAS_EXT_DL
+		  | VSP1_HAS_NON_ZERO_LBA,
+	.lif_count = 1,
+	.rpf_count = 2,
+	.wpf_count = 1,
+};
+
 static const struct vsp1_device_info *vsp1_lookup_info(struct vsp1_device *vsp1)
 {
 	const struct vsp1_device_info *info;
@@ -961,6 +973,7 @@ static int vsp1_remove(struct platform_device *pdev)
 static const struct of_device_id vsp1_of_match[] = {
 	{ .compatible = "renesas,vsp1" },
 	{ .compatible = "renesas,vsp2" },
+	{ .compatible = "renesas,r9a07g044-vsp2", .data = &rzg2l_vsp2_device_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, vsp1_of_match);
diff --git a/drivers/media/platform/vsp1/vsp1_lif.c b/drivers/media/platform/vsp1/vsp1_lif.c
index 5205f34699a1..6a5c03d64c6e 100644
--- a/drivers/media/platform/vsp1/vsp1_lif.c
+++ b/drivers/media/platform/vsp1/vsp1_lif.c
@@ -106,6 +106,7 @@ static void lif_configure_stream(struct vsp1_entity *entity,
 
 	case VI6_IP_VERSION_MODEL_VSPDL_GEN3:
 	case VI6_IP_VERSION_MODEL_VSPD_V3:
+	case VI6_IP_VERSION_MODEL_VSPD_RZG2L:
 		hbth = 0;
 		obth = 1500;
 		lbth = 0;
@@ -129,10 +130,10 @@ static void lif_configure_stream(struct vsp1_entity *entity,
 			VI6_LIF_CTRL_REQSEL | VI6_LIF_CTRL_LIF_EN);
 
 	/*
-	 * On R-Car V3M the LIF0 buffer attribute register has to be set to a
-	 * non-default value to guarantee proper operation (otherwise artifacts
-	 * may appear on the output). The value required by the manual is not
-	 * explained but is likely a buffer size or threshold.
+	 * On R-Car V3M and RZ/G2L the LIF0 buffer attribute register has to be
+	 * set to a non-default value to guarantee proper operation (otherwise
+	 * artifacts may appear on the output). The value required by the
+	 * manual is not explained but is likely a buffer size or threshold.
 	 */
 	if (vsp1_feature(entity->vsp1, VSP1_HAS_NON_ZERO_LBA))
 		vsp1_lif_write(lif, dlb, VI6_LIF_LBA,
diff --git a/drivers/media/platform/vsp1/vsp1_regs.h b/drivers/media/platform/vsp1/vsp1_regs.h
index ce8707ff1f13..0569869f332f 100644
--- a/drivers/media/platform/vsp1/vsp1_regs.h
+++ b/drivers/media/platform/vsp1/vsp1_regs.h
@@ -766,6 +766,9 @@
 #define VI6_IP_VERSION_MODEL_VSPD_V3	(0x18 << 8)
 #define VI6_IP_VERSION_MODEL_VSPDL_GEN3	(0x19 << 8)
 #define VI6_IP_VERSION_MODEL_VSPBS_GEN3	(0x1a << 8)
+/* RZ/G2L SoCs have no version register, So use 0x80 as the model version */
+#define VI6_IP_VERSION_MODEL_VSPD_RZG2L	(0x80 << 8)
+
 #define VI6_IP_VERSION_SOC_MASK		(0xff << 0)
 #define VI6_IP_VERSION_SOC_H2		(0x01 << 0)
 #define VI6_IP_VERSION_SOC_V2H		(0x01 << 0)
@@ -777,6 +780,8 @@
 #define VI6_IP_VERSION_SOC_D3		(0x04 << 0)
 #define VI6_IP_VERSION_SOC_M3N		(0x04 << 0)
 #define VI6_IP_VERSION_SOC_E3		(0x04 << 0)
+/* RZ/G2L SoCs have no version register, So use 0x80 for SoC Identification */
+#define VI6_IP_VERSION_SOC_RZG2L	(0x80 << 0)
 
 #define VI6_IP_VERSION_VSP_SW		(0xfffe << 16) /* SW VSP version */
 
-- 
2.25.1


