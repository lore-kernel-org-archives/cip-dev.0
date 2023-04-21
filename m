Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DACFC77B78
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6183.1682061521328276104
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156787049"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:40 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D56A641AA65A;
	Fri, 21 Apr 2023 16:18:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 27/33] arm64: dts: renesas: r9a09g011: Add ethernet nodes
Date: Fri, 21 Apr 2023 08:17:23 +0100
Message-Id: <20230421071729.130347-28-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11300

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 4872ca1f92b0545cd0898cf43fe0576fc7c7a1c7 upstream.

Add Ethernet nodes to SoC dtsi.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220517081645.3764-2-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index 27810f4ad4cb..d4cc5459fbb7 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -62,6 +62,57 @@ gic: interrupt-controller@82000000 {
 			clock-names = "clk";
 		};
 
+		avb: ethernet@a3300000 {
+			compatible = "renesas,etheravb-r9a09g011","renesas,etheravb-rzv2m";
+			reg = <0 0xa3300000 0 0x800>;
+			interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>, /* ch0: Rx0 BE */
+				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>, /* ch1: Rx1 NC */
+				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>, /* ch18: Tx0 BE */
+				     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>, /* ch19: Tx1 NC */
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>, /* DiA */
+				     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>, /* DiB */
+				     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>, /* Line1_A */
+				     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>, /* Line1_B */
+				     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>, /* Line2_A */
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>, /* Line2_B */
+				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>; /* Line3 MAC */
+			interrupt-names = "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15",
+					  "ch16", "ch17", "ch18", "ch19",
+					  "ch20", "ch21", "dia", "dib",
+					  "err_a", "err_b", "mgmt_a", "mgmt_b",
+					  "line3";
+			clocks = <&cpg CPG_MOD R9A09G011_ETH0_CLK_AXI>,
+				 <&cpg CPG_MOD R9A09G011_ETH0_CLK_CHI>,
+				 <&cpg CPG_MOD R9A09G011_ETH0_GPTP_EXT>;
+			clock-names = "axi", "chi", "gptp";
+			resets = <&cpg R9A09G011_ETH0_RST_HW_N>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disable";
+		};
+
 		cpg: clock-controller@a3500000 {
 			compatible = "renesas,r9a09g011-cpg";
 			reg = <0 0xa3500000 0 0x1000>;
-- 
2.25.1


