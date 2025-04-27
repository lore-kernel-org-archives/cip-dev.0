Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE0C369D1
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 19:17:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.32068.1745781355894878289
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 12:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: mfpC8r3kQAackmgjQ206EA==
X-CSE-MsgGUID: 1xHESXrUSKChoPmX1fnRUA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Apr 2025 04:16:01 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DF7464075A56;
	Mon, 28 Apr 2025 04:15:59 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 05/16] arm64: dts: renesas: r9a08g045: Update fallback string for SDHI nodes
Date: Sun, 27 Apr 2025 20:15:37 +0100
Message-ID: <20250427191548.130118-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 19:17:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18656

commit f6e32aa9693e7f0748087e49484d97808f1bbc98 upstream.

Use 'renesas,rzg2l-sdhi' as a fallback string for SDHI nodes, where
hs400_disabled and fixed_addr_mode quirks are applied.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240422213006.505576-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 3401c1200a1c4..2511f291cdeb5 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -209,7 +209,7 @@ irqc: interrupt-controller@11050000 {
 		};
 
 		sdhi0: mmc@11c00000  {
-			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
+			compatible = "renesas,sdhi-r9a08g045", "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
@@ -224,7 +224,7 @@ sdhi0: mmc@11c00000  {
 		};
 
 		sdhi1: mmc@11c10000 {
-			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
+			compatible = "renesas,sdhi-r9a08g045", "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c10000 0 0x10000>;
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
@@ -239,7 +239,7 @@ sdhi1: mmc@11c10000 {
 		};
 
 		sdhi2: mmc@11c20000 {
-			compatible = "renesas,sdhi-r9a08g045", "renesas,rcar-gen3-sdhi";
+			compatible = "renesas,sdhi-r9a08g045", "renesas,rzg2l-sdhi";
 			reg = <0x0 0x11c20000 0 0x10000>;
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0


