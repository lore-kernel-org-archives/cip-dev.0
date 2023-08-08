Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F06C001B0
	for <webhook@archiver.kernel.org>; Tue,  8 Aug 2023 09:28:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.57495.1691486937870616383
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Aug 2023 02:28:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,263,1684767600"; 
   d="scan'208";a="172311606"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 08 Aug 2023 18:28:55 +0900
Received: from localhost.localdomain (unknown [10.226.93.91])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 63C4B41AC46D;
	Tue,  8 Aug 2023 18:28:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg2l: Update overfow/underflow IRQ names for MTU3 channels
Date: Tue,  8 Aug 2023 10:28:49 +0100
Message-Id: <20230808092849.32139-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Aug 2023 09:28:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12561

commit 4c188fa183ebb45238ef16504c4c7606955cf9d4 upstream.

As per R01UH0914EJ0130 Rev.1.30 HW manual the MTU3 overflow/underflow
interrupt names start with 'tci' instead of 'tgi'.

Replace the below overflow/underflow interrupt names:
 - tgiv0->tciv0
 - tgiv1->tciv1
 - tgiu1->tciu1
 - tgiv2->tciv2
 - tgiu2->tciu2
 - tgiv3->tciv3
 - tgiv4->tciv4
 - tgiv6->tciv6
 - tgiv7->tciv7
 - tgiv8->tciv8
 - tgiu8->tciu8

Fixes: 26336d66d021 ("arm64: dts: renesas: r9a07g044: Add MTU3a node")
Fixes: dd123dd01def ("arm64: dts: renesas: r9a07g054: Add MTU3a node")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230724091927.123847-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index a386d434e53c..12dbe4cf51e7 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -217,20 +217,20 @@ mtu3: timer@10001200 {
 				     <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0",
-					  "tgiv0", "tgie0", "tgif0",
-					  "tgia1", "tgib1", "tgiv1", "tgiu1",
-					  "tgia2", "tgib2", "tgiv2", "tgiu2",
+					  "tciv0", "tgie0", "tgif0",
+					  "tgia1", "tgib1", "tciv1", "tciu1",
+					  "tgia2", "tgib2", "tciv2", "tciu2",
 					  "tgia3", "tgib3", "tgic3", "tgid3",
-					  "tgiv3",
+					  "tciv3",
 					  "tgia4", "tgib4", "tgic4", "tgid4",
-					  "tgiv4",
+					  "tciv4",
 					  "tgiu5", "tgiv5", "tgiw5",
 					  "tgia6", "tgib6", "tgic6", "tgid6",
-					  "tgiv6",
+					  "tciv6",
 					  "tgia7", "tgib7", "tgic7", "tgid7",
-					  "tgiv7",
+					  "tciv7",
 					  "tgia8", "tgib8", "tgic8", "tgid8",
-					  "tgiv8", "tgiu8";
+					  "tciv8", "tciu8";
 			clocks = <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 9c046d4bd11d..7d924c1f61b7 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -217,20 +217,20 @@ mtu3: timer@10001200 {
 				     <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0",
-					  "tgiv0", "tgie0", "tgif0",
-					  "tgia1", "tgib1", "tgiv1", "tgiu1",
-					  "tgia2", "tgib2", "tgiv2", "tgiu2",
+					  "tciv0", "tgie0", "tgif0",
+					  "tgia1", "tgib1", "tciv1", "tciu1",
+					  "tgia2", "tgib2", "tciv2", "tciu2",
 					  "tgia3", "tgib3", "tgic3", "tgid3",
-					  "tgiv3",
+					  "tciv3",
 					  "tgia4", "tgib4", "tgic4", "tgid4",
-					  "tgiv4",
+					  "tciv4",
 					  "tgiu5", "tgiv5", "tgiw5",
 					  "tgia6", "tgib6", "tgic6", "tgid6",
-					  "tgiv6",
+					  "tciv6",
 					  "tgia7", "tgib7", "tgic7", "tgid7",
-					  "tgiv7",
+					  "tciv7",
 					  "tgia8", "tgib8", "tgic8", "tgid8",
-					  "tgiv8", "tgiu8";
+					  "tciv8", "tciu8";
 			clocks = <&cpg CPG_MOD R9A07G054_MTU_X_MCK_MTU3>;
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G054_MTU_X_PRESET_MTU3>;
-- 
2.25.1


