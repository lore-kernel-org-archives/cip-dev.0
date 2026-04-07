Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EE0EDB7F6
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 10:58:13 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78638.1775559492699210337
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2026 03:58:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: qi+/X941Q9iRU+tSGzulyw==
X-CSE-MsgGUID: ZyDwoJLbQxmSiucmLsAm6g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Apr 2026 19:58:11 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.188])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D379B4007F40;
	Tue,  7 Apr 2026 19:58:09 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/10] Add CANFD support to RZ/T2H and RZ/N2H SoCs
Date: Tue,  7 Apr 2026 11:57:58 +0100
Message-ID: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2026 10:58:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22621

Hi All,

This patch series aims to add CANFD support to the Renesas
RZ/T2H and RZ/N2H SoCs and enable it on the EVKs.

Note,
1] All the patches have been cherry-picked from upstream kernel
2] Patches apply on top of commit-id 7c78ffe0f95bf.

Cheers,
Prabhakar

Lad Prabhakar (10):
  dt-bindings: clock: renesas,r9a09g077/87: Add XSPI0/1 IDs
  dt-bindings: clock: renesas,r9a09g077/87: Add PCLKCAN ID
  clk: renesas: r9a09g077: Propagate rate changes through mux parents
  clk: renesas: r9a09g077: Add CANFD clocks
  dt-bindings: can: renesas,rcar-canfd: Document RZ/T2H and RZ/N2H SoCs
  can: rcar_canfd: Add RZ/T2H support
  arm64: dts: renesas: r9a09g077: Add CANFD node
  arm64: dts: renesas: r9a09g087: Add CANFD node
  arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Enable CANFD
  arm64: dts: renesas: r9a09g087m44-rzn2h-evk: Enable CANFD

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 48 +++++++++++++++++--
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    | 31 ++++++++++++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    | 21 ++++++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    | 31 ++++++++++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 29 +++++++++++
 drivers/clk/renesas/r9a09g077-cpg.c           | 15 +++++-
 drivers/net/can/rcar/rcar_canfd.c             | 18 +++++++
 .../clock/renesas,r9a09g077-cpg-mssr.h        |  3 ++
 .../clock/renesas,r9a09g087-cpg-mssr.h        |  3 ++
 9 files changed, 193 insertions(+), 6 deletions(-)

-- 
2.43.0


