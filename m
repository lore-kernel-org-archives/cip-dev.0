Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B556EFA3741
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 14:41:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.7910.1666708896535930741
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 07:41:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.95,212,1661785200"; 
   d="scan'208";a="137874120"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Oct 2022 23:41:54 +0900
Received: from localhost.localdomain (unknown [10.226.92.152])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2D897436AEE2;
	Tue, 25 Oct 2022 23:41:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 08/12] arm64: dts: renesas: r9a07g044: Fix SCI{Rx,Tx} interrupt types
Date: Tue, 25 Oct 2022 15:41:27 +0100
Message-Id: <20221025144131.1309463-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 14:41:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9829

commit f3b7bc89c97b98aa6f157d5f296695af8940a5ac upstream.

As per the latest RZ/G2L Hardware User's Manual (Rev.1.10 Apr, 2022),
the interrupt type of SCI{Rx,Tx} is edge triggered.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Fixes: f9a2adcc9e908907 ("arm64: dts: renesas: r9a07g044: Add SCI[0-1] nodes")
Link: https://lore.kernel.org/r/20220802101534.1401342-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 6b13d3b8e209..e8ad84c55fca 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -356,8 +356,8 @@ sci0: serial@1004d000 {
 			compatible = "renesas,r9a07g044-sci", "renesas,sci";
 			reg = <0 0x1004d000 0 0x400>;
 			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 407 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "eri", "rxi", "txi", "tei";
 			clocks = <&cpg CPG_MOD R9A07G044_SCI0_CLKP>;
@@ -371,8 +371,8 @@ sci1: serial@1004d400 {
 			compatible = "renesas,r9a07g044-sci", "renesas,sci";
 			reg = <0 0x1004d400 0 0x400>;
 			interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 410 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 411 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "eri", "rxi", "txi", "tei";
 			clocks = <&cpg CPG_MOD R9A07G044_SCI1_CLKP>;
-- 
2.25.1


