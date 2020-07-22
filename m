Return-Path: <SRS0=fQfx=BB=lists.cip-project.org=bounce+64572+4966+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5404C433E6
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F2E207BB
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="SMibgbCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F2E207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4966+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FBefYY4521723xUbYIXJzpTt; Wed, 22 Jul 2020 10:47:07 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.23131.1595435702347090404
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:02 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52832222"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2020 01:35:01 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 53E8D40078CA;
	Thu, 23 Jul 2020 01:35:00 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 05/17] drm: rcar-du: Skip LVDS1 output on Gen3 when using dual-link LVDS mode
Date: Wed, 22 Jul 2020 17:34:37 +0100
Message-Id: <20200722163449.3513-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qhlYak5WLOHXaViZQ4QCxLoDx4520388AA=
Content-Type: multipart/mixed; boundary="hu7oc2A1YQRAUCR1HATY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440027;
 bh=5fDaMf1AuoaPBd32DS+PHGlgSJ/MPlhToELLwlfU1r8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=SMibgbCOJmrBHhkJ7akneaaNFcnUhiTcsBzNpt51HZDkbyMyRMbAkaT9Xjukjxnoh2u
 iB4hdvRI6U8EmxtSPoolIMjcyRwp0yS/b9FXnjdoM5gNc2LfqNoLG0Lg3aURB7KVTcGCI
 8d0UJu94/eEKY8ONOTfVeQZgLMbrd+PJnqM=

--hu7oc2A1YQRAUCR1HATY

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 8e8fddab0d0acdefb1ad76852d954b2bbaa3896d upstream.

In dual-link LVDS mode, the LVDS1 encoder is used as a companion for
LVDS0, and both encoders transmit data from DU0. The LVDS1 output of DU1
can't be used in that case, don't create an encoder and connector for
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 12 ++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c     |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 5cca7f7aacd8..de8fe74c0362 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -21,6 +21,7 @@
 #include "rcar_du_drv.h"
 #include "rcar_du_encoder.h"
 #include "rcar_du_kms.h"
+#include "rcar_lvds.h"
 
 /* -----------------------------------------------------------------------------
  * Encoder
@@ -60,6 +61,17 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 		goto done;
 	}
 
+	/*
+	 * On Gen3 skip the LVDS1 output if the LVDS1 encoder is used as a
+	 * companion for LVDS0 in dual-link mode.
+	 */
+	if (rcdu->info->gen >= 3 && output == RCAR_DU_OUTPUT_LVDS1) {
+		if (rcar_lvds_dual_link(bridge)) {
+			ret = -ENOLINK;
+			goto done;
+		}
+	}
+
 	ret = drm_encoder_init(rcdu->ddev, encoder, &encoder_funcs,
 			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 3257aca39a65..5cf0331defd4 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -380,7 +380,7 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 	}
 
 	ret = rcar_du_encoder_init(rcdu, output, entity);
-	if (ret && ret != -EPROBE_DEFER)
+	if (ret && ret != -EPROBE_DEFER && ret != -ENOLINK)
 		dev_warn(rcdu->dev,
 			 "failed to initialize encoder %pOF on output %u (%d), skipping\n",
 			 entity, output, ret);
-- 
2.17.1


--hu7oc2A1YQRAUCR1HATY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4966): https://lists.cip-project.org/g/cip-dev/message=
/4966
Mute This Topic: https://lists.cip-project.org/mt/75730028/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--hu7oc2A1YQRAUCR1HATY--
