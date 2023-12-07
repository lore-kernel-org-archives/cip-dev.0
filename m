Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F374CC46CA0
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:47:26 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.84369.1701956840474461646
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:47:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189544056"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 22:47:24 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8E86642B1D29;
	Thu,  7 Dec 2023 22:47:22 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 11/18] media: renesas: vsp1: Add VSP1_HAS_NON_ZERO_LBA feature bit
Date: Thu,  7 Dec 2023 13:46:50 +0000
Message-Id: <20231207134657.371420-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
References: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:47:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13854

commit 4d728fd4c60e0f367321843290a618caf86b95cd upstream.

As per HW manual V3M and RZ/G2L SoCs has nonzero LIF buffer
attributes. So, introduce a feature bit for handling the same.

This patch also adds separate device info structure for V3M and V3H
SoCs, as both these SoCs share the same model ID, but V3H does not
have VSP1_HAS_NON_ZERO_LBA feature bit.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/platform/vsp1/vsp1.h     | 1 +
 drivers/media/platform/vsp1/vsp1_drv.c | 7 ++++++-
 drivers/media/platform/vsp1/vsp1_lif.c | 3 +--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1.h b/drivers/media/platform/vsp1/vsp1.h
index ff4435705abb..2f6f0c6ae555 100644
--- a/drivers/media/platform/vsp1/vsp1.h
+++ b/drivers/media/platform/vsp1/vsp1.h
@@ -55,6 +55,7 @@ struct vsp1_uif;
 #define VSP1_HAS_HGT		BIT(8)
 #define VSP1_HAS_BRS		BIT(9)
 #define VSP1_HAS_EXT_DL		BIT(10)
+#define VSP1_HAS_NON_ZERO_LBA	BIT(11)
 
 struct vsp1_device_info {
 	u32 version;
diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index e3026cb76dcc..b30f2a0ef285 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -790,6 +790,7 @@ static const struct vsp1_device_info vsp1_device_infos[] = {
 	}, {
 		.version = VI6_IP_VERSION_MODEL_VSPD_V3,
 		.model = "VSP2-D",
+		.soc = VI6_IP_VERSION_SOC_V3H,
 		.gen = 3,
 		.features = VSP1_HAS_BRS | VSP1_HAS_BRU,
 		.lif_count = 1,
@@ -814,6 +815,8 @@ static const struct vsp1_device_info *vsp1_lookup_info(struct vsp1_device *vsp1)
 {
 	const struct vsp1_device_info *info;
 	unsigned int i;
+	u32 model;
+	u32 soc;
 
 	/*
 	 * Try the info stored in match data first for devices that don't have
@@ -826,11 +829,13 @@ static const struct vsp1_device_info *vsp1_lookup_info(struct vsp1_device *vsp1)
 	}
 
 	vsp1->version = vsp1_read(vsp1, VI6_IP_VERSION);
+	model = vsp1->version & VI6_IP_VERSION_MODEL_MASK;
+	soc = vsp1->version & VI6_IP_VERSION_SOC_MASK;
 
 	for (i = 0; i < ARRAY_SIZE(vsp1_device_infos); ++i) {
 		info = &vsp1_device_infos[i];
 
-		if ((vsp1->version & VI6_IP_VERSION_MODEL_MASK) == info->version)
+		if (model == info->version && (!info->soc || soc == info->soc))
 			return info;
 	}
 
diff --git a/drivers/media/platform/vsp1/vsp1_lif.c b/drivers/media/platform/vsp1/vsp1_lif.c
index 14ed5d7bd061..5205f34699a1 100644
--- a/drivers/media/platform/vsp1/vsp1_lif.c
+++ b/drivers/media/platform/vsp1/vsp1_lif.c
@@ -134,8 +134,7 @@ static void lif_configure_stream(struct vsp1_entity *entity,
 	 * may appear on the output). The value required by the manual is not
 	 * explained but is likely a buffer size or threshold.
 	 */
-	if ((entity->vsp1->version & VI6_IP_VERSION_MASK) ==
-	    (VI6_IP_VERSION_MODEL_VSPD_V3 | VI6_IP_VERSION_SOC_V3M))
+	if (vsp1_feature(entity->vsp1, VSP1_HAS_NON_ZERO_LBA))
 		vsp1_lif_write(lif, dlb, VI6_LIF_LBA,
 			       VI6_LIF_LBA_LBA0 |
 			       (1536 << VI6_LIF_LBA_LBA1_SHIFT));
-- 
2.25.1


