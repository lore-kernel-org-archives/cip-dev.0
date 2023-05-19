Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D07C7EE2A
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:07 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20922.1684484462890095063
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="159963100"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2023 17:21:00 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 057E3419E24B;
	Fri, 19 May 2023 17:20:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 00/23]  Add RZ/V2M I2C and WDT support
Date: Fri, 19 May 2023 09:20:35 +0100
Message-Id: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11532

This patch series aims to add I2C and WDT support for RZ/V2M EVK platform

Also backported Timer clock and reset entries, Added L2 Cache and System
controller nodes.

All these patches are cherry-picked from the mainline.

Biju Das (3):
  clk: renesas: r9a09g011: Add TIM clock and reset entries
  arm64: dts: renesas: r9a09g011: Add L2 Cache node
  arm64: dts: renesas: r9a09g011: Add system controller node

Chris Paterson (1):
  dt-bindings: i2c: renesas,rzv2m: Change maintainer to Fabrizio Castro

Fabrizio Castro (7):
  arm64: dts: renesas: r9a09g011: Fix unit address format error
  arm64: dts: renesas: r9a09g011: Reword ethernet status
  watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
  arm64: dts: renesas: r9a09g011: Add watchdog node
  arm64: dts: renesas: rzv2mevk2: Enable watchdog
  dt-bindings: i2c: renesas,rzv2m: Fix SoC specific string
  arm64: dts: renesas: r9a09g011: Fix I2C SoC specific strings

Geert Uytterhoeven (1):
  arm64: defconfig: Enable additional support for Renesas platforms

Ioana Ciornei (1):
  driver core: add a helper to setup both the of_node and fwnode of a
    device

Paul Cercueil (2):
  PM: core: Redefine pm_ptr() macro
  PM: core: Add new *_PM_OPS macros, deprecate old ones

Phil Edworthy (8):
  clk: renesas: r9a09g011: Add WDT clock and reset entries
  dt-bindings: watchdog: renesas,wdt: Add r9a09g011 (RZ/V2M) support
  watchdog: rzg2l_wdt: Add rzv2m support
  clk: renesas: r9a09g011: Add IIC clock and reset entries
  dt-bindings: i2c: Document RZ/V2M I2C controller
  i2c: Add Renesas RZ/V2M controller
  arm64: dts: renesas: r9a09g011: Add i2c nodes
  arm64: dts: renesas: rzv2m evk: Enable i2c

 .../bindings/i2c/renesas,rzv2m.yaml           |  80 +++
 .../bindings/watchdog/renesas,wdt.yaml        |  73 ++-
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |  31 +
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  57 +-
 arch/arm64/configs/defconfig                  |   1 +
 drivers/base/core.c                           |   7 +
 drivers/clk/renesas/r9a09g011-cpg.c           |  29 +
 drivers/i2c/busses/Kconfig                    |  10 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-rzv2m.c                | 532 ++++++++++++++++++
 drivers/watchdog/rzg2l_wdt.c                  |  76 ++-
 include/linux/device.h                        |   1 +
 include/linux/pm.h                            |  80 ++-
 13 files changed, 919 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
 create mode 100644 drivers/i2c/busses/i2c-rzv2m.c

-- 
2.25.1


