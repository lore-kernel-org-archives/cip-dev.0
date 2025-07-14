Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90F4C83F22
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:17:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74897.1752488214061695340
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:16:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: /P96bTUkS1CQZDPbZlrvRg==
X-CSE-MsgGUID: DMI+T8j7RkmyX4+yvHKCNw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:16:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C0B57400D4C7;
	Mon, 14 Jul 2025 19:16:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 00/36] Add RZ/G3E CANFD support
Date: Mon, 14 Jul 2025 11:16:00 +0100
Message-ID: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:17:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19486

This series adds support for the RZ/G3E CANFD driver into 6.12.y-cip.
All the patches in the series are cherry-picked from mainline.

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

Lad Prabhakar (9):
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

Tommaso Merciai (2):
  clk: renesas: rzv2h: Improve rzv2h_ddiv_set_rate()
  clk: renesas: rzv2h: Simplify rzv2h_cpg_assert()/rzv2h_cpg_deassert()

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 171 ++++++++---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  60 ++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  53 ++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  29 ++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  14 +-
 drivers/clk/renesas/rzv2h-cpg.c               | 183 ++++++++----
 drivers/clk/renesas/rzv2h-cpg.h               |  54 ++++
 drivers/net/can/rcar/rcar_canfd.c             | 278 +++++++++++++-----
 8 files changed, 676 insertions(+), 166 deletions(-)

-- 
2.43.0


