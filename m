Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7262DEE644C
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 17:00:33 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88822.1767200430621493146
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 09:00:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: jlxKOPZmQsGZ+GLGjBGFXw==
X-CSE-MsgGUID: 5p/8AlkPRsiPIrImuxeebg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Jan 2026 02:00:29 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AE85C4023E88;
	Thu,  1 Jan 2026 02:00:27 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/17] Add SDHI/eMMC and WDT support for RZ/T2H and RZ/N2H
Date: Wed, 31 Dec 2025 17:00:09 +0000
Message-ID: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 17:00:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21279

Hi All,

This series of patches adds support for the SDHI/eMMC controller as well as
the Watchdog Timer (WDT) found on the Renesas RZ/T2H (R9A09G077) and RZ/N2H
(R9A09G087) SoCs. The series includes device tree bindings, clock controller
support, and device tree nodes for the respective peripherals.

Note,
- All the patches have been cherry picked from the mainline Linux kernel.
- This series depends on the following series which has already been
  submitted for review:
  https://lore.kernel.org/all/20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (17):
  dt-bindings: watchdog: renesas,wdt: Add support for RZ/T2H and RZ/N2H
  watchdog: rzv2h: Obtain clock-divider and timeout values from OF match
    data
  watchdog: rzv2h: Make "oscclk" and reset controller optional
  watchdog: rzv2h: Add support for configurable count clock source
  watchdog: rzv2h: Add support for RZ/T2H
  dt-bindings: mmc: renesas,sdhi: Document RZ/T2H and RZ/N2H support
  dt-bindings: clock: renesas,r9a09g077/87: Add SDHI_CLKHS clock ID
  clk: renesas: cpg-mssr: Add read-back and delay handling for RZ/T2H
    MSTP
  clk: renesas: r9a09g077: Add PLL2 and SDHI clock support
  arm64: dts: renesas: r9a09g077: Add SDHI nodes
  arm64: dts: renesas: r9a09g087: Add SDHI nodes
  arm64: dts: renesas: rzt2h-rzn2h-evk: Enable eMMC
  arm64: dts: renesas: rzt2h-rzn2h-evk: Enable MicroSD card slot
  arm64: dts: renesas: rzt2h-rzn2h-evk: Enable SD card slot
  arm64: dts: renesas: r9a09g077: Add WDT nodes
  arm64: dts: renesas: r9a09g087: Add WDT nodes
  arm64: dts: renesas: rzt2h-n2h-evk-common: Enable WDT2

 .../devicetree/bindings/mmc/renesas,sdhi.yaml |  85 +++++----
 .../bindings/watchdog/renesas,wdt.yaml        |  36 +++-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    | 100 +++++++++++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  23 +++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    | 100 +++++++++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  25 +++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     | 169 ++++++++++++++++++
 drivers/clk/renesas/r9a09g077-cpg.c           |  12 +-
 drivers/clk/renesas/renesas-cpg-mssr.c        |  15 +-
 drivers/watchdog/rzv2h_wdt.c                  | 140 +++++++++++++--
 .../clock/renesas,r9a09g077-cpg-mssr.h        |   1 +
 .../clock/renesas,r9a09g087-cpg-mssr.h        |   1 +
 12 files changed, 656 insertions(+), 51 deletions(-)

-- 
2.43.0


