Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5B2CA0EFA
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:39:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.15351.1755679146753582501
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:39:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: Rck/D+40ThOVEEnjHoJW4Q==
X-CSE-MsgGUID: TmoxbLyWRrisxjEAbA5RdA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:39:05 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9CFCB415F3C9;
	Wed, 20 Aug 2025 17:39:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/22] Add RZ/G3E XSPI support
Date: Wed, 20 Aug 2025 09:38:08 +0100
Message-ID: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:39:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19769

Add RZ/G3E XSPI support to cip-6.1. Also backported
clk and irq patches.

All the patches in the series are cherry-picked from mainline.

Biju Das (15):
  dt-bindings: clock: renesas,r9a09g047-cpg: Add XSPI and GBETH PTP core
    clocks
  clk: renesas: r9a09g047: Add support for xspi mux and divider
  clk: renesas: r9a09g047: Add XSPI clock/reset
  memory: renesas-rpc-if: Fix RPCIF_DRENR_CDB macro error
  memory: renesas-rpc-if: Move rpcif_info definitions near to the user
  dt-bindings: memory: Document RZ/G3E support
  memory: renesas-rpc-if: Move rpc-if reg definitions
  memory: renesas-rpc-if: Use devm_reset_control_array_get_exclusive()
  memory: renesas-rpc-if: Add regmap to struct rpcif_info
  memory: renesas-rpc-if: Add wrapper functions
  memory: renesas-rpc-if: Add RZ/G3E xSPI support
  spi: rpc-if: Add write support for memory-mapped area
  irqchip/renesas-rzv2h: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
  arm64: dts: renesas: r9a09g047: Add XSPI node
  arm64: dts: renesas: rzg3e-smarc-som: Enable serial NOR FLASH

Fabrizio Castro (1):
  clk: renesas: rzv2h: Add missing include file

Geert Uytterhoeven (1):
  clk: renesas: Use str_on_off() helper

John Madieu (1):
  arm64: dts: renesas: r9a09g047: Add SYS node

Lad Prabhakar (4):
  clk: renesas: rzv2h: Skip monitor checks for external clocks
  clk: renesas: rzv2h: Fix missing CLK_SET_RATE_PARENT flag for ddiv
    clocks
  clk: renesas: rzv2h: Drop redundant base pointer from pll_clk
  clk: renesas: rzv2h: Add fixed-factor module clocks with status
    reporting

 .../renesas,rzg3e-xspi.yaml                   | 135 ++++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  28 +
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  46 ++
 drivers/clk/renesas/r9a09g047-cpg.c           |  39 +-
 drivers/clk/renesas/renesas-cpg-mssr.c        |   3 +-
 drivers/clk/renesas/rzg2l-cpg.c               |   5 +-
 drivers/clk/renesas/rzv2h-cpg.c               | 126 +++-
 drivers/clk/renesas/rzv2h-cpg.h               |  47 +-
 drivers/irqchip/irq-renesas-rzv2h.c           |   4 +-
 drivers/memory/renesas-rpc-if-regs.h          | 146 ++++
 drivers/memory/renesas-rpc-if.c               | 689 +++++++++++++-----
 drivers/memory/renesas-xspi-if-regs.h         | 105 +++
 drivers/spi/spi-rpc-if.c                      |  16 +-
 .../dt-bindings/clock/renesas,r9a09g047-cpg.h |   3 +
 include/memory/renesas-rpc-if.h               |   4 +
 15 files changed, 1201 insertions(+), 195 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml
 create mode 100644 drivers/memory/renesas-rpc-if-regs.h
 create mode 100644 drivers/memory/renesas-xspi-if-regs.h

-- 
2.43.0


