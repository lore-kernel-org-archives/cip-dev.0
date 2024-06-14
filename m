Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7F7C2BA15
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 10:19:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.8374.1718360341318683626
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 03:19:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="211896736"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jun 2024 19:19:05 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D16F5401C577;
	Fri, 14 Jun 2024 19:19:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 7/8] arm64: dts: renesas: rzg2l-smarc: Enable DU and link with DSI
Date: Fri, 14 Jun 2024 11:18:44 +0100
Message-Id: <20240614101845.40656-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614101845.40656-1-biju.das.jz@bp.renesas.com>
References: <20240614101845.40656-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 10:19:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16255

commit eaa5907bcc7611c7a07e994a69a905deca34a9b6 upstream.

Enable DU and link with DSI on RZ/{G2L,G2LC,V2L} SMARC EVK.

Move DSI port properties from board dtsi to SoC dtsi and then link with DU
and after that enable DU on the board dtsi.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240222132117.137729-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 19 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 19 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 14 ++++----------
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 14 ++++----------
 4 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 6e57bbb25c83..87a07a359c57 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -714,6 +714,22 @@ dsi: dsi@10850000 {
 			reset-names = "rst", "arst", "prst";
 			power-domains = <&cpg>;
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dsi0_in: endpoint {
+						remote-endpoint = <&du_out_dsi>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+			};
 		};
 
 		vspd: vsp@10870000 {
@@ -760,6 +776,9 @@ ports {
 
 				port@0 {
 					reg = <0>;
+					du_out_dsi: endpoint {
+						remote-endpoint = <&dsi0_in>;
+					};
 				};
 
 				port@1 {
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 3ed1b38664ec..8f2430c95f07 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -719,6 +719,22 @@ dsi: dsi@10850000 {
 			reset-names = "rst", "arst", "prst";
 			power-domains = <&cpg>;
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dsi0_in: endpoint {
+						remote-endpoint = <&du_out_dsi>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+			};
 		};
 
 		vspd: vsp@10870000 {
@@ -767,6 +783,9 @@ ports {
 
 				port@0 {
 					reg = <0>;
+					du_out_dsi: endpoint {
+						remote-endpoint = <&dsi0_in>;
+					};
 				};
 
 				port@1 {
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index 37807f1bda4d..887dffe14910 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -40,17 +40,7 @@ &dsi {
 	status = "okay";
 
 	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-			dsi0_in: endpoint {
-			};
-		};
-
 		port@1 {
-			reg = <1>;
 			dsi0_out: endpoint {
 				data-lanes = <1 2 3 4>;
 				remote-endpoint = <&adv7535_in>;
@@ -59,6 +49,10 @@ dsi0_out: endpoint {
 	};
 };
 
+&du {
+	status = "okay";
+};
+
 &i2c1 {
 	adv7535: hdmi@3d {
 		compatible = "adi,adv7535";
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index 859bc8745e66..f21508640b6e 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -56,17 +56,7 @@ &dsi {
 	status = "okay";
 
 	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-			dsi0_in: endpoint {
-			};
-		};
-
 		port@1 {
-			reg = <1>;
 			dsi0_out: endpoint {
 				data-lanes = <1 2 3 4>;
 				remote-endpoint = <&adv7535_in>;
@@ -75,6 +65,10 @@ dsi0_out: endpoint {
 	};
 };
 
+&du {
+	status = "okay";
+};
+
 &i2c1 {
 	adv7535: hdmi@3d {
 		compatible = "adi,adv7535";
-- 
2.25.1


