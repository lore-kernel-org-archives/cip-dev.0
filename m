Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937D5EE3F22
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 19:59:55 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.462.1694548793599716351
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 12:59:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,141,1688396400"; 
   d="scan'208";a="175845718"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Sep 2023 04:59:52 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A575940A489B;
	Wed, 13 Sep 2023 04:59:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 14/15] arm64: dts: renesas: r9a07g043: Add MTU3a node
Date: Tue, 12 Sep 2023 20:59:14 +0100
Message-Id: <20230912195915.607664-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
References: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 19:59:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13088

commit a4c125a8a35113f53f5085b376cb9a9763fb9129 upstream.

Add MTU3a node to R9A07G043 (RZ/{G2UL,Five}) SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230727081848.100834-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 27c35a657b15..8721f4c9fa0f 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -74,6 +74,76 @@ soc: soc {
 		#size-cells = <2>;
 		ranges;
 
+		mtu3: timer@10001200 {
+			compatible = "renesas,r9a07g043-mtu3",
+				     "renesas,rz-mtu3";
+			reg = <0 0x10001200 0 0xb00>;
+			interrupts = <SOC_PERIPHERAL_IRQ(170) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(171) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(172) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(173) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(174) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(175) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(176) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(177) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(178) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(179) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(180) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(181) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(182) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(183) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(184) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(185) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(186) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(187) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(188) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(189) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(190) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(191) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(192) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(193) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(194) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(195) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(196) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(197) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(198) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(199) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(200) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(201) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(202) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(203) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(204) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(205) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(206) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(207) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(208) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(209) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(210) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(211) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(212) IRQ_TYPE_EDGE_RISING>,
+				     <SOC_PERIPHERAL_IRQ(213) IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0",
+					  "tciv0", "tgie0", "tgif0",
+					  "tgia1", "tgib1", "tciv1", "tciu1",
+					  "tgia2", "tgib2", "tciv2", "tciu2",
+					  "tgia3", "tgib3", "tgic3", "tgid3",
+					  "tciv3",
+					  "tgia4", "tgib4", "tgic4", "tgid4",
+					  "tciv4",
+					  "tgiu5", "tgiv5", "tgiw5",
+					  "tgia6", "tgib6", "tgic6", "tgid6",
+					  "tciv6",
+					  "tgia7", "tgib7", "tgic7", "tgid7",
+					  "tciv7",
+					  "tgia8", "tgib8", "tgic8", "tgid8",
+					  "tciv8", "tciu8";
+			clocks = <&cpg CPG_MOD R9A07G043_MTU_X_MCK_MTU3>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G043_MTU_X_PRESET_MTU3>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		ssi0: ssi@10049c00 {
 			compatible = "renesas,r9a07g043-ssi",
 				     "renesas,rz-ssi";
-- 
2.25.1


