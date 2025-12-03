Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5835D15D9D
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:41:07 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18296.1764776461970046583
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 07:41:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: bFZL4fPoQu6ZmXnnrAcd8g==
X-CSE-MsgGUID: +pGhjrlqT3iXYG1DwBPxqg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Dec 2025 00:41:01 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.82])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 397E0400C979;
	Thu,  4 Dec 2025 00:40:59 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 00/11] Add initial support for RZ/V2N EVK
Date: Wed,  3 Dec 2025 15:40:47 +0000
Message-ID: <20251203154058.33022-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 15:41:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20826

Hi,

This series adds initial support for the Renesas RZ/V2N EVK platform. It
provides the basic SoC and board dts files and enables the following core
functionality:
  - CPU (Cortex-A55 cores with operating points)
  - External clocks (audio, qextal, rtxin)
  - Pin controller (GPIO support)
  - Clock Pulse Generator (CPG)
  - System controller (SYS)
  - Serial Communication Interface (SCIF)
  - Secure Digital Host Interface and eMMC (SDHI)
  - Generic Interrupt Controller (GIC)
  - ARMv8 timer

Note that the RZ/V2N SoC shares most functionality with the RZ/V2H SoC,
which is already supported in the CIP kernels, so most of the required
driver infrastructure is already available.

Thanks,
Ovidiu

Lad Prabhakar (11):
  dt-bindings: soc: renesas: Document Renesas RZ/V2N SoC variants and
    EVK
  soc: renesas: Add config option for RZ/V2N (R9A09G056) SoC
  dt-bindings: soc: renesas: Document SYS for RZ/V2N SoC
  soc: renesas: rz-sysc: Add SoC identification for RZ/V2N SoC
  dt-bindings: serial: renesas: Document RZ/V2N SCIF
  dt-bindings: mmc: renesas,sdhi: Document RZ/V2N support
  dt-bindings: clock: renesas: Document RZ/V2N SoC CPG
  clk: renesas: rzv2h: Add support for RZ/V2N SoC
  arm64: dts: renesas: Add initial SoC DTSI for RZ/V2N
  arm64: dts: renesas: Add initial device tree for RZ/V2N EVK
  arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and
    RZ/V2N EVKs

 .../bindings/clock/renesas,rzv2h-cpg.yaml     |   5 +-
 .../devicetree/bindings/mmc/renesas,sdhi.yaml |   4 +-
 .../bindings/serial/renesas,scif.yaml         |   1 +
 .../soc/renesas/renesas,r9a09g057-sys.yaml    |   5 +-
 .../bindings/soc/renesas/renesas.yaml         |  15 +
 arch/arm64/boot/dts/renesas/Makefile          |   8 +
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 282 ++++++++++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 123 ++++++++
 drivers/clk/renesas/Kconfig                   |   5 +
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a09g056-cpg.c           | 152 ++++++++++
 drivers/clk/renesas/rzv2h-cpg.c               |   6 +
 drivers/clk/renesas/rzv2h-cpg.h               |   1 +
 drivers/soc/renesas/Kconfig                   |  11 +
 drivers/soc/renesas/Makefile                  |   1 +
 drivers/soc/renesas/r9a09g056-sys.c           |  75 +++++
 drivers/soc/renesas/rz-sysc.c                 |   3 +
 drivers/soc/renesas/rz-sysc.h                 |   1 +
 .../dt-bindings/clock/renesas,r9a09g056-cpg.h |  24 ++
 19 files changed, 719 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g056.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
 create mode 100644 drivers/clk/renesas/r9a09g056-cpg.c
 create mode 100644 drivers/soc/renesas/r9a09g056-sys.c
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g056-cpg.h

-- 
2.51.0


