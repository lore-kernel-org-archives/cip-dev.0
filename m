Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB243C83F27
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.74764.1752487687852249465
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: jZXwPi+uRtmdm7ztHMZOGw==
X-CSE-MsgGUID: 9H7KA5juTIaspDQcTUsSdg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:05 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 38B6741D45A4;
	Mon, 14 Jul 2025 19:08:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 00/57] Add RZ/G3E CANFD support
Date: Mon, 14 Jul 2025 11:06:41 +0100
Message-ID: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19428

This series adds support for the RZ/G3E CANFD driver into 6.1.y-cip.
All the patches in the series are cherry-picked from mainline.

Andy Shevchenko (1):
  lib/string_helpers: Split out string_choices.h

Bhavya Kapoor (1):
  arm64: defconfig: Enable CAN PHY transceiver driver

Biju Das (25):
  clk: renesas: rzv2h: Adjust for CPG_BUS_m_MSTOP starting from m = 1
  clk: renesas: rzv2h: Fix a typo
  clk: renesas: rzv2h: Support static dividers without RMW
  dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
  dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
  can: rcar_canfd: Use of_get_available_child_by_name()
  can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
  can: rcar_canfd: Update RCANFD_GERFL_ERR macro
  can: rcar_canfd: Drop the mask operation in RCANFD_GAFLCFG_SETRNC
    macro
  can: rcar_canfd: Add rcar_canfd_setrnc()
  can: rcar_canfd: Update RCANFD_GAFLCFG macro
  can: rcar_canfd: Add rnc_field_width variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
  can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
  can: rcar_canfd: Add {nom,data}_bittiming variables to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Add ch_interface_mode variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Add shared_can_regs variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Add struct rcanfd_regs variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
  can: rcar_canfd: Add external_clk variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Enhance multi_channel_irqs handling
  can: rcar_canfd: Add RZ/G3E support
  arm64: dts: renesas: r9a09g047: Add CANFD node
  arm64: dts: renesas: r9a09g047e57-smarc: Enable CANFD
  arm64: dts: renesas: r9a09g047e57-smarc: Enable CAN Transceiver

Geert Uytterhoeven (18):
  dt-bindings: can: renesas,rcar-canfd: Fix number of channels for R-Car
    V3U
  dt-bindings: can: renesas,rcar-canfd: R-Car V3U is R-Car Gen4
  dt-bindings: can: renesas,rcar-canfd: Add transceiver support
  can: rcar_canfd: Fix R-Car V3U CAN mode selection
  can: rcar_canfd: Abstract out DCFG address differences
  can: rcar_canfd: Add support for R-Car Gen4
  can: rcar_canfd: Fix R-Car Gen4 DCFG.DSJW field width
  can: rcar_canfd: Fix R-Car Gen4 CFCC.CFTML field width
  can: rcar_canfd: Sort included header files
  can: rcar_canfd: Add helper variable dev
  phy: Remove unused phy_optional_get()
  phy: Add devm_of_phy_optional_get() helper
  can: rcar_canfd: Add transceiver support
  can: rcar_canfd: Improve error messages
  can: rcar_canfd: rcar_canfd_probe(): fix plain integer in
    transceivers[] init
  can: rcar_canfd: Simplify clock handling
  can: rcar_canfd: Improve printing of global operational state
  can: rcar_canfd: Remove superfluous parentheses in address
    calculations

Lad Prabhakar (10):
  clk: renesas: rzv2h: Update error message
  clk: renesas: rzv2h: Remove unused `type` field from `struct pll_clk`
  clk: renesas: rzv2h: Add support for enabling PLLs
  clk: renesas: rzv2h: Rename PLL field macros for consistency
  clk: renesas: rzv2h: Sort compatible list based on SoC part number
  clk: renesas: rzv2h: Add support for static mux clocks
  clk: renesas: rzv2h: Add macro for defining static dividers
  clk: renesas: rzv2h: Use str_on_off() helper in
    rzv2h_mod_clock_endisable()
  clk: renesas: rzv2h: Use both CLK_ON and CLK_MON bits for clock state
    validation
  dt-bindings: can: renesas,rcar-canfd: Document RZ/Five SoC

Tommaso Merciai (2):
  clk: renesas: rzv2h: Improve rzv2h_ddiv_set_rate()
  clk: renesas: rzv2h: Simplify rzv2h_cpg_assert()/rzv2h_cpg_deassert()

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 242 ++++++---
 Documentation/driver-api/phy/phy.rst          |  24 +-
 MAINTAINERS                                   |   3 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  60 +++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  53 ++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  29 +
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  14 +-
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/rzv2h-cpg.c               | 183 +++++--
 drivers/clk/renesas/rzv2h-cpg.h               |  54 ++
 drivers/net/can/rcar/rcar_canfd.c             | 507 ++++++++++++------
 drivers/phy/phy-core.c                        |  51 +-
 include/linux/phy/phy.h                       |  16 +-
 include/linux/string_choices.h                |  32 ++
 include/linux/string_helpers.h                |  26 +-
 15 files changed, 929 insertions(+), 366 deletions(-)
 create mode 100644 include/linux/string_choices.h

-- 
2.43.0


