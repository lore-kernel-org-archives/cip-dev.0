Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB234D489B8
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 12:54:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34158.1768827247991069381
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 04:54:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: nLddf1xoTFmHxvjJ1fKvXQ==
X-CSE-MsgGUID: dDd36iJzTnuVTyKH98ZSLA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jan 2026 21:54:14 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 47ED841319E2;
	Mon, 19 Jan 2026 21:54:13 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 5/5] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable serial NOR FLASH
Date: Mon, 19 Jan 2026 12:54:03 +0000
Message-ID: <20260119125403.32197-6-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119125403.32197-1-ovidiu.panait.rb@renesas.com>
References: <20260119125403.32197-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 12:54:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21664

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 885bf52d044ad24acab2b7f4d9e7a0d233dc8f13 upstream.

Enable MT25QU512ABB8E12 FLASH connected to XSPI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250704140823.163572-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index c3b09050899b..b7abc0fc5701 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -312,6 +312,18 @@ vbus {
 			pinmux = <RZV2N_PORT_PINMUX(9, 5, 14)>; /* VBUS */
 		};
 	};
+
+	xspi_pins: xspi0 {
+		ctrl {
+			pins = "XSPI0_RESET0N", "XSPI0_CS0N", "XSPI0_CKP";
+			output-enable;
+		};
+
+		io {
+			pins = "XSPI0_IO0", "XSPI0_IO1", "XSPI0_IO2", "XSPI0_IO3";
+			renesas,output-impedance = <3>;
+		};
+	};
 };
 
 &qextal_clk {
@@ -354,3 +366,46 @@ &usb2_phy0 {
 &wdt1 {
 	status = "okay";
 };
+
+&xspi {
+	pinctrl-0 = <&xspi_pins>;
+	pinctrl-names = "default";
+	/*
+	 * MT25QU512ABB8E12 flash chip is capable of running at 166MHz
+	 * clock frequency. Set the clock frequency to the maximum 133MHz
+	 * supported by the RZ/V2N SoC.
+	 */
+	assigned-clocks = <&cpg CPG_CORE R9A09G056_SPI_CLK_SPI>;
+	assigned-clock-rates = <133333334>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		vcc-supply = <&reg_1p8v>;
+		m25p,fast-read;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "bl2";
+				reg = <0x00000000 0x00060000>;
+			};
+
+			partition@60000 {
+				label = "fip";
+				reg = <0x00060000 0x1fa0000>;
+			};
+
+			partition@2000000 {
+				label = "user";
+				reg = <0x2000000 0x2000000>;
+			};
+		};
+	};
+};
-- 
2.51.0


