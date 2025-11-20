Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CAACF9C50
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1430.1763657851334031061
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 08:57:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: WN0fsyOSSyuW43yR5vM+5Q==
X-CSE-MsgGUID: QRkbiA8cT+Sy7TkYnIP0cg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Nov 2025 01:57:29 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2ABA2405D4C7;
	Fri, 21 Nov 2025 01:57:27 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.1.y-cip 0/9] Add RZ/V2H USB2.0 support
Date: Thu, 20 Nov 2025 16:57:17 +0000
Message-ID: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 16:57:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20637

Hi,

This series adds USB2.0 support for the Renesas RZ/V2H SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (9):
  dt-bindings: usb: renesas,usbhs: Add RZ/V2H(P) SoC support
  dt-bindings: reset: Document RZ/V2H(P) USB2PHY reset
  reset: Add USB2PHY port reset driver for Renesas RZ/V2H(P)
  dt-bindings: phy: renesas,usb2-phy: Add clock constraint for RZ/G2L
    family
  dt-bindings: phy: renesas,usb2-phy: Document RZ/V2H(P) SoC
  phy: renesas: phy-rcar-gen3-usb2: Add USB2.0 PHY support for RZ/V2H(P)
  arm64: dts: renesas: r9a09g057: Add USB2.0 support
  arm64: defconfig: Enable RZ/V2H(P) USB2 PHY controller reset driver
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable USB2.0 support

 .../bindings/phy/renesas,usb2-phy.yaml        |  11 +-
 .../reset/renesas,rzv2h-usb2phy-reset.yaml    |  56 ++++
 .../bindings/usb/renesas,usbhs.yaml           |   6 +-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 113 ++++++++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  65 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |  30 ++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-rzv2h-usb2phy.c           | 270 ++++++++++++++++++
 10 files changed, 554 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/renesas,rzv2h-usb2phy-reset.yaml
 create mode 100644 drivers/reset/reset-rzv2h-usb2phy.c

-- 
2.51.0


