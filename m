Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45CDF3D30B
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 15:37:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47100.1772725048718379703
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 07:37:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: bvg+R9ncTo+buh+8GLQDBg==
X-CSE-MsgGUID: 8NLJHYhPTPGq1MKlVS/fkw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Mar 2026 00:37:28 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EC91F400CE81;
	Fri,  6 Mar 2026 00:37:26 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/8] Add RZ/V2N display support
Date: Thu,  5 Mar 2026 15:37:17 +0000
Message-ID: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 15:37:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22089

Hi,

This series adds display support for the Renesas RZ/V2N SoC and EVK
board.

All patches were cherry-picked from mainline kernel.

Note: This series depends on:
https://lore.kernel.org/cip-dev/20260225121232.129678-1-ovidiu.panait.rb@renesas.com/

Best regards,
Ovidiu

Lad Prabhakar (8):
  media: dt-bindings: media: renesas,fcp: Document RZ/V2N SoC
  media: dt-bindings: media: renesas,fcp: Allow three clocks for RZ/V2N
    SoC
  media: dt-bindings: media: renesas,vsp1: Document RZ/V2N SoC
  dt-bindings: display: renesas,rzg2l-du: Add support for RZ/V2N SoC
  clk: renesas: r9a09g056: Add clocks and resets for DSI and LCDC
    modules
  arm64: dts: renesas: r9a09g056: Add FCPV and VSPD nodes
  arm64: dts: renesas: r9a09g056: Add DU and DSI nodes
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable DU and DSI

 .../bindings/display/renesas,rzg2l-du.yaml    |  3 +
 .../bindings/media/renesas,fcp.yaml           |  2 +
 .../bindings/media/renesas,vsp1.yaml          |  1 +
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 89 +++++++++++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 69 ++++++++++++++
 drivers/clk/renesas/r9a09g056-cpg.c           | 64 +++++++++++++
 6 files changed, 228 insertions(+)

-- 
2.34.1


