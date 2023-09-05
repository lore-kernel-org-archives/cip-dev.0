Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C3CA0FE2
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 16:07:43 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.25749.1693930062988095764
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 09:07:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,229,1688396400"; 
   d="scan'208";a="175102490"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Sep 2023 01:07:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.194])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 20760401CC90;
	Wed,  6 Sep 2023 01:07:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/20] Add Renesas RZ/G2L DSI,VSP,FCP support
Date: Tue,  5 Sep 2023 17:07:17 +0100
Message-Id: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Sep 2023 16:07:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12942

This patch series aims to add RZ/G2L DSI,VSP,FCP support
 
All the patches are cherry-picked from the mainline except the last
6 patches.

The last 6 patches are in review state and just added here for testing.

There is a plan to backport to these patch series to 5.10.y-cip
later.

Biju Das (20):
  dt-bindings: display: bridge: Document RZ/G2L MIPI DSI TX bindings
  dt-bindings: display: bridge: renesas,rzg2l-mipi-dsi: Document RZ/V2L
    support
  drm: rcar-du: Add RZ/G2L DSI driver
  drm: rcar-du: Fix Kconfig dependency between DRM and RZG2L_MIPI_DSI
  drm: rcar-du: rzg2l_mipi_dsi: Enhance device lanes check
  arm64: dts: renesas: r9a07g044: Add fcpvd node
  arm64: dts: renesas: r9a07g044: Add vspd node
  arm64: dts: renesas: r9a07g044: Add DSI node
  arm64: dts: renesas: r9a07g054: Add fcpvd node
  arm64: dts: renesas: r9a07g054: Add vspd node
  arm64: dts: renesas: r9a07g054: Add DSI node
  arm64: dts: renesas: rzg2l-smarc: Link DSI with ADV7535
  arm64: dts: renesas: rzg2lc-smarc: Link DSI with ADV7535
  arm64: defconfig: Enable Renesas RZ/G2L MIPI DSI driver
  drm: renesas: Add RZ/G2L DU Support
  arm64: dts: renesas: r9a07g044: Add DU node
  arm64: dts: renesas: r9a07g054: Add DU node
  arm64: dts: renesas: rzg2l-smarc: Enable DU and link with DSI
  arm64: dts: renesas: rzg2lc-smarc: Enable DU and link with DSI
  defconfig: Enable display on RZ/G2L SMARC EVK.

 .../bindings/display/bridge/renesas,dsi.yaml  | 183 ++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  67 ++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  69 ++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 100 +++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 100 +++
 arch/arm64/configs/defconfig                  |   2 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/rcar-du/Kconfig               |   8 +
 drivers/gpu/drm/rcar-du/Makefile              |   2 +
 drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c      | 816 ++++++++++++++++++
 drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi_regs.h | 151 ++++
 drivers/gpu/drm/rz-du/Kconfig                 |  12 +
 drivers/gpu/drm/rz-du/Makefile                |   8 +
 drivers/gpu/drm/rz-du/rzg2l_du_crtc.c         | 599 +++++++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_crtc.h         |  92 ++
 drivers/gpu/drm/rz-du/rzg2l_du_drv.c          | 185 ++++
 drivers/gpu/drm/rz-du/rzg2l_du_drv.h          |  84 ++
 drivers/gpu/drm/rz-du/rzg2l_du_encoder.c      | 109 +++
 drivers/gpu/drm/rz-du/rzg2l_du_encoder.h      |  32 +
 drivers/gpu/drm/rz-du/rzg2l_du_kms.c          | 711 +++++++++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_kms.h          |  43 +
 drivers/gpu/drm/rz-du/rzg2l_du_regs.h         |  67 ++
 drivers/gpu/drm/rz-du/rzg2l_du_vsp.c          | 469 ++++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_vsp.h          |  97 +++
 25 files changed, 4009 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
 create mode 100644 drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
 create mode 100644 drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi_regs.h
 create mode 100644 drivers/gpu/drm/rz-du/Kconfig
 create mode 100644 drivers/gpu/drm/rz-du/Makefile
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_crtc.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_crtc.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_drv.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_drv.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_encoder.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_encoder.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_kms.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_kms.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_regs.h
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_vsp.c
 create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_vsp.h

-- 
2.25.1


