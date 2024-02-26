Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E5EC48BF6
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 10:40:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.17711.1708943998572307424
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Feb 2024 02:40:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.06,185,1705330800"; 
   d="scan'208";a="199275411"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Feb 2024 19:40:04 +0900
Received: from localhost.localdomain (unknown [10.226.93.86])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1A961400C73F;
	Mon, 26 Feb 2024 19:40:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 5/5] arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3
Date: Mon, 26 Feb 2024 10:39:49 +0000
Message-Id: <20240226103949.138960-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240226103949.138960-1-biju.das.jz@bp.renesas.com>
References: <20240226103949.138960-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Feb 2024 10:40:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15093

commit e578a36320f92e88a46d6cd66458895d2d45d965 upstream.

Add support for PMOD_MTU3 macro to enable MTU3 node on RZ/G2UL SMARC
EVK.

The MTU3a PWM pins on PMOD0 are muxed with SPI1. Disable SPI1, when
PMOD_MTU3 macro is enabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230727081848.100834-6-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts  | 11 +++++++++++
 .../boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi  |  6 ++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi       | 13 +++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index bfe0e9f128a3..2c69128a9ae3 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -20,6 +20,17 @@
 #define SW_SW0_DEV_SEL	1
 #define SW_ET0_EN_N	1
 
+/*
+ * To enable MTU3a PWM on PMOD0,
+ *  - Set DIP-Switch SW1-3 to On position.
+ *  - Set PMOD_MTU3 macro to 1.
+ */
+#define PMOD_MTU3	0
+
+#if (PMOD_MTU3 && !SW_ET0_EN_N)
+#error "Cannot set as both PMOD_MTU3 and !SW_ET0_EN_N are mutually exclusive"
+#endif
+
 #include "r9a07g043u.dtsi"
 #include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
index 58923dc83faa..355694fe4af6 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
@@ -50,6 +50,12 @@ i2c1_pins: i2c1 {
 		input-enable;
 	};
 
+	mtu3_pins: mtu3 {
+		mtu2-pwm {
+			pinmux = <RZG2L_PORT_PINMUX(4, 0, 4)>; /* MTIOC2A */
+		};
+	};
+
 	scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(6, 4, 6)>, /* TxD */
 			 <RZG2L_PORT_PINMUX(6, 3, 6)>; /* RxD */
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index 56c0752977d2..727e3268a15b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -52,6 +52,19 @@ wm8978: codec@1a {
 	};
 };
 
+#if PMOD_MTU3
+&mtu3 {
+	pinctrl-0 = <&mtu3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&spi1 {
+	status = "disabled";
+};
+#endif
+
 #if (SW_ET0_EN_N && PMOD_SCI0_EN)
 &pinctrl {
 	can0-stb-hog {
-- 
2.25.1


