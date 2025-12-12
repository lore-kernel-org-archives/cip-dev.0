Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477D4D59F46
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 21:38:24 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4825.1765575497661740180
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 13:38:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: F7VrVdkgQn+SR1D/ThMciQ==
X-CSE-MsgGUID: ysPYuQFHQ3KlwPUiJCCifQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Dec 2025 06:38:15 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AC06D407379E;
	Sat, 13 Dec 2025 06:38:14 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 0/4] Add RZ/V2N WDT support
Date: Fri, 12 Dec 2025 21:38:00 +0000
Message-ID: <20251212213804.24005-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 21:38:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20994

Hi,

This series adds watchdog timer support for the Renesas RZ/V2N SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (4):
  clk: renesas: r9a09g056: Add clock and reset entries for WDT
    controllers
  dt-bindings: watchdog: renesas,wdt: Document RZ/V2N (R9A09G056)
    support
  arm64: dts: renesas: r9a09g056: Add WDT0-WDT3 nodes
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable WDT1

 .../bindings/watchdog/renesas,wdt.yaml        |  4 +-
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 40 +++++++++++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    |  4 ++
 drivers/clk/renesas/r9a09g056-cpg.c           | 20 ++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

-- 
2.51.0


