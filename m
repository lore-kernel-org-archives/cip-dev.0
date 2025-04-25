Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC65C369D5
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:14:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5186.1745583290157660139
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 05:14:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: Iw2eKN3eTFu4jidK1u7+pA==
X-CSE-MsgGUID: ALxX4ZLkQ4qBC+QeAV/hZg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Apr 2025 21:14:48 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1CD5842D7EC5;
	Fri, 25 Apr 2025 21:14:46 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 00/21] Add SYSC/MMC/GTM driver support for Renesas RZ/V2H(P) SoC
Date: Fri, 25 Apr 2025 13:14:24 +0100
Message-ID: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 12:14:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18622

Hi All,

This patch series aims to add below driver support to
Renesas RZ/V2H(P) SoC:
- eMMC/SDHI
- GTM
- SYSC

Note,
- All the patches have been cherry picked from upstream kernel
  v6.15-rc1
- All the patches have applied cleanly apart from 5/6/11/14 where
  the patch had to be applied manually.
- Once these patches are accepted, I plan to send the below patches
  which add initial DTS/I support to Renesas RZ/V2H EVK  (out of
  which couple of them were already posted to v6.12-cip):
   * clk: renesas: r9a09g057: Add reset entry for SYS
   * clk: renesas: r9a09g057: Add clock and reset entries for GIC
   * arm64: dts: renesas: r9a09g011: Update fallback string for SDHI nodes
   * arm64: dts: renesas: rzg2l: Update fallback string for SDHI nodes
   * arm64: dts: renesas: r9a08g045: Update fallback string for SDHI nodes
   * arm64: dts: renesas: r9a08g045: Enable SYS node
   * arm64: dts: renesas: Add initial SoC DTSI for RZ/V2H(P) SoC
   * arm64: dts: renesas: Add initial DTS for RZ/V2H EVK board
   * arm64: dts: renesas: r9a09g057: Add OSTM0-OSTM7 nodes
   * arm64: dts: renesas: r9a09g057: Add RIIC0-RIIC8 nodes
   * arm64: dts: renesas: r9a09g057: Add SDHI0-SDHI2 nodes
   * arm64: dts: renesas: r9a09g057: Add WDT0-WDT3 nodes
   * arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable OSTM, I2C, and SDHI
   * arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable watchdog
   * arm64: dts: renesas: r9a09g057: Add OPP table
   * arm64: dts: renesas: r9a09g057: Enable SYS node

Cheers,
Prabhakar

Claudiu Beznea (2):
  soc: renesas: Add SYSC driver for Renesas RZ family
  soc: renesas: rz-sysc: Move RZ/G3S SoC detection to the SYSC driver

Geert Uytterhoeven (1):
  clocksource/drivers/renesas-ostm: Avoid reprobe after successful early
    probe

John Madieu (3):
  soc: renesas: rz-sysc: Add support for RZ/G3E family
  soc: renesas: rz-sysc: Move RZ/V2H SoC detection to the SYS driver
  soc: renesas: r9a09g057-sys: Add a callback to print SoC-specific
    extra features

Krzysztof Kozlowski (1):
  soc: renesas: mark OF related data as maybe unused

Lad Prabhakar (14):
  dt-bindings: soc: renesas: Document Renesas RZ/V2H(P) SoC variants
  dt-bindings: soc: renesas: Document RZ/V2H EVK board
  dt-bindings: arm: renesas: Document Renesas RZ/V2H(P) System
    Controller
  soc: renesas: Add identification support for RZ/V2H SoC
  arm64: defconfig: Enable R9A09G057 SoC
  dt-bindings: mmc: renesas,sdhi: Group single const value items into an
    enum list
  dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC
  dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
  mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S,
    and RZ/V2M SoCs
  dt-bindings: mmc: renesas,sdhi: Document RZ/V2H(P) support
  dt-bindings: mmc: renesas,sdhi: Remove duplicate compatible and add
    clock checks
  mmc: renesas_sdhi: Add RZ/V2H(P) compatible string
  dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2H(P) SoC
  clocksource/drivers/renesas-ostm: Allow OSTM driver to reprobe for
    RZ/V2H(P) SoC

 .../devicetree/bindings/arm/renesas.yaml      |  10 ++
 .../devicetree/bindings/mmc/renesas,sdhi.yaml |  39 +++--
 .../soc/renesas/renesas,r9a09g057-sys.yaml    |  51 +++++++
 .../bindings/timer/renesas,ostm.yaml          |   2 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clocksource/renesas-ostm.c            |   3 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  10 +-
 drivers/soc/renesas/Kconfig                   |  23 +++
 drivers/soc/renesas/Makefile                  |   4 +
 drivers/soc/renesas/r9a08g045-sysc.c          |  23 +++
 drivers/soc/renesas/r9a09g047-sys.c           |  67 +++++++++
 drivers/soc/renesas/r9a09g057-sys.c           |  67 +++++++++
 drivers/soc/renesas/renesas-soc.c             |  15 +-
 drivers/soc/renesas/rz-sysc.c                 | 137 ++++++++++++++++++
 drivers/soc/renesas/rz-sysc.h                 |  46 ++++++
 15 files changed, 458 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml
 create mode 100644 drivers/soc/renesas/r9a08g045-sysc.c
 create mode 100644 drivers/soc/renesas/r9a09g047-sys.c
 create mode 100644 drivers/soc/renesas/r9a09g057-sys.c
 create mode 100644 drivers/soc/renesas/rz-sysc.c
 create mode 100644 drivers/soc/renesas/rz-sysc.h

-- 
2.43.0


