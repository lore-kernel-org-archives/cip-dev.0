Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB4CD3437
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:49:54 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9369.1777877386474264569
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 May 2026 23:49:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: +TYpiAJFRnaSTZDKXmKb6g==
X-CSE-MsgGUID: b5DsRwatQaenDGrMzseXug==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 May 2026 15:49:45 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B9F2F400A884;
	Mon,  4 May 2026 15:49:44 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/9] Add USB3 support for RZ/V2H and RZ/V2N
Date: Mon,  4 May 2026 06:49:34 +0000
Message-ID: <20260504064943.7237-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 06:49:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22847

Hi,

This series adds USB3 support for the Renesas RZ/V2H and RZ/V2N SoCs.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (9):
  clk: renesas: r9a09g057: Add USB3.0 clocks/resets
  dt-bindings: clock: renesas,r9a09g057-cpg: Add USB3.0 core clocks
  dt-bindings: phy: renesas,rzg3e-usb3-phy: Add RZ/V2H(P) and RZ/V2N
    support
  arm64: dts: renesas: r9a09g057: Add USB3 PHY/Host nodes
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable USB3.0 PHYs and
    xHCI controllers
  dt-bindings: clock: renesas,r9a09g056-cpg: Add USB3.0 core clocks
  clk: renesas: r9a09g056: Add USB3.0 clocks/resets
  arm64: dts: renesas: r9a09g056: Add USB3 PHY/Host nodes
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable USB3.0 PHY and
    xHCI controller

 .../bindings/phy/renesas,rzg3e-usb3-phy.yaml  |  9 ++-
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 30 ++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 15 +++++
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 60 +++++++++++++++++++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 30 ++++++++++
 drivers/clk/renesas/r9a09g056-cpg.c           |  9 ++-
 drivers/clk/renesas/r9a09g057-cpg.c           | 16 ++++-
 .../dt-bindings/clock/renesas,r9a09g056-cpg.h |  2 +
 .../dt-bindings/clock/renesas,r9a09g057-cpg.h |  4 ++
 9 files changed, 172 insertions(+), 3 deletions(-)

-- 
2.34.1


