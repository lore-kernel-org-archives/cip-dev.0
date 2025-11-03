Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B58CCFA06
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:37:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18464.1762169810637923023
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:36:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: IdkEAsO0Tjy7S2s5B2xnaA==
X-CSE-MsgGUID: fKAADOjTTSCvdSibnTMTYg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Nov 2025 20:36:50 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E8A46400942A;
	Mon,  3 Nov 2025 20:36:48 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.1.y-cip 23/25] arm64: dts: renesas: r9a09g047: Add GBETH nodes
Date: Mon,  3 Nov 2025 12:35:56 +0100
Message-ID: <20251103113608.36240-24-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:37:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20315

[ Upstream commit 41ffbb1c42d30a173cc43e931bbaf7bf29e92d1f ]

Add GBETH nodes to RZ/G3E (R9A09G047) SoC DTSI.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Link: https://lore.kernel.org/20250623080405.355083-3-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 209 +++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index a0d4fab4fe05..e4fac7e0d764 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -691,6 +691,208 @@ sdhi2_vqmmc: vqmmc-regulator {
 			};
 		};
 
+		eth0: ethernet@15c30000 {
+			compatible = "renesas,r9a09g047-gbeth", "renesas,rzv2h-gbeth",
+				     "snps,dwmac-5.20";
+			reg = <0 0x15c30000 0 0x10000>;
+			clocks = <&cpg CPG_MOD 0xbd>, <&cpg CPG_MOD 0xbc>,
+				 <&cpg CPG_CORE R9A09G047_GBETH_0_CLK_PTP_REF_I>,
+				 <&cpg CPG_MOD 0xb8>, <&cpg CPG_MOD 0xb9>,
+				 <&cpg CPG_MOD 0xba>, <&cpg CPG_MOD 0xbb>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref",
+				      "tx", "rx", "tx-180", "rx-180";
+			interrupts = <GIC_SPI 765 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 767 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 766 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 772 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 774 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 775 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 768 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 770 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 771 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq", "eth_lpi",
+					  "rx-queue-0", "rx-queue-1", "rx-queue-2",
+					  "rx-queue-3", "tx-queue-0", "tx-queue-1",
+					  "tx-queue-2", "tx-queue-3";
+			resets = <&cpg 0xb0>;
+			power-domains = <&cpg>;
+			snps,multicast-filter-bins = <256>;
+			snps,perfect-filter-entries = <128>;
+			rx-fifo-depth = <8192>;
+			tx-fifo-depth = <8192>;
+			snps,fixed-burst;
+			snps,no-pbl-x8;
+			snps,force_thresh_dma_mode;
+			snps,axi-config = <&stmmac_axi_setup>;
+			snps,mtl-rx-config = <&mtl_rx_setup0>;
+			snps,mtl-tx-config = <&mtl_tx_setup0>;
+			snps,txpbl = <32>;
+			snps,rxpbl = <32>;
+			status = "disabled";
+
+			mdio0: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			mtl_rx_setup0: rx-queues-config {
+				snps,rx-queues-to-use = <4>;
+				snps,rx-sched-sp;
+
+				queue0 {
+					snps,dcb-algorithm;
+					snps,priority = <0x1>;
+					snps,map-to-dma-channel = <0>;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+					snps,priority = <0x2>;
+					snps,map-to-dma-channel = <1>;
+				};
+
+				queue2 {
+					snps,dcb-algorithm;
+					snps,priority = <0x4>;
+					snps,map-to-dma-channel = <2>;
+				};
+
+				queue3 {
+					snps,dcb-algorithm;
+					snps,priority = <0x8>;
+					snps,map-to-dma-channel = <3>;
+				};
+			};
+
+			mtl_tx_setup0: tx-queues-config {
+				snps,tx-queues-to-use = <4>;
+
+				queue0 {
+					snps,dcb-algorithm;
+					snps,priority = <0x1>;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+					snps,priority = <0x2>;
+				};
+
+				queue2 {
+					snps,dcb-algorithm;
+					snps,priority = <0x4>;
+				};
+
+				queue3 {
+					snps,dcb-algorithm;
+					snps,priority = <0x8>;
+				};
+			};
+		};
+
+		eth1: ethernet@15c40000 {
+			compatible = "renesas,r9a09g047-gbeth", "renesas,rzv2h-gbeth",
+				     "snps,dwmac-5.20";
+			reg = <0 0x15c40000 0 0x10000>;
+			clocks = <&cpg CPG_MOD 0xc3>, <&cpg CPG_MOD 0xc2>,
+				 <&cpg CPG_CORE R9A09G047_GBETH_1_CLK_PTP_REF_I>,
+				 <&cpg CPG_MOD 0xbe>, <&cpg CPG_MOD 0xbf>,
+				 <&cpg CPG_MOD 0xc0>, <&cpg CPG_MOD 0xc1>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref",
+				      "tx", "rx", "tx-180", "rx-180";
+			interrupts = <GIC_SPI 780 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 782 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 781 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 787 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 788 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 789 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 790 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 783 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 784 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 785 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 786 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_wake_irq", "eth_lpi",
+					  "rx-queue-0", "rx-queue-1", "rx-queue-2",
+					  "rx-queue-3", "tx-queue-0", "tx-queue-1",
+					  "tx-queue-2", "tx-queue-3";
+			resets = <&cpg 0xb1>;
+			power-domains = <&cpg>;
+			snps,multicast-filter-bins = <256>;
+			snps,perfect-filter-entries = <128>;
+			rx-fifo-depth = <8192>;
+			tx-fifo-depth = <8192>;
+			snps,fixed-burst;
+			snps,no-pbl-x8;
+			snps,force_thresh_dma_mode;
+			snps,axi-config = <&stmmac_axi_setup>;
+			snps,mtl-rx-config = <&mtl_rx_setup1>;
+			snps,mtl-tx-config = <&mtl_tx_setup1>;
+			snps,txpbl = <32>;
+			snps,rxpbl = <32>;
+			status = "disabled";
+
+			mdio1: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			mtl_rx_setup1: rx-queues-config {
+				snps,rx-queues-to-use = <4>;
+				snps,rx-sched-sp;
+
+				queue0 {
+					snps,dcb-algorithm;
+					snps,priority = <0x1>;
+					snps,map-to-dma-channel = <0>;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+					snps,priority = <0x2>;
+					snps,map-to-dma-channel = <1>;
+				};
+
+				queue2 {
+					snps,dcb-algorithm;
+					snps,priority = <0x4>;
+					snps,map-to-dma-channel = <2>;
+				};
+
+				queue3 {
+					snps,dcb-algorithm;
+					snps,priority = <0x8>;
+					snps,map-to-dma-channel = <3>;
+				};
+			};
+
+			mtl_tx_setup1: tx-queues-config {
+				snps,tx-queues-to-use = <4>;
+
+				queue0 {
+					snps,dcb-algorithm;
+					snps,priority = <0x1>;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+					snps,priority = <0x2>;
+				};
+
+				queue2 {
+					snps,dcb-algorithm;
+					snps,priority = <0x4>;
+				};
+
+				queue3 {
+					snps,dcb-algorithm;
+					snps,priority = <0x8>;
+				};
+			};
+		};
+
 		cru: video@16000000 {
 			compatible = "renesas,r9a09g047-cru";
 			reg = <0 0x16000000 0 0x400>;
@@ -761,6 +963,13 @@ csi2cru: endpoint@0 {
 		};
 	};
 
+	stmmac_axi_setup: stmmac-axi-config {
+		snps,lpi_en;
+		snps,wr_osr_lmt = <0xf>;
+		snps,rd_osr_lmt = <0xf>;
+		snps,blen = <16 8 4 0 0 0 0>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.25.1


