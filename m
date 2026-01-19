Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B32D4899D
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 12:52:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34123.1768827110577540923
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 04:51:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: KxnwH8OVTFm2bhyF4bxo9Q==
X-CSE-MsgGUID: LDJbqsK5TJKU3ep3OhLvEw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jan 2026 21:51:49 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B0F12401BC1D;
	Mon, 19 Jan 2026 21:51:48 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/6] Add RZ/V2N USB2.0 support
Date: Mon, 19 Jan 2026 12:51:41 +0000
Message-ID: <20260119125147.32175-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 12:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21652

Hi,

This series adds USB2.0 support for the Renesas RZ/V2N SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (6):
  clk: renesas: r9a09g056: Add clock and reset entries for USB2.0
  dt-bindings: reset: renesas,rzv2h-usb2phy: Document RZ/V2N SoC support
  dt-bindings: usb: renesas,usbhs: Add RZ/V2N SoC support
  dt-bindings: phy: renesas,usb2-phy: Document RZ/V2N SoC support
  arm64: dts: renesas: r9a09g056: Add USB2.0 support
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable USB2.0 support

 .../bindings/phy/renesas,usb2-phy.yaml        |  4 ++
 .../reset/renesas,rzv2h-usb2phy-reset.yaml    |  7 +-
 .../bindings/usb/renesas,usbhs.yaml           |  1 +
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 66 +++++++++++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 36 ++++++++++
 drivers/clk/renesas/r9a09g056-cpg.c           | 10 +++
 6 files changed, 123 insertions(+), 1 deletion(-)

-- 
2.51.0


