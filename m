Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444C0D44158
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 09:20:13 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9107.1765531208351010290
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 01:20:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: Yb3e2QQRRxmlG9IQf+ZiRA==
X-CSE-MsgGUID: DbK5r2PWSdaqfNoz5xMZrA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 12 Dec 2025 18:20:07 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.53])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9B19E401C23D;
	Fri, 12 Dec 2025 18:20:06 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/5] Add RZ/V2N General Timer (GTM) support
Date: Fri, 12 Dec 2025 09:19:54 +0000
Message-ID: <20251212091959.22073-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 09:20:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20975

Hi,

This series adds General Timer (GTM) support for the Renesas RZ/V2N SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (5):
  clk: renesas: r9a09g056-cpg: Add clock and reset entries for OSTM
    instances
  dt-bindings: timer: renesas,ostm: Document RZ/V2N (R9A09G056) support
  clocksource/drivers/renesas-ostm: Unconditionally enable reprobe
    support
  arm64: dts: renesas: r9a09g056: Add OSTM0-OSTM7 nodes
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable OSTM timers on
    RZ/V2N EVK

 .../bindings/timer/renesas,ostm.yaml          | 12 +--
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 80 +++++++++++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 32 ++++++++
 drivers/clk/renesas/r9a09g056-cpg.c           | 26 ++++++
 drivers/clocksource/renesas-ostm.c            |  4 +-
 5 files changed, 145 insertions(+), 9 deletions(-)

-- 
2.51.0


