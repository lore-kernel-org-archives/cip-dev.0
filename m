Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEF6CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 10:40:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11710.1762425627318172200
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 02:40:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: KmqhEWUWTymCjur/OiufRw==
X-CSE-MsgGUID: wbe7VqjlSTiNHLObfNXU8g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2025 19:40:26 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.83])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 90CCF400B9FB;
	Thu,  6 Nov 2025 19:40:25 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.12.y-cip 0/9] Add RZ/V2H GBETH support
Date: Thu,  6 Nov 2025 10:40:15 +0000
Message-ID: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 10:40:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20450

Hi,

This patch series adds GBETH support for the Renesas RZ/V2H SoC,
to the linux-6.12.y-cip kernel.

Patches were cherry-picked from mainline kernel.

Note: this series depends on the following RZ/G3E series:
https://lore.kernel.org/cip-dev/20251103113817.36331-1-john.madieu.xa@bp.renesas.com/T/#t

Best regards,
Ovidiu

Biju Das (1):
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Replace RZG2L macros

Lad Prabhakar (8):
  dt-bindings: clock: renesas,r9a09g057-cpg: Add USB2 PHY and GBETH PTP
    core clocks
  clk: renesas: r9a09g057: Add clock and reset entries for USB2
  clk: renesas: r9a09g057: Add clock and reset entries for GBETH0/1
  dt-bindings: net: Define interrupt constraints for DWMAC vendor
    bindings
  dt-bindings: net: dwmac: Increase 'maxItems' for 'interrupts' and
    'interrupt-names'
  arm64: dts: renesas: r9a09g057: Add GBETH nodes
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable GBETH
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Fix pinctrl node name for
    GBETH1

 .../bindings/net/amlogic,meson-dwmac.yaml     |   6 +
 .../bindings/net/intel,dwmac-plat.yaml        |   6 +
 .../bindings/net/mediatek-dwmac.yaml          |   6 +
 .../bindings/net/nxp,dwmac-imx.yaml           |   8 +
 .../bindings/net/rockchip-dwmac.yaml          |  10 +
 .../devicetree/bindings/net/snps,dwmac.yaml   |  24 +-
 .../devicetree/bindings/net/stm32-dwmac.yaml  |  10 +
 .../bindings/net/toshiba,visconti-dwmac.yaml  |   6 +
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 209 ++++++++++++++++++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 102 +++++++--
 drivers/clk/renesas/r9a09g057-cpg.c           |  84 ++++++-
 .../dt-bindings/clock/renesas,r9a09g057-cpg.h |   4 +
 12 files changed, 447 insertions(+), 28 deletions(-)

-- 
2.51.0


