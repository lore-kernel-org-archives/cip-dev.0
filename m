Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3A8D25B65
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 13:27:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12806.1769606813945727931
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 05:26:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: yr+e4X3eSLe9Ganxmruq6A==
X-CSE-MsgGUID: xKohGAaiRS2vdPYxb4pKqQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Jan 2026 22:26:53 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3451540325B4;
	Wed, 28 Jan 2026 22:26:51 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 00/12] Add RZ/V2H TSU support
Date: Wed, 28 Jan 2026 13:26:37 +0000
Message-ID: <20260128132650.6955-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 13:27:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21749

Hi,

This series adds TSU support for the Renesas RZ/V2H SoC.

All patches, except for patch 4/12, were cherry-picked from mainline kernel.

Patch 4/12 is needed to fix asynchronous aborts during unbind. See the MSTOP
series [1] for more details.

[1] https://lore.kernel.org/cip-dev/20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com/

Best regards,
Ovidiu

Claudiu Beznea (2):
  soc: renesas: r9a09g056-sys: Populate max_register
  soc: renesas: rz-sysc: Populate readable_reg/writeable_reg in regmap
    config

Geert Uytterhoeven (1):
  thermal: renesas: Fix RZ/G3E fall-out

John Madieu (5):
  soc: renesas: rz-sysc: Add syscon/regmap support
  dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
  thermal/drivers/renesas/rzg3e: Add thermal driver for the Renesas
    RZ/G3E SoC
  thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas
    RZ/G3E SoC
  arm64: defconfig: Enable the Renesas RZ/G3E thermal driver

Kuninori Morimoto (1):
  arm64: dts: renesas: r9a09g057: Move interrupt-parent to root node

Ovidiu Panait (3):
  PM: domains: Add RZ/V2H compatible to PM domain detach list
  clk: renesas: r9a09g057: Add clock and reset entries for TSU
  arm64: dts: renesas: r9a09g057: Add TSU nodes

 .../thermal/renesas,r9a09g047-tsu.yaml        |  87 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  89 ++-
 arch/arm64/configs/defconfig                  |   1 +
 drivers/base/power/common.c                   |   1 +
 drivers/clk/renesas/r9a09g057-cpg.c           |   6 +
 drivers/soc/renesas/Kconfig                   |   1 +
 drivers/soc/renesas/r9a08g045-sysc.c          |  70 +++
 drivers/soc/renesas/r9a09g047-sys.c           |  80 +++
 drivers/soc/renesas/r9a09g056-sys.c           |  69 +++
 drivers/soc/renesas/r9a09g057-sys.c           | 102 ++++
 drivers/soc/renesas/rz-sysc.c                 |  32 +-
 drivers/soc/renesas/rz-sysc.h                 |   6 +
 drivers/thermal/renesas/Kconfig               |   7 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3e_thermal.c       | 547 ++++++++++++++++++
 16 files changed, 1098 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c

-- 
2.51.0


