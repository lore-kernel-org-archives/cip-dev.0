Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E73AD78763
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 12:29:29 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15744.1766147361501654675
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 04:29:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iG10u8mq;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7355f6ef12so327715266b.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 04:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766147360; x=1766752160; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/xzXVFm8tNyFXsh01E5F+s+UDdaxzvb76Ifm3Yi9D4=;
        b=iG10u8mqQHYGEqM/+hMql9gnnF1bEJDe7BHA8az1xffdF1pAKJ7CuPccQsxVClRK4b
         xmOvfnUYdaT/WYJiIZitlO9CPKKDLMwXsUnaeW6FT5Pf2vcHG4eK0eqw+PPMJfG+KZaG
         qcz297B2/bBL/xlrkpXHCjJpli2mCC0c+KaUIq2psAEMgDJN99+TbTLbRwwYcOiDrc5O
         OiR5/DWCe2Lnejfb7UHKkfLCNL1LZDi9n8SrREdBHtm0nCdzd0mfv6z0UKcRsNVId7Kb
         yu3o9UpEuaf4bZGZrfEc4aymvurVSWAHKiawN/VzAVM/y8OGmynjifTSY1c/ORJ+ep1i
         ALyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766147360; x=1766752160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/xzXVFm8tNyFXsh01E5F+s+UDdaxzvb76Ifm3Yi9D4=;
        b=dvr8AakT4WHqyL2Cvr/IJK+lnXU9uWxID8ujpcR5ehcK3gYQTyvb5KzGNJbQAXYL/8
         3j0Rz50sDRU4j9Wc6ZtEHacFrGFoQjjKheWNvELrJtjy9L6T53+I4VNQgp8D/jZs01O1
         PvQ7SzW+24HQTM2d04C/Dcfw5RIQeP66F5j46Q2SjPP0k2Kgrdi9T8z2RWxpj5XFwEIy
         NI3COz035nAFs7vrboyBebQXm5Phvic7frY6YIUE0sMZ3qws7fRIRnuOJJjLaFwLV93T
         S7fz3xtSJz0ei15zCegb/YSGxs58WVWEvKMbogL1oEbMbnhpxiKJjt1PwYGnE1Bu0r2m
         Q6Bw==
X-Gm-Message-State: AOJu0YxV3I03ocKSa3GSIRM33VTqNyRUx7JQmxzxW9Sh0xC/0QY/HNsI
	wBdfvnC89u7kcnBUI++rZ01A95maGnyzyb80os1ua7GYE/g5HQyOwdI4d9rN7A==
X-Gm-Gg: AY/fxX6+ggP2JPlU+pULPCgOV1zbNM54W9D+Y3XuIts4xzqGyu7Q1kdKoBOnnHsqWgP
	R/gXcTUJp4PK05XKq/+yzxzG3kD5ahiXGS6KJgzqjJuDGdgANBOWx+k1INNLH22TLUpYBX4dNTq
	9dBJaPp96JxA0fVl2vS9lHCUH+M0sBi3IkrHbCOd+IKAwobComh2Z3rsNskW/CqhVKj1WH7R0XT
	PKvRuvhKJw5KMpVm9YxxBHd5CuiUnUi7Nx8EHlAvgDDUuAnfxw5gRBnfGYUIakhk5GpGY2FD8ri
	pJxnqt9XETwJ3/SWOZpfst9SpNHLaoEA1n1cWih0VIySSD1gUW4mCFb0JBeVWXUMMLe+RkuSGwb
	4eCBKCXTznWSdqt5QkV4xmy8Tm7nXDb+iOodYl7F/bvBq3fDl9i8BCwTOTlUhoh5TsQ5+3LSrip
	0CvfWwN2Y91l2pjS8QYt8dz6lYZNltOaXsTA==
X-Google-Smtp-Source: AGHT+IFxRpgIS/BL/lb7Qh4GJchjdpzd4MD5fcKXsfUoJXRE+GOsPwWH6UcuEeuLavyfDlgrkhOvkg==
X-Received: by 2002:a17:906:730d:b0:b73:b05c:38fd with SMTP id a640c23a62f3a-b8037183211mr268552966b.50.1766147359456;
        Fri, 19 Dec 2025 04:29:19 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bb1:f7ee:1376:35e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f511fesm223648666b.65.2025.12.19.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:29:19 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 4/5] arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys
Date: Fri, 19 Dec 2025 12:29:10 +0000
Message-ID: <20251219122916.129256-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 12:29:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21178

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstram commit 9e95446b0cf93a91bc3b3b64c6d423f4024a6ff0 ]

RZ/G3E SMARC EVK  has 3 user buttons called USER_SW1, USER_SW2 and
USER_SW3 and SLEEP button with NMI support. Add a DT node in device tree
to instantiate the gpio-keys driver for these buttons.

The system can enter into STR state by pressing the sleep button and
wakeup from STR is done by pressing power button. The USER_SW{1,2,3}
configured as wakeup-source, so it can wakeup the system during s2idle.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250702092755.70847-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Biju: Squashed the commit 3e5df910b592d4 ("arm64: dts: renesas:
r9a09g047e57-smarc: Fix gpio key's pin control node"]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 37 +++++++++++++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      | 31 ++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 2454a9743df2..9f6716fa1086 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /* Switch selection settings */
+#define SW_LCD_EN		0
 #define SW_GPIO8_CAN0_STB	0
 #define SW_GPIO9_CAN1_STB	0
 #define SW_LCD_EN		0
@@ -15,7 +16,16 @@
 #define SW_SD0_DEV_SEL		0
 #define SW_SDIO_M2E		0
 
+#define PMOD_GPIO4		0
+#define PMOD_GPIO6		0
+#define PMOD_GPIO7		0
+
+#define KEY_1_GPIO		RZG3E_GPIO(3, 1)
+#define KEY_2_GPIO		RZG3E_GPIO(8, 4)
+#define KEY_3_GPIO		RZG3E_GPIO(8, 5)
+
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
 #include "r9a09g047e57.dtsi"
 #include "rzg3e-smarc-som.dtsi"
@@ -79,6 +89,29 @@ &i2c0 {
 	pinctrl-names = "default";
 };
 
+&keys {
+	pinctrl-0 = <&nmi_pins>;
+	pinctrl-names = "default";
+
+	key-sleep {
+		interrupts-extended = <&icu 0 IRQ_TYPE_EDGE_FALLING>;
+		linux,code = <KEY_SLEEP>;
+		label = "SLEEP";
+		debounce-interval = <20>;
+	};
+#if PMOD_GPIO4
+	/delete-node/ key-1;
+#endif
+
+#if SW_LCD_EN || PMOD_GPIO6
+	/delete-node/ key-2;
+#endif
+
+#if SW_LCD_EN || PMOD_GPIO7
+	/delete-node/ key-3;
+#endif
+};
+
 &pinctrl {
 	canfd_pins: canfd {
 		can1_pins: can1 {
@@ -97,6 +130,10 @@ i2c0_pins: i2c0 {
 			 <RZG3E_PORT_PINMUX(D, 5, 4)>; /* SDA0 */
 	};
 
+	nmi_pins: nmi {
+		pinmux = <RZG3E_PORT_PINMUX(S, 0, 0)>; /* NMI */
+	};
+
 	scif_pins: scif {
 		pins = "SCIF_TXD", "SCIF_RXD";
 		renesas,output-impedance = <1>;
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
index 3cac292f20b3..58561da3007a 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -23,6 +23,9 @@
  * SW_GPIO9_CAN1_STB:
  *	0 - Connect to GPIO9 PMOD (default)
  *	1 - Connect to CAN1 transceiver STB pin
+ *
+ * GPIO keys are enabled by default. Use PMOD_GPIO macros to disable them
+ * if needed.
  */
 
 / {
@@ -53,6 +56,34 @@ can_transceiver1: can-phy1 {
 		max-bitrate = <8000000>;
 		status = "disabled";
 	};
+
+	keys: keys {
+		compatible = "gpio-keys";
+
+		key-1 {
+			interrupts-extended = <&pinctrl KEY_1_GPIO IRQ_TYPE_EDGE_FALLING>;
+			linux,code = <KEY_1>;
+			label = "USER_SW1";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-2 {
+			interrupts-extended = <&pinctrl KEY_2_GPIO IRQ_TYPE_EDGE_FALLING>;
+			linux,code = <KEY_2>;
+			label = "USER_SW2";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-3 {
+			interrupts-extended = <&pinctrl KEY_3_GPIO IRQ_TYPE_EDGE_FALLING>;
+			linux,code = <KEY_3>;
+			label = "USER_SW3";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+	};
 };
 
 &canfd {
-- 
2.43.0


