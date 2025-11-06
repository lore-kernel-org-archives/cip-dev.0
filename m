Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6467CCFA1B
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 10:37:56 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11655.1762425463946013726
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 02:37:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: TmjoV4iaTZSWK5k1WTLoVg==
X-CSE-MsgGUID: 28Fibvb0T6+dHm/k9+LuVQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2025 19:37:53 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.83])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C94B44003FD6;
	Thu,  6 Nov 2025 19:37:52 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.1.y-cip 7/9] arm64: dts: renesas: r9a09g057: Add GBETH nodes
Date: Thu,  6 Nov 2025 10:37:36 +0000
Message-ID: <20251106103738.28911-8-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106103738.28911-1-ovidiu.panait.rb@renesas.com>
References: <20251106103738.28911-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 10:37:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20447

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 050ee38d00025771d22348bbf1e9922f8fe8d502 upstream.

Renesas RZ/V2H(P) SoC is equipped with 2x Synopsys DesignWare Ethernet
Quality-of-Service IP block version 5.20. Add GBETH nodes to R9A09G057
RZ/V2H(P) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250513131412.253091-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 209 +++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index bdaab9ae10b8..2e2d8ed42e6d 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -650,6 +650,215 @@ sdhi2_vqmmc: vqmmc-regulator {
 				status = "disabled";
 			};
 		};
+
+		eth0: ethernet@15c30000 {
+			compatible = "renesas,r9a09g057-gbeth", "renesas,rzv2h-gbeth",
+				     "snps,dwmac-5.20";
+			reg = <0 0x15c30000 0 0x10000>;
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
+			clocks =  <&cpg CPG_MOD 0xbd>, <&cpg CPG_MOD 0xbc>,
+				  <&cpg CPG_CORE R9A09G057_GBETH_0_CLK_PTP_REF_I>,
+				  <&cpg CPG_MOD 0xb8>, <&cpg CPG_MOD 0xb9>,
+				  <&cpg CPG_MOD 0xba>, <&cpg CPG_MOD 0xbb>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref",
+				      "tx", "rx", "tx-180", "rx-180";
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
+			compatible = "renesas,r9a09g057-gbeth", "renesas,rzv2h-gbeth",
+				     "snps,dwmac-5.20";
+			reg = <0 0x15c40000 0 0x10000>;
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
+			clocks =  <&cpg CPG_MOD 0xc3>, <&cpg CPG_MOD 0xc2>,
+				  <&cpg CPG_CORE R9A09G057_GBETH_1_CLK_PTP_REF_I>,
+				  <&cpg CPG_MOD 0xbe>, <&cpg CPG_MOD 0xbf>,
+				  <&cpg CPG_MOD 0xc0>, <&cpg CPG_MOD 0xc1>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref",
+				      "tx", "rx", "tx-180", "rx-180";
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
+	};
+
+	stmmac_axi_setup: stmmac-axi-config {
+		snps,lpi_en;
+		snps,wr_osr_lmt = <0xf>;
+		snps,rd_osr_lmt = <0xf>;
+		snps,blen = <16 8 4 0 0 0 0>;
 	};
 
 	timer {
-- 
2.51.0


