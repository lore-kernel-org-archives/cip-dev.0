Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754D4EE49A6
	for <webhook@archiver.kernel.org>; Mon, 21 Aug 2023 14:38:11 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.1000.1692628685025774887
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 07:38:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,190,1684767600"; 
   d="scan'208";a="177171105"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2023 23:38:03 +0900
Received: from localhost.localdomain (unknown [10.226.92.38])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 99D6C4002C1F;
	Mon, 21 Aug 2023 23:38:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/15] RZ/G2{L,UL} Improvements
Date: Mon, 21 Aug 2023 15:37:44 +0100
Message-Id: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Aug 2023 14:38:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12794

This patch series add improvements to RZ/G2{L,UL} SMARC EVKs.
All the patches are cherry-picked from mainline.

Andy Shevchenko (1):
  pinctrl: renesas: Add missing header(s)

Lad Prabhakar (13):
  ASoC: sh: rz-ssi: Update interrupt handling for half duplex channels
  arm64: dts: renesas: rzg2ul-smarc: Move spi1 pinmux to carrier board
    DTSI
  clk: renesas: r9a07g044: Drop WDT2 clock and reset entry
  clk: renesas: r9a07g043: Drop WDT2 clock and reset entry
  arm64: dts: renesas: rzg2l: Drop WDT2 nodes
  arm64: dts: renesas: rzg2l: Drop #address-cells from pinctrl nodes
  arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific parts
  pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks
  arm64: dts: renesas: r9a07g043u: Add IRQC node
  arm64: dts: renesas: r9a07g043u: Update pinctrl node to handle GPIO
    interrupts
  arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for
    ETH{0/1}
  arm64: dts: renesas: r9a07g043u: Add Cortex-A55 PMU node
  arm64: dts: renesas: Drop specifying the GIC_CPU_MASK_SIMPLE() for
    GICv3 systems

Pierre Gondois (1):
  arm64: dts: renesas: rzg2l: Add missing cache-level properties

 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |  71 +--------
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   | 138 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  25 +---
 arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi  |   7 -
 arch/arm64/boot/dts/renesas/r9a07g044l1.dtsi  |   7 -
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  25 +---
 arch/arm64/boot/dts/renesas/r9a07g054l1.dtsi  |   7 -
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |   5 -
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    |   5 -
 .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi |   7 +
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    |  18 +--
 drivers/clk/renesas/r9a07g043-cpg.c           |   5 -
 drivers/clk/renesas/r9a07g044-cpg.c           |   7 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  15 +-
 drivers/pinctrl/renesas/pinctrl-rzn1.c        |   8 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |   4 +-
 drivers/pinctrl/renesas/pinctrl.c             |   8 +-
 sound/soc/sh/rz-ssi.c                         |  63 +++++---
 18 files changed, 238 insertions(+), 187 deletions(-)

-- 
2.25.1


