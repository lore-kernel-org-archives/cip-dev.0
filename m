Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644DBC32774
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:34:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.15194.1660653252618185662
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:34:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600";
   d="scan'208";a="129665691"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 21:34:09 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6124F402D0A2;
	Tue, 16 Aug 2022 21:34:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/31] Renesas RZ/V2L extend peripheral support
Date: Tue, 16 Aug 2022 13:33:35 +0100
Message-Id: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:34:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9220

Hi All,

This patches series backports support for below IP blocks on the Renesas
RZ/V2L SoC and also enables on SMARC EVK:
* USB2.0
* TSU/OPP
* SPI/SBC
* CANFD
* ADC
* WDT
* I2C
* Audio
* SDHI/eMMC
* Timer (OSTM)

Note:
* All the patches have been cherry picked from 6.0-rc1 kernel.
* Patch 13/31 is required for future addition of SoC's (RZ/G2UL)
* Patch 04/31 adds CANFD binding patch for RZ/G2L, device tree is
  already merged into CIP
* Patch 16/31 is a cosmetic change which affects both RZ/G2L and RZ/V2L

Cheers,
Prabhakar

Geert Uytterhoeven (3):
  dt-bindings: can: renesas,rcar-canfd: Make interrupt-names required
  dt-bindings: soc: renesas: Move renesas,rzg2l-sysc from arm to soc
  clk: renesas: r9a07g044: Fix OSTM1 module clock name

Lad Prabhakar (28):
  ASoC: dt-bindings: renesas,rz-ssi: Document RZ/V2L SoC
  spi: dt-bindings: renesas,rspi: Document RZ/V2L SoC
  dt-bindings: mmc: renesas,sdhi: Document RZ/V2L SoC
  dt-bindings: net: can: renesas,rcar-canfd: Document RZ/G2L SoC
  dt-bindings: net: can: renesas,rcar-canfd: Document RZ/V2L SoC
  dt-bindings: i2c: renesas,riic: Document RZ/V2L SoC
  dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2L OSTM
  dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/V2L USBPHY
    Control bindings
  dt-bindings: usb: renesas,usbhs: Document RZ/V2L bindings
  dt-bindings: phy: renesas,usb2-phy: Document RZ/V2L phy bindings
  dt-bindings: memory: renesas,rpc-if: Document RZ/V2L SoC
  dt-bindings: watchdog: renesas,wdt: Document RZ/V2L SoC
  dt-bindings: thermal: rzg2l-thermal: Document RZ/V2L bindings
  arm64: dts: renesas: r9a07g054: Fillup the ADC stub node
  arm64: dts: renesas: r9a07g054: Fillup the SDHI{0,1} stub nodes
  arm64: dts: renesas: r9a07g054l2-smarc: Drop deleting gpio-hog pins
    related to SDHI
  arm64: dts: renesas: r9a07g054: Fillup the CANFD stub node
  arm64: dts: renesas: r9a07g054l2-smarc: Drop deleting can{0,1}-stb-hog
    nodes
  arm64: dts: renesas: r9a07g054: Fillup the I2C{0,1,2,3} stub nodes
  arm64: dts: renesas: r9a07g054: Fillup the sbc stub node
  arm64: dts: renesas: r9a07g054: Fillup the OSTM{0,1,2} stub nodes
  arm64: dts: renesas: r9a07g054: Fillup the WDT{0,1,2} stub nodes
  arm64: dts: renesas: r9a07g054: Add SSI{1,2,3} nodes and fillup the
    SSI0 stub node
  arm64: dts: renesas: r9a07g054: Add USB2.0 phy and host support
  arm64: dts: renesas: r9a07g054: Add USB2.0 device support
  arm64: dts: renesas: r9a07g054: Add SPI{0,2} nodes and fillup SPI1
    stub node
  arm64: dts: renesas: r9a07g054: Add OPP table
  arm64: dts: renesas: r9a07g054: Add TSU node

 .../devicetree/bindings/i2c/renesas,riic.yaml |   2 +
 .../memory-controllers/renesas,rpc-if.yaml    |   3 +-
 .../devicetree/bindings/mmc/renesas,sdhi.yaml |   5 +-
 .../bindings/net/can/renesas,rcar-canfd.yaml  |  71 ++-
 .../bindings/phy/renesas,usb2-phy.yaml        |   3 +-
 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      |   3 +-
 .../renesas}/renesas,rzg2l-sysc.yaml          |   2 +-
 .../bindings/sound/renesas,rz-ssi.yaml        |   3 +-
 .../devicetree/bindings/spi/renesas,rspi.yaml |   2 +
 .../bindings/thermal/rzg2l-thermal.yaml       |   1 +
 .../bindings/timer/renesas,ostm.yaml          |   2 +
 .../bindings/usb/renesas,usbhs.yaml           |   5 +-
 .../bindings/watchdog/renesas,wdt.yaml        |   3 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 522 +++++++++++++++++-
 .../boot/dts/renesas/r9a07g054l2-smarc.dts    |   8 -
 drivers/clk/renesas/r9a07g044-cpg.c           |   2 +-
 16 files changed, 590 insertions(+), 47 deletions(-)
 rename Documentation/devicetree/bindings/{power => soc/renesas}/renesas,rzg2l-sysc.yaml (96%)

-- 
2.17.1


