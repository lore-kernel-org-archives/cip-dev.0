Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59A9D1681D
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 12:16:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8762.1767960986846098294
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 04:16:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: mzysUMenTG++AiEpKMA5Qg==
X-CSE-MsgGUID: QYy1hrD+QWmnefhatJlkeQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jan 2026 21:16:25 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.57])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 18633401DE03;
	Fri,  9 Jan 2026 21:16:23 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 0/8] Add RZ/V2H RTC support
Date: Fri,  9 Jan 2026 12:16:14 +0000
Message-ID: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 12:16:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21507

Hi,

This patch series adds RTC support for the Renesas RZ/V2H SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Alexandre Belloni (1):
  rtc: renesas-rtca3: stop setting max_user_freq

Claudiu Beznea (1):
  rtc: renesas-rtca3: Disable interrupts only if the RTC is enabled

Ovidiu Panait (6):
  dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2H support
  clk: renesas: r9a09g057: Add clock and reset entries for RTC
  rtc: renesas-rtca3: Add support for multiple reset lines
  arm64: dts: renesas: r9a09g057: Add RTC node
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable RTC
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Add NMI pushbutton
    support

 .../bindings/rtc/renesas,rz-rtca3.yaml        | 46 +++++++++++++++++--
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 15 ++++++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 17 +++++++
 drivers/clk/renesas/r9a09g057-cpg.c           |  4 ++
 drivers/rtc/rtc-renesas-rtca3.c               | 18 +++-----
 5 files changed, 84 insertions(+), 16 deletions(-)

-- 
2.51.0


