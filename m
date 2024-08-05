Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7589CC3DA7F
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 16:43:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.12741.1722876226641507271
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 09:43:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,265,1716217200"; 
   d="scan'208";a="214739863"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Aug 2024 01:43:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.197])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8CD144020F32;
	Tue,  6 Aug 2024 01:43:43 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/30] Add support for RZ/{G2L,G2LC,G2UL,V2L} Camera Data Receiving Unit
Date: Mon,  5 Aug 2024 17:42:53 +0100
Message-ID: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 16:43:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16722

This patch series aim to add support for RZ/{G2L,G2LC,G2UL,V2L} Camera
Data Receiving Unit(a.k.a CRU)

All the patches are cherry-picked from the mainline.

Biju Das (11):
  media: i2c: ov5645: Remove software reset entry from
    ov5645_global_init_setting
  clk: renesas: r9a07g043: Add clock and reset entries for CRU
  media: platform: rzg2l-cru: rzg2l-csi2: Switch to RUNTIME_PM_OPS()
  media: platform: rzg2l-cru: rzg2l-ip: Add delay after D-PHY reset
  media: platform: rzg2l-cru: rzg2l-video: Fix image processing
    initialization
  media: platform: rzg2l-cru: rzg2l-csi2: Restructure vclk handling
  media: platform: rzg2l-cru: rzg2l-video: Fix start reception procedure
  media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G2UL CSI-2
    block
  media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G2UL CRU
    block
  arm64: dts: renesas: r9a07g043u: Add CSI and CRU nodes
  arm64: dts: renesas: rzg2ul-smarc: Enable CRU, CSI support

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
  clk: renesas: r9a07g044: Add clock and reset entries for CRU
  media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver
  media: platform: Add Renesas RZ/G2L CRU driver
  media: platform: renesas: rzg2l-cru: Add missing documentation for
    image_conv_irq
  arm64: dts: renesas: r9a07g044: Add CSI and CRU nodes
  arm64: dts: renesas: r9a07g054: Add CSI and CRU nodes
  arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support
  arm64: dts: renesas: rzg2lc-smarc: Enable CRU, CSI support

Nathan Chancellor (1):
  media: rzg2l-cru: Remove unnecessary shadowing of ret in
    rzg2l_csi2_s_stream()

 .../bindings/media/renesas,rzg2l-cru.yaml     |  184 +++
 .../bindings/media/renesas,rzg2l-csi2.yaml    |  150 +++
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |   69 ++
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |    8 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |   79 ++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |   79 ++
 .../dts/renesas/rz-smarc-cru-csi-ov5645.dtsi  |   80 ++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |    8 +
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |    8 +
 arch/arm64/configs/defconfig                  |    2 +
 drivers/clk/renesas/r9a07g043-cpg.c           |   31 +
 drivers/clk/renesas/r9a07g044-cpg.c           |   26 +-
 drivers/media/i2c/ov5645.c                    |  153 +--
 drivers/media/platform/renesas/Kconfig        |    1 +
 drivers/media/platform/renesas/Makefile       |    1 +
 .../media/platform/renesas/rzg2l-cru/Kconfig  |   33 +
 .../media/platform/renesas/rzg2l-cru/Makefile |    6 +
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   |  338 ++++++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  151 +++
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   |  882 ++++++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     |  247 ++++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 1045 +++++++++++++++++
 22 files changed, 3506 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Kconfig
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Makefile
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c

-- 
2.43.0


