Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D46CC25B0E
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:35:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.15100.1660653294204212629
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:34:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,241,1654527600";
   d="scan'208";a="131578422"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2022 21:34:59 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B89E0402D0AD;
	Tue, 16 Aug 2022 21:34:57 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 26/31] arm64: dts: renesas: r9a07g054: Add
 SSI{1,2,3} nodes and fillup the SSI0 stub node
Date: Tue, 16 Aug 2022 13:34:01 +0100
Message-Id: <20220816123406.27553-27-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:35:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9245

commit cd0339ec25895c0be45656908442bc121bbadacb upstream.

Add SSI{1,2,3} nodes and fillup the SSI0 stub node in RZ/V2L
(R9A07G054) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220227203744.18355-10-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 80 +++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index a3623e70f02c..e3a9f78b7fb8 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -96,9 +96,87 @@
 		ranges;
 
 		ssi0: ssi@10049c00 {
+			compatible = "renesas,r9a07g054-ssi",
+				     "renesas,rz-ssi";
 			reg = <0 0x10049c00 0 0x400>;
+			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			clocks = <&cpg CPG_MOD R9A07G054_SSI0_PCLK2>,
+				 <&cpg CPG_MOD R9A07G054_SSI0_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A07G054_SSI0_RST_M2_REG>;
+			dmas = <&dmac 0x2655>, <&dmac 0x2656>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
 			#sound-dai-cells = <0>;
-			/* place holder */
+			status = "disabled";
+		};
+
+		ssi1: ssi@1004a000 {
+			compatible = "renesas,r9a07g054-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x1004a000 0 0x400>;
+			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			clocks = <&cpg CPG_MOD R9A07G054_SSI1_PCLK2>,
+				 <&cpg CPG_MOD R9A07G054_SSI1_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A07G054_SSI1_RST_M2_REG>;
+			dmas = <&dmac 0x2659>, <&dmac 0x265a>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi2: ssi@1004a400 {
+			compatible = "renesas,r9a07g054-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x1004a400 0 0x400>;
+			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 336 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 337 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			clocks = <&cpg CPG_MOD R9A07G054_SSI2_PCLK2>,
+				 <&cpg CPG_MOD R9A07G054_SSI2_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A07G054_SSI2_RST_M2_REG>;
+			dmas = <&dmac 0x265f>;
+			dma-names = "rt";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi3: ssi@1004a800 {
+			compatible = "renesas,r9a07g054-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x1004a800 0 0x400>;
+			interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 341 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			clocks = <&cpg CPG_MOD R9A07G054_SSI3_PCLK2>,
+				 <&cpg CPG_MOD R9A07G054_SSI3_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A07G054_SSI3_RST_M2_REG>;
+			dmas = <&dmac 0x2661>, <&dmac 0x2662>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
 		};
 
 		spi1: spi@1004b000 {
-- 
2.17.1


