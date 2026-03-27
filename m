Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DFF10ED64B
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 09:53:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.68318.1774605212525443362
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Mar 2026 02:53:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: v02l5yYoSIOFv+nNCvPoBA==
X-CSE-MsgGUID: bFPGZzDdRf6vCH/Zt+KUXA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Mar 2026 18:53:31 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.114])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8A40E4007556;
	Fri, 27 Mar 2026 18:53:28 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/5] Add CANFD support to RZ/{V2H,V2N} SoCs
Date: Fri, 27 Mar 2026 09:53:22 +0000
Message-ID: <20260327095327.36412-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Mar 2026 09:53:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22595

Hi All,

This patch series aims to add CANFD support on the Renesas
RZ/V2H and RZ/V2N SoCs. CANFD has been tested with external
CAN PHY transceiver as the EVK isn't fitted with one.

Note,
- All the patches have been cherry-picked from upstream
  kernel.
- Patches apply cleanly on top of commit-id 1ea90e3298a62
  of linux-6.1.y-cip branch

Cheers,
Prabhakar

Lad Prabhakar (5):
  clk: renesas: r9a09g057: Add entries for CANFD
  clk: renesas: r9a09g056: Add entries for CANFD
  dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N
    SoCs
  arm64: dts: renesas: r9a09g056: Add CANFD node
  arm64: dts: renesas: r9a09g057: Add CANFD node

 .../bindings/net/can/renesas,rcar-canfd.yaml  |  6 ++
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 60 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 60 +++++++++++++++++++
 drivers/clk/renesas/r9a09g056-cpg.c           | 10 ++++
 drivers/clk/renesas/r9a09g057-cpg.c           | 10 ++++
 5 files changed, 146 insertions(+)

-- 
2.43.0


