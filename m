Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424C5FD374C
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 12:13:13 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43799.1772021557809195659
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 04:13:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 0vKEQ6vSQV+pPdXwgq1K7A==
X-CSE-MsgGUID: urEYP3c5TDWNCwicKUxsRg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Feb 2026 21:13:04 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 72F1B401CBF7;
	Wed, 25 Feb 2026 21:13:03 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 16/24] drm: renesas: rz-du: mipi_dsi: Add dphy_late_init() callback for RZ/V2H(P)
Date: Wed, 25 Feb 2026 12:12:24 +0000
Message-ID: <20260225121232.129678-17-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
References: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 12:13:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21973

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7c1e102ccf1d276bbaee2ddb601b0bdeb6eeaf5c upstream.

Introduce the `dphy_late_init` callback in `rzg2l_mipi_dsi_hw_info` to
allow additional D-PHY register configurations after enabling data and
clock lanes. This is required for the RZ/V2H(P) SoC but not for the
RZ/G2L SoC.

Modify `rzg2l_mipi_dsi_startup()` to invoke `dphy_late_init` if defined,
ensuring SoC-specific initialization is performed only when necessary.

This change prepares for RZ/V2H(P) SoC support while maintaining
compatibility with existing platforms.

Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250609225630.502888-9-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 6278b8f79f4a..044eb085b960 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -34,6 +34,7 @@ struct rzg2l_mipi_dsi;
 
 struct rzg2l_mipi_dsi_hw_info {
 	int (*dphy_init)(struct rzg2l_mipi_dsi *dsi, u64 hsfreq_millihz);
+	void (*dphy_startup_late_init)(struct rzg2l_mipi_dsi *dsi);
 	void (*dphy_exit)(struct rzg2l_mipi_dsi *dsi);
 	u32 phy_reg_offset;
 	u32 link_reg_offset;
@@ -320,6 +321,9 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 	txsetr = TXSETR_DLEN | TXSETR_NUMLANEUSE(dsi->lanes - 1) | TXSETR_CLEN;
 	rzg2l_mipi_dsi_link_write(dsi, TXSETR, txsetr);
 
+	if (dsi->info->dphy_startup_late_init)
+		dsi->info->dphy_startup_late_init(dsi);
+
 	hsfreq = DIV_ROUND_CLOSEST_ULL(hsfreq_millihz, MILLI);
 	/*
 	 * Global timings characteristic depends on high speed Clock Frequency
-- 
2.51.0


