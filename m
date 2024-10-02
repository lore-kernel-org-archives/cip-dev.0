Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EF8CF6D50
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:05:02 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1054.1727888691447172225
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:04:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="224579666"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Oct 2024 02:04:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A4AA6402586C;
	Thu,  3 Oct 2024 02:04:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 16/16] arm64: dts: renesas: r9a07g043u11-smarc: Enable DU
Date: Wed,  2 Oct 2024 18:04:09 +0100
Message-ID: <20241002170417.655339-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
References: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:05:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16964

commit cc49fcd0bc2db23489a87f6fa17119a76b70ec6b upstream.

Enable the Display Unit and link with the HDMI add-on board connected
to the parallel connector on the RZ/G2UL SMARC EVK by using a Device
Tree overlay.

DT overlay changes are different compared to mainline. So ported the
changes without using overlay.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240826101648.176647-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Biju: Dropped r9a07g043u11-smarc-du-adv7513.dtso file ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   | 50 ++++++++++++
 .../boot/dts/renesas/rz-smarc-du-adv7513.dtsi | 76 +++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-du-adv7513.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index eab24a811370..73ead513fadc 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -38,6 +38,9 @@
 #define OV5645_PARENT_I2C i2c0
 #include "rz-smarc-cru-csi-ov5645.dtsi"
 
+#define ADV7513_PARENT_I2C i2c1
+#include "rz-smarc-du-adv7513.dtsi"
+
 / {
 	model = "Renesas SMARC EVK based on r9a07g043u11";
 	compatible = "renesas,smarc-evk", "renesas,r9a07g043u11", "renesas,r9a07g043";
@@ -47,3 +50,50 @@ &ov5645 {
 	enable-gpios = <&pinctrl RZG2L_GPIO(4, 4) GPIO_ACTIVE_HIGH>;
 	reset-gpios = <&pinctrl RZG2L_GPIO(0, 1) GPIO_ACTIVE_LOW>;
 };
+
+&pinctrl {
+	du_pins: du {
+		data {
+			pinmux = <RZG2L_PORT_PINMUX(11, 2, 6)>,
+				 <RZG2L_PORT_PINMUX(13, 1, 6)>,
+				 <RZG2L_PORT_PINMUX(13, 0, 6)>,
+				 <RZG2L_PORT_PINMUX(13, 4, 6)>,
+				 <RZG2L_PORT_PINMUX(13, 3, 6)>,
+				 <RZG2L_PORT_PINMUX(12, 1, 6)>,
+				 <RZG2L_PORT_PINMUX(13, 2, 6)>,
+				 <RZG2L_PORT_PINMUX(14, 0, 6)>,
+				 <RZG2L_PORT_PINMUX(14, 2, 6)>,
+				 <RZG2L_PORT_PINMUX(14, 1, 6)>,
+				 <RZG2L_PORT_PINMUX(16, 0, 6)>,
+				 <RZG2L_PORT_PINMUX(15, 0, 6)>,
+				 <RZG2L_PORT_PINMUX(16, 1, 6)>,
+				 <RZG2L_PORT_PINMUX(15, 1, 6)>,
+				 <RZG2L_PORT_PINMUX(15, 3, 6)>,
+				 <RZG2L_PORT_PINMUX(18, 0, 6)>,
+				 <RZG2L_PORT_PINMUX(15, 2, 6)>,
+				 <RZG2L_PORT_PINMUX(17, 0, 6)>,
+				 <RZG2L_PORT_PINMUX(17, 2, 6)>,
+				 <RZG2L_PORT_PINMUX(17, 1, 6)>,
+				 <RZG2L_PORT_PINMUX(18, 1, 6)>,
+				 <RZG2L_PORT_PINMUX(18, 2, 6)>,
+				 <RZG2L_PORT_PINMUX(17, 3, 6)>,
+				 <RZG2L_PORT_PINMUX(18, 3, 6)>;
+			drive-strength = <2>;
+		};
+
+		sync {
+			pinmux = <RZG2L_PORT_PINMUX(11, 0, 6)>, /* HSYNC */
+				 <RZG2L_PORT_PINMUX(12, 0, 6)>; /* VSYNC */
+			drive-strength = <2>;
+		};
+
+		de {
+			pinmux = <RZG2L_PORT_PINMUX(11, 1, 6)>; /* DE */
+			drive-strength = <2>;
+		};
+
+		clk {
+			pinmux = <RZG2L_PORT_PINMUX(11, 3, 6)>; /* CLK */
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-du-adv7513.dtsi b/arch/arm64/boot/dts/renesas/rz-smarc-du-adv7513.dtsi
new file mode 100644
index 000000000000..36707576030d
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rz-smarc-du-adv7513.dtsi
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common Device Tree for the RZ/G2UL SMARC EVK (and alike EVKs) with
+ * ADV7513 transmitter connected to DU enabled.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+&{/} {
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "d";
+
+		port {
+			hdmi_con_out: endpoint {
+				remote-endpoint = <&adv7513_out>;
+			};
+		};
+	};
+};
+
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	ports {
+		port@0 {
+			du_out_rgb: endpoint {
+				remote-endpoint = <&adv7513_in>;
+			};
+		};
+	};
+};
+
+&ADV7513_PARENT_I2C {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	adv7513: adv7513@39 {
+		compatible = "adi,adv7513";
+		reg = <0x39>;
+
+		adi,input-depth = <8>;
+		adi,input-colorspace = "rgb";
+		adi,input-clock = "1x";
+
+		avdd-supply = <&reg_1p8v>;
+		dvdd-supply = <&reg_1p8v>;
+		pvdd-supply = <&reg_1p8v>;
+		dvdd-3v-supply = <&reg_3p3v>;
+		bgvdd-supply = <&reg_1p8v>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				adv7513_in: endpoint {
+					remote-endpoint = <&du_out_rgb>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				adv7513_out: endpoint {
+					remote-endpoint = <&hdmi_con_out>;
+				};
+			};
+		};
+	};
+};
-- 
2.43.0


