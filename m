Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EFACFA47F
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 08:07:44 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7333.1763712460639498828
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 00:07:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: kTLFrcKeRlGVfDXLkOHp4A==
X-CSE-MsgGUID: d6s8j7jvTP2sqFOtWWX4Sw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Nov 2025 17:07:39 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 91A8341B5577;
	Fri, 21 Nov 2025 17:07:38 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/6] Add RZ/V2H XSPI support
Date: Fri, 21 Nov 2025 08:07:31 +0000
Message-ID: <20251121080737.20611-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 08:07:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20668

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


