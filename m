Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F34BF3D317
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 15:37:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47109.1772725063481588333
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 07:37:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: VHhWXs/CSqKACUw8Mk/tUA==
X-CSE-MsgGUID: wTvPGyffT5GMWQdQ1y1Geg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2026 00:37:42 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AC7D2400D12C;
	Fri,  6 Mar 2026 00:37:41 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 8/8] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable DU and DSI
Date: Thu,  5 Mar 2026 15:37:25 +0000
Message-ID: <20260305153725.19821-9-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
References: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 15:37:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22097

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9a5a73dca92aa120ec1ab8b510eb4dbbd653d4e2 upstream.

Enable DU, DSI and adv7535 HDMI encoder on RZ/V2N Evaluation Kit.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251103200349.62087-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index 5f6281a808f9..f81bbd083cdb 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -33,6 +33,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "d";
+
+		port {
+			hdmi_con_out: endpoint {
+				remote-endpoint = <&adv7535_out>;
+			};
+		};
+	};
+
 	memory@48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
@@ -75,12 +86,36 @@ vqmmc_sdhi1: regulator-vqmmc-sdhi1 {
 		gpios-states = <0>;
 		states = <3300000 0>, <1800000 1>;
 	};
+
+	/* 12MHz oscillator for ADV7535 */
+	y1: y1-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
 };
 
 &audio_extal_clk {
 	clock-frequency = <22579200>;
 };
 
+&dsi {
+	status = "okay";
+
+	ports {
+		port@1 {
+			dsi_out: endpoint {
+				data-lanes = <1 2 3 4>;
+				remote-endpoint = <&adv7535_in>;
+			};
+		};
+	};
+};
+
+&du {
+	status = "okay";
+};
+
 &ehci0 {
 	dr_mode = "otg";
 	status = "okay";
@@ -138,6 +173,40 @@ &i2c3 {
 	pinctrl-names = "default";
 	clock-frequency = <400000>;
 	status = "okay";
+
+	adv7535: hdmi@3d {
+		compatible = "adi,adv7535";
+		reg = <0x3d>, <0x3f>, <0x3c>, <0x38>;
+		reg-names = "main", "edid", "cec", "packet";
+		clocks = <&y1>;
+		clock-names = "cec";
+		avdd-supply = <&reg_1p8v>;
+		dvdd-supply = <&reg_1p8v>;
+		pvdd-supply = <&reg_1p8v>;
+		a2vdd-supply = <&reg_1p8v>;
+		v3p3-supply = <&reg_3p3v>;
+		v1p2-supply = <&reg_1p8v>;
+		adi,dsi-lanes = <4>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7535_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				adv7535_out: endpoint {
+					remote-endpoint = <&hdmi_con_out>;
+				};
+			};
+		};
+	};
 };
 
 &i2c6 {
-- 
2.34.1


