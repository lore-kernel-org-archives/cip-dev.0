Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79179F506E4
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:24 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52440.1773673159009042004
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 3zWeDYPRT1ScfyKHl3sPRg==
X-CSE-MsgGUID: DHd6twc7T2SEg6sJuKiBjQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:18 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C1E1241B7818;
	Mon, 16 Mar 2026 23:59:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/35] Add USB and Ethernet support to RZ/T2H and RZ/N2H SoC
Date: Mon, 16 Mar 2026 14:58:37 +0000
Message-ID: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22392

Hi All,

This patch series aims to add USB and Ethernet support to the RZ/T2H
and RZ/N2H SoCs and enable support for it on the EVKs respectively.
This also includes clock support for enabling these peripherals note
there is additional clock patch for SCI-SC5 which I have included as
part of this series which was supposed to be ideally sent during [0]
was sent out.

Note:
1] All the patches have been picked up from upstream kernel
   with some minor merge conflicts.
2] The patches aplly on top of commit 4a8da9cdb192 on linux-6.12.y-cip
+ patch series [0]

[0] https://lore.kernel.org/all/20260311123638.25773-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Geert Uytterhoeven (1):
  net: pcs: rzn1-miic: Convert to for_each_available_child_of_node()
    helper

Lad Prabhakar (34):
  dt-bindings: clock: renesas,r9a09g077/87: Add USB_CLK clock ID
  clk: renesas: r9a09g077: Add USB core and module clocks
  clk: renesas: r9a09g077: Add module clocks for SCI1-SCI5
  dt-bindings: clock: renesas,r9a09g077/87: Add Ethernet clock IDs
  clk: renesas: r9a09g077: Add Ethernet Subsystem core and module clocks
  dt-bindings: phy: renesas,usb2-phy: Add RZ/T2H and RZ/N2H support
  phy: renesas: rcar-gen3-usb2: store drvdata pointer in channel
  phy: renesas: rcar-gen3-usb2: Allow SoC-specific OBINT bits via
    phy_data
  phy: renesas: rcar-gen3-usb2: Add support for RZ/T2H SoC
  phy: renesas: rcar-gen3-usb2: Move debug print after register value is
    updated
  phy: renesas: rcar-gen3-usb2: Fix ID check logic with VBUS valid
  dt-bindings: usb: renesas,usbhs: Add RZ/T2H and RZ/N2H support
  usb: renesas_usbhs: Add support for RZ/T2H SoC
  arm64: dts: renesas: r9a09g077: Add USB2.0 support
  arm64: dts: renesas: r9a09g087: Add USB2.0 support
  arm64: dts: renesas: rzt2h-n2h-evk: Enable USB2.0 support
  dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/T2H and
    RZ/N2H SoCs
  net: stmmac: dwmac-renesas-gbeth: Use OF data for configuration
  net: stmmac: dwmac-renesas-gbeth: Add support for RZ/T2H SoC
  dt-bindings: net: pcs: renesas,rzn1-miic: Add RZ/T2H and RZ/N2H
    support
  net: pcs: rzn1-miic: Drop trailing comma from of_device_id table
  net: pcs: rzn1-miic: Add missing include files
  net: pcs: rzn1-miic: Move configuration data to SoC-specific struct
  net: pcs: rzn1-miic: move port range handling into SoC data
  net: pcs: rzn1-miic: Make switch mode mask SoC-specific
  net: pcs: rzn1-miic: Add support to handle resets
  net: pcs: rzn1-miic: Add per-SoC control for MIIC register unlock/lock
  net: pcs: rzn1-miic: Add RZ/T2H MIIC support
  net: pcs: Kconfig: Fix unmet dependency warning
  arm64: dts: renesas: r9a09g077: Add ETHSS node
  arm64: dts: renesas: r9a09g087: Add ETHSS node
  arm64: dts: renesas: r9a09g077: Add GMAC nodes
  arm64: dts: renesas: r9a09g087: Add GMAC nodes
  arm64: dts: renesas: rzt2h-n2h-evk: Enable Ethernet support

 .../bindings/net/pcs/renesas,rzn1-miic.yaml   | 177 ++++--
 .../bindings/net/renesas,rzv2h-gbeth.yaml     | 178 ++++--
 .../devicetree/bindings/net/snps,dwmac.yaml   |   9 +-
 .../bindings/phy/renesas,usb2-phy.yaml        |  17 +
 .../bindings/usb/renesas,usbhs.yaml           |  28 +-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    | 529 +++++++++++++++++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    | 106 ++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    | 532 ++++++++++++++++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 119 ++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  92 +++
 drivers/clk/renesas/r9a09g077-cpg.c           |  41 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +-
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      | 107 +++-
 drivers/net/pcs/Kconfig                       |  11 +-
 drivers/net/pcs/pcs-rzn1-miic.c               | 322 +++++++++--
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      | 132 +++--
 drivers/usb/renesas_usbhs/common.c            |   4 +
 .../clock/renesas,r9a09g077-cpg-mssr.h        |   6 +
 .../clock/renesas,r9a09g087-cpg-mssr.h        |   6 +
 .../net/renesas,r9a09g077-pcs-miic.h          |  36 ++
 20 files changed, 2262 insertions(+), 202 deletions(-)
 create mode 100644 include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h

-- 
2.43.0


