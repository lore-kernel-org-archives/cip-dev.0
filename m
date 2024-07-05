Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62D5C41513
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 12:52:57 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.16121.1720183966307535087
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 05:52:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,184,1716217200"; 
   d="scan'208";a="214373461"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jul 2024 21:52:47 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.112])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 453B344B8E9A;
	Fri,  5 Jul 2024 21:52:45 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/10] riscv: dts: renesas: r9a07g043f: Add IRQC node to RZ/Five SoC DTSI
Date: Fri,  5 Jul 2024 13:52:27 +0100
Message-Id: <20240705125230.125392-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 12:52:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16402

commit 808852fa3a5e11c8d2bf0aef3695aaf930bd4fa9 upstream.

Add the IRQC node to RZ/Five (R9A07G043F) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240403203503.634465-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 75 +++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index e68a91c9fe775..611f6908aede2 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -50,6 +50,81 @@ &soc {
 	dma-noncoherent;
 	interrupt-parent = <&plic>;
 
+	irqc: interrupt-controller@110a0000 {
+		compatible = "renesas,r9a07g043f-irqc";
+		reg = <0 0x110a0000 0 0x20000>;
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		interrupt-controller;
+		interrupts = <32 IRQ_TYPE_LEVEL_HIGH>,
+			     <33 IRQ_TYPE_LEVEL_HIGH>,
+			     <34 IRQ_TYPE_LEVEL_HIGH>,
+			     <35 IRQ_TYPE_LEVEL_HIGH>,
+			     <36 IRQ_TYPE_LEVEL_HIGH>,
+			     <37 IRQ_TYPE_LEVEL_HIGH>,
+			     <38 IRQ_TYPE_LEVEL_HIGH>,
+			     <39 IRQ_TYPE_LEVEL_HIGH>,
+			     <40 IRQ_TYPE_LEVEL_HIGH>,
+			     <476 IRQ_TYPE_LEVEL_HIGH>,
+			     <477 IRQ_TYPE_LEVEL_HIGH>,
+			     <478 IRQ_TYPE_LEVEL_HIGH>,
+			     <479 IRQ_TYPE_LEVEL_HIGH>,
+			     <480 IRQ_TYPE_LEVEL_HIGH>,
+			     <481 IRQ_TYPE_LEVEL_HIGH>,
+			     <482 IRQ_TYPE_LEVEL_HIGH>,
+			     <483 IRQ_TYPE_LEVEL_HIGH>,
+			     <484 IRQ_TYPE_LEVEL_HIGH>,
+			     <485 IRQ_TYPE_LEVEL_HIGH>,
+			     <486 IRQ_TYPE_LEVEL_HIGH>,
+			     <487 IRQ_TYPE_LEVEL_HIGH>,
+			     <488 IRQ_TYPE_LEVEL_HIGH>,
+			     <489 IRQ_TYPE_LEVEL_HIGH>,
+			     <490 IRQ_TYPE_LEVEL_HIGH>,
+			     <491 IRQ_TYPE_LEVEL_HIGH>,
+			     <492 IRQ_TYPE_LEVEL_HIGH>,
+			     <493 IRQ_TYPE_LEVEL_HIGH>,
+			     <494 IRQ_TYPE_LEVEL_HIGH>,
+			     <495 IRQ_TYPE_LEVEL_HIGH>,
+			     <496 IRQ_TYPE_LEVEL_HIGH>,
+			     <497 IRQ_TYPE_LEVEL_HIGH>,
+			     <498 IRQ_TYPE_LEVEL_HIGH>,
+			     <499 IRQ_TYPE_LEVEL_HIGH>,
+			     <500 IRQ_TYPE_LEVEL_HIGH>,
+			     <501 IRQ_TYPE_LEVEL_HIGH>,
+			     <502 IRQ_TYPE_LEVEL_HIGH>,
+			     <503 IRQ_TYPE_LEVEL_HIGH>,
+			     <504 IRQ_TYPE_LEVEL_HIGH>,
+			     <505 IRQ_TYPE_LEVEL_HIGH>,
+			     <506 IRQ_TYPE_LEVEL_HIGH>,
+			     <507 IRQ_TYPE_LEVEL_HIGH>,
+			     <57 IRQ_TYPE_LEVEL_HIGH>,
+			     <66 IRQ_TYPE_EDGE_RISING>,
+			     <67 IRQ_TYPE_EDGE_RISING>,
+			     <68 IRQ_TYPE_EDGE_RISING>,
+			     <69 IRQ_TYPE_EDGE_RISING>,
+			     <70 IRQ_TYPE_EDGE_RISING>,
+			     <71 IRQ_TYPE_EDGE_RISING>;
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
+				  "bus-err", "ec7tie1-0", "ec7tie2-0",
+				  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+				  "ec7tiovf-1";
+		clocks = <&cpg CPG_MOD R9A07G043_IAX45_CLK>,
+			 <&cpg CPG_MOD R9A07G043_IAX45_PCLK>;
+		clock-names = "clk", "pclk";
+		power-domains = <&cpg>;
+		resets = <&cpg R9A07G043_IAX45_RESETN>;
+	};
+
 	plic: interrupt-controller@12c00000 {
 		compatible = "renesas,r9a07g043-plic", "andestech,nceplic100";
 		#interrupt-cells = <2>;
-- 
2.34.1


