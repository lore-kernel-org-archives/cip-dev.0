Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479BAC77B7A
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 12:49:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.7861.1684932583108467280
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 05:49:43 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,189,1681138800"; 
   d="scan'208";a="164171349"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 May 2023 21:49:41 +0900
Received: from localhost.localdomain (unknown [10.226.93.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 82AF24000AA0;
	Wed, 24 May 2023 21:49:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip v2 00/10] Add RZ/V2M I2C support
Date: Wed, 24 May 2023 13:49:27 +0100
Message-Id: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 12:49:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11634

This patch series aims to add I2C support for RZ/V2M EVK platform

All these patches are cherry-picked from the mainline.

v1->v2:
 * Dropped patch#2 and patch#3 and replaced 
   SYSTEM_SLEEP_PM_OPS->SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
   and pm_sleep_ptr->DEV_PM_OPS.

Chris Paterson (1):
  dt-bindings: i2c: renesas,rzv2m: Change maintainer to Fabrizio Castro

Fabrizio Castro (2):
  dt-bindings: i2c: renesas,rzv2m: Fix SoC specific string
  arm64: dts: renesas: r9a09g011: Fix I2C SoC specific strings

Geert Uytterhoeven (1):
  arm64: defconfig: Enable additional support for Renesas platforms

Ioana Ciornei (1):
  driver core: add a helper to setup both the of_node and fwnode of a
    device

Phil Edworthy (5):
  clk: renesas: r9a09g011: Add IIC clock and reset entries
  dt-bindings: i2c: Document RZ/V2M I2C controller
  i2c: Add Renesas RZ/V2M controller
  arm64: dts: renesas: r9a09g011: Add i2c nodes
  arm64: dts: renesas: rzv2m evk: Enable i2c

 .../bindings/i2c/renesas,rzv2m.yaml           |  80 +++
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |  27 +
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  28 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/base/core.c                           |   7 +
 drivers/clk/renesas/r9a09g011-cpg.c           |   4 +
 drivers/i2c/busses/Kconfig                    |  10 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-rzv2m.c                | 538 ++++++++++++++++++
 include/linux/device.h                        |   1 +
 10 files changed, 697 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
 create mode 100644 drivers/i2c/busses/i2c-rzv2m.c

-- 
2.25.1


