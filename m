Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1D4C00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:01 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.4832.1659438534534175527
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:08:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="130054288"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2022 20:08:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 733104004934;
	Tue,  2 Aug 2022 20:08:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 00/24] Add RZ/{G2LC, V2L} support
Date: Tue,  2 Aug 2022 12:08:26 +0100
Message-Id: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8997

This patch series aims to add Basic board support for SMARC EVK
based on RZ/G2LC and RZ/V2L SoC. RZ/{G2L, G2LC, V2L} share the same
SMARC EVK board, but SoM is different and pin mapping of SoM
module is different.

All these patches are cherry-picked from the mainline.

Subsequent patch series will add more functionality to these platforms.

RZ/G2LC SMARC EVK logs:
root@smarc-rzg2lc:~# cat /sys/devices/soc0/family
RZ/G2L
root@smarc-rzg2lc:~# cat /sys/devices/soc0/machine
Renesas SMARC EVK based on r9a07g044c2
root@smarc-rzg2lc:~# cat /sys/devices/soc0/revision
1
root@smarc-rzg2lc:~# cat /sys/devices/soc0/soc_id
r9a07g044
root@smarc-rzg2lc:~# dmesg  | grep Detect
[    0.003208] Detected Renesas RZ/G2L r9a07g044 Rev 1

RZ/V2L SMARC EVK logs:
root@smarc-rzv2l:~# cat /sys/devices/soc0/family
RZ/V2L
root@smarc-rzv2l:~# cat /sys/devices/soc0/machine
Renesas SMARC EVK based on r9a07g054l2
root@smarc-rzv2l:~# cat /sys/devices/soc0/revision
0
root@smarc-rzv2l:~# cat /sys/devices/soc0/soc_id
r9a07g054
root@smarc-rzv2l:~# dmesg  | grep Detect
[    0.003260] Detected Renesas RZ/V2L r9a07g054 Rev 0

Biju Das (20):
  arm64: dts: renesas: Add initial DTSI for RZ/G2LC SoC
  arm64: dts: renesas: Add initial device tree for RZ/G2LC SMARC EVK
  arm64: dts: renesas: rzg2lc-smarc-som: Enable eMMC on SMARC platform
  arm64: dts: renesas: rzg2lc-smarc: Enable microSD on SMARC platform
  clk: renesas: r9a07g044: Add mux and divider for G clock
  clk: renesas: r9a07g044: Add GPU clock and reset entries
  dt-bindings: clock: Add R9A07G054 CPG Clock and Reset Definitions
  dt-bindings: clock: renesas: Document RZ/V2L SoC
  clk: renesas: rzg2l-cpg: Add support for RZ/V2L SoC
  dt-bindings: serial: renesas,scif: Document RZ/V2L SoC
  dt-bindings: serial: renesas,sci: Document RZ/V2L SoC
  dt-bindings: pinctrl: renesas: Document RZ/V2L pinctrl
  pinctrl: renesas: Kconfig: Select PINCTRL_RZG2L if RZ/V2L SoC is
    enabled
  pinctrl: renesas: rzg2l: Improve rzg2l_gpio_register()
  dt-bindings: net: renesas,etheravb: Document RZ/V2L SoC
  arm64: dts: renesas: Add initial DTSI for RZ/V2L SoC
  arm64: dts: renesas: Add initial device tree for RZ/V2L SMARC EVK
  arm64: dts: renesas: rzg2l-smarc: Add common dtsi file
  arm64: dts: renesas: rzg2lc-smarc: Add macros for DIP-Switch settings
  arm64: dts: renesas: rzg2lc-smarc: Enable SCIF1 on carrier board

Geert Uytterhoeven (1):
  clk: renesas: rzg2l: Simplify multiplication/shift logic

Lad Prabhakar (2):
  clk: renesas: r9a07g044: Update multiplier and divider values for
    PLL2/3
  arm64: defconfig: Enable ARCH_R9A07G054

Phil Edworthy (1):
  clk: renesas: rzg2l: Remove unused notifiers

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |  14 +-
 .../bindings/net/renesas,etheravb.yaml        |   3 +-
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  15 +-
 .../bindings/serial/renesas,sci.yaml          |   2 +
 .../bindings/serial/renesas,scif.yaml         |   7 +
 arch/arm64/boot/dts/renesas/Makefile          |   3 +
 arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi  |  32 ++
 .../boot/dts/renesas/r9a07g044c2-smarc.dts    |  97 ++++
 arch/arm64/boot/dts/renesas/r9a07g044c2.dtsi  |  20 +
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |   1 +
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 491 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi  |  25 +
 .../boot/dts/renesas/r9a07g054l2-smarc.dts    |  26 +
 arch/arm64/boot/dts/renesas/r9a07g054l2.dtsi  |  13 +
 .../boot/dts/renesas/rz-smarc-common.dtsi     | 207 ++++++++
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  |   2 +-
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |   2 +-
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 195 +------
 .../dts/renesas/rzg2lc-smarc-pinfunction.dtsi |  71 +++
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    | 218 ++++++++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  62 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a07g044-cpg.c           | 421 ++++++++-------
 drivers/clk/renesas/rzg2l-cpg.c               |  10 +-
 drivers/clk/renesas/rzg2l-cpg.h               |   5 +
 drivers/pinctrl/renesas/Kconfig               |   6 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |   4 +-
 include/dt-bindings/clock/r9a07g054-cpg.h     | 229 ++++++++
 30 files changed, 1795 insertions(+), 395 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044c2.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g054.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g054l2.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
 create mode 100644 include/dt-bindings/clock/r9a07g054-cpg.h

-- 
2.25.1


