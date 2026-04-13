Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DACF34C76
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 17:17:43 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.277700.1776100659634165962
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Apr 2026 10:17:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: dCzvWrVBSe6JdiaC68IyCQ==
X-CSE-MsgGUID: i7bcYKh9Qj2U6pwlRjQlhg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Apr 2026 02:17:39 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 174C24036C46;
	Tue, 14 Apr 2026 02:17:37 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 6.12.y-cip 3/7] drm: renesas: rz-du: mipi_dsi: fix kernel panic when rebooting for some panels
Date: Mon, 13 Apr 2026 13:17:29 -0400
Message-ID: <20260413171733.3088070-3-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171733.3088070-1-chris.brandt@renesas.com>
References: <20260413171733.3088070-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 17:17:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22684

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

commit 64aa8b3a60a825134f7d866adf05c024bbe0c24c upstream.

Since commit 56de5e305d4b ("clk: renesas: r9a07g044: Add MSTOP for RZ/G2L")
we may get the following kernel panic, for some panels, when rebooting:

  systemd-shutdown[1]: Rebooting.
  Call trace:
   ...
   do_serror+0x28/0x68
   el1h_64_error_handler+0x34/0x50
   el1h_64_error+0x6c/0x70
   rzg2l_mipi_dsi_host_transfer+0x114/0x458 (P)
   mipi_dsi_device_transfer+0x44/0x58
   mipi_dsi_dcs_set_display_off_multi+0x9c/0xc4
   ili9881c_unprepare+0x38/0x88
   drm_panel_unprepare+0xbc/0x108

This happens for panels that need to send MIPI-DSI commands in their
unprepare() callback. Since the MIPI-DSI interface is stopped at that
point, rzg2l_mipi_dsi_host_transfer() triggers the kernel panic.

Fix by moving rzg2l_mipi_dsi_stop() to new callback function
rzg2l_mipi_dsi_atomic_post_disable().

With this change we now have the correct power-down/stop sequence:

  systemd-shutdown[1]: Rebooting.
  rzg2l-mipi-dsi 10850000.dsi: rzg2l_mipi_dsi_atomic_disable(): entry
  ili9881c-dsi 10850000.dsi.0: ili9881c_unprepare(): entry
  rzg2l-mipi-dsi 10850000.dsi: rzg2l_mipi_dsi_atomic_post_disable(): entry
  reboot: Restarting system

Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260112154333.655352-1-hugo@hugovil.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 7042ee9ad4aa..44c47556ae46 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1068,6 +1068,13 @@ static void rzg2l_mipi_dsi_atomic_disable(struct drm_bridge *bridge,

 	rzg2l_mipi_dsi_stop_video(dsi);
 	rzg2l_mipi_dsi_stop_hs_clock(dsi);
+}
+
+static void rzg2l_mipi_dsi_atomic_post_disable(struct drm_bridge *bridge,
+					       struct drm_bridge_state *old_bridge_state)
+{
+	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
+
 	rzg2l_mipi_dsi_stop(dsi);
 }

@@ -1103,6 +1110,7 @@ static const struct drm_bridge_funcs rzg2l_mipi_dsi_bridge_ops = {
 	.atomic_pre_enable = rzg2l_mipi_dsi_atomic_pre_enable,
 	.atomic_enable = rzg2l_mipi_dsi_atomic_enable,
 	.atomic_disable = rzg2l_mipi_dsi_atomic_disable,
+	.atomic_post_disable = rzg2l_mipi_dsi_atomic_post_disable,
 	.mode_valid = rzg2l_mipi_dsi_bridge_mode_valid,
 };

--
2.52.0


