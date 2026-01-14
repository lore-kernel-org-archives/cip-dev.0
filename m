Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED99D2A005
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 12:54:14 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9307.1768395249685970082
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 04:54:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: wMZD2lmxQEifS6rBlM6VgQ==
X-CSE-MsgGUID: 8Ic2dLP+SnyCRIJWemmomg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jan 2026 21:54:08 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B3633401009B;
	Wed, 14 Jan 2026 21:54:07 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 4/4] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RIIC controllers
Date: Wed, 14 Jan 2026 12:53:59 +0000
Message-ID: <20260114125359.8668-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114125359.8668-1-ovidiu.panait.rb@renesas.com>
References: <20260114125359.8668-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 12:54:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21556

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f631c8392c9830f354b8b069f87e5ee19303b5b1 upstream.

Enable the RIIC controllers 0, 1, 2, 3, 6, 7, and 8 which are populated
on the RZ/V2N EVK.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514101528.41663-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index b3e68e1a9f03..55a023b70d3b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -17,6 +17,13 @@ / {
 	aliases {
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
 		mmc1 = &sdhi1;
 		serial0 = &scif;
 	};
@@ -81,6 +88,55 @@ &eth1 {
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c6 {
+	pinctrl-0 = <&i2c6_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c7 {
+	pinctrl-0 = <&i2c7_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c8 {
+	pinctrl-0 = <&i2c8_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
 &mdio0 {
 	phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-id0022.1640", "ethernet-phy-ieee802.3-c22";
@@ -162,6 +218,45 @@ eth1_pins: eth1 {
 		output-enable;
 	};
 
+	i2c0_pins: i2c0 {
+		pinmux = <RZV2N_PORT_PINMUX(3, 0, 1)>, /* I2C0_SDA */
+			 <RZV2N_PORT_PINMUX(3, 1, 1)>; /* I2C0_SCL */
+	};
+
+	i2c1_pins: i2c1 {
+		pinmux = <RZV2N_PORT_PINMUX(3, 2, 1)>, /* I2C1_SDA */
+			 <RZV2N_PORT_PINMUX(3, 3, 1)>; /* I2C1_SCL */
+	};
+
+	i2c2_pins: i2c2 {
+		pinmux = <RZV2N_PORT_PINMUX(2, 0, 4)>, /* I2C2_SDA */
+			 <RZV2N_PORT_PINMUX(2, 1, 4)>; /* I2C2_SCL */
+	};
+
+	i2c3_pins: i2c3 {
+		pinmux = <RZV2N_PORT_PINMUX(3, 6, 1)>, /* I2C3_SDA */
+			 <RZV2N_PORT_PINMUX(3, 7, 1)>; /* I2C3_SCL */
+	};
+
+	i2c6_pins: i2c6 {
+		pinmux = <RZV2N_PORT_PINMUX(4, 4, 1)>, /* I2C6_SDA */
+			 <RZV2N_PORT_PINMUX(4, 5, 1)>; /* I2C6_SCL */
+		/* There are no pull-up resistors on the EVK, so enable the internal pull-up */
+		bias-pull-up;
+	};
+
+	i2c7_pins: i2c7 {
+		pinmux = <RZV2N_PORT_PINMUX(4, 6, 1)>, /* I2C7_SDA */
+			 <RZV2N_PORT_PINMUX(4, 7, 1)>; /* I2C7_SCL */
+		/* There are no pull-up resistors on the EVK, so enable the internal pull-up */
+		bias-pull-up;
+	};
+
+	i2c8_pins: i2c8 {
+		pinmux = <RZV2N_PORT_PINMUX(0, 6, 1)>, /* I2C8_SDA */
+			 <RZV2N_PORT_PINMUX(0, 7, 1)>; /* I2C8_SCL */
+	};
+
 	scif_pins: scif {
 		pins = "SCIF_TXD", "SCIF_RXD";
 		renesas,output-impedance = <1>;
-- 
2.51.0


