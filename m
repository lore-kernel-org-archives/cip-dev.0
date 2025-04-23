Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA3EC369D7
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 18:14:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1769.1745432044927270126
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 11:14:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 9qhpFs4mQdq35AXhdQk0wA==
X-CSE-MsgGUID: sH1/Gh3cR06hCJKmFO6qMA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2025 03:14:03 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8755C40071EF;
	Thu, 24 Apr 2025 03:14:01 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.12.y-cip 00/10] Add SYS and OPP support to Renesas RZ/V2H(P) SoC
Date: Wed, 23 Apr 2025 19:13:50 +0100
Message-ID: <20250423181400.13960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 18:14:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18568

Hi all,

This patch series aims to add SYS support to RZ/V2H SoC.
The base driver was first added to RZ/G3S and later extended to
RZ/V2H SoC hence Ive included changes for RZ/G3S too. Alsong side
added the clock and reset entries for SYS and GIC and added OPP
table to the RZ/V2H SoC DTSI.

Note,
- All the patches have been cherry-picked from v6.15-rc3.
- I plan to send similar patch series for v6.1-cip

Cheers,
Prabhakar

Claudiu Beznea (3):
  soc: renesas: Add SYSC driver for Renesas RZ family
  soc: renesas: rz-sysc: Move RZ/G3S SoC detection to the SYSC driver
  arm64: dts: renesas: r9a08g045: Enable SYS node

John Madieu (4):
  soc: renesas: rz-sysc: Add support for RZ/G3E family
  soc: renesas: rz-sysc: Move RZ/V2H SoC detection to the SYS driver
  soc: renesas: r9a09g057-sys: Add a callback to print SoC-specific
    extra features
  arm64: dts: renesas: r9a09g057: Enable SYS node

Lad Prabhakar (3):
  clk: renesas: r9a09g057: Add reset entry for SYS
  clk: renesas: r9a09g057: Add clock and reset entries for GIC
  arm64: dts: renesas: r9a09g057: Add OPP table

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi |   1 -
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi |  42 ++++++-
 drivers/clk/renesas/r9a09g057-cpg.c        |   5 +
 drivers/soc/renesas/Kconfig                |  18 +++
 drivers/soc/renesas/Makefile               |   4 +
 drivers/soc/renesas/r9a08g045-sysc.c       |  23 ++++
 drivers/soc/renesas/r9a09g047-sys.c        |  67 ++++++++++
 drivers/soc/renesas/r9a09g057-sys.c        |  67 ++++++++++
 drivers/soc/renesas/renesas-soc.c          |  33 +----
 drivers/soc/renesas/rz-sysc.c              | 137 +++++++++++++++++++++
 drivers/soc/renesas/rz-sysc.h              |  46 +++++++
 11 files changed, 409 insertions(+), 34 deletions(-)
 create mode 100644 drivers/soc/renesas/r9a08g045-sysc.c
 create mode 100644 drivers/soc/renesas/r9a09g047-sys.c
 create mode 100644 drivers/soc/renesas/r9a09g057-sys.c
 create mode 100644 drivers/soc/renesas/rz-sysc.c
 create mode 100644 drivers/soc/renesas/rz-sysc.h

-- 
2.43.0


