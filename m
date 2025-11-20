Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B807CF9C6A
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 17:04:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1523.1763658240642756193
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 09:04:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: CdusPMrXSXGHaHpFJ50MVw==
X-CSE-MsgGUID: oE83mziDThma0FSUF0dfqA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Nov 2025 02:04:17 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 441A140614F0;
	Fri, 21 Nov 2025 02:04:15 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.12.y-cip 10/10] arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable USB2.0 support
Date: Thu, 20 Nov 2025 17:03:57 +0000
Message-ID: <20251120170357.18342-11-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120170357.18342-1-ovidiu.panait.rb@renesas.com>
References: <20251120170357.18342-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 17:04:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20657

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 46d5ca6521dee03cf66b2ed54709112053e94c35 upstream.

Enable USB2.0 support on the RZ/V2H EVK board, CN3 supports
host only operation and CN2 supports host/function operation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250515183104.330964-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Link: https://lore.kernel.org/20250613152216.201957-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index 392fd2a54649..81b9bcbd440b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -79,6 +79,15 @@ &audio_extal_clk {
 	clock-frequency = <22579200>;
 };
 
+&ehci0 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
 	pinctrl-names = "default";
@@ -95,6 +104,11 @@ &eth1 {
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
@@ -189,6 +203,15 @@ phy1: ethernet-phy@1 {
 	};
 };
 
+&ohci0 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
 &ostm0 {
 	status = "okay";
 };
@@ -297,6 +320,26 @@ sd1_cd {
 			pinmux = <RZV2H_PORT_PINMUX(9, 4, 14)>; /* SD1_CD */
 		};
 	};
+
+	usb20_pins: usb20 {
+		ovc {
+			pinmux =  <RZV2H_PORT_PINMUX(9, 6, 14)>; /* OVC */
+		};
+
+		vbus {
+			pinmux = <RZV2H_PORT_PINMUX(9, 5, 14)>; /* VBUS */
+		};
+	};
+
+	usb21_pins: usb21 {
+		ovc {
+			pinmux = <RZV2H_PORT_PINMUX(6, 7, 14)>; /* OVC */
+		};
+
+		vbus {
+			pinmux = <RZV2H_PORT_PINMUX(6, 6, 14)>; /* VBUS */
+		};
+	};
 };
 
 &qextal_clk {
@@ -326,6 +369,28 @@ &sdhi1 {
 	status = "okay";
 };
 
+&usb20phyrst {
+	status = "okay";
+};
+
+&usb21phyrst {
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
+&usb2_phy1 {
+	pinctrl-0 = <&usb21_pins>;
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


