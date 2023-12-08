Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F6C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:20:13 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.34953.1702041612066062593
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:20:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,260,1695654000"; 
   d="scan'208";a="189673937"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Dec 2023 22:20:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.254])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0B27140065A7;
	Fri,  8 Dec 2023 22:20:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip v2 00/25] Add RZ/G2L DSI support
Date: Fri,  8 Dec 2023 13:19:42 +0000
Message-Id: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:20:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13943

This patch series aims to add RZ/G2L DSI support on
RZ/{G2L,GLC,V2L} SMARC EVKs.
 
All the patches are cherry-picked from the mainline, except [1] and [2]

Without [1] DU is giving probe failure as the encoder is not
able to find all the connected bridges due to the framework changes
between mainline and 5.10 kernel. So just restructured the bridge handling.

IA55 IRQ driver is not backported to 5.10, so defining it in dts is
giving warnings, so drop IRQs in patch[2].

Please don't apply patch#18 to patch#25 as it is added for testing purpose.

[1]
0011-drm-rcar-du-rzg2l_mipi_dsi-Reorder-bridge-attach.patch
[2]
0017-arm64-dts-renesas-Drop-ADV7535-IRQ.patch

v1->v2:
 * Fix the x86 build issue with patch#2

Biju Das (18):
  dt-bindings: display: bridge: Document RZ/G2L MIPI DSI TX bindings
  dt-bindings: display: bridge: renesas,rzg2l-mipi-dsi: Document RZ/V2L
    support
  drm: rcar-du: Add RZ/G2L DSI driver
  drm: rcar-du: Fix Kconfig dependency between DRM and RZG2L_MIPI_DSI
  drm: rcar-du: rzg2l_mipi_dsi: Enhance device lanes check
  drm: rcar-du: rzg2l_mipi_dsi: Reorder bridge attach
  arm64: defconfig: Enable Renesas RZ/G2L MIPI DSI driver
  arm64: dts: renesas: r9a07g044: Add DSI node
  arm64: dts: renesas: r9a07g054: Add DSI node
  arm64: dts: renesas: rzg2l-smarc: Link DSI with ADV7535
  arm64: dts: renesas: rzg2lc-smarc: Link DSI with ADV7535
  arm64: dts: renesas: Drop ADV7535 IRQ
  arm64: dts: renesas: r9a07g044: [HACK DO NOT APPLY] Add DU node
  arm64: dts: renesas: r9a07g054: [HACK DO NOT APPLY] Add DU node
  arm64: dts: renesas: rzg2l-smarc: [HACK DO NOT APPLY] Enable DU and
    link with DSI
  arm64: dts: renesas: rzg2lc-smarc: [HACK DO NOT APPLY] Enable DU and
    link with DSI
  drm: [HACK DO NOT APPLY] Add RZ/G2L DU Support
  defconfig: [HACK DO NOT APPLY] Enable display on RZ/G2L SMARC EVK.

Daniel Vetter (1):
  drm: [HACK DO NOT APPLY] Allow const struct drm_driver

Marek Vasut (2):
  drm: of: Add drm_of_get_data_lanes_count and drm_of_get_data_lanes_ep
  drm: of: Mark empty drm_of_get_data_lanes_count and
    drm_of_get_data_lanes_ep static

Maxime Ripard (3):
  drm/bridge: Add a function to abstract away panels
  drm/bridge: Add stubs for devm_drm_of_get_bridge when OF is disabled
  drm/bridge: Move devm_drm_of_get_bridge to bridge/panel.c

Philipp Zabel (1):
  drm: [HACK DO NOT APPLY] add drmm_encoder_alloc()

 .../bindings/display/bridge/renesas,dsi.yaml  | 183 ++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  42 +
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  43 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  98 +++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  98 +++
 arch/arm64/configs/defconfig                  |   2 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/bridge/panel.c                |  37 +
 drivers/gpu/drm/drm_bridge.c                  |   8 +-
 drivers/gpu/drm/drm_drv.c                     |  17 +-
 drivers/gpu/drm/drm_encoder.c                 | 109 ++-
 drivers/gpu/drm/drm_of.c                      |  64 ++
 drivers/gpu/drm/rcar-du/Kconfig               |   8 +
 drivers/gpu/drm/rcar-du/Makefile              |   2 +
 drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c      | 816 ++++++++++++++++++
 drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi_regs.h | 151 ++++
 drivers/gpu/drm/rz-du/Kconfig                 |  22 +
 drivers/gpu/drm/rz-du/Makefile                |   8 +
 drivers/gpu/drm/rz-du/rzg2l_du_crtc.c         | 432 ++++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_crtc.h         |  91 ++
 drivers/gpu/drm/rz-du/rzg2l_du_drv.c          | 187 ++++
 drivers/gpu/drm/rz-du/rzg2l_du_drv.h          |  85 ++
 drivers/gpu/drm/rz-du/rzg2l_du_encoder.c      | 121 +++
 drivers/gpu/drm/rz-du/rzg2l_du_encoder.h      |  33 +
 drivers/gpu/drm/rz-du/rzg2l_du_kms.c          | 389 +++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_kms.h          |  43 +
 drivers/gpu/drm/rz-du/rzg2l_du_regs.h         |  67 ++
 drivers/gpu/drm/rz-du/rzg2l_du_vsp.c          | 428 +++++++++
 drivers/gpu/drm/rz-du/rzg2l_du_vsp.h          |  96 +++
 include/drm/drm_bridge.h                      |  13 +
 include/drm/drm_device.h                      |   4 +
 include/drm/drm_drv.h                         |   5 +-
 include/drm/drm_encoder.h                     |  30 +
 include/drm/drm_of.h                          |  22 +
 35 files changed, 3722 insertions(+), 35 deletions(-)
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


