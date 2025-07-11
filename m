Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D777C83F1A
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 16:32:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.18317.1752251561490884650
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jul 2025 09:32:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: +rFqQCwrSSKiZYceeY02sw==
X-CSE-MsgGUID: B1ZaJWh4S7m2Ye8r/eCFEw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Jul 2025 01:32:40 +0900
Received: from localhost.localdomain (unknown [10.226.93.74])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1A48F402A8BF;
	Sat, 12 Jul 2025 01:32:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 7/8] drm: renesas: Add zpos, alpha and blend properties to RZ/G2L DU
Date: Fri, 11 Jul 2025 17:32:17 +0100
Message-ID: <20250711163222.191633-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
References: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 16:32:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19413

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
index 0ae6331d6430..5f8e1a713f02 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
@@ -343,6 +343,15 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 
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


