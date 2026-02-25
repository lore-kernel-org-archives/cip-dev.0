Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE84FCEE98
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 12:10:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43743.1772021407767692371
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 04:10:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: o+gXir9JSumvDgnpWF5z5g==
X-CSE-MsgGUID: dkzwXc4LQJ+SIEv/jO3onw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Feb 2026 21:10:06 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DA22741A8278;
	Wed, 25 Feb 2026 21:10:04 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 00/25] Add RZ/V2H display support
Date: Wed, 25 Feb 2026 12:09:38 +0000
Message-ID: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 12:10:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21931

Hi,

This series adds display support for the Renesas RZ/V2H SoC and EVK board.

All patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Hugo Villeneuve (1):
  dt-bindings: display: bridge: renesas,dsi: allow properties from
    dsi-controller

Lad Prabhakar (24):
  dt-bindings: display: bridge: renesas,dsi: Document RZ/V2H(P) and
    RZ/V2N
  media: dt-bindings: media: renesas,vsp1: Document RZ/V2H(P)
  media: dt-bindings: media: renesas,fcp: Document RZ/V2H(P) SoC
  dt-bindings: display: renesas,rzg2l-du: Add support for RZ/V2H(P) SoC
  clk: renesas: rzv2h: Add instance field to struct pll
  clk: renesas: rzv2h: Use GENMASK for PLL fields
  clk: renesas: rzv2h: Add support for DSI clocks
  clk: renesas: r9a09g057: Add clock and reset entries for DSI and LCDC
  drm: renesas: rz-du: mipi_dsi: Simplify HSFREQ calculation
  drm: renesas: rz-du: mipi_dsi: Use VCLK for HSFREQ calculation
  drm: renesas: rz-du: mipi_dsi: Add min check for VCLK range
  drm: renesas: rz-du: mipi_dsi: Add OF data support
  drm: renesas: rz-du: mipi_dsi: Make "rst" reset control optional for
    RZ/V2H(P)
  drm: renesas: rz-du: mipi_dsi: Use mHz for D-PHY frequency
    calculations
  drm: renesas: rz-du: mipi_dsi: Add feature flag for 16BPP support
  drm: renesas: rz-du: mipi_dsi: Add dphy_late_init() callback for
    RZ/V2H(P)
  drm: renesas: rz-du: mipi_dsi: Add function pointers for configuring
    VCLK and mode validation
  drm: renesas: rz-du: mipi_dsi: Add LPCLK clock support
  drm: renesas: rz-du: mipi_dsi: Add support for RZ/V2H(P) SoC
  drm: renesas: rz-du: Add support for RZ/V2H(P) SoC
  drm: renesas: rz-du: Drop ARCH_RZG2L dependency
  arm64: dts: renesas: r9a09g057: Add FCPV and VSPD nodes
  arm64: dts: renesas: r9a09g057: Add DU and DSI nodes
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable DU and DSI

 .../bindings/display/bridge/renesas,dsi.yaml  | 187 +++++-
 .../bindings/display/renesas,rzg2l-du.yaml    |  23 +-
 .../bindings/media/renesas,fcp.yaml           |   2 +
 .../bindings/media/renesas,vsp1.yaml          |   1 +
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  89 +++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  71 +++
 drivers/clk/renesas/r9a09g057-cpg.c           |  62 ++
 drivers/clk/renesas/rzv2h-cpg.c               | 512 ++++++++++++++-
 drivers/clk/renesas/rzv2h-cpg.h               |  29 +-
 drivers/gpu/drm/renesas/rz-du/Kconfig         |   2 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |  11 +
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 602 ++++++++++++++++--
 .../drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h   |  36 +-
 include/linux/clk/renesas.h                   | 145 +++++
 14 files changed, 1691 insertions(+), 81 deletions(-)

-- 
2.34.1


