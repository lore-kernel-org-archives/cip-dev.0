Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C3CC83F1A
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 16:32:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.18309.1752251547448211862
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jul 2025 09:32:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: DAInireVT/mEeHMLCo3dHQ==
X-CSE-MsgGUID: 9VghqsLRRIOHQNAPUbIzgw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Jul 2025 01:32:25 +0900
Received: from localhost.localdomain (unknown [10.226.93.74])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6975D402AA23;
	Sat, 12 Jul 2025 01:32:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 0/8] RZ/G2L DU enhancements
Date: Fri, 11 Jul 2025 17:32:10 +0100
Message-ID: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 16:32:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19406

This patch series for enhancing RZ/G2L DU driver.
All the patches are cherry-picked from mainline.

Biju Das (6):
  drm: renesas: rz-du: Drop DU_MCR0_DPI_OE macro
  drm: renesas: rz-du: rzg2l_du_encoder: Fix max dot clock for DPI
  drm: renesas: rz-du: Add Kconfig dependency between RZG2L_DU and
    RZG2L_MIPI_DSI
  drm: renesas: rz-du: Drop bpp variable from struct
    rzg2l_du_format_info
  drm: renesas: Add zpos, alpha and blend properties to RZ/G2L DU
  drm: renesas: rz-du: rzg2l_mipi_dsi: Update the comment in
    rzg2l_mipi_dsi_start_video()

Kieran Bingham (1):
  drm: renesas: Extend RZ/G2L supported KMS formats

Laurent Pinchart (1):
  drm: renesas: rz-du: Support dmabuf import

 drivers/gpu/drm/renesas/rz-du/Kconfig         |  15 ++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |   8 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |   1 +
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  18 +++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  | 120 +++++++++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h  |   1 -
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  |   9 ++
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    |   2 +-
 8 files changed, 153 insertions(+), 21 deletions(-)

-- 
2.43.0


