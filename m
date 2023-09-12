Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94137EE3F25
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 19:59:55 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.462.1694548793599716351
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 12:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,141,1688396400"; 
   d="scan'208";a="175845721"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Sep 2023 04:59:53 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E245A40A4BEC;
	Wed, 13 Sep 2023 04:59:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 15/15] arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3
Date: Tue, 12 Sep 2023 20:59:15 +0100
Message-Id: <20230912195915.607664-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
References: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 19:59:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13089

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
index 01483b4302c2..8e0107df2d46 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -17,6 +17,17 @@
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
index 63f0d6774ddf..2b2e73bf6c24 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -32,6 +32,19 @@ wm8978: codec@1a {
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


