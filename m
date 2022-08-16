Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7DAC48BEA
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:35:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.14837.1660653273153913362
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:35:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600";
   d="scan'208";a="129665765"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 21:35:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 75DA4402D0BD;
	Tue, 16 Aug 2022 21:35:03 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 29/31] arm64: dts: renesas: r9a07g054: Add SPI{0,2}
 nodes and fillup SPI1 stub node
Date: Tue, 16 Aug 2022 13:34:04 +0100
Message-Id: <20220816123406.27553-30-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:35:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9248

commit 3f3c46d4e2cb38bfa7d1f24c2099a20229867d9d upstream.

Add SPI{0,2} nodes and fillup SPI1 stub node in RZ/V2L (R9A07G054)
SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220227203744.18355-13-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 43 +++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 8bbdcf48bb61..9e730171efa8 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -179,11 +179,52 @@
 			status = "disabled";
 		};
 
+		spi0: spi@1004ac00 {
+			compatible = "renesas,r9a07g054-rspi", "renesas,rspi-rz";
+			reg = <0 0x1004ac00 0 0x400>;
+			interrupts = <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&cpg CPG_MOD R9A07G054_RSPI0_CLKB>;
+			resets = <&cpg R9A07G054_RSPI0_RST>;
+			power-domains = <&cpg>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		spi1: spi@1004b000 {
+			compatible = "renesas,r9a07g054-rspi", "renesas,rspi-rz";
 			reg = <0 0x1004b000 0 0x400>;
+			interrupts = <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&cpg CPG_MOD R9A07G054_RSPI1_CLKB>;
+			resets = <&cpg R9A07G054_RSPI1_RST>;
+			power-domains = <&cpg>;
+			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* place holder */
+			status = "disabled";
+		};
+
+		spi2: spi@1004b400 {
+			compatible = "renesas,r9a07g054-rspi", "renesas,rspi-rz";
+			reg = <0 0x1004b400 0 0x400>;
+			interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&cpg CPG_MOD R9A07G054_RSPI2_CLKB>;
+			resets = <&cpg R9A07G054_RSPI2_RST>;
+			power-domains = <&cpg>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		scif0: serial@1004b800 {
-- 
2.17.1


