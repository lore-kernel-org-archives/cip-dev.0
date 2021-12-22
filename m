Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D165C433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 13:49:57 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.19313.1640180996475750192
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 05:49:56 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000";
   d="scan'208";a="104842202"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Dec 2021 22:49:53 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E0A86430F434;
	Wed, 22 Dec 2021 22:49:52 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/21] RZ/G2L: Add support for USB/CANFD
Date: Wed, 22 Dec 2021 13:49:30 +0000
Message-Id: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 13:49:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7234

Hi All,

This patch series adds USB and CANFD support to Renesas RZ/G2L SoC.

All the patches have been cherry picked from v5.16-rc5.

I have created a MR [0] for cip-kernel-config (for testing purpose),
which can later be merged once this patches have been merged.

[0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/54

Cheers,
Prabhakar

Biju Das (12):
  dt-bindings: usb: generic-ehci: Document dr_mode property
  dt-bindings: usb: generic-ohci: Document dr_mode property
  dt-bindings: reset: Document RZ/G2L USBPHY Control bindings
  reset: renesas: Add RZ/G2L usbphy control driver
  dt-bindings: usb: renesas,usbhs: Document RZ/G2L bindings
  dt-bindings: phy: renesas,usb2-phy: Document RZ/G2L phy bindings
  phy: renesas: phy-rcar-gen3-usb2: Add USB2.0 PHY support for RZ/G2L
  clk: renesas: r9a07g044: Add USB clocks/resets
  arm64: dts: renesas: r9a07g044: Add USB2.0 phy and host support
  arm64: dts: renesas: r9a07g044: Add USB2.0 device support
  arm64: dts: renesas: rzg2l-smarc: Enable USB2.0 support
  arm64: defconfig: Enable RZ/G2L USBPHY control driver

Chunfeng Yun (1):
  phy: renesas: convert to devm_platform_ioremap_resource

Geert Uytterhoeven (2):
  dt-bindings: can: rcar_canfd: Group tuples in pin control properties
  dt-bindings: can: rcar_canfd: Convert to json-schema

Lad Prabhakar (6):
  can: rcar_canfd: Add support for RZ/G2L family
  can: rcar_canfd: rcar_canfd_handle_channel_tx(): fix redundant
    assignment
  dt-bindings: clock: r9a07g044-cpg: Add entry for P0_DIV2 core clock
  clk: renesas: r9a07g044: Add entry for fixed clock P0_DIV2
  clk: renesas: r9a07g044: Add clock and reset entries for CANFD
  arm64: dts: renesas: r9a07g044: Add CANFD node

 .../bindings/net/can/rcar_canfd.txt           | 107 ------
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 122 +++++++
 .../bindings/phy/renesas,usb2-phy.yaml        |  15 +
 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      |  65 ++++
 .../devicetree/bindings/usb/generic-ehci.yaml |   5 +
 .../devicetree/bindings/usb/generic-ohci.yaml |   5 +
 .../bindings/usb/renesas,usbhs.yaml           |  26 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 155 ++++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  61 ++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a07g044-cpg.c           |  19 +-
 drivers/net/can/rcar/rcar_canfd.c             | 338 ++++++++++++++----
 drivers/phy/renesas/phy-rcar-gen2.c           |   4 +-
 drivers/phy/renesas/phy-rcar-gen3-pcie.c      |   4 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      | 101 ++++--
 drivers/phy/renesas/phy-rcar-gen3-usb3.c      |   4 +-
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c       | 175 +++++++++
 include/dt-bindings/clock/r9a07g044-cpg.h     |   1 +
 20 files changed, 997 insertions(+), 219 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/can/rcar_canfd.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
 create mode 100644 drivers/reset/reset-rzg2l-usbphy-ctrl.c

-- 
2.17.1


