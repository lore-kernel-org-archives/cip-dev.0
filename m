Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ACBF4180B
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 15:07:41 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16933.1773068839276120535
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 08:07:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: tAcOqeEpRRqfmJ4ULNZ9yQ==
X-CSE-MsgGUID: MCdLnj/dQceTg0THQ0I68Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2026 00:07:36 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.213])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 478B140071E2;
	Tue, 10 Mar 2026 00:07:35 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip v3 16/17] arm64: dts: renesas: r9a09g077: Add SPI nodes
Date: Mon,  9 Mar 2026 17:06:18 +0200
Message-ID: <20260309150619.761962-17-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 15:07:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22214

commit fb8f11c7975ad6096437e6a6757c98c9c9475551 upstream.

Add support for the four SPI controllers on the Renesas RZ/T2H Soc.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251119161434.595677-13-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[cosmin.tanislav: resolve merge conflict]
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V3:
 * describe changes made to apply on top of CIP

V2:
 * remove internal Reviewed-by tags

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 342e1470928a..78436a486ffe 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -90,6 +90,78 @@ sci0: serial@80005000 {
 			status = "disabled";
 		};
 
+		rspi0: spi@80007000 {
+			compatible = "renesas,r9a09g077-rspi";
+			reg = <0x0 0x80007000 0x0 0x400>;
+			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 637 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 638 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 634 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 635 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
+				 <&cpg CPG_MOD 104>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rspi1: spi@80007400 {
+			compatible = "renesas,r9a09g077-rspi";
+			reg = <0x0 0x80007400 0x0 0x400>;
+			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 643 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 639 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 640 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
+				 <&cpg CPG_MOD 105>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rspi2: spi@80007800 {
+			compatible = "renesas,r9a09g077-rspi";
+			reg = <0x0 0x80007800 0x0 0x400>;
+			interrupts = <GIC_SPI 646 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 647 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 648 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 644 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 645 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
+				 <&cpg CPG_MOD 106>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rspi3: spi@81007000 {
+			compatible = "renesas,r9a09g077-rspi";
+			reg = <0x0 0x81007000 0x0 0x400>;
+			interrupts = <GIC_SPI 651 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 653 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 649 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 650 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "idle", "error", "end", "rx", "tx";
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
+				 <&cpg CPG_MOD 602>;
+			clock-names = "pclk", "pclkspi";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		wdt0: watchdog@80082000 {
 			compatible = "renesas,r9a09g077-wdt";
 			reg = <0 0x80082000 0 0x400>,
-- 
2.53.0

