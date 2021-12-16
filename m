Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04505C4332F
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 12:54:56 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.10105.1639659291122281966
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 04:54:51 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000";
   d="scan'208";a="103722191"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2021 21:54:49 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1E41840121CF;
	Thu, 16 Dec 2021 21:54:47 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/24] Add CPG and initial DTS/I for Renesas RZ/G2L
 SoC + SMARC EVK
Date: Thu, 16 Dec 2021 12:54:22 +0000
Message-Id: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 12:54:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7123

Hi All,

This patch series adds the following:
* Serial support
* Clock support
* Initial RZ/G2L SoC DTSI
  - CPU
  - CPG
  - GIC
* Initial device tree for RZ/G2L SMARC EVK
  - memory
  - External input clock
  - SCIF

All the patches have been cherry picked from 5.16-rc5. For testing purpose
MR [0] can be used.

[0] https://gitlab.com/cip-project/cip-kernel/
cip-kernel-config/-/merge_requests/52

Cheers,
Prabhakar

Biju Das (9):
  serial: sh-sci: Add support for RZ/G2L SoC
  clk: renesas: r9a07g044: Rename divider table
  clk: renesas: r9a07g044: Fix P1 Clock
  clk: renesas: r9a07g044: Add P2 Clock support
  clk: renesas: rzg2l: Add multi clock PM support
  dt-bindings: clock: r9a07g044-cpg: Update clock/reset definitions
  clk: renesas: rzg2l: Add support to handle MUX clocks
  clk: renesas: rzg2l: Add support to handle coupled clocks
  clk: renesas: rzg2l: Fix clk status function

Dan Carpenter (2):
  clk: renesas: rzg2l: Fix a double free on error
  clk: renesas: rzg2l: Avoid mixing error pointers and NULL

Dmitry Baryshkov (1):
  clk: mux: provide devm_clk_hw_register_mux()

Geert Uytterhoeven (1):
  clk: renesas: Rename renesas-rzg2l-cpg.[ch] to rzg2l-cpg.[ch]

Lad Prabhakar (9):
  dt-bindings: serial: renesas,scif: Document r9a07g044 bindings
  dt-bindings: clock: renesas: Document RZ/G2L SoC CPG driver
  dt-bindings: clock: Add r9a07g044 CPG Clock Definitions
  clk: renesas: Add CPG core wrapper for RZ/G2L SoC
  clk: renesas: Add support for R9A07G044 SoC
  arm64: dts: renesas: Add initial DTSI for RZ/G2{L,LC} SoC's
  arm64: dts: renesas: Add initial device tree for RZ/G2L SMARC EVK
  arm64: dts: renesas: r9a07g044: Add SYSC node
  clk: renesas: rzg2l: Fix off-by-one check in
    rzg2l_cpg_clk_src_twocell_get()

Yang Li (2):
  clk: renesas: rzg2l: Remove unneeded semicolon
  clk: renesas: rzg2l: Fix return value and unused assignment

 .../bindings/clock/renesas,rzg2l-cpg.yaml     |  83 ++
 .../bindings/serial/renesas,scif.yaml         |   4 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 132 +++
 arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi  |  25 +
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |  21 +
 arch/arm64/boot/dts/renesas/r9a07g044l2.dtsi  |  13 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  27 +
 drivers/clk/clk-mux.c                         |  35 +
 drivers/clk/renesas/Kconfig                   |   9 +
 drivers/clk/renesas/Makefile                  |   2 +
 drivers/clk/renesas/r9a07g044-cpg.c           | 142 +++
 drivers/clk/renesas/rzg2l-cpg.c               | 844 ++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h               | 176 ++++
 drivers/tty/serial/sh-sci.c                   |  12 +-
 drivers/tty/serial/sh-sci.h                   |   1 +
 include/dt-bindings/clock/r9a07g044-cpg.h     | 219 +++++
 include/linux/clk-provider.h                  |  13 +
 18 files changed, 1759 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
 create mode 100644 drivers/clk/renesas/r9a07g044-cpg.c
 create mode 100644 drivers/clk/renesas/rzg2l-cpg.c
 create mode 100644 drivers/clk/renesas/rzg2l-cpg.h
 create mode 100644 include/dt-bindings/clock/r9a07g044-cpg.h

-- 
2.17.1


