Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A42C25B0E
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:34:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.15100.1660653294204212629
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:34:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,241,1654527600";
   d="scan'208";a="131578415"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2022 21:34:55 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id ED66E402D0A9;
	Tue, 16 Aug 2022 21:34:53 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 24/31] arm64: dts: renesas: r9a07g054: Fillup the
 OSTM{0,1,2} stub nodes
Date: Tue, 16 Aug 2022 13:33:59 +0100
Message-Id: <20220816123406.27553-25-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:34:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9243

commit f458b7707c9c4acabb7cdf6c0fcfde1a506b360f upstream.

Fillup the OSTM{0,1,2} stub nodes in RZ/V2L (R9A07G054) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220227203744.18355-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 24 +++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 1207a99bf3fe..50cb2f0e6e73 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -629,18 +629,36 @@
 		};
 
 		ostm0: timer@12801000 {
+			compatible = "renesas,r9a07g054-ostm",
+				     "renesas,ostm";
 			reg = <0x0 0x12801000 0x0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G054_OSTM0_PCLK>;
+			resets = <&cpg R9A07G054_OSTM0_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ostm1: timer@12801400 {
+			compatible = "renesas,r9a07g054-ostm",
+				     "renesas,ostm";
 			reg = <0x0 0x12801400 0x0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G054_OSTM1_PCLK>;
+			resets = <&cpg R9A07G054_OSTM1_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ostm2: timer@12801800 {
+			compatible = "renesas,r9a07g054-ostm",
+				     "renesas,ostm";
 			reg = <0x0 0x12801800 0x0 0x400>;
-			/* place holder */
+			interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G054_OSTM2_PCLK>;
+			resets = <&cpg R9A07G054_OSTM2_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 	};
 
-- 
2.17.1


