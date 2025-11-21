Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB6CFA477
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 08:06:54 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7203.1763712411705775757
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 00:06:52 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 4d7/ADv6TjmBrz5+0+vE7A==
X-CSE-MsgGUID: 2SC0V9hdRJKc4kO8D6o/7A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Nov 2025 17:06:49 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D24B0437D117;
	Fri, 21 Nov 2025 17:06:48 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 0/6] Add RZ/V2H XSPI support
Date: Fri, 21 Nov 2025 08:06:41 +0000
Message-ID: <20251121080647.20592-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 08:06:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20661

Hi,

This series adds XSPI support for the Renesas RZ/V2H SoC and enables the
MT25QU512ABB8E12 flash device used on the RZ/V2H EVK board.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (6):
  dt-bindings: clock: renesas,r9a09g056/57-cpg: Add XSPI core clock
  clk: renesas: r9a09g057: Add support for xspi mux and divider
  clk: renesas: r9a09g057: Add XSPI clock/reset
  dt-bindings: memory: renesas,rzg3e-xspi: Document RZ/V2H(P) and RZ/V2N
    support
  arm64: dts: renesas: r9a09g057: Add XSPI node
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable serial NOR FLASH

 .../renesas,rzg3e-xspi.yaml                   |  9 ++-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 21 +++++++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 55 +++++++++++++++++++
 drivers/clk/renesas/r9a09g057-cpg.c           | 39 +++++++++++--
 drivers/clk/renesas/rzv2h-cpg.h               |  2 +
 .../dt-bindings/clock/renesas,r9a09g057-cpg.h |  1 +
 6 files changed, 122 insertions(+), 5 deletions(-)

-- 
2.51.0


