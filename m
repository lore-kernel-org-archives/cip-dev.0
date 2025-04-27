Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11268C369D5
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 19:16:01 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.32067.1745781352669965398
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 12:15:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: nkGHnad3S+S+Lq3aeTX1aA==
X-CSE-MsgGUID: ZWx4f1iURyiJ6zCn1g5SQw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Apr 2025 04:15:50 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5B1864075A42;
	Mon, 28 Apr 2025 04:15:49 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 00/16] Add initial support for Renesas RZ/V2H(SoC) and EVK
Date: Sun, 27 Apr 2025 20:15:32 +0100
Message-ID: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 19:16:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18651

Hi All,

This patch series aims to add initial support for Renesas
RZ/V2H(P) SoC. With the initial patches in, the EVK platform
can boot up with the below features enabled.
- EXT CLKs
- 4X CA55
- SCIF
- PFC
- CPG
- SYS
- GIC
- ARMv8 Timer
- SDHI
- I2C
- OSTM

Note,
- All the patches have been cherry picked from v6.15-rc3
- There are some RZ/G2L SoC family patches which update
  the fallback compatiable string for which the driver patches
  have been already posted [0].
- There is a RZ/G3S SoC DTSI change to enabled SYS node for which
  the driver has been already posted [0].

[0] https://lore.kernel.org/all/20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Claudiu Beznea (1):
  arm64: dts: renesas: r9a08g045: Enable SYS node

John Madieu (1):
  arm64: dts: renesas: r9a09g057: Enable SYS node

Lad Prabhakar (14):
  clk: renesas: r9a09g057: Add reset entry for SYS
  clk: renesas: r9a09g057: Add clock and reset entries for GIC
  arm64: dts: renesas: r9a09g011: Update fallback string for SDHI nodes
  arm64: dts: renesas: rzg2l: Update fallback string for SDHI nodes
  arm64: dts: renesas: r9a08g045: Update fallback string for SDHI nodes
  arm64: dts: renesas: Add initial SoC DTSI for RZ/V2H(P) SoC
  arm64: dts: renesas: Add initial DTS for RZ/V2H EVK board
  arm64: dts: renesas: r9a09g057: Add OSTM0-OSTM7 nodes
  arm64: dts: renesas: r9a09g057: Add RIIC0-RIIC8 nodes
  arm64: dts: renesas: r9a09g057: Add SDHI0-SDHI2 nodes
  arm64: dts: renesas: r9a09g057: Add WDT0-WDT3 nodes
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable OSTM, I2C, and
    SDHI
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable watchdog
  arm64: dts: renesas: r9a09g057: Add OPP table

 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   4 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |   4 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |   4 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   7 +-
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |   6 +-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 553 ++++++++++++++++++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 256 ++++++++
 drivers/clk/renesas/r9a09g057-cpg.c           |   5 +
 9 files changed, 828 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g057.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts

-- 
2.43.0


