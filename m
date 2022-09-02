Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECC0ECAAD5
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:44:58 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.4674.1662111876828858051
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:44:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="131460957"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Sep 2022 18:44:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AF154400CF08;
	Fri,  2 Sep 2022 18:44:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/25] arm64: dts: renesas: r9a07g043: Fillup the
 OSTM{0,1,2} stub nodes
Date: Fri,  2 Sep 2022 10:44:11 +0100
Message-Id: <20220902094427.116227-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:44:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9435

commit e42faad1ef822e186c20e60576b198e1ac9866c4 upstream.

Fillup the OSTM{0,1,2} stub nodes in RZ/G2UL (R9A07G043) SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220425170530.200921-6-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 24 +++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 60db9b02e0a7..d161600495aa 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -704,18 +704,36 @@ wdt2: watchdog@12800400 {
 		};
 
 		ostm0: timer@12801000 {
+			compatible = "renesas,r9a07g043-ostm",
+				     "renesas,ostm";
 			reg = <0x0 0x12801000 0x0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G043_OSTM0_PCLK>;
+			resets = <&cpg R9A07G043_OSTM0_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ostm1: timer@12801400 {
+			compatible = "renesas,r9a07g043-ostm",
+				     "renesas,ostm";
 			reg = <0x0 0x12801400 0x0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G043_OSTM1_PCLK>;
+			resets = <&cpg R9A07G043_OSTM1_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ostm2: timer@12801800 {
+			compatible = "renesas,r9a07g043-ostm",
+				     "renesas,ostm";
 			reg = <0x0 0x12801800 0x0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G043_OSTM2_PCLK>;
+			resets = <&cpg R9A07G043_OSTM2_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 	};
 
-- 
2.25.1


