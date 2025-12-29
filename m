Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D8DE9271B
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:43:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40127.1766997760871127584
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:42:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: hzuRs7nST4Kb5NFrKos9Yw==
X-CSE-MsgGUID: tLPpTY7TRkmeb+4EuCjtlQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Dec 2025 17:42:40 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1DF684005E3A;
	Mon, 29 Dec 2025 17:42:38 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12-y.cip 0/5] Add RZ/V2N GBETH support
Date: Mon, 29 Dec 2025 08:42:32 +0000
Message-ID: <20251229084237.3634-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:43:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21242

Hi,

This patch series adds GBETH support for the Renesas RZ/V2N SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (5):
  clk: renesas: r9a09g056-cpg: Add clock and reset entries for GBETH0/1
  dt-bindings: net: renesas-gbeth: Add support for RZ/V2N (R9A09G056)
    SoC
  arm64: dts: renesas: r9a09g056: Add GBETH nodes
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable GBETH
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Fix pinctrl node name for
    GBETH1

 .../bindings/net/renesas,rzv2h-gbeth.yaml     |   2 +
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 209 ++++++++++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    |  66 ++++++
 drivers/clk/renesas/r9a09g056-cpg.c           |  66 ++++++
 4 files changed, 343 insertions(+)

-- 
2.51.0


