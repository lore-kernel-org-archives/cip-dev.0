Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D89C47DA9
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 16:16:16 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.23.1706631367024829960
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 08:16:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,230,1701097200"; 
   d="scan'208";a="196170644"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 31 Jan 2024 01:16:06 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 112754003EC2;
	Wed, 31 Jan 2024 01:16:04 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 4/9] arm64: dts: renesas: r9a07g044: Update IRQ numbers for SSI channels
Date: Tue, 30 Jan 2024 16:15:50 +0000
Message-Id: <20240130161555.85042-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130161555.85042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240130161555.85042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 16:16:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14505

commit 5da750ddd96454757a3b467e968e3fb70bb12bc8 upstream.

From R01UH0914EJ0120 Rev.1.20 HW manual the interrupt numbers for SSI
channels have been updated,

SPI 329 - SSIF0 is now marked as reserved
SPI 333 - SSIF1 is now marked as reserved
SPI 335 - SSIF2 is now marked as reserved
SPI 336 - SSIF2 is now marked as reserved
SPI 341 - SSIF3 is now marked as reserved

This patch drops the above IRQs from SoC DTSI.

Fixes: 92a341315afc9 ("arm64: dts: renesas: r9a07g044: Add SSI support")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230217185225.43310-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 0495f1168a6c6..f7edace31807e 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -249,9 +249,8 @@ ssi0: ssi@10049c00 {
 			reg = <0 0x10049c00 0 0x400>;
 			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G044_SSI0_PCLK2>,
 				 <&cpg CPG_MOD R9A07G044_SSI0_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -270,9 +269,8 @@ ssi1: ssi@1004a000 {
 			reg = <0 0x1004a000 0 0x400>;
 			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G044_SSI1_PCLK2>,
 				 <&cpg CPG_MOD R9A07G044_SSI1_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -290,10 +288,8 @@ ssi2: ssi@1004a400 {
 				     "renesas,rz-ssi";
 			reg = <0 0x1004a400 0 0x400>;
 			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 335 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 336 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 337 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			interrupt-names = "int_req", "dma_rt";
 			clocks = <&cpg CPG_MOD R9A07G044_SSI2_PCLK2>,
 				 <&cpg CPG_MOD R9A07G044_SSI2_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -312,9 +308,8 @@ ssi3: ssi@1004a800 {
 			reg = <0 0x1004a800 0 0x400>;
 			interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 339 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 341 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G044_SSI3_PCLK2>,
 				 <&cpg CPG_MOD R9A07G044_SSI3_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
-- 
2.34.1


