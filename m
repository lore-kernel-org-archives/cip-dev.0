Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BD6D32D66
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:11 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7063.1764945182570660387
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: AKYprOzcTEqWvfnSRw3CQA==
X-CSE-MsgGUID: NtapIc/AQ0+j4sOG2ToGhA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:00 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8B2A84178CDE;
	Fri,  5 Dec 2025 23:32:59 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/38] Add support for Renesas RZ/T2H and RZ/N2H SoCs
Date: Fri,  5 Dec 2025 14:32:20 +0000
Message-ID: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20914

Hi All,

This series adds baseline support for Renesas RZ/T2H [0] and RZ/N2H [1]
SoCs, covering DT bindings, SoC configuration entries, CPG/MSSR clocks,
pinctrl support, and the necessary updates to the sh-sci driver to handle
the new SCI/RSCI instances. It introduces initial SoC and EVK DTSI/DTS
files, refactors the existing RZ/T2H EVK description, and adds variant
specific data and common EVK features such as pinctrl nodes and user LEDs.
These changes form the core groundwork for further enablement in CIP.

Note,
- All the patches have been cherry-picked from upstream kernel apart from
  patch "dt-bindings: soc: renesas: Sort SoC entries based on part number"
  which is created to maintain consistency in SoC entries based on part
  number.
- Patch "serial: sh-sci: Add support for RZ/T2H SCI" has a manual change
  fixing EXPORT_SYMBOL_NS_GPL and MODULE_IMPORT_NS to fit according to the
  API which is present in kernel version 6.12.
- Patch "pinctrl: renesas: Add support for RZ/T2H" has a manual change to
  fit according to the API which is present in kernel version 6.12.

[0] https://www.renesas.com/en/products/rz-t2h?srsltid=AfmBOooNZStbc2FFDRvMlu-chTtqSufcSWJvXRPQtZZJLgO5oYRWQ-P4
[1] https://www.renesas.com/en/products/rz-n2h?srsltid=AfmBOopClNxf1_5hg3ilhM6b-LvGf1zmcFB07TmQHt-ZohHTKYSQyHew

Cheers,
Prabhakar

Geert Uytterhoeven (1):
  dt-bindings: soc: renesas: Document RZ/T2H Evaluation Board part
    number

Lad Prabhakar (16):
  dt-bindings: serial: rsci: Update maintainer entry
  dt-bindings: serial: renesas,rsci: Document RZ/N2H support
  serial: sh-sci: Replace direct stop_rx/stop_tx calls with port ops in
    sci_shutdown()
  dt-bindings: soc: renesas: Sort SoC entries based on part number
  soc: renesas: Add RZ/N2H (R9A09G087) config option
  dt-bindings: clock: renesas,cpg-mssr: Document RZ/N2H support
  dt-bindings: clock: renesas,r9a09g077: Add PCLKL core clock ID
  clk: renesas: r9a09g077: Add PCLKL core clock
  clk: renesas: Add CPG/MSSR support to RZ/N2H SoC
  dt-bindings: pinctrl: renesas: Document RZ/T2H and RZ/N2H SoCs
  pinctrl: renesas: rzt2h: Add support for RZ/N2H
  arm64: dts: renesas: Add initial SoC DTSI for the RZ/N2H SoC
  arm64: dts: renesas: r9a09g087: Add pinctrl node
  arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Add user LEDs
  arm64: dts: renesas: r9a09g087m44-rzn2h-evk: Add user LEDs
  arm64: dts: renesas: rzt2h-n2h-evk-common: Add pinctrl for SCI0 node

Paul Barker (4):
  dt-bindings: soc: renesas: Document RZ/N2H (R9A09G087) SoC
  arm64: dts: renesas: Refactor RZ/T2H EVK device tree
  arm64: dts: renesas: Add DTSI for R9A09G087M44 variant of RZ/N2H
  arm64: dts: renesas: Add initial support for the RZ/N2H EVK

Thierry Bultel (17):
  dt-bindings: serial: Add compatible for Renesas RZ/T2H SoC in sci
  dt-bindings: serial: renesas,rsci: Add optional secondary clock input
  serial: sh-sci: Fix a comment about SCIFA
  serial: sh-sci: Introduced function pointers
  serial: sh-sci: Introduced sci_of_data
  serial: sh-sci: Use private port ID
  serial: sh-sci: Add support for RZ/T2H SCI
  dt-bindings: soc: renesas: Add Renesas RZ/T2H (R9A09G077) SoC
  soc: renesas: Add RZ/T2H (R9A09G077) config option
  dt-bindings: clock: renesas,cpg-mssr: Document RZ/T2H support
  clk: renesas: Pass sub struct of cpg_mssr_priv to cpg_clk_register
  clk: renesas: Add support for R9A09G077 SoC
  pinctrl: renesas: Add support for RZ/T2H
  arm64: dts: renesas: Add initial support for the Renesas RZ/T2H SoC
  arm64: dts: renesas: Add initial support for the Renesas RZ/T2H eval
    board
  arm64: dts: renesas: r9a09g077: Add pinctrl node
  arm64: defconfig: Enable Renesas RZ/T2H serial SCI

 .../bindings/clock/renesas,cpg-mssr.yaml      |  49 +-
 .../pinctrl/renesas,r9a09g077-pinctrl.yaml    | 172 ++++
 .../bindings/serial/renesas,rsci.yaml         |  85 ++
 .../bindings/soc/renesas/renesas.yaml         |  44 +-
 arch/arm64/boot/dts/renesas/Makefile          |   4 +
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    | 137 +++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  91 ++
 arch/arm64/boot/dts/renesas/r9a09g077m44.dtsi |  13 +
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    | 137 +++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 107 +++
 arch/arm64/boot/dts/renesas/r9a09g087m44.dtsi |  13 +
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  45 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/Kconfig                   |  10 +
 drivers/clk/renesas/Makefile                  |   2 +
 drivers/clk/renesas/r7s9210-cpg-mssr.c        |   7 +-
 drivers/clk/renesas/r8a77970-cpg-mssr.c       |   8 +-
 drivers/clk/renesas/r9a09g077-cpg.c           | 243 +++++
 drivers/clk/renesas/rcar-gen2-cpg.c           |   5 +-
 drivers/clk/renesas/rcar-gen2-cpg.h           |   3 +-
 drivers/clk/renesas/rcar-gen3-cpg.c           |   6 +-
 drivers/clk/renesas/rcar-gen3-cpg.h           |   3 +-
 drivers/clk/renesas/rcar-gen4-cpg.c           |   6 +-
 drivers/clk/renesas/rcar-gen4-cpg.h           |   3 +-
 drivers/clk/renesas/renesas-cpg-mssr.c        | 193 ++--
 drivers/clk/renesas/renesas-cpg-mssr.h        |  32 +-
 drivers/pinctrl/renesas/Kconfig               |  13 +
 drivers/pinctrl/renesas/Makefile              |   1 +
 drivers/pinctrl/renesas/pinctrl-rzt2h.c       | 811 +++++++++++++++++
 drivers/soc/renesas/Kconfig                   |  12 +
 drivers/tty/serial/Kconfig                    |   7 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/rsci.c                     | 480 ++++++++++
 drivers/tty/serial/rsci.h                     |  10 +
 drivers/tty/serial/sh-sci-common.h            | 175 ++++
 drivers/tty/serial/sh-sci.c                   | 840 ++++++++++--------
 drivers/tty/serial/sh-sci.h                   |   2 -
 .../clock/renesas,r9a09g077-cpg-mssr.h        |  28 +
 .../clock/renesas,r9a09g087-cpg-mssr.h        |  28 +
 .../pinctrl/renesas,r9a09g077-pinctrl.h       |  22 +
 40 files changed, 3403 insertions(+), 446 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,r9a09g077-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,rsci.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g077.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g077m44.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g087.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g087m44.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
 create mode 100644 drivers/clk/renesas/r9a09g077-cpg.c
 create mode 100644 drivers/pinctrl/renesas/pinctrl-rzt2h.c
 create mode 100644 drivers/tty/serial/rsci.c
 create mode 100644 drivers/tty/serial/rsci.h
 create mode 100644 drivers/tty/serial/sh-sci-common.h
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g077-pinctrl.h


base-commit: 52bf1e8331d81be1bfeb950a51e3ad683157b805
-- 
2.43.0


