Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8498EC4167D
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 12:40:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.689.1702384849048197610
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Dec 2023 04:40:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,270,1695654000"; 
   d="scan'208";a="186194491"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 12 Dec 2023 21:40:47 +0900
Received: from localhost.localdomain (unknown [10.226.93.124])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 18B6F400517D;
	Tue, 12 Dec 2023 21:40:45 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 04/14] arm64: dts: renesas: r9a07g054: Fillup the GPU node
Date: Tue, 12 Dec 2023 12:40:25 +0000
Message-Id: <20231212124035.151367-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
References: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Dec 2023 12:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14047

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 809823b853a2559d04948ea43800408f00c8db23 upstream.

Renesas RZ/V2L SoC has Mali-G31 GPU, this patch fills up the GPU node and
adds opp table to RZ/V2L (R9A07G054) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220308223324.7456-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 62 +++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index c4b6d051692c..d2de7c615aed 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -112,6 +112,50 @@ L3_CA55: cache-controller-0 {
 		};
 	};
 
+	gpu_opp_table: opp-table-1 {
+		compatible = "operating-points-v2";
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <1100000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1100000>;
+		};
+
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <1100000>;
+		};
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1100000>;
+		};
+
+		opp-125000000 {
+			opp-hz = /bits/ 64 <125000000>;
+			opp-microvolt = <1100000>;
+		};
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1100000>;
+		};
+
+		opp-62500000 {
+			opp-hz = /bits/ 64 <62500000>;
+			opp-microvolt = <1100000>;
+		};
+
+		opp-50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+			opp-microvolt = <1100000>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a55-pmu";
 		interrupts-extended = <&gic GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
@@ -782,8 +826,24 @@ dmac: dma-controller@11820000 {
 		};
 
 		gpu: gpu@11840000 {
+			compatible = "renesas,r9a07g054-mali",
+				     "arm,mali-bifrost";
 			reg = <0x0 0x11840000 0x0 0x10000>;
-			/* place holder */
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu", "event";
+			clocks = <&cpg CPG_MOD R9A07G054_GPU_CLK>,
+				 <&cpg CPG_MOD R9A07G054_GPU_AXI_CLK>,
+				 <&cpg CPG_MOD R9A07G054_GPU_ACE_CLK>;
+			clock-names = "gpu", "bus", "bus_ace";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G054_GPU_RESETN>,
+				 <&cpg R9A07G054_GPU_AXI_RESETN>,
+				 <&cpg R9A07G054_GPU_ACE_RESETN>;
+			reset-names = "rst", "axi_rst", "ace_rst";
+			operating-points-v2 = <&gpu_opp_table>;
 		};
 
 		gic: interrupt-controller@11900000 {
-- 
2.25.1


