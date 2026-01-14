Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691CED2A005
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 12:54:04 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9303.1768395242441736265
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 04:54:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: n6naFQpoQImXjeu1SaGLZA==
X-CSE-MsgGUID: sBSHSaaCSkOHPsOOJ+x1ig==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jan 2026 21:54:01 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AD1DC40103D5;
	Wed, 14 Jan 2026 21:54:00 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/4] Add RZ/V2N I2C support
Date: Wed, 14 Jan 2026 12:53:55 +0000
Message-ID: <20260114125359.8668-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 12:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21552

Hi,

This patch series adds I2C support for the Renesas RZ/V2N SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (4):
  clk: renesas: r9a09g056: Add clock and reset entries for RIIC
    controllers
  dt-bindings: i2c: renesas,riic: Document RZ/V2N (R9A09G056) support
  arm64: dts: renesas: r9a09g056: Add RIIC controllers
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RIIC controllers

 .../devicetree/bindings/i2c/renesas,riic.yaml |   1 +
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 189 ++++++++++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    |  95 +++++++++
 drivers/clk/renesas/r9a09g056-cpg.c           |  27 +++
 4 files changed, 312 insertions(+)

-- 
2.51.0


