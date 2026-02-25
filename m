Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99A8FCEEB4
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 12:12:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43797.1772021555976081793
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 04:12:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: GFIf82j9Roe+zkIWs6gCAw==
X-CSE-MsgGUID: aDimo5b6ScWoNXiq0OKAEg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Feb 2026 21:12:35 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 404DA401CBF7;
	Wed, 25 Feb 2026 21:12:33 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 00/24] Add RZ/V2H display support
Date: Wed, 25 Feb 2026 12:12:08 +0000
Message-ID: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 12:12:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21957

Hi,

This series adds display support for the Renesas RZ/V2H SoC and EVK board.

All patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Hugo Villeneuve (1):
  dt-bindings: display: bridge: renesas,dsi: allow properties from
    dsi-controller

Lad Prabhakar (23):
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
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 601 ++++++++++++++++--
 .../drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h   |  36 +-
 include/linux/clk/renesas.h                   | 145 +++++
 14 files changed, 1689 insertions(+), 82 deletions(-)

-- 
2.51.0


