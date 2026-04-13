Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C663AF34C78
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 17:18:43 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.278275.1776100714896898936
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Apr 2026 10:18:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: ycDSVTjATq2J6bUNactLsA==
X-CSE-MsgGUID: Jl34zTy1SrmD/hMJmBWo+Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Apr 2026 02:18:34 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 06CCA4037DA6;
	Tue, 14 Apr 2026 02:18:32 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 6.1.y-cip 1/7] drm: renesas: rz-du: Add atomic_pre_enable
Date: Mon, 13 Apr 2026 13:18:25 -0400
Message-ID: <20260413171831.3091144-1-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 17:18:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22689

commit 5ce16c169a4cb8ffceabfd48853d0bf605ce785a upstream.

When drm_panel.prepare_prev_first is set to true in a panel driver, the
panel expects the MIPI DSI hardware to be already configured before the
panel's prepare function is called because it might need to send DCS
commands.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Tested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250521210335.3149065-1-chris.brandt@renesas.com
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 87e7ceeb1b02..f1ae7ecddbb2 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -999,8 +999,8 @@ static int rzg2l_mipi_dsi_attach(struct drm_bridge *bridge,
 				 flags);
 }

-static void rzg2l_mipi_dsi_atomic_enable(struct drm_bridge *bridge,
-					 struct drm_bridge_state *old_bridge_state)
+static void rzg2l_mipi_dsi_atomic_pre_enable(struct drm_bridge *bridge,
+					     struct drm_bridge_state *old_bridge_state)
 {
 	struct drm_atomic_state *state = old_bridge_state->base.state;
 	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
@@ -1018,6 +1018,13 @@ static void rzg2l_mipi_dsi_atomic_enable(struct drm_bridge *bridge,
 		return;

 	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
+}
+
+static void rzg2l_mipi_dsi_atomic_enable(struct drm_bridge *bridge,
+					 struct drm_bridge_state *old_bridge_state)
+{
+	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
+	int ret;

 	ret = rzg2l_mipi_dsi_start_hs_clock(dsi);
 	if (ret < 0)
@@ -1074,6 +1081,7 @@ static const struct drm_bridge_funcs rzg2l_mipi_dsi_bridge_ops = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_pre_enable = rzg2l_mipi_dsi_atomic_pre_enable,
 	.atomic_enable = rzg2l_mipi_dsi_atomic_enable,
 	.atomic_disable = rzg2l_mipi_dsi_atomic_disable,
 	.mode_valid = rzg2l_mipi_dsi_bridge_mode_valid,
--
2.52.0


