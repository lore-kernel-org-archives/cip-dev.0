Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E292CEB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 14:11:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.8584.1689689497866713402
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 07:11:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="169768628"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Jul 2023 23:11:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.137])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6B965400F736;
	Tue, 18 Jul 2023 23:11:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 5/6] arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
Date: Tue, 18 Jul 2023 15:11:28 +0100
Message-Id: <20230718141129.119809-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
References: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 14:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12396

commit 742ebf5d715a4d4b9b4800f5b9eb3a2fae9c9282 upstream.

Add support for PMOD_MTU3 macro to enable MTU3 node on RZ/G2LC SMARC
EVK.

The MTU3a PWM pins on PMOD0 are muxed with SPI1. Disable SPI1, when
PMOD_MTU3 macro is enabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230707155849.86649-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts  | 12 ++++++++++++
 .../boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi |  9 +++++++++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi      | 14 +++++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
index f67a6f125d9c..0b90367b6d1e 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
@@ -35,6 +35,18 @@
 /* comment the #define statement to disable SCIF1 (SER0) on PMOD1 (CN7) */
 #define PMOD1_SER0	1
 
+/*
+ * To enable MTU3a PWM on PMOD0,
+ *  - Set DIP-Switch SW1-4 to Off position.
+ *  - Set SW_RSPI_CAN macro to 0.
+ *  - Set PMOD_MTU3 macro to 1.
+ */
+#define PMOD_MTU3	0
+
+#if (PMOD_MTU3 && SW_RSPI_CAN)
+#error "Cannot set as both PMOD_MTU3 and SW_RSPI_CAN are mutually exclusive"
+#endif
+
 #include "r9a07g044c2.dtsi"
 #include "rzg2lc-smarc-som.dtsi"
 #include "rzg2lc-smarc.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
index a78a8def363e..92c64d58349f 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
@@ -50,6 +50,15 @@ i2c2_pins: i2c2 {
 			 <RZG2L_PORT_PINMUX(42, 4, 1)>; /* SCL */
 	};
 
+	mtu3_pins: mtu3 {
+		mtu3-pwm {
+			pinmux = <RZG2L_PORT_PINMUX(44, 0, 4)>, /* MTIOC3A */
+				 <RZG2L_PORT_PINMUX(44, 1, 4)>, /* MTIOC3B */
+				 <RZG2L_PORT_PINMUX(44, 2, 4)>, /* MTIOC3C */
+				 <RZG2L_PORT_PINMUX(44, 3, 4)>; /* MTIOC3D */
+		};
+	};
+
 	scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(38, 0, 1)>,	/* TxD */
 			 <RZG2L_PORT_PINMUX(38, 1, 1)>;	/* RxD */
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index b6bd27196d88..664318e3dfb6 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -11,7 +11,6 @@
 #include "rzg2lc-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
-
 / {
 	aliases {
 		serial1 = &scif1;
@@ -50,6 +49,19 @@ wm8978: codec@1a {
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
 /*
  * To enable SCIF1 (SER0) on PMOD1 (CN7), On connector board
  * SW1 should be at position 2->3 so that SER0_CTS# line is activated
-- 
2.25.1


