Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87581CD342F
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:50:04 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9370.1777877388211967274
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 May 2026 23:49:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: kyUo/Y9hSDquon+rWOw6wg==
X-CSE-MsgGUID: XW/ncijIRu+WV8/HlyZLdQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 May 2026 15:49:54 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4A853400B9F7;
	Mon,  4 May 2026 15:49:53 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 5/9] arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable USB3.0 PHYs and xHCI controllers
Date: Mon,  4 May 2026 06:49:39 +0000
Message-ID: <20260504064943.7237-6-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504064943.7237-1-ovidiu.panait.rb@renesas.com>
References: <20260504064943.7237-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 06:50:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22852

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7ef7ba62ec5cd1d32fd282669d0ff947df255408 upstream.

Enable the USB3.0 (CH0) and USB3.1 (CH1) host controllers on the RZ/V2H
Evaluation Kit. The CN4 stacked connector on the EVK provides access to
both channels, with CH0 corresponding to USB3.0 and CH1 to USB3.1.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251119110505.100253-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index a2c8509648b6..5540b97a4a9e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -440,6 +440,16 @@ vbus {
 		};
 	};
 
+	usb30_pins: usb30 {
+		pinmux = <RZV2H_PORT_PINMUX(B, 0, 14)>, /* USB30_VBUSEN */
+			 <RZV2H_PORT_PINMUX(B, 1, 14)>; /* USB30_OVRCURN */
+	};
+
+	usb31_pins: usb31 {
+		pinmux = <RZV2H_PORT_PINMUX(6, 2, 14)>, /* USB31_VBUSEN */
+			 <RZV2H_PORT_PINMUX(6, 3, 14)>; /* USB31_OVRCURN */
+	};
+
 	xspi_pins: xspi0 {
 		ctrl {
 			pins = "XSPI0_RESET0N", "XSPI0_CS0N", "XSPI0_CKP";
@@ -506,10 +516,30 @@ &usb2_phy1 {
 	status = "okay";
 };
 
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
 &wdt1 {
 	status = "okay";
 };
 
+&xhci0 {
+	pinctrl-0 = <&usb30_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&xhci1 {
+	pinctrl-0 = <&usb31_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &xspi {
 	pinctrl-0 = <&xspi_pins>;
 	pinctrl-names = "default";
-- 
2.34.1


