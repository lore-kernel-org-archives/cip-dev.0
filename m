Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233CBFD7091
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:56 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73607.1773746273850482813
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XSwrYcXj;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483487335c2so53406905e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746272; x=1774351072; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecaZsv6gi1PIEBZCjHvO+xqk7OFgrQFsuEP+lchEtlc=;
        b=XSwrYcXjSm48uKT+m6LiP6ntvcd/zIGz/2E8jEKumRFsQVOEqtIQptGzRySQ2SYGzl
         tIzZhi4lv7MtLjaYramSpB6OmWL6Nsciz+UWZQbOdYO5747iuwDvAvuquXAoF5zp5dv7
         yocWxlZv6wA9z/Hf23CRtu8uq9yJGoSx0TY43FClVf9f5CM2gReBsq/ngAMFnuZZWC7q
         CtjWRhaak6A5eXp5KXOKS1YbI2Fh/ICiGTqz7P7bSaa1CkfWhvc1UXXictYsDi1ozMTe
         LT6DcR31Rkwiq4h9XVvLJ4uLPfv3R0CJcP2yVu2YL0D4SFxpdBt68FzbrePjudsW66NI
         lmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746272; x=1774351072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ecaZsv6gi1PIEBZCjHvO+xqk7OFgrQFsuEP+lchEtlc=;
        b=ImsbXkgyzRq1KbwbjjU5B1FbrG0xlKskohHNZ7Mr2kJO39gt+9smveB/76vh2mel5Q
         CE1CvQa67x41Vffmr80iBd50HDYS3Zhb1f/vwE2+UhprHRq0/eAUjWxdVOwQsCr8aznc
         p6h7DNsQiJ+q5UgcyrYK3QTSSzmoom9avPX6raJWobbnwPxSH1/NB/s4BtC5SCqggv22
         TfX3hWg+LCKBZK759WNY+T3U2Fi0I59awWAJDBboUXYdI+RLDCxfNAw5NiGSqGSVn+D3
         HaIuADbyIhYTTlreacgvODNeendYMh03v+JYdYb2z2TkONisfwPkH/7PfZix1yQ5ZarG
         AVLA==
X-Gm-Message-State: AOJu0YxIZ5dbiNcMwc19H61UZoBARjp3zMJPVSjO41NIK8TAS9/wZwi8
	dLkLJOpubqMaYvUeKxvngTV2o6jBDPL0dmupytBx/KlgSvqd+oHNooz4qvHeYQ==
X-Gm-Gg: ATEYQzz0kcjdyWzXaALCX74/MqtAs7Zd5UPJf+xJ6fZtwFwYBaPOoRnqan0M6d1gfrg
	849Y6fkPDBR386+atqm+DvaglLzvpr0e3hsiH4B+nEYut4Ike47QTwGeMQqcTkjbF0fAeyvKlOo
	l+DfIGCx+bvwDOO3O8QeeAR5M3jHGIASCPhGNJV6OATpF03tnaa1gyWKJKlBAm6SH56XiHBzJJv
	RN884T46lKP7ZbWrthIVMcaZrhG/AvjalL7vK8ufMcMBP8hngbLfZKxEHw3glVZCF7t7osRPzvT
	StB982M8B0PAc566RyoU1eKSfpnG3k5n6Qm6McEv6svQNUESj4K3IRuttoEn7ixKJlYDv6v8o8d
	dMceYJUfo0YnrpKUblgIJgH7loJMv7ELidF7AQ1Xc+iIQzcgPUMXaOm/gu+mHd+LyxvIwcEnG/L
	Q6Wn77T5pimfowiTuGaa20xE5kYJber3NjTYnEoLdOGrAHek+B
X-Received: by 2002:a05:600c:3552:b0:485:3a59:99ca with SMTP id 5b1f17b1804b1-485566fab0bmr275932655e9.16.1773746271843;
        Tue, 17 Mar 2026 04:17:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:51 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 39/39] arm64: dts: renesas: r9a09g047e57-smarc: Enable rsci{2,4,9} nodes
Date: Tue, 17 Mar 2026 11:17:04 +0000
Message-ID: <20260317111718.281633-40-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22472

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 835666e7403c3ddc6f3122888d975464f8272efe ]

Enable device rsci{2,4,9} nodes for the RZ/G3E SMARC EVK.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251129185203.380002-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 58 +++++++++++++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  7 +++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  4 ++
 3 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 8847dd8ba00c..f7868029f19a 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -12,6 +12,8 @@
 #define SW_GPIO9_CAN1_STB	0
 #define SW_LCD_EN		0
 #define SW_PDM_EN		0
+#define SW_SER0_PMOD		1
+#define SW_SER2_EN		1
 #define SW_SD0_DEV_SEL		0
 #define SW_SDIO_M2E		0
 
@@ -40,6 +42,9 @@ / {
 
 	aliases {
 		i2c0 = &i2c0;
+		serial0 = &rsci4;
+		serial1 = &rsci9;
+		serial2 = &rsci2;
 		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
@@ -148,6 +153,28 @@ nmi_pins: nmi {
 		input-schmitt-enable;
 	};
 
+	rsci2_pins: rsci2 {
+		pinmux = <RZG3E_PORT_PINMUX(1, 0, 1)>, /* RXD2 */
+			 <RZG3E_PORT_PINMUX(1, 1, 1)>, /* TXD2 */
+			 <RZG3E_PORT_PINMUX(1, 2, 6)>, /* CTS2N */
+			 <RZG3E_PORT_PINMUX(1, 3, 1)>; /* RTS2N */
+		bias-pull-up;
+	};
+
+	rsci4_pins: rsci4 {
+		pinmux = <RZG3E_PORT_PINMUX(7, 6, 5)>, /* RXD4 */
+			 <RZG3E_PORT_PINMUX(7, 7, 5)>, /* TXD4 */
+			 <RZG3E_PORT_PINMUX(8, 0, 6)>, /* CTS4N */
+			 <RZG3E_PORT_PINMUX(8, 1, 5)>; /* RTS4N */
+		bias-pull-up;
+	};
+
+	rsci9_pins: rsci9 {
+		pinmux = <RZG3E_PORT_PINMUX(8, 2, 5)>, /* RXD9 */
+			 <RZG3E_PORT_PINMUX(8, 3, 5)>; /* TXD9 */
+		bias-pull-up;
+	};
+
 	scif_pins: scif {
 		pins = "SCIF_TXD", "SCIF_RXD";
 		renesas,output-impedance = <1>;
@@ -179,6 +206,37 @@ sd1-data {
 	};
 };
 
+#if SW_SER0_PMOD && SW_SER2_EN
+&rsci2 {
+	pinctrl-0 = <&rsci2_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+
+	status = "okay";
+};
+#endif
+
+#if (!SW_LCD_EN) && (SW_SER0_PMOD)
+&rsci4 {
+	pinctrl-0 = <&rsci4_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+
+	status = "okay";
+};
+#endif
+
+#if (!SW_LCD_EN)
+&rsci9 {
+	pinctrl-0 = <&rsci9_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+#endif
+
 &scif0 {
 	pinctrl-0 = <&scif_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
index a296c2c1c7ab..69c0101ff7f5 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -13,6 +13,13 @@
  *     0 - SMARC SDIO signal is connected to uSD1
  *     1 - SMARC SDIO signal is connected to M.2 Key E connector
  *
+ * Please set the switch position SW_OPT_MUX.4 on the carrier board and the
+ * corresponding macro SW_SER0_PMOD on the board DTS:
+ *
+ * SW_SER0_PMOD:
+ *     0 - SER0 signals connect to M.2 Key-E, SER2 signals are unconnected
+ *     1 - SER0 signals connect to PMOD, SER2 signals connect to M.2 Key-E
+ *
  * Please set the switch position SW_GPIO_CAN_PMOD on the carrier board and the
  * corresponding macro SW_GPIO8_CAN0_STB/SW_GPIO8_CAN0_STB on the board DTS:
  *
diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
index f05b9fec05f0..3b571c096752 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -13,6 +13,10 @@
  *      0 - SD0 is connected to eMMC (default)
  *      1 - SD0 is connected to uSD0 card
  *
+ * Switch position SYS.4, Macro SW_SER2_EN:
+ *      0 - Select Module DSI connector(GPIO)
+ *      1 - Select SER2
+ *
  * Switch position SYS.5, Macro SW_LCD_EN:
  *      0 - Select Misc. Signals routing
  *      1 - Select LCD
-- 
2.43.0


