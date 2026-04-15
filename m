Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BCDF419A7
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 13:19:34 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18766.1776259163887805767
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 06:19:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 0iuWxF7UTmWvhyydoLJj6A==
X-CSE-MsgGUID: OF8foUN2Q56WDql6sKpqHg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Apr 2026 22:19:22 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.18])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1DD92400A116;
	Wed, 15 Apr 2026 22:19:20 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 0/8] Add RSPI support for RZ/V2H and RZ/V2N
Date: Wed, 15 Apr 2026 13:19:11 +0000
Message-ID: <20260415131919.95486-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 13:19:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22705

Hi,

This series adds RSPI support for the Renesas RZ/V2H and RZ/V2N SoCs.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu 

Fabrizio Castro (5):
  spi: dt-bindings: Document the RZ/V2H(P) RSPI
  spi: Add driver for the RZ/V2H(P) RSPI IP
  arm64: defconfig: Enable the RZ/V2H(P) RSPI driver
  clk: renesas: r9a09g057: Add entries for the RSPIs
  arm64: dts: renesas: r9a09g057: Add RSPI nodes

Lad Prabhakar (3):
  spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/V2N SoC support
  clk: renesas: r9a09g056: Add entries for the RSPIs
  arm64: dts: renesas: r9a09g056: Add RSPI nodes

 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 100 ++++
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    |  63 +++
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  63 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a09g056-cpg.c           |  24 +
 drivers/clk/renesas/r9a09g057-cpg.c           |  24 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rzv2h-rspi.c                  | 465 ++++++++++++++++++
 9 files changed, 749 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
 create mode 100644 drivers/spi/spi-rzv2h-rspi.c

-- 
2.34.1


