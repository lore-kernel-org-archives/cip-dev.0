Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8B6C83F20
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 16:32:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.18311.1752251551050692981
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jul 2025 09:32:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: e7atOEHCSL2oIUljcOmAHA==
X-CSE-MsgGUID: 0vBzS0j/TMW47JyAGGs71g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Jul 2025 01:32:30 +0900
Received: from localhost.localdomain (unknown [10.226.93.74])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 92938402A8BF;
	Sat, 12 Jul 2025 01:32:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 2/8] drm: renesas: rz-du: rzg2l_du_encoder: Fix max dot clock for DPI
Date: Fri, 11 Jul 2025 17:32:12 +0100
Message-ID: <20250711163222.191633-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
References: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 16:32:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19408

commit 68573a561362cc11d4dbfdcf97127fbf0e118896 upstream.

As per the RZ/G2UL hardware manual Table 33.4 Clock List, the maximum
dot clock for the DPI interface is 83.5 MHz. Add mode_valid callback
to reject modes greater than 83.5 MHz.

Suggested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241022082433.32513-3-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index 339cbaaea0b5..564ab4cb3d37 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/of.h>
 
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_panel.h>
@@ -24,6 +25,22 @@
 static const struct drm_encoder_funcs rzg2l_du_encoder_funcs = {
 };
 
+static enum drm_mode_status
+rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
+			    const struct drm_display_mode *mode)
+{
+	struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
+
+	if (renc->output == RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83500)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
+static const struct drm_encoder_helper_funcs rzg2l_du_encoder_helper_funcs = {
+	.mode_valid = rzg2l_du_encoder_mode_valid,
+};
+
 int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 			  enum rzg2l_du_output output,
 			  struct device_node *enc_node)
@@ -48,6 +65,7 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 		return PTR_ERR(renc);
 
 	renc->output = output;
+	drm_encoder_helper_add(&renc->base, &rzg2l_du_encoder_helper_funcs);
 
 	/* Attach the bridge to the encoder. */
 	ret = drm_bridge_attach(&renc->base, bridge, NULL,
-- 
2.43.0


