Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A7BEB1075
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 15:51:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43462.1773157854170485238
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2026 08:50:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: QAziDTGTT2u5DqEk2EZjjw==
X-CSE-MsgGUID: 6Sm9k2ipTz+Omlhz3EPkRA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Mar 2026 00:50:52 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.14])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6647340029C7;
	Wed, 11 Mar 2026 00:50:51 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 0/5] Add RZ/V2N Interrupt Controller Unit (ICU) support
Date: Tue, 10 Mar 2026 15:50:45 +0000
Message-ID: <20260310155050.39087-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Mar 2026 15:51:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22229

Hi,

This series adds Interrupt Controller Unit (ICU) support for the
Renesas RZ/V2N SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (5):
  dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/V2N
    SoC
  clk: renesas: r9a09g056: Add entries for ICU
  irqchip/renesas-rzv2h: Add support for RZ/V2N SoC
  arm64: dts: renesas: r9a09g056: Add ICU node
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add NMI wakeup button
    support

 .../renesas,rzv2h-icu.yaml                    |  1 +
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 92 +++++++++++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 13 +++
 drivers/clk/renesas/r9a09g056-cpg.c           |  3 +
 drivers/irqchip/irq-renesas-rzv2h.c           |  1 +
 5 files changed, 110 insertions(+)

-- 
2.51.0


