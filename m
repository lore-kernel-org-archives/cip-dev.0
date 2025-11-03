Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE950CCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18444.1762169771188210783
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:36:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: 2Rnth/ekSc6O0w4SVZcDBQ==
X-CSE-MsgGUID: KfB7VHc8TtChwDs6nspZDA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Nov 2025 20:36:10 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 71E28400942A;
	Mon,  3 Nov 2025 20:36:09 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.1.y-cip 00/25] Add RZ/G3E GBETH support
Date: Mon,  3 Nov 2025 12:35:33 +0100
Message-ID: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:36:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20292

Add RZ/G3E GBETH support to cip-6.1. While at it, also backport RZ/V2N Pinctrl and
OEN dependencies.

Biju Das (1):
  pinctrl: renesas: rzg2l: Fix OEN resume

Claudiu Beznea (1):
  pinctrl: renesas: rzg2l: Suppress binding attributes

Emil Renner Berthing (1):
  net: stmmac: platform: Add snps,dwmac-5.20 IP compatible string

Geert Uytterhoeven (1):
  dt-bindings: net: Rename renesas,r9a09g057-gbeth.yaml

Jan Petrous (OSS) (1):
  net: phy: Add helper for mapping RGMII link speed to clock rate

John Madieu (5):
  clk: renesas: r9a09g047: Add clock and reset signals for the GBETH IPs
  dt-bindings: net: renesas-gbeth: Add support for RZ/G3E (R9A09G047)
    SoC
  arm64: dts: renesas: r9a09g047: Add GBETH nodes
  arm64: dts: renesas: rzg3e-smarc-som: Enable eth{0-1} (GBETH)
    interfaces
  arm64: dts: renesas: r9a09g047: Enable Tx coe support

Lad Prabhakar (12):
  soc: renesas: Add config option for RZ/V2N (R9A09G056) SoC
  dt-bindings: pinctrl: renesas: Document RZ/V2N SoC
  pinctrl: renesas: rzg2l: Add support for RZ/V2N SoC
  pinctrl: renesas: rzg2l: Fix invalid unsigned return in
    rzg3s_oen_read()
  pinctrl: renesas: rzg2l: Parameterize OEN register offset
  pinctrl: renesas: rzg2l: Unify OEN access by making pin-to-bit mapping
    configurable
  pinctrl: renesas: rzg2l: Remove OEN ops for RZ/G3E
  pinctrl: renesas: rzg2l: Unify OEN handling across RZ/{G2L,V2H,V2N}
  pinctrl: renesas: rzg2l: Add PFC_OEN support for RZ/G3E SoC
  pinctrl: renesas: rzg2l: Drop oen_read and oen_write callbacks
  dt-bindings: net: Document support for Renesas RZ/V2H(P) GBETH
  net: stmmac: Add DWMAC glue layer for Renesas GBETH

Russell King (Oracle) (3):
  net: stmmac: provide set_clk_tx_rate() hook
  net: stmmac: provide generic implementation for set_clk_tx_rate method
  net: stmmac: provide stmmac_pltfr_find_clk()

 .../bindings/net/renesas,rzv2h-gbeth.yaml     | 203 +++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |   2 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 207 ++++++++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 111 ++++
 drivers/clk/renesas/r9a09g047-cpg.c           |  64 +++
 drivers/clk/renesas/rzv2h-cpg.h               |   7 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      | 147 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  43 ++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  14 +-
 .../ethernet/stmicro/stmmac/stmmac_platform.h |   3 +
 drivers/pinctrl/renesas/Kconfig               |   1 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 502 ++++++++++--------
 drivers/soc/renesas/Kconfig                   |   6 +
 include/linux/phy.h                           |  23 +
 include/linux/stmmac.h                        |   7 +
 19 files changed, 1120 insertions(+), 235 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c

-- 
2.25.1


