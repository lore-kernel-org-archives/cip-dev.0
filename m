Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D81C369D1
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 19:16:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.32068.1745781355894878289
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 12:15:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: OB633ytlQFmE0pNnSTglYg==
X-CSE-MsgGUID: 7cjF6pFaRQeGNbb5ntOteA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Apr 2025 04:15:59 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C557E4075A42;
	Mon, 28 Apr 2025 04:15:57 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 04/16] arm64: dts: renesas: rzg2l: Update fallback string for SDHI nodes
Date: Sun, 27 Apr 2025 20:15:36 +0100
Message-ID: <20250427191548.130118-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 19:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18655

commit 046084b5e1426efbf08913830bdb101dcbb06be5 upstream.

Use 'renesas,rzg2l-sdhi' as a fallback string for SDHI nodes, where
hs400_disabled and fixed_addr_mode quirks are applied.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240422213006.505576-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 4 ++--
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 4 ++--
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 7b07bcb3be887..593c66b27ad12 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -646,7 +646,7 @@ dmac: dma-controller@11820000 {
 
 		sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g043",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
 			interrupts = <SOC_PERIPHERAL_IRQ(104) IRQ_TYPE_LEVEL_HIGH>,
 				     <SOC_PERIPHERAL_IRQ(105) IRQ_TYPE_LEVEL_HIGH>;
@@ -662,7 +662,7 @@ sdhi0: mmc@11c00000 {
 
 		sdhi1: mmc@11c10000 {
 			compatible = "renesas,sdhi-r9a07g043",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c10000 0 0x10000>;
 			interrupts = <SOC_PERIPHERAL_IRQ(106) IRQ_TYPE_LEVEL_HIGH>,
 				     <SOC_PERIPHERAL_IRQ(107) IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index d5520e09c2a15..3a4a7761792ec 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -1049,7 +1049,7 @@ gic: interrupt-controller@11900000 {
 
 		sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g044",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
 			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
@@ -1065,7 +1065,7 @@ sdhi0: mmc@11c00000 {
 
 		sdhi1: mmc@11c10000 {
 			compatible = "renesas,sdhi-r9a07g044",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c10000 0 0x10000>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index bc8a058a767d8..49c6e7a0bccf9 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1057,7 +1057,7 @@ gic: interrupt-controller@11900000 {
 
 		sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g054",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
 			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
@@ -1073,7 +1073,7 @@ sdhi0: mmc@11c00000 {
 
 		sdhi1: mmc@11c10000 {
 			compatible = "renesas,sdhi-r9a07g054",
-				     "renesas,rcar-gen3-sdhi";
+				     "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c10000 0 0x10000>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0


