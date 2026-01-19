Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E10CCF2FA
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 12:51:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34111.1768827068704176654
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 04:51:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: V5M91VQZSI2maUmOPUYSig==
X-CSE-MsgGUID: 3F6k1CwuTw6gIp691FKrNw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jan 2026 21:51:17 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 486DB413152F;
	Mon, 19 Jan 2026 21:51:16 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 6/6] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable USB2.0 support
Date: Mon, 19 Jan 2026 12:51:04 +0000
Message-ID: <20260119125104.32147-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119125104.32147-1-ovidiu.panait.rb@renesas.com>
References: <20260119125104.32147-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 12:51:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21651

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 4f6780c14fea09bc56c4991d6bf8f2a594bfb51f upstream.

Enable USB2.0 support on the RZ/V2N EVK board, CN2 connector on the EVK
supports host/function operation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250528140453.181851-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index 55a023b70d3b..c3b09050899b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -72,6 +72,11 @@ &audio_extal_clk {
 	clock-frequency = <22579200>;
 };
 
+&ehci0 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
 	pinctrl-names = "default";
@@ -88,6 +93,11 @@ &eth1 {
 	status = "okay";
 };
 
+&hsusb {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
@@ -175,6 +185,11 @@ phy1: ethernet-phy@1 {
 	};
 };
 
+&ohci0 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &ostm0 {
 	status = "okay";
 };
@@ -287,6 +302,16 @@ sd1-dat-cmd {
 			slew-rate = <0>;
 		};
 	};
+
+	usb20_pins: usb20 {
+		ovc {
+			pinmux =  <RZV2N_PORT_PINMUX(9, 6, 14)>; /* OVC */
+		};
+
+		vbus {
+			pinmux = <RZV2N_PORT_PINMUX(9, 5, 14)>; /* VBUS */
+		};
+	};
 };
 
 &qextal_clk {
@@ -315,6 +340,17 @@ &sdhi1 {
 	status = "okay";
 };
 
+&usb20phyrst {
+	status = "okay";
+};
+
+&usb2_phy0 {
+	pinctrl-0 = <&usb20_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &wdt1 {
 	status = "okay";
 };
-- 
2.51.0


