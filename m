Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829B4C3DA6B
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:48:07 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.1247.1661964477615523173
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:47:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="131240536"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 01:47:57 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8F51440457D2;
	Thu,  1 Sep 2022 01:47:54 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 21/26] arm64: dts: renesas: r9a07g043: Add SDHI
 nodes
Date: Wed, 31 Aug 2022 17:46:40 +0100
Message-Id: <20220831164645.2134258-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9381

commit 20e63d3948985672b9e8efa98ff3643d91378e84 upstream.

Add SDHI{0, 1} nodes to RZ/G2UL SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220402081328.26292-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 26 ++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index f24756d89bc2..c013d4fbe9f7 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -334,13 +334,35 @@ gic: interrupt-controller@11900000 {
 		};
 
 		sdhi0: mmc@11c00000  {
+			compatible = "renesas,sdhi-r9a07g043",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
-			/* place holder */
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G043_SDHI0_IMCLK>,
+				 <&cpg CPG_MOD R9A07G043_SDHI0_CLK_HS>,
+				 <&cpg CPG_MOD R9A07G043_SDHI0_IMCLK2>,
+				 <&cpg CPG_MOD R9A07G043_SDHI0_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A07G043_SDHI0_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		sdhi1: mmc@11c10000 {
+			compatible = "renesas,sdhi-r9a07g043",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0x0 0x11c10000 0 0x10000>;
-			/* place holder */
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G043_SDHI1_IMCLK>,
+				 <&cpg CPG_MOD R9A07G043_SDHI1_CLK_HS>,
+				 <&cpg CPG_MOD R9A07G043_SDHI1_IMCLK2>,
+				 <&cpg CPG_MOD R9A07G043_SDHI1_ACLK>;
+			clock-names = "core", "clkh", "cd", "aclk";
+			resets = <&cpg R9A07G043_SDHI1_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		phyrst: usbphy-ctrl@11c40000 {
-- 
2.25.1


