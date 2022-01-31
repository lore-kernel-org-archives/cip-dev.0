Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF76BC433EF
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:11 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.31488.1643631550485289299
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108231880"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:06 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2370B4347FEA;
	Mon, 31 Jan 2022 21:19:04 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/27] Add RPCIF,
 SCI{F1} support to Renesas RZ/G2L SoC
Date: Mon, 31 Jan 2022 12:18:36 +0000
Message-Id: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7522

Hi All,

This patch series add support for the below:
* Adds a generic property "output-impedance-ohms"
* Pinctrl driver update to support set/get drive-strength and
  output-impedance-ohms
* Driver fixes and updates for RPC-IF
* Support to SPI Multi I/O Bus controller (RPC-IF) for RZ/G2L
* Support to SCI for RZ/G2L SoC
* DTS updates for RZ/G2L SMARC

All the patches have been cherry-picked from Linux v5.17-rc2.

Cheers,
Prabhakar

Biju Das (1):
  arm64: dts: renesas: r9a07g044: Sort psci node

Geert Uytterhoeven (1):
  dt-bindings: memory: renesas,rpc-if: Miscellaneous improvements

Krzysztof Kozlowski (1):
  memory: renesas-rpc-if: correct whitespace

Lad Prabhakar (24):
  dt-bindings: pincfg-node: Add "output-impedance-ohms" property
  pinctrl: pinconf-generic: Add support for "output-impedance-ohms" to
    be extracted from DT files
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Add output-impedance-ohms
    property
  pinctrl: renesas: rzg2l: Rename RZG2L_SINGLE_PIN_GET_PORT macro
  pinctrl: renesas: rzg2l: Add helper functions to read/write pin config
  pinctrl: renesas: rzg2l: Add support to get/set pin config for GPIO
    port pins
  pinctrl: renesas: rzg2l: Rename PIN_CFG_* macros to match HW manual
  pinctrl: renesas: rzg2l: Add support to get/set drive-strength and
    output-impedance-ohms
  dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
  dt-bindings: memory: renesas,rpc-if: Add optional interrupts property
  mtd: hyperbus: rpc-if: Check return value of rpcif_sw_init()
  memory: renesas-rpc-if: Return error in case devm_ioremap_resource()
    fails
  memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
  memory: renesas-rpc-if: Add support for RZ/G2L
  clk: renesas: r9a07g044: Add clock and reset entries for SPI Multi I/O
    Bus Controller
  arm64: dts: renesas: r9a07g044: Add SPI Multi I/O Bus controller node
  arm64: dts: renesas: rzg2l-smarc-som: Enable serial NOR flash
  clk: renesas: r9a07g044: Add clock and reset entry for SCI1
  dt-bindings: serial: renesas,scif: Make resets as a required property
  dt-bindings: serial: renesas,sci: Document RZ/G2L SoC
  serial: sh-sci: Add support to deassert/assert reset line
  arm64: dts: renesas: r9a07g044: Add SCIF[1-4] nodes
  arm64: dts: renesas: rzg2l-smarc: Enable SCIF2 on carrier board
  arm64: dts: renesas: r9a07g044: Add SCI[0-1] nodes

 .../memory-controllers/renesas,rpc-if.yaml    |  55 +++-
 .../bindings/pinctrl/pincfg-node.yaml         |   3 +
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |   2 +
 .../bindings/serial/renesas,sci.yaml          |  46 ++-
 .../bindings/serial/renesas,scif.yaml         |   1 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 129 +++++++-
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  40 +++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  28 ++
 drivers/clk/renesas/r9a07g044-cpg.c           |  21 ++
 drivers/clk/renesas/rzg2l-cpg.h               |   3 +
 drivers/memory/renesas-rpc-if.c               |  80 ++++-
 drivers/mtd/hyperbus/rpc-if.c                 |   8 +-
 drivers/pinctrl/pinconf-generic.c             |   2 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 310 ++++++++++++------
 drivers/spi/spi-rpc-if.c                      |   4 +-
 drivers/tty/serial/sh-sci.c                   |  39 ++-
 include/linux/pinctrl/pinconf-generic.h       |   3 +
 include/memory/renesas-rpc-if.h               |  14 +-
 18 files changed, 639 insertions(+), 149 deletions(-)

-- 
2.17.1


