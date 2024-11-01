Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B89E6B25A
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 12:57:55 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.36847.1730465874079586267
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Nov 2024 05:57:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,249,1725289200"; 
   d="scan'208";a="223655285"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Nov 2024 21:57:52 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.182])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C70224006DF8;
	Fri,  1 Nov 2024 21:57:47 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 00/28] Add CRU, CSI support for Renesas RZ/{G2L, V2L} SoCs
Date: Fri,  1 Nov 2024 12:57:18 +0000
Message-ID: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Nov 2024 12:57:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17134

Hi All,

This patch series aims to add support for CRU and CSI drivers for the
Renesas RZ/G2L SoC.

All the patches have been cherry-picked from upstream kernel.

Cheers,
Prabhakar

v1->v2
- Fixed dtb build issue by adding missing patch `arm64: dts: renesas: r9a07g054:
  Add CSI and CRU nodes`

Biju Das (7):
  media: i2c: ov5645: Remove software reset entry from
    ov5645_global_init_setting
  media: platform: rzg2l-cru: rzg2l-csi2: Switch to RUNTIME_PM_OPS()
  media: platform: rzg2l-cru: rzg2l-ip: Add delay after D-PHY reset
  media: platform: rzg2l-cru: rzg2l-video: Fix image processing
    initialization
  media: platform: rzg2l-cru: rzg2l-csi2: Restructure vclk handling
  media: platform: rzg2l-cru: rzg2l-video: Fix start reception procedure
  media: platform: rzg2l-cru: rzg2l-csi2: Add missing
    MODULE_DEVICE_TABLE

Dan Carpenter (1):
  media: rzg2l-cru: fix a test for timeout

Geert Uytterhoeven (1):
  arm64: defconfig: Enable RZ/G2L MIPI CSI-2 and CRU support

Jiapeng Chong (1):
  media: rzg2l-cru: Fix missing error code in
    rzg2l_cru_start_streaming_vq()

Lad Prabhakar (15):
  media: i2c: ov5645: Drop fetching the clk reference by name
  media: i2c: ov5645: Use runtime PM
  media: i2c: ov5645: Drop empty comment
  media: i2c: ov5645: Make sure to call PM functions
  media: i2c: ov5645: Call ov5645_entity_init_cfg() before registering
    the subdev
  media: dt-bindings: Document Renesas RZ/G2L CSI-2 block
  media: dt-bindings: Document Renesas RZ/G2L CRU block
  media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver
  media: platform: Add Renesas RZ/G2L CRU driver
  media: platform: renesas: rzg2l-cru: Add missing documentation for
    image_conv_irq
  media: platform: rzg2l-cru: rzg2l-csi2: Enclose the macro in
    parentheses
  clk: renesas: r9a07g044: Add clock and reset entries for CRU
  arm64: dts: renesas: r9a07g044: Add CSI and CRU nodes
  arm64: dts: renesas: r9a07g054: Add CSI and CRU nodes
  arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support

Nathan Chancellor (1):
  media: rzg2l-cru: Remove unnecessary shadowing of ret in
    rzg2l_csi2_s_stream()

Sakari Ailus (1):
  media: v4l: subdev: Add pre_streamon and post_streamoff callbacks

Yang Li (1):
  media: rzg2l-cru: Remove unneeded semicolon

 .../bindings/media/renesas,rzg2l-cru.yaml     |  157 +++
 .../bindings/media/renesas,rzg2l-csi2.yaml    |  149 +++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |   79 ++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |   79 ++
 .../dts/renesas/rz-smarc-cru-csi-ov5645.dtsi  |   80 ++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |    8 +
 arch/arm64/configs/defconfig                  |    2 +
 drivers/clk/renesas/r9a07g044-cpg.c           |   26 +-
 drivers/media/i2c/ov5645.c                    |  153 +--
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/renesas/Kconfig        |    0
 drivers/media/platform/renesas/Makefile       |    0
 .../media/platform/renesas/rzg2l-cru/Kconfig  |   33 +
 .../media/platform/renesas/rzg2l-cru/Makefile |    6 +
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   |  338 ++++++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  152 +++
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   |  889 ++++++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     |  255 ++++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 1047 +++++++++++++++++
 include/media/v4l2-subdev.h                   |   25 +
 21 files changed, 3405 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
 create mode 100644 drivers/media/platform/renesas/Kconfig
 create mode 100644 drivers/media/platform/renesas/Makefile
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Kconfig
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Makefile
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c

-- 
2.43.0


