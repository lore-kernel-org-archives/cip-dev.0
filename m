Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D298C001B0
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 17:17:13 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.39279.1688404616547405615
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 10:17:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,178,1684767600"; 
   d="scan'208";a="166630709"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jul 2023 02:17:03 +0900
Received: from dev.ree.adwin.renesas.com (unknown [10.226.38.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 152C5400BBFE;
	Tue,  4 Jul 2023 02:17:00 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 4/5] arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
Date: Mon,  3 Jul 2023 18:16:48 +0100
Message-Id: <20230703171649.15862-5-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
References: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 17:17:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12194

Commit 36aa3eee39b2bce5596d3a1178d3c381c1cf3b57 upstream.

The RZ/V2M comes with 2 SDHI interfaces and 1 eMMC interface.
Add the relevant nodes to the SoC specific device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20221213230129.549968-5-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index d3af097f5fae..46d67b200a66 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -69,6 +69,54 @@ gic: interrupt-controller@82010000 {
 			clock-names = "clk";
 		};
 
+		sdhi0: mmc@85000000 {
+			compatible = "renesas,sdhi-r9a09g011",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x85000000 0 0x2000>;
+			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_SDI0_IMCLK>,
+				 <&cpg CPG_MOD R9A09G011_SDI0_CLK_HS>,
+				 <&cpg CPG_MOD R9A09G011_SDI0_IMCLK2>,
+				 <&cpg CPG_MOD R9A09G011_SDI0_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A09G011_SDI0_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sdhi1: mmc@85010000  {
+			compatible = "renesas,sdhi-r9a09g011",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x85010000 0 0x2000>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_SDI1_IMCLK>,
+				 <&cpg CPG_MOD R9A09G011_SDI1_CLK_HS>,
+				 <&cpg CPG_MOD R9A09G011_SDI1_IMCLK2>,
+				 <&cpg CPG_MOD R9A09G011_SDI1_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A09G011_SDI1_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		emmc: mmc@85020000  {
+			compatible = "renesas,sdhi-r9a09g011",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x85020000 0 0x2000>;
+			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A09G011_EMM_IMCLK>,
+				 <&cpg CPG_MOD R9A09G011_EMM_CLK_HS>,
+				 <&cpg CPG_MOD R9A09G011_EMM_IMCLK2>,
+				 <&cpg CPG_MOD R9A09G011_EMM_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A09G011_EMM_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		usb3drd: usb3drd@85070400 {
 			compatible = "renesas,r9a09g011-usb3drd",
 				     "renesas,rzv2m-usb3drd";
-- 
2.25.1


