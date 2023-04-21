Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5CFC77B7E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:17:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6166.1682061454427200641
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:17:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156786855"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:17:32 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AFA7541AA3F4;
	Fri, 21 Apr 2023 16:17:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 00/33] Add RZ/V2M support
Date: Fri, 21 Apr 2023 08:16:56 +0100
Message-Id: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:17:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11273

This patch series aims to add Basic board support for EVK
based on RZ/V2M SoC.

All these patches are cherry-picked from the mainline.

Subsequent patch series will add more functionality to this platform.

RZ/V2M EVK logs:
root@rzv2m:~# cat /sys/devices/soc0/family
RZ/V2M
root@rzv2m:~# cat /sys/devices/soc0/machine
RZ/V2M Evaluation Kit 2.0
root@rzv2m:~# cat /sys/devices/soc0/soc_id
r9a09g011
root@rzv2m:~# dmesg  | grep Detect
[    0.002815] Detected Renesas RZ/V2M r9a09g011

Geert Uytterhoeven (1):
  serial: 8250: SERIAL_8250_EM should depend on ARCH_RENESAS

Johan Hovold (1):
  serial: 8250: extend compile-test coverage

Lad Prabhakar (1):
  pinctrl: renesas: Select PINCTRL_RZG2L if ARCH_RZG2L is enabled

Phil Edworthy (30):
  dt-bindings: serial: renesas,em-uart: Document r9a09g011 bindings
  dt-bindings: serial: renesas,em-uart: Add RZ/V2M clock to access the
    registers
  serial: 8250: Make SERIAL_8250_EM available for arm64 systems
  dt-bindings: arm: renesas: Document Renesas RZ/V2M SoC and EVK board
  dt-bindings: arm: renesas: Document Renesas RZ/V2M System
    Configuration
  soc: renesas: Identify RZ/V2M SoC
  soc: renesas: Add RZ/V2M (R9A09G011) config option
  arm64: defconfig: Enable Renesas RZ/V2M SoC
  dt-bindings: clock: Add r9a09g011 CPG Clock Definitions
  dt-bindings: clock: renesas,rzg2l: Document RZ/V2M SoC
  clk: renesas: rzg2l: Move the DEF_MUX array size calc into the macro
  clk: renesas: rzg2l: Add read only versions of the clk macros
  clk: renesas: rzg2l: Set HIWORD mask for all mux and dividers
  clk: renesas: rzg2l: Make use of CLK_MON registers optional
  clk: renesas: rzg2l: Add support for RZ/V2M reset monitor reg
  clk: renesas: Add RZ/V2M support using the rzg2l driver
  clk: renesas: r9a09g011: Add eth clock and reset entries
  arm64: dts: renesas: Add initial DTSI for RZ/V2M SoC
  arm64: dts: renesas: Add initial device tree for RZ/V2M EVK
  dt-bindings: net: renesas,etheravb: Document RZ/V2M SoC
  ravb: Separate handling of irq enable/disable regs into feature
  ravb: Support separate Line0 (Desc), Line1 (Err) and Line2 (Mgmt) irqs
  ravb: Use separate clock for gPTP
  ravb: Add support for RZ/V2M
  arm64: dts: renesas: r9a09g011: Add ethernet nodes
  arm64: dts: renesas: rzv2mevk2: Enable ethernet
  clk: renesas: r9a09g011: Add PFC clock and reset entries
  dt-bindings: pinctrl: Add DT bindings for Renesas RZ/V2M pinctrl
  pinctrl: renesas: Add RZ/V2M pin and gpio controller driver
  arm64: dts: renesas: r9a09g011: Add pinctrl node

 .../devicetree/bindings/arm/renesas.yaml      |    6 +
 .../bindings/clock/renesas,rzg2l-cpg.yaml     |   13 +-
 .../bindings/net/renesas,etheravb.yaml        |   82 +-
 .../pinctrl/renesas,rzv2m-pinctrl.yaml        |  170 +++
 .../bindings/serial/renesas,em-uart.yaml      |   37 +-
 .../soc/renesas/renesas,r9a09g011-sys.yaml    |   43 +
 arch/arm64/boot/dts/renesas/Makefile          |    2 +
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |   58 +
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  194 +++
 arch/arm64/configs/defconfig                  |    2 +
 drivers/clk/renesas/Kconfig                   |    5 +
 drivers/clk/renesas/Makefile                  |    1 +
 drivers/clk/renesas/r9a07g043-cpg.c           |   29 +-
 drivers/clk/renesas/r9a07g044-cpg.c           |   37 +-
 drivers/clk/renesas/r9a09g011-cpg.c           |  174 +++
 drivers/clk/renesas/rzg2l-cpg.c               |   24 +-
 drivers/clk/renesas/rzg2l-cpg.h               |   41 +-
 drivers/net/ethernet/renesas/ravb.h           |    6 +
 drivers/net/ethernet/renesas/ravb_main.c      |  109 +-
 drivers/net/ethernet/renesas/ravb_ptp.c       |    6 +-
 drivers/pinctrl/renesas/Kconfig               |   17 +-
 drivers/pinctrl/renesas/Makefile              |    1 +
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       | 1119 +++++++++++++++++
 drivers/soc/renesas/Kconfig                   |    7 +
 drivers/soc/renesas/renesas-soc.c             |   22 +
 drivers/tty/serial/8250/Kconfig               |    3 +-
 include/dt-bindings/clock/r9a09g011-cpg.h     |  352 ++++++
 include/dt-bindings/pinctrl/rzv2m-pinctrl.h   |   23 +
 28 files changed, 2481 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g011-sys.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g011.dtsi
 create mode 100644 drivers/clk/renesas/r9a09g011-cpg.c
 create mode 100644 drivers/pinctrl/renesas/pinctrl-rzv2m.c
 create mode 100644 include/dt-bindings/clock/r9a09g011-cpg.h
 create mode 100644 include/dt-bindings/pinctrl/rzv2m-pinctrl.h

-- 
2.25.1


