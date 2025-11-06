Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D429CCFA18
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 10:40:47 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11740.1762425629102090874
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 02:40:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: bE4S2lL/TaSw5vy55iIxLQ==
X-CSE-MsgGUID: quRx93N3Rx2ChGQTSrrTEg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Nov 2025 19:40:41 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.83])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0E21D400B9FB;
	Thu,  6 Nov 2025 19:40:39 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.12.y-cip 8/9] arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable GBETH
Date: Thu,  6 Nov 2025 10:40:23 +0000
Message-ID: <20251106104024.28947-9-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
References: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 10:40:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20458

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 802292ee27a7bb0b685c00c22cc3ce7ae4ff280e upstream.

Enable the GBETH nodes on the RZ/V2H Evaluation Kit.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250513131412.253091-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index 0b705c987b6c..6ddc1746aa5a 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -16,6 +16,8 @@ / {
 	compatible = "renesas,rzv2h-evk", "renesas,r9a09g057h44", "renesas,r9a09g057";
 
 	aliases {
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
@@ -68,6 +70,22 @@ &audio_extal_clk {
 	clock-frequency = <22579200>;
 };
 
+&eth0 {
+	pinctrl-0 = <&eth0_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&eth1 {
+	pinctrl-0 = <&eth1_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
@@ -124,6 +142,44 @@ &i2c8 {
 	status = "okay";
 };
 
+&mdio0 {
+	phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id0022.1640", "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		rxc-skew-psec = <0>;
+		txc-skew-psec = <0>;
+		rxdv-skew-psec = <0>;
+		txdv-skew-psec = <0>;
+		rxd0-skew-psec = <0>;
+		rxd1-skew-psec = <0>;
+		rxd2-skew-psec = <0>;
+		rxd3-skew-psec = <0>;
+		txd0-skew-psec = <0>;
+		txd1-skew-psec = <0>;
+		txd2-skew-psec = <0>;
+		txd3-skew-psec = <0>;
+	};
+};
+
+&mdio1 {
+	phy1: ethernet-phy@1 {
+		compatible = "ethernet-phy-id0022.1640", "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		rxc-skew-psec = <0>;
+		txc-skew-psec = <0>;
+		rxdv-skew-psec = <0>;
+		txdv-skew-psec = <0>;
+		rxd0-skew-psec = <0>;
+		rxd1-skew-psec = <0>;
+		rxd2-skew-psec = <0>;
+		rxd3-skew-psec = <0>;
+		txd0-skew-psec = <0>;
+		txd1-skew-psec = <0>;
+		txd2-skew-psec = <0>;
+		txd3-skew-psec = <0>;
+	};
+};
+
 &ostm0 {
 	status = "okay";
 };
@@ -157,6 +213,16 @@ &ostm7 {
 };
 
 &pinctrl {
+	eth0_pins: eth0 {
+		pins = "ET0_TXC_TXCLK";
+		output-enable;
+	};
+
+	eth1_pins: eth0 {
+		pins = "ET1_TXC_TXCLK";
+		output-enable;
+	};
+
 	i2c0_pins: i2c0 {
 		pinmux = <RZV2H_PORT_PINMUX(3, 0, 1)>, /* I2C0_SDA */
 			 <RZV2H_PORT_PINMUX(3, 1, 1)>; /* I2C0_SCL */
-- 
2.51.0


