Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0710AC6FA85
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:44:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.4674.1662111876828858051
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:44:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="131460937"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Sep 2022 18:44:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9B124400A11F;
	Fri,  2 Sep 2022 18:44:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/25] arm64: dts: renesas: r9a07g043: Add I2C2
 node and fillup the I2C{0,1,3} stub nodes
Date: Fri,  2 Sep 2022 10:44:07 +0100
Message-Id: <20220902094427.116227-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:44:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9431

commit bc9e1dbb175706242a7160675b4f52d0380ae4ea upstream.

Add I2C2 node and fillup the I2C{0,1,3} stub nodes in RZ/G2UL
(R9A07G043) SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220425170530.200921-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 73 +++++++++++++++++++++-
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index c8aadbe55278..2025224d71ab 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -220,22 +220,89 @@ canfd: can@10050000 {
 		i2c0: i2c@10058000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			compatible = "renesas,riic-r9a07g043", "renesas,riic-rz";
 			reg = <0 0x10058000 0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 348 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 349 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A07G043_I2C0_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A07G043_I2C0_MRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		i2c1: i2c@10058400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			compatible = "renesas,riic-r9a07g043", "renesas,riic-rz";
 			reg = <0 0x10058400 0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 356 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 357 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A07G043_I2C1_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A07G043_I2C1_MRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@10058800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,riic-r9a07g043", "renesas,riic-rz";
+			reg = <0 0x10058800 0 0x400>;
+			interrupts = <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A07G043_I2C2_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A07G043_I2C2_MRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		i2c3: i2c@10058c00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			compatible = "renesas,riic-r9a07g043", "renesas,riic-rz";
 			reg = <0 0x10058c00 0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 372 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 373 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A07G043_I2C3_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A07G043_I2C3_MRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		adc: adc@10059000 {
-- 
2.25.1


