Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014B8C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 12:34:05 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.17192.1661171631811752245
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Aug 2022 05:33:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,254,1654527600";
   d="scan'208";a="130189797"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Aug 2022 21:33:50 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F297242296DF;
	Mon, 22 Aug 2022 21:33:48 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip] arm64: dts: renesas: r9a07g054l2-smarc: Correct
 SoC name in comment
Date: Mon, 22 Aug 2022 13:33:46 +0100
Message-Id: <20220822123346.24089-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Aug 2022 12:34:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9295

From: Chris Paterson <chris.paterson2@renesas.com>

commit d1273f541ab409242e08da6bb836bb564021274c upstream.

This dts is for the RZ/V2L SMARC EVK, not RZ/G2L.

Fixes: f91c4c74796a ("arm64: dts: renesas: Add initial device tree for RZ/V2L SMARC EVK")
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Link: https://lore.kernel.org/r/20220623103024.24222-1-chris.paterson2@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
index 4e07e1a0fb66..3d01a4cf0fbe 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /*
- * Device Tree Source for the RZ/G2L SMARC EVK board
+ * Device Tree Source for the RZ/V2L SMARC EVK board
  *
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
-- 
2.17.1


