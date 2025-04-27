Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A8BC369D9
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 19:17:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.32070.1745781366282420937
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 12:16:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: aOnvAw9RSnaqf9ArgjLiKg==
X-CSE-MsgGUID: ZAnzxQnlQtGf8bMJrqydjA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Apr 2025 04:16:09 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 628DC4075A70;
	Mon, 28 Apr 2025 04:16:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 09/16] arm64: dts: renesas: r9a09g057: Add OSTM0-OSTM7 nodes
Date: Sun, 27 Apr 2025 20:15:41 +0100
Message-ID: <20250427191548.130118-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 19:17:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18660

commit e3dc593ef3a854c8a0817b456269a806a9688277 upstream.

Add OSTM0-OSTM7 nodes to RZ/V2H(P) ("R9A09G057") SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240828124134.188864-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 35b34c40cdc85..335a6dd17fcec 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -121,6 +121,86 @@ sys: system-controller@10430000 {
 			status = "disabled";
 		};
 
+		ostm0: timer@11800000 {
+			compatible = "renesas,r9a09g057-ostm", "renesas,ostm";
+			reg = <0x0 0x11800000 0x0 0x1000>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x43>;
+			resets = <&cpg 0x6d>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm1: timer@11801000 {
+			compatible = "renesas,r9a09g057-ostm", "renesas,ostm";
+			reg = <0x0 0x11801000 0x0 0x1000>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x44>;
+			resets = <&cpg 0x6e>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm2: timer@14000000 {
+			compatible = "renesas,r9a09g057-ostm", "renesas,ostm";
+			reg = <0x0 0x14000000 0x0 0x1000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x45>;
+			resets = <&cpg 0x6f>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm3: timer@14001000 {
+			compatible = "renesas,r9a09g057-ostm", "renesas,ostm";
+			reg = <0x0 0x14001000 0x0 0x1000>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x46>;
+			resets = <&cpg 0x70>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm4: timer@12c00000 {
+			compatible = "renesas,r9a09g057-ostm", "renesas,ostm";
+			reg = <0x0 0x12c00000 0x0 0x1000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x47>;
+			resets = <&cpg 0x71>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm5: timer@12c01000 {
+			compatible = "renesas,r9a09g057-ostm", "renesas,ostm";
+			reg = <0x0 0x12c01000 0x0 0x1000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x48>;
+			resets = <&cpg 0x72>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm6: timer@12c02000 {
+			compatible = "renesas,r9a09g057-ostm", "renesas,ostm";
+			reg = <0x0 0x12c02000 0x0 0x1000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x49>;
+			resets = <&cpg 0x73>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm7: timer@12c03000 {
+			compatible = "renesas,r9a09g057-ostm", "renesas,ostm";
+			reg = <0x0 0x12c03000 0x0 0x1000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD 0x4a>;
+			resets = <&cpg 0x74>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		scif: serial@11c01400 {
 			compatible = "renesas,scif-r9a09g057";
 			reg = <0 0x11c01400 0 0x400>;
-- 
2.43.0


