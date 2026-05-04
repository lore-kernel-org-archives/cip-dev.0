Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B1CD3423
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:48:23 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9356.1777877297486053007
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 May 2026 23:48:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: kzUsVx1hQsayAwNQrSaDFQ==
X-CSE-MsgGUID: t9Z+1cv1SrGHg6dNJ2FYxg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 May 2026 15:48:21 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BB048412451D;
	Mon,  4 May 2026 15:48:20 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 9/9] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable USB3.0 PHY and xHCI controller
Date: Mon,  4 May 2026 06:48:03 +0000
Message-ID: <20260504064804.7021-10-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504064804.7021-1-ovidiu.panait.rb@renesas.com>
References: <20260504064804.7021-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 06:48:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22846

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f221ce9f7c13ce2c1c9e4fd79743d18fb098f19a upstream.

Enable the USB3.0 (CH0) host controllers on the RZ/V2N Evaluation Kit.
The CN4 connector on the EVK provides access to the USB3.0 channel.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251119110505.100253-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index e7bb4334ca47..6ed74e091d4b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -409,6 +409,11 @@ vbus {
 		};
 	};
 
+	usb3_pins: usb3 {
+		pinmux = <RZV2N_PORT_PINMUX(B, 0, 14)>, /* USB30_VBUSEN */
+			 <RZV2N_PORT_PINMUX(B, 1, 14)>; /* USB30_OVRCURN */
+	};
+
 	xspi_pins: xspi0 {
 		ctrl {
 			pins = "XSPI0_RESET0N", "XSPI0_CS0N", "XSPI0_CKP";
@@ -459,10 +464,20 @@ &usb2_phy0 {
 	status = "okay";
 };
 
+&usb3_phy {
+	status = "okay";
+};
+
 &wdt1 {
 	status = "okay";
 };
 
+&xhci {
+	pinctrl-0 = <&usb3_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &xspi {
 	pinctrl-0 = <&xspi_pins>;
 	pinctrl-names = "default";
-- 
2.34.1


