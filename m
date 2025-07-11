Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD67C83F1B
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 18:27:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20853.1752258435651618686
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jul 2025 11:27:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: NQMHEVleQmSxOj3lo4zqbA==
X-CSE-MsgGUID: AgdlTeKyRtuzFhdObKjnBg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 12 Jul 2025 03:27:20 +0900
Received: from localhost.localdomain (unknown [10.226.93.74])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 61B78401C775;
	Sat, 12 Jul 2025 03:27:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 6/7] drm: renesas: Add zpos, alpha and blend properties to RZ/G2L DU
Date: Fri, 11 Jul 2025 19:27:00 +0100
Message-ID: <20250711182705.346314-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711182705.346314-1-biju.das.jz@bp.renesas.com>
References: <20250711182705.346314-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 18:27:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19421

commit e7bb7d44c3b97aea1f0e354c6499900154ac67f2 upstream.

Add support for zpos, alpha and blend properties to RZ/G2L DU
driver as the IP supports all these properties.

It is tested by the below modetest commands:

modetest -M rzg2l-du -s 44@42:1920x1080@AR24 -d -P \
37@42:512x300+200+200@XR15

modetest -M rzg2l-du -w {32,37}:alpha:{0,65535}
modetest -M rzg2l-du -w {32,37}:zpos:{0,1}

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> #On RZ/V2H
Link: https://lore.kernel.org/r/20250404133047.172080-1-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
index 8cf7b7a9bef6e..aa6da9fd93af2 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
@@ -338,6 +338,15 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 
 		drm_plane_helper_add(&plane->plane,
 				     &rzg2l_du_vsp_plane_helper_funcs);
+
+		drm_plane_create_alpha_property(&plane->plane);
+		drm_plane_create_zpos_property(&plane->plane, i, 0,
+					       num_planes - 1);
+
+		drm_plane_create_blend_mode_property(&plane->plane,
+					BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+					BIT(DRM_MODE_BLEND_PREMULTI) |
+					BIT(DRM_MODE_BLEND_COVERAGE));
 	}
 
 	return 0;
-- 
2.43.0


