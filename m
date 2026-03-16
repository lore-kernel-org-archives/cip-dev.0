Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40091F506DC
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:34:24 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51757.1773671662049070421
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:34:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: W5HEyqvhS4GtqnpLss5jyQ==
X-CSE-MsgGUID: qR9vnedaR32/aa8pAWjrQw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Mar 2026 23:34:20 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4EAAA4005E1A;
	Mon, 16 Mar 2026 23:34:19 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 0/3] Add RZ/V2N DMAC support
Date: Mon, 16 Mar 2026 14:34:14 +0000
Message-ID: <20260316143417.76612-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:34:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22384

Hi,

This series adds DMAC support for the Renesas RZ/V2N SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (3):
  dt-bindings: dma: rz-dmac: Document RZ/V2N SoC support
  clk: renesas: r9a09g056: Add entries for the DMACs
  arm64: dts: renesas: r9a09g056: Add DMAC nodes

 .../bindings/dma/renesas,rz-dmac.yaml         |   1 +
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 165 ++++++++++++++++++
 drivers/clk/renesas/r9a09g056-cpg.c           |  19 ++
 3 files changed, 185 insertions(+)

-- 
2.34.1


