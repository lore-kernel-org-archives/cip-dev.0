Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDB4C43327
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:07 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19091.1782820145636016577
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Xag77bCj;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47488efcf30so1036600f8f.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820144; x=1783424944; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZUyzJJx38cbfoMiVw0uIoPBYHYvBEcpy28F0n8saG8=;
        b=Xag77bCjp39OQo7kWM08a6fxP8EsB8PZSuT+XXGUcSCUNVuS8rWY/26AHnWjfC67mu
         Zb+14t5k0I1jRNzy5RGYtnzHal6ZDcz6QauMrWAOUWytOZkAhjWQWC1FkrNsL3top154
         6R3ttw2yPTwAK7A8HGhfNb8pshu4ulSNaCAPCv9x1Qhi0luuPO78OusXDKfDozjCtV2C
         EhqCJP3buAz4szqjVQH7XhxJPsaHGqnH/R1khb10pChob0PllDMRV8fy8qr6byqYqQlY
         CDjWQnv0foPUj0pq6hCHtebwKvxMFdeLYHsYP0T88+/aKY0Jh8GOeWvb2xyvr5sL4hCv
         prkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820144; x=1783424944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZUyzJJx38cbfoMiVw0uIoPBYHYvBEcpy28F0n8saG8=;
        b=mtlmXUIsqC+NmDLoKWuQTVTv74glR3lK6fuY+Rx3haS66Ho/MPzQNi/G87H6Ym8y1L
         w+YnqKmKivovwnWX0Uv23yBpChc6qr4FToHwHLHsIKqgSuqPjSLtdWMljs2X2GAR2Yut
         /3oFGFYERRzDwP7x3AWRAqFWMcgEoVAYrtExxqjBiSyWT94qveywacuF3YpHJwrRm1Lj
         XT1VC6gkxXv8tA+3M0qbCbKho/Y58g7RIqUAdS4sR5yIXMQwYvva+Acwp7VZS0nT/VQ2
         nd1gjjso9v4t8mjE0DyvHCitUE4j/ganusd9oBkbaAF+a6J9+rh7BoqjGuWlBnXF3F2z
         6jbg==
X-Gm-Message-State: AOJu0Ywe+N0vkHgs+I/DXWyhrmJUrA7yODYJA2E2L0vU+3bUyDuIqmx6
	zbnC1/sHTWmom+DOuCGZq7R3zhKkIKZZwJYPRpUF8leBPLiudGSVJssASu1c2b+W
X-Gm-Gg: AfdE7clTYmUoDPio9tqeZ15wW2B3AisNs/ynZhvfchwoVl3L/ihVTnKHbRgxnEhkNFN
	Xufmv/tqLCkwaM+w+Rlt4FYk8EWiDINpaKk0ClD3KNsMWFPGjSbuRkYVKD+7zVPPZsoFeZaMakL
	GpPOmLzsoc0pJvK/Jt9EjLJnzAlO+7J17ceCqrjaPRmM3eWEtCWfqeSpGaFWAJEeVZxCoH4FJMV
	QfDKdtojDPjUCxYv2qHvdi1Dlr/NaOYGlTzoSeT5qb1F0NL5YwWuSqe+ZWbHIIq9JkfuN2/Ceqx
	a7dWJe1d81T/aSfM1nZ0AYUH6UrE9QtbFiysBbBfMtULYqmBRivJUnYJizAFzS3Nc0nSmS8ym/h
	2uNH4DCyYNDvWH4Vbw20ixBOLuwbW+Drkt2Zj3J/eJFz+jAhyzj9itmECs0OYcastiQtS4wdjnu
	65kw9cGntMlZb/aiICBwIF6BtFnHiAdGgYrQO53Q==
X-Received: by 2002:adf:e195:0:b0:475:f0f0:9ef8 with SMTP id ffacd0b85a97d-475f0f09fe9mr2252779f8f.61.1782820143790;
        Tue, 30 Jun 2026 04:49:03 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:49:03 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 37/39] arm64: dts: renesas: r9a08g046: Add GBETH nodes
Date: Tue, 30 Jun 2026 12:47:56 +0100
Message-ID: <20260630114813.92739-38-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23361

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit a357a31c3436ee90a991f1111e7c1ae93ed84f75 ]

Renesas RZ/G3L SoC is equipped with 2x Synopsys DesignWare Ethernet
(10/100/1000 BASE) with TSN, IP block version 5.30. Add GBETH nodes
to R9A08G046 RZ/G3L SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260326111953.31024-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 241 +++++++++++++++++++++
 1 file changed, 241 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index 28b0c7558748..236a675231e5 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -171,6 +171,240 @@ sdhi1: mmc@11c10000 {
 			/* placeholder */
 		};
 
+		eth0: ethernet@11c30000 {
+			compatible = "renesas,r9a08g046-gbeth", "snps,dwmac-5.30a";
+			reg = <0 0x11c30000 0 0x10000>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 86 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 81 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 83 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 91 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 92 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "macirq", "eth_wake_irq", "eth_lpi",
+					  "rx-queue-0", "rx-queue-1", "rx-queue-2",
+					  "rx-queue-3", "tx-queue-0", "tx-queue-1",
+					  "tx-queue-2", "tx-queue-3", "ptp-pps-0",
+					  "ptp-pps-1", "ptp-pps-2", "ptp-pps-3";
+			clocks =  <&cpg CPG_MOD R9A08G046_ETH0_CLK_AXI>,
+				  <&cpg CPG_MOD R9A08G046_ETH0_CLK_CHI>,
+				  <&cpg CPG_MOD R9A08G046_ETH0_CLK_PTP_REF_I>,
+				  <&cpg CPG_MOD R9A08G046_ETH0_CLK_TX_I>,
+				  <&cpg CPG_MOD R9A08G046_ETH0_CLK_RX_I>,
+				  <&cpg CPG_MOD R9A08G046_ETH0_CLK_TX_180_I>,
+				  <&cpg CPG_MOD R9A08G046_ETH0_CLK_RX_180_I>,
+				  <&cpg CPG_MOD R9A08G046_ETH0_CLK_RMII_I>,
+				  <&cpg CPG_MOD R9A08G046_ETH0_CLK_TX_I_RMII>,
+				  <&cpg CPG_MOD R9A08G046_ETH0_CLK_RX_I_RMII>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref",
+				      "tx", "rx", "tx-180", "rx-180",
+				      "rmii", "rmii_tx", "rmii_rx";
+			resets = <&cpg R9A08G046_ETH0_ARESET_N>;
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
+				snps,tx-sched-wrr;
+
+				queue0 {
+					snps,weight = <0x10>;
+					snps,dcb-algorithm;
+					snps,priority = <0x1>;
+				};
+
+				queue1 {
+					snps,weight = <0x12>;
+					snps,dcb-algorithm;
+					snps,priority = <0x2>;
+				};
+
+				queue2 {
+					snps,weight = <0x14>;
+					snps,dcb-algorithm;
+					snps,priority = <0x4>;
+				};
+
+				queue3 {
+					snps,weight = <0x18>;
+					snps,dcb-algorithm;
+					snps,priority = <0x8>;
+				};
+			};
+		};
+
+		eth1: ethernet@11c40000 {
+			compatible = "renesas,r9a08g046-gbeth", "snps,dwmac-5.30a";
+			reg = <0 0x11c40000 0 0x10000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 101 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 103 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 96 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 97 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 98 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 99 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 104 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 105 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 106 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 107 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "macirq", "eth_wake_irq", "eth_lpi",
+					  "rx-queue-0", "rx-queue-1", "rx-queue-2",
+					  "rx-queue-3", "tx-queue-0", "tx-queue-1",
+					  "tx-queue-2", "tx-queue-3", "ptp-pps-0",
+					  "ptp-pps-1", "ptp-pps-2", "ptp-pps-3";
+			clocks = <&cpg CPG_MOD R9A08G046_ETH1_CLK_AXI>,
+				 <&cpg CPG_MOD R9A08G046_ETH1_CLK_CHI>,
+				 <&cpg CPG_MOD R9A08G046_ETH1_CLK_PTP_REF_I>,
+				 <&cpg CPG_MOD R9A08G046_ETH1_CLK_TX_I>,
+				 <&cpg CPG_MOD R9A08G046_ETH1_CLK_RX_I>,
+				 <&cpg CPG_MOD R9A08G046_ETH1_CLK_TX_180_I>,
+				 <&cpg CPG_MOD R9A08G046_ETH1_CLK_RX_180_I>,
+				 <&cpg CPG_MOD R9A08G046_ETH1_CLK_RMII_I>,
+				 <&cpg CPG_MOD R9A08G046_ETH1_CLK_TX_I_RMII>,
+				 <&cpg CPG_MOD R9A08G046_ETH1_CLK_RX_I_RMII>;
+			clock-names = "stmmaceth", "pclk", "ptp_ref",
+				      "tx", "rx", "tx-180", "rx-180",
+				      "rmii", "rmii_tx", "rmii_rx";
+			resets = <&cpg R9A08G046_ETH1_ARESET_N>;
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
+				snps,tx-sched-wrr;
+
+				queue0 {
+					snps,weight = <0x10>;
+					snps,dcb-algorithm;
+					snps,priority = <0x1>;
+				};
+
+				queue1 {
+					snps,weight = <0x12>;
+					snps,dcb-algorithm;
+					snps,priority = <0x2>;
+				};
+
+				queue2 {
+					snps,weight = <0x14>;
+					snps,dcb-algorithm;
+					snps,priority = <0x4>;
+				};
+
+				queue3 {
+					snps,weight = <0x18>;
+					snps,dcb-algorithm;
+					snps,priority = <0x8>;
+				};
+			};
+		};
+
 		pcie: pcie@11e40000 {
 			reg = <0 0x11e40000 0 0x10000>;
 			ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>;
@@ -200,6 +434,13 @@ gic: interrupt-controller@12400000 {
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
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.43.0


