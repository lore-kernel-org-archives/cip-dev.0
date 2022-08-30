X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.12176.1661869338901959922
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Aug 2022 07:22:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,275,1654527600"; 
   d="scan'208";a="133104450"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 Aug 2022 23:22:17 +0900
Received: from localhost.localdomain (unknown [10.226.92.122])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D7BD8439A389;
	Tue, 30 Aug 2022 23:22:14 +0900 (JST)
From: "Biju Das" <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip] drm: rcar-du: Fix Alpha blending issue on Gen3
Date: Tue, 30 Aug 2022 15:22:12 +0100
Message-Id: <20220830142212.1269865-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: LUU HOAI <hoai.luu.ub@renesas.com>

commit b7aaa61726cbc7b941007af14a9f991a828c67e4 upstream.

As per R-Car-Gen3_Common_OPC_Customer_Notifications_V30.1.pdf,
unexpected image output(such as incorrect colors or planes being
invisible) can happen on the below conditions, as PnALPHAR register
is not initialized by reset.

When alpha blending (PpMRm.PpSPIM=0b101) is performed and:
	•two Planes are enabled on any DUn (n=0,1,2,3)
		oDSPRn= 0x0000 0031 or 0x0000 0013
	•or DU0 and DU1 is used for display at the same time
		oDSPR0= 0x0000 0001 and DSPR1= 0x0000 0003
		oDSPR0= 0x0000 0003 and DSPR1= 0x0000 0001
	•or DU2 and DU3(H3 Only) is used for display at the same time
		oDSPR2= 0x0000 0001 and DSPR3= 0x0000 0003
		oDSPR2= 0x0000 0003 and DSPR3= 0x0000 0001

This patch set PnALPHAR register to 0 to avoid this issue.

Signed-off-by: LUU HOAI <hoai.luu.ub@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index a0021fc25b27..151efd25b554 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -510,6 +510,18 @@ static void rcar_du_plane_setup_format_gen3(struct rcar_du_group *rgrp,
 
 	rcar_du_plane_write(rgrp, index, PnDDCR4,
 			    state->format->edf | PnDDCR4_CODE);
+
+	/*
+	 * On Gen3, some DU channels have two planes, each being wired to a
+	 * separate VSPD instance. The DU can then blend two planes. While
+	 * this feature isn't used by the driver, issues related to alpha
+	 * blending (such as incorrect colors or planes being invisible) may
+	 * still occur if the PnALPHAR register has a stale value. Set the
+	 * register to 0 to avoid this.
+	 */
+
+	/* TODO: Check if alpha-blending should be disabled in PnMR. */
+	rcar_du_plane_write(rgrp, index, PnALPHAR, 0);
 }
 
 static void rcar_du_plane_setup_format(struct rcar_du_group *rgrp,
-- 
2.25.1


