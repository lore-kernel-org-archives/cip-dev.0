Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20976C27C6E
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 10:13:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.8276.1718359994763562701
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 03:13:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="207938144"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jun 2024 19:13:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7FDFF428BB21;
	Fri, 14 Jun 2024 19:13:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/14] Add Display support for SMARC RZ/{G2L,G2LC,V2L}
Date: Fri, 14 Jun 2024 11:12:54 +0100
Message-Id: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 10:13:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16233

This patch series aims to add Display support for SMARC RZ/{G2L,G2LC,V2L} EVK
platforms.

All the patches are cherry-picked from the mainline.

Patch 1 mainline commit does not include some files present
in 5.10 tree, so manually moved across.

Adapted header files/KConfig changes for 5.10 kernel
in patch9 (0009-drm-renesas-Add-RZ-G2L-DU-Support.patch)
similar to rcar_du abd shmobile drm drivers.

Biju Das (9):
  drm: Place Renesas drivers in a separate dir
  dt-bindings: display: Document Renesas RZ/G2L DU bindings
  dt-bindings: display: renesas,rzg2l-du: Document RZ/V2L DU bindings
  drm: renesas: Add RZ/G2L DU Support
  arm64: dts: renesas: r9a07g044: Add DU node
  arm64: dts: renesas: r9a07g054: Add DU node
  Revert "arm64: dts: renesas: Drop ADV7535 IRQ"
  arm64: dts: renesas: rzg2l-smarc: Enable DU and link with DSI
  arm64: defconfig: Enable Renesas RZ/G2L display unit DRM driver

Daniel Vetter (1):
  drm: Allow const struct drm_driver

Maxime Ripard (1):
  drm/crtc: Introduce drmm_crtc_init_with_planes

Philipp Zabel (3):
  drm: add drmm_encoder_alloc()
  drm/plane: add drmm_universal_plane_alloc()
  drm/crtc: add drmm_crtc_alloc_with_planes()

 .../bindings/display/renesas,rzg2l-du.yaml    | 126 ++++++
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  46 ++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  47 ++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  16 +-
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  16 +-
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpu/drm/Kconfig                       |   4 +-
 drivers/gpu/drm/Makefile                      |   3 +-
 drivers/gpu/drm/drm_crtc.c                    | 198 ++++++--
 drivers/gpu/drm/drm_drv.c                     |  17 +-
 drivers/gpu/drm/drm_encoder.c                 | 109 ++++-
 drivers/gpu/drm/drm_plane.c                   | 134 ++++--
 drivers/gpu/drm/renesas/Kconfig               |   5 +
 drivers/gpu/drm/renesas/Makefile              |   5 +
 drivers/gpu/drm/{ => renesas}/rcar-du/Kconfig |   0
 .../gpu/drm/{ => renesas}/rcar-du/Makefile    |   0
 .../gpu/drm/{ => renesas}/rcar-du/rcar_cmm.c  |   0
 .../gpu/drm/{ => renesas}/rcar-du/rcar_cmm.h  |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_crtc.c  |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_crtc.h  |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_drv.c   |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_drv.h   |   0
 .../{ => renesas}/rcar-du/rcar_du_encoder.c   |   0
 .../{ => renesas}/rcar-du/rcar_du_encoder.h   |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_group.c |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_group.h |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_kms.c   |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_kms.h   |   0
 drivers/gpu/drm/renesas/rcar-du/rcar_du_of.c  | 323 +++++++++++++
 drivers/gpu/drm/renesas/rcar-du/rcar_du_of.h  |  20 +
 .../rcar-du/rcar_du_of_lvds_r8a7790.dts       |  69 +++
 .../rcar-du/rcar_du_of_lvds_r8a7791.dts       |  43 ++
 .../rcar-du/rcar_du_of_lvds_r8a7793.dts       |  43 ++
 .../rcar-du/rcar_du_of_lvds_r8a7795.dts       |  43 ++
 .../rcar-du/rcar_du_of_lvds_r8a7796.dts       |  43 ++
 .../drm/{ => renesas}/rcar-du/rcar_du_plane.c |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_plane.h |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_regs.h  |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_vsp.c   |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_vsp.h   |   0
 .../{ => renesas}/rcar-du/rcar_du_writeback.c |   0
 .../{ => renesas}/rcar-du/rcar_du_writeback.h |   0
 .../drm/{ => renesas}/rcar-du/rcar_dw_hdmi.c  |   0
 .../gpu/drm/{ => renesas}/rcar-du/rcar_lvds.c |   0
 .../gpu/drm/{ => renesas}/rcar-du/rcar_lvds.h |   0
 .../{ => renesas}/rcar-du/rcar_lvds_regs.h    |   0
 .../{ => renesas}/rcar-du/rzg2l_mipi_dsi.c    |   0
 .../rcar-du/rzg2l_mipi_dsi_regs.h             |   0
 drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
 drivers/gpu/drm/renesas/rz-du/Makefile        |   8 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 423 ++++++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h |  89 ++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 175 ++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  78 ++++
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  72 +++
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.h  |  32 ++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  | 372 +++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h  |  43 ++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  | 344 ++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h  |  82 ++++
 .../gpu/drm/{ => renesas}/shmobile/Kconfig    |   0
 .../gpu/drm/{ => renesas}/shmobile/Makefile   |   0
 .../shmobile/shmob_drm_backlight.c            |   0
 .../shmobile/shmob_drm_backlight.h            |   0
 .../{ => renesas}/shmobile/shmob_drm_crtc.c   |   0
 .../{ => renesas}/shmobile/shmob_drm_crtc.h   |   0
 .../{ => renesas}/shmobile/shmob_drm_drv.c    |   0
 .../{ => renesas}/shmobile/shmob_drm_drv.h    |   0
 .../{ => renesas}/shmobile/shmob_drm_kms.c    |   0
 .../{ => renesas}/shmobile/shmob_drm_kms.h    |   0
 .../{ => renesas}/shmobile/shmob_drm_plane.c  |   0
 .../{ => renesas}/shmobile/shmob_drm_plane.h  |   0
 .../{ => renesas}/shmobile/shmob_drm_regs.h   |   0
 include/drm/drm_crtc.h                        |  42 ++
 include/drm/drm_device.h                      |   4 +
 include/drm/drm_drv.h                         |   5 +-
 include/drm/drm_encoder.h                     |  30 ++
 include/drm/drm_plane.h                       |  42 ++
 79 files changed, 3053 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
 create mode 100644 drivers/gpu/drm/renesas/Kconfig
 create mode 100644 drivers/gpu/drm/renesas/Makefile
 rename drivers/gpu/drm/{ => renesas}/rcar-du/Kconfig (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/Makefile (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_cmm.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_cmm.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_crtc.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_crtc.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_drv.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_drv.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_encoder.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_encoder.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_group.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_group.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_kms.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_kms.h (100%)
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of.c
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of.h
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7790.dts
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7791.dts
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7793.dts
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7795.dts
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7796.dts
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_plane.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_plane.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_regs.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_vsp.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_vsp.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_writeback.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_writeback.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_dw_hdmi.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_lvds.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_lvds.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_lvds_regs.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rzg2l_mipi_dsi.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rzg2l_mipi_dsi_regs.h (100%)
 create mode 100644 drivers/gpu/drm/renesas/rz-du/Kconfig
 create mode 100644 drivers/gpu/drm/renesas/rz-du/Makefile
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
 rename drivers/gpu/drm/{ => renesas}/shmobile/Kconfig (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/Makefile (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_backlight.c (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_backlight.h (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_crtc.c (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_crtc.h (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_drv.c (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_drv.h (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_kms.c (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_kms.h (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_plane.c (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_plane.h (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_regs.h (100%)

-- 
2.25.1


