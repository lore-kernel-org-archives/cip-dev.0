Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96666ECAAD1
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:46:57 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.1219.1661964411538127821
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:46:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="133251633"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2022 01:46:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3C64340457CA;
	Thu,  1 Sep 2022 01:46:47 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/26] Add RZ/G2UL support
Date: Wed, 31 Aug 2022 17:46:19 +0100
Message-Id: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:46:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9360

This patch series aims to add Basic board support for SMARC EVK
based on RZ/G2UL SoC.

All these patches are cherry-picked from the mainline.

Subsequent patch series will add more functionality to this platform.

RZ/G2UL SMARC EVK logs:
root@smarc-rzg2ul:~# cat /sys/devices/soc0/family
RZ/G2UL
root@smarc-rzg2ul:~# cat /sys/devices/soc0/machine
Renesas SMARC EVK based on r9a07g043u11
root@smarc-rzg2ul:~# cat /sys/devices/soc0/revision
0
root@smarc-rzg2ul:~# cat /sys/devices/soc0/soc_id
r9a07g043
root@smarc-rzg2ul:~# dmesg  | grep Detect
[    0.021282] Detected Renesas RZ/G2UL r9a07g043 Rev 0

Biju Das (24):
  dt-bindings: clock: Add R9A07G043 CPG Clock and Reset Definitions
  soc: renesas: Identify RZ/G2UL SoC
  clk: renesas: Add support for RZ/G2UL SoC
  clk: renesas: r9a07g043: Add GPIO clock and reset entries
  clk: renesas: r9a07g043: Add ethernet clock sources
  clk: renesas: r9a07g043: Add GbEthernet clock/reset
  clk: renesas: r9a07g043: Add SDHI clock and reset entries
  clk: renesas: r9a07g043: Add I2C clocks/resets
  clk: renesas: r9a07g043: Add SSIF-2 clock and reset entries
  clk: renesas: r9a07g043: Add USB clocks/resets
  clk: renesas: r9a07g043: Add clock and reset entries for CANFD
  clk: renesas: r9a07g043: Add OSTM clock and reset entries
  clk: renesas: r9a07g043: Add WDT clock and reset entries
  pinctrl: renesas: rzg2l: Add RZ/G2UL support
  arm64: dts: renesas: Add initial DTSI for RZ/G2UL SoC
  arm64: dts: renesas: Add initial device tree for RZ/G2UL Type-1 SMARC
    EVK
  arm64: dts: renesas: r9a07g043: Fillup the pinctrl stub node
  arm64: dts: renesas: rzg2ul-smarc: Add scif0 and audio clk pins
  arm64: dts: renesas: r9a07g043: Add SDHI nodes
  arm64: dts: renesas: r9a07g043: Add GbEthernet nodes
  arm64: defconfig: Enable ARCH_R9A07G043
  arm64: dts: renesas: rzg2ul-smarc: Enable microSD on SMARC platform
  arm64: dts: renesas: rzg2ul-smarc-som: Enable eMMC on SMARC platform
  arm64: dts: renesas: rzg2ul-smarc-som: Enable Ethernet on SMARC
    platform

Geert Uytterhoeven (1):
  pinctrl: renesas: rzg2l: Restore pin config order

Lad Prabhakar (1):
  pinctrl: renesas: rzg2l: Return -EINVAL for pins which have input
    disabled

 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 481 ++++++++++++++++++
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |  97 ++++
 .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi |  63 +++
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    | 233 +++++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  24 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/Kconfig                   |   7 +-
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a07g043-cpg.c           | 288 +++++++++++
 drivers/clk/renesas/rzg2l-cpg.c               |   6 +
 drivers/clk/renesas/rzg2l-cpg.h               |   1 +
 drivers/pinctrl/renesas/Kconfig               |   5 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 202 +++++---
 drivers/soc/renesas/Kconfig                   |   6 +
 drivers/soc/renesas/renesas-soc.c             |  13 +
 include/dt-bindings/clock/r9a07g043-cpg.h     | 184 +++++++
 17 files changed, 1532 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g043.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
 create mode 100644 drivers/clk/renesas/r9a07g043-cpg.c
 create mode 100644 include/dt-bindings/clock/r9a07g043-cpg.h

-- 
2.25.1


