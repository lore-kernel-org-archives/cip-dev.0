Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5737CC83F22
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 16:32:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.18311.1752251551050692981
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jul 2025 09:32:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 1r/+yK26Tq6jH1j4FlCcbw==
X-CSE-MsgGUID: /c/wfFuURsmbVSOfHUYyyA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Jul 2025 01:32:34 +0900
Received: from localhost.localdomain (unknown [10.226.93.74])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CA3DA402A8BF;
	Sat, 12 Jul 2025 01:32:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 4/8] drm: renesas: rz-du: Support dmabuf import
Date: Fri, 11 Jul 2025 17:32:14 +0100
Message-ID: <20250711163222.191633-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
References: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 16:32:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19410

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 66c302563985756f8154c4783b7a31e7137eb0fa upstream.

The rz-du driver uses GEM DMA helpers, but does not implement the
drm_driver .gem_prime_import_sg_table operation. This  prevents
importing dmabufs. Fix it by implementing the missing operation using
the DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE() helper macro.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com> # RZ/V2H + DSI
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250321104615.31809-1-laurent.pinchart+renesas@ideasonboard.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 6312effe8719..0259e3f280ad 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -82,6 +82,7 @@ static const struct drm_driver rzg2l_du_driver = {
 	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
 	.gem_prime_mmap		= drm_gem_prime_mmap,
+	DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(rzg2l_du_dumb_create),
 	.fops			= &rzg2l_du_fops,
 	.name			= "rzg2l-du",
 	.desc			= "Renesas RZ/G2L Display Unit",
-- 
2.43.0


