Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48917C4725D
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 18:16:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4650.1704737779601560182
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jan 2024 10:16:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,180,1695654000"; 
   d="scan'208";a="189691435"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jan 2024 03:16:58 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.235])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 372374046F50;
	Tue,  9 Jan 2024 03:16:56 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 22/30] riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable ADC/OPP/Thermal Zones/TSU
Date: Mon,  8 Jan 2024 18:16:04 +0000
Message-Id: <20240108181612.5651-23-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 18:16:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14310

commit 42d3345eb3466587798c25a7e5704e15b738263e upstream.

Enable support for below blocks found on RZ/Five SMARC EVK SoC/SoM:
- ADC
- OPP
- Thermal Zones
- TSU

Note, these blocks are enabled in RZ/G2UL SMARC SoM DTSI [0] hence
deleting these disabled nodes from RZ/Five SMARC SoM DTSI enables them
here too as we include [0] in RZ/Five SMARC SoM DTSI.

[0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20221115105135.1180490-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi       |  2 ++
 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 11 -----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index 50134be548f5..6ec1c6f9a403 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -20,6 +20,7 @@ cpus {
 		cpu0: cpu@0 {
 			compatible = "andestech,ax45mp", "riscv";
 			device_type = "cpu";
+			#cooling-cells = <2>;
 			reg = <0x0>;
 			status = "okay";
 			riscv,isa = "rv64imafdc";
@@ -29,6 +30,7 @@ cpu0: cpu@0 {
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <0x40>;
 			clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
+			operating-points-v2 = <&cluster0_opp>;
 
 			cpu0_intc: interrupt-controller {
 				#interrupt-cells = <1>;
diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index 45a182fa3b4b..2b7672bc4b52 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -16,13 +16,6 @@ aliases {
 	chosen {
 		bootargs = "ignore_loglevel";
 	};
-
-	/delete-node/opp-table-0;
-	/delete-node/thermal-zones;
-};
-
-&adc {
-	status = "disabled";
 };
 
 &dmac {
@@ -49,10 +42,6 @@ &sdhi0 {
 	status = "disabled";
 };
 
-&tsu {
-	status = "disabled";
-};
-
 &wdt0 {
 	status = "disabled";
 };
-- 
2.34.1


