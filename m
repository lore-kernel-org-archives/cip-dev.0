Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4647D489BC
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 12:55:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34560.1768827319468980930
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 04:55:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: +NiZSfcyRFKwvrpEWl7d/Q==
X-CSE-MsgGUID: FRd//6/kQAuov5mSiLJ1RQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jan 2026 21:55:18 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B1DAA412CB9A;
	Mon, 19 Jan 2026 21:55:17 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/5] Add RZ/V2N XSPI support
Date: Mon, 19 Jan 2026 12:55:11 +0000
Message-ID: <20260119125516.32220-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 12:55:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21665

Hi,

This series adds XSPI support for the Renesas RZ/V2N SoC and enables the
MT25QU512ABB8E12 flash device used on the RZ/V2N EVK board.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (5):
  dt-bindings: clock: renesas,r9a09g056/57-cpg: Add XSPI core clock
  clk: renesas: r9a09g056: Add support for xspi mux and divider
  clk: renesas: r9a09g056: Add XSPI clock/reset
  arm64: dts: renesas: r9a09g056: Add XSPI node
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable serial NOR FLASH

 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 21 +++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 55 +++++++++++++++++++
 drivers/clk/renesas/r9a09g056-cpg.c           | 37 ++++++++++++-
 .../dt-bindings/clock/renesas,r9a09g056-cpg.h |  1 +
 4 files changed, 113 insertions(+), 1 deletion(-)

-- 
2.51.0


