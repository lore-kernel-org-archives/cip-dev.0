Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8BBC47089
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.34923.1649075759465928352
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Apr 2022 05:35:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200";
   d="scan'208";a="115671972"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Apr 2022 21:35:55 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F10244285531;
	Mon,  4 Apr 2022 21:35:54 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/29] Add RSPI/OSTM/WDT/TSU/OPP support to Renesas
 RZ/G2L SoC
Date: Mon,  4 Apr 2022 13:35:24 +0100
Message-Id: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7963

Hi All,

This patch series adds support for following to Renesas RZ/RGL SoC:
* RSPI
* WDT
* OSTM
* TSU/OPP/IPA

All the patches have been cherry-picked from v5.17 release.

Cheers,
Prabhakar

Andy Shevchenko (1):
  units: Add SI metric prefix definitions

Biju Das (22):
  clk: renesas: r9a07g044: Add WDT clock and reset entries
  clk: renesas: r9a07g044: Rename CLK_PLL2_DIV16 and CLK_PLL2_DIV20
    macros
  dt-bindings: watchdog: renesas,wdt: Add support for RZ/G2L
  watchdog: Add Watchdog Timer driver for RZ/G2L
  clk: renesas: r9a07g044: Add OSTM clock and reset entries
  dt-bindings: timer: renesas: ostm: Document Renesas RZ/G2L OSTM
  reset: Add of_reset_control_get_optional_exclusive()
  clocksource/drivers/renesas-ostm: Add RZ/G2L OSTM support
  clocksource/drivers/renesas,ostm: Make RENESAS_OSTM symbol visible
  arm64: dts: renesas: r9a07g044: Add OSTM nodes
  arm64: dts: renesas: rzg2l-smarc-som: Enable OSTM
  arm64: dts: renesas: r9a07g044: Add WDT nodes
  arm64: dts: renesas: rzg2l-smarc-som: Enable watchdog
  clk: renesas: r9a07g044: Change core clock "I" from DEF_FIXED->DEF_DIV
  clk: renesas: r9a07g044: Add TSU clock and reset entry
  clk: renesas: r9a07g044: Rename CLK_PLL3_DIV4 macro
  clk: renesas: rzg2l: Add CPG_PL1_DDIV macro
  dt-bindings: thermal: Document Renesas RZ/G2L TSU
  thermal/drivers: Add TSU driver for RZ/G2L
  arm64: dts: renesas: r9a07g044: Add OPP table
  arm64: dts: renesas: r9a07g044: Add TSU node
  arm64: dts: renesas: r9a07g044: Create thermal zone to support IPA

Lad Prabhakar (6):
  clk: renesas: r9a07g044: Add RSPI clock and reset entries
  spi: dt-bindings: renesas,rspi: Document RZ/G2L SoC
  spi: spi-rspi: Add support to deassert/assert reset line
  spi: spi-rspi: Drop redeclaring ret variable in qspi_transfer_in()
  arm64: dts: renesas: r9a07g044: Add RSPI{0,1,2} nodes
  arm64: dts: renesas: rzg2l-smarc: Enable RSPI1 on carrier board

 .../devicetree/bindings/spi/renesas,rspi.yaml |   4 +-
 .../bindings/thermal/rzg2l-thermal.yaml       |  76 +++++
 .../bindings/timer/renesas,ostm.yaml          |  20 +-
 .../bindings/watchdog/renesas,wdt.yaml        |  75 +++--
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 199 +++++++++++++
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  23 ++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  14 +
 drivers/clk/renesas/r9a07g044-cpg.c           |  63 ++++-
 drivers/clk/renesas/rzg2l-cpg.h               |   2 +
 drivers/clocksource/Kconfig                   |   3 +-
 drivers/clocksource/renesas-ostm.c            |  39 ++-
 drivers/spi/spi-rspi.c                        |  27 +-
 drivers/thermal/Kconfig                       |   9 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/rzg2l_thermal.c               | 239 ++++++++++++++++
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/rzg2l_wdt.c                  | 263 ++++++++++++++++++
 include/linux/reset.h                         |  20 ++
 include/linux/units.h                         |  16 ++
 20 files changed, 1068 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
 create mode 100644 drivers/thermal/rzg2l_thermal.c
 create mode 100644 drivers/watchdog/rzg2l_wdt.c


base-commit: 05648080e85d797e727b8935406c2057c8a76637
-- 
2.17.1


