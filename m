Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DD4EE49AE
	for <webhook@archiver.kernel.org>; Mon, 21 Aug 2023 14:38:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1008.1692628695125774967
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 07:38:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,190,1684767600"; 
   d="scan'208";a="173473046"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2023 23:38:25 +0900
Received: from localhost.localdomain (unknown [10.226.92.38])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1357B400754E;
	Mon, 21 Aug 2023 23:38:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 10/15] arm64: dts: renesas: r9a07g043u: Add IRQC node
Date: Mon, 21 Aug 2023 15:37:54 +0100
Message-Id: <20230821143759.227105-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
References: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Aug 2023 14:38:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12804

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 48ab6eddd8bbcf7e9c8ae27bf42d0b52a777aaba upstream.

Add IRQC node to R9A07G043 (RZ/G2UL) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230102221815.273719-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 68 +++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index b8bf06b51235..a6e777aee02e 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -51,6 +51,74 @@ timer {
 &soc {
 	interrupt-parent = <&gic>;
 
+	irqc: interrupt-controller@110a0000 {
+		compatible = "renesas,r9a07g043u-irqc",
+			     "renesas,rzg2l-irqc";
+		reg = <0 0x110a0000 0 0x10000>;
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		interrupt-controller;
+		interrupts = <SOC_PERIPHERAL_IRQ(0) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(1) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(2) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(3) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(4) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(5) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(6) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(7) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(8) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(444) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(445) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(446) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(447) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(448) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(449) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(450) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(451) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(452) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(453) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(454) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(455) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(456) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(457) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(458) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(459) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(460) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(461) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(462) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(463) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(464) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(465) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(466) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(467) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(468) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(469) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(470) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(471) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(472) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "nmi",
+				  "irq0", "irq1", "irq2", "irq3",
+				  "irq4", "irq5", "irq6", "irq7",
+				  "tint0", "tint1", "tint2", "tint3",
+				  "tint4", "tint5", "tint6", "tint7",
+				  "tint8", "tint9", "tint10", "tint11",
+				  "tint12", "tint13", "tint14", "tint15",
+				  "tint16", "tint17", "tint18", "tint19",
+				  "tint20", "tint21", "tint22", "tint23",
+				  "tint24", "tint25", "tint26", "tint27",
+				  "tint28", "tint29", "tint30", "tint31",
+				  "bus-err";
+		clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
+			<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
+		clock-names = "clk", "pclk";
+		power-domains = <&cpg>;
+		resets = <&cpg R9A07G043_IA55_RESETN>;
+	};
+
 	gic: interrupt-controller@11900000 {
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <3>;
-- 
2.25.1


