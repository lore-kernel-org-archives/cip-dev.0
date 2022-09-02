Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DFBC6FA83
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:45:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4758.1662111901797907608
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:45:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="131461007"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Sep 2022 18:45:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8F68A400CF08;
	Fri,  2 Sep 2022 18:45:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 18/25] arm64: dts: renesas: r9a07g043: Add
 RSPI{0,1,2} nodes
Date: Fri,  2 Sep 2022 10:44:20 +0100
Message-Id: <20220902094427.116227-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9444

commit 22ec868997108e514fe380171c45578da630a0ec upstream.

Add RSPI{0,1,2} nodes to R9A07G043 (RZ/G2UL) SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220501112926.47024-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 43 +++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 15335e9ca06b..82fe61991204 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -158,11 +158,52 @@ ssi3: ssi@1004a800 {
 			status = "disabled";
 		};
 
+		spi0: spi@1004ac00 {
+			compatible = "renesas,r9a07g043-rspi", "renesas,rspi-rz";
+			reg = <0 0x1004ac00 0 0x400>;
+			interrupts = <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&cpg CPG_MOD R9A07G043_RSPI0_CLKB>;
+			resets = <&cpg R9A07G043_RSPI0_RST>;
+			power-domains = <&cpg>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		spi1: spi@1004b000 {
+			compatible = "renesas,r9a07g043-rspi", "renesas,rspi-rz";
 			reg = <0 0x1004b000 0 0x400>;
+			interrupts = <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&cpg CPG_MOD R9A07G043_RSPI1_CLKB>;
+			resets = <&cpg R9A07G043_RSPI1_RST>;
+			power-domains = <&cpg>;
+			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* place holder */
+			status = "disabled";
+		};
+
+		spi2: spi@1004b400 {
+			compatible = "renesas,r9a07g043-rspi", "renesas,rspi-rz";
+			reg = <0 0x1004b400 0 0x400>;
+			interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&cpg CPG_MOD R9A07G043_RSPI2_CLKB>;
+			resets = <&cpg R9A07G043_RSPI2_RST>;
+			power-domains = <&cpg>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		scif0: serial@1004b800 {
-- 
2.25.1


