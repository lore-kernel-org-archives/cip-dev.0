Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF45CEB64DD
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 14:11:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.8584.1689689497866713402
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 07:11:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="169768620"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Jul 2023 23:11:41 +0900
Received: from localhost.localdomain (unknown [10.226.92.137])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2EC25400F736;
	Tue, 18 Jul 2023 23:11:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 4/6] arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
Date: Tue, 18 Jul 2023 15:11:27 +0100
Message-Id: <20230718141129.119809-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
References: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 14:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12395

commit fb9341ebc7df140813d4fbc4a29fddba55a90728 upstream.

Add support for PMOD_MTU3 macro to enable MTU3 node on RZ/{G2,V2}L SMARC
EVK.

The MTU3a PWM pins are muxed with spi1 pins and counter external input
phase clock pins are muxed with scif2 pins. Disable these IPs when
PMOD_MTU3 macro is enabled.

Apart from this, the counter Z phase clock signal is muxed with the
SDHI1 cd signal. So disable SDHI1 IP, when the counter Z phase signal
is enabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230706153047.368993-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    | 21 +++++++++++++++++
 .../boot/dts/renesas/r9a07g054l2-smarc.dts    | 20 ++++++++++++++++
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  | 20 ++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 23 ++++++++++++++++---
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
index bc2af6c92ccd..568d49cfe44a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
@@ -6,6 +6,27 @@
  */
 
 /dts-v1/;
+
+/* Enable SCIF2 (SER0) on PMOD1 (CN7) */
+#define PMOD1_SER0	1
+
+/*
+ * To enable MTU3a PWM on PMOD0,
+ * Disable PMOD1_SER0 by setting "#define PMOD1_SER0	0" above and
+ * enable PMOD_MTU3 by setting "#define PMOD_MTU3	1" below.
+ */
+#define PMOD_MTU3	0
+
+#if (PMOD_MTU3 && PMOD1_SER0)
+#error "Cannot set as PMOD_MTU3 and PMOD1_SER0 are mutually exclusive "
+#endif
+
+#define MTU3_COUNTER_Z_PHASE_SIGNAL	0
+
+#if (!PMOD_MTU3 && MTU3_COUNTER_Z_PHASE_SIGNAL)
+#error "Cannot set 1 to MTU3_COUNTER_Z_PHASE_SIGNAL as PMOD_MTU3=0"
+#endif
+
 #include "r9a07g044l2.dtsi"
 #include "rzg2l-smarc-som.dtsi"
 #include "rzg2l-smarc-pinfunction.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
index 3d01a4cf0fbe..b3e6016880dd 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
@@ -6,6 +6,26 @@
  */
 
 /dts-v1/;
+
+/* Enable SCIF2 (SER0) on PMOD1 (CN7) */
+#define PMOD1_SER0	1
+
+/*
+ * To enable MTU3a PWM on PMOD0,
+ * Disable PMOD1_SER0 by setting "#define PMOD1_SER0	0" above and
+ * enable PMOD_MTU3 by setting "#define PMOD_MTU3	1" below.
+ */
+#define PMOD_MTU3	0
+
+#if (PMOD_MTU3 && PMOD1_SER0)
+#error "Cannot set as PMOD_MTU3 and PMOD1_SER0 are mutually exclusive "
+#endif
+
+#define MTU3_COUNTER_Z_PHASE_SIGNAL	0
+#if (!PMOD_MTU3 && MTU3_COUNTER_Z_PHASE_SIGNAL)
+#error "Cannot set 1 to MTU3_COUNTER_Z_PHASE_SIGNAL as PMOD_MTU3=0"
+#endif
+
 #include "r9a07g054l2.dtsi"
 #include "rzg2l-smarc-som.dtsi"
 #include "rzg2l-smarc-pinfunction.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
index 9085d8c76ce1..18c526c7a4cf 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
@@ -53,6 +53,26 @@ i2c3_pins: i2c3 {
 			 <RZG2L_PORT_PINMUX(18, 1, 3)>; /* SCL */
 	};
 
+	mtu3_pins: mtu3 {
+		mtu3-ext-clk-input-pin {
+			pinmux = <RZG2L_PORT_PINMUX(48, 0, 4)>, /* MTCLKA */
+				 <RZG2L_PORT_PINMUX(48, 1, 4)>; /* MTCLKB */
+		};
+
+		mtu3-pwm {
+			pinmux = <RZG2L_PORT_PINMUX(44, 0, 4)>, /* MTIOC3A */
+				 <RZG2L_PORT_PINMUX(44, 1, 4)>, /* MTIOC3B */
+				 <RZG2L_PORT_PINMUX(44, 2, 4)>, /* MTIOC3C */
+				 <RZG2L_PORT_PINMUX(44, 3, 4)>; /* MTIOC3D */
+		};
+
+#if MTU3_COUNTER_Z_PHASE_SIGNAL
+		mtu3-zphase-clk {
+			pinmux = <RZG2L_PORT_PINMUX(19, 0, 3)>; /* MTIOC1A */
+		};
+#endif /* MTU3_COUNTER_Z_PHASE_SIGNAL */
+	};
+
 	scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(38, 0, 1)>,	/* TxD */
 			 <RZG2L_PORT_PINMUX(38, 1, 1)>;	/* RxD */
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index e180a955b6ac..018c34f841bf 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -8,9 +8,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
-/* comment the #define statement to disable SCIF2 (SER0) on PMOD1 (CN7) */
-#define PMOD1_SER0	1
-
 / {
 	aliases {
 		serial1 = &scif2;
@@ -36,6 +33,26 @@ wm8978: codec@1a {
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
+#if MTU3_COUNTER_Z_PHASE_SIGNAL
+/* SDHI cd pin is muxed with counter Z phase signal */
+&sdhi1 {
+	status = "disabled";
+};
+#endif /* MTU3_COUNTER_Z_PHASE_SIGNAL */
+
+&spi1 {
+	status = "disabled";
+};
+#endif /* PMOD_MTU3 */
+
 /*
  * To enable SCIF2 (SER0) on PMOD1 (CN7)
  * SW1 should be at position 2->3 so that SER0_CTS# line is activated
-- 
2.25.1


