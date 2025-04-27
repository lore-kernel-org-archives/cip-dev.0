Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F4C369D1
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 19:18:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.32206.1745781381173889399
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 12:16:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: ZlU5hbPKQBSK1NwteQ0UTA==
X-CSE-MsgGUID: 8HbsxMZwRXCERbgexaxDBg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Apr 2025 04:16:22 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 129364075CA8;
	Mon, 28 Apr 2025 04:16:20 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 15/16] arm64: dts: renesas: r9a09g057: Add OPP table
Date: Sun, 27 Apr 2025 20:15:47 +0100
Message-ID: <20250427191548.130118-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 19:18:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18666

commit 9ddc07404cbab0aee36b076b627ad9ecb7bb2290 upstream.

Add OPP table for RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241008164935.335043-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 1ad5a1b6917fe..4bbe75b81f545 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -20,6 +20,39 @@ audio_extal_clk: audio-clk {
 		clock-frequency = <0>;
 	};
 
+	/*
+	 * The default cluster table is based on the assumption that the PLLCA55 clock
+	 * frequency is set to 1.7GHz. The PLLCA55 clock frequency can be set to
+	 * 1.7/1.6/1.5/1.1 GHz based on the BOOTPLLCA_0/1 pins (and additionally can be
+	 * clocked to 1.8GHz as well). The table below should be overridden in the board
+	 * DTS based on the PLLCA55 clock frequency.
+	 */
+	cluster0_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+
+		opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-850000000 {
+			opp-hz = /bits/ 64 <850000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-425000000 {
+			opp-hz = /bits/ 64 <425000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-212500000 {
+			opp-hz = /bits/ 64 <212500000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -30,6 +63,8 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK0>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu@100 {
@@ -38,6 +73,8 @@ cpu1: cpu@100 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK1>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu@200 {
@@ -46,6 +83,8 @@ cpu2: cpu@200 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK2>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu3: cpu@300 {
@@ -54,6 +93,8 @@ cpu3: cpu@300 {
 			device_type = "cpu";
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK3>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		L3_CA55: cache-controller-0 {
-- 
2.43.0


