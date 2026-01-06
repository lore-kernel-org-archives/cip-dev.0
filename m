Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FF6C47BEB
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 10:41:57 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.87380.1767696116342985929
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 02:41:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PqfpPCGQ;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so562827f8f.2
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 02:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696114; x=1768300914; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwZ6v+fvYK8+ZCZ+dP+vdTvYeLxHXmy6MkRqH/kYEcM=;
        b=PqfpPCGQmsknuiPOFMwqSiseXmFLyRbNt0joB9nKeZb5G0OT0phKEXaiv+kGLiJfzs
         4jba3+n4p0XJGuyM1/ZkaEcIls4Z1Xdt4tAFfLIJjj8oKDMFpL2Rrzi7GxNVTd7x6F1D
         vdRboXesmrR/Ibbt1WgNoLLpAO4WbqqBf0h2Bnmvhskqh0qEnHAbtJgcW23lCI0Nw4ag
         NMbxD9UDvkWNkDRwHc6xS7fPduuQQNBeY4gzBwehVKNGMBL/RdtQQEKe6UFXBKwmPR8D
         fFKPy6GveIWUwgx4zYK64qLzGTalNGzKSGfDqPFRGKBp68wCvQOI2QrOBiFDQC4d7nK8
         xGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696114; x=1768300914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwZ6v+fvYK8+ZCZ+dP+vdTvYeLxHXmy6MkRqH/kYEcM=;
        b=pDniiQ/smpaZya9enghj4G+PwZk+el195YvE8D7GZpg5mp7nSIdnzE+UbwQFzHjXpa
         4beXffLKRyJquZ+Qmqxf0nTsYg9ldzaHw0h+EfzJ1KaSlPh59QJqL4jB8HE4v6zIswkA
         tCenxn3tTOaSU5khePALiqgONVz742G+Ote2t70NL36KLIDogJyTy+nBaCatvzbhMtyl
         f/0FF8mJFRQRIWWVXbZ+XdDehB/uJwW+SIyQ9yqxafVULIuwGb51Qqjse04io/6DRH8O
         b3cdrGTb0pNiNTrfbVkHVdYkxs6cOFafSBIanD8981fgUtF3cMOrFKGiWuM0P2JO97rY
         N1ew==
X-Gm-Message-State: AOJu0Yx7/rp6+bgV4wqUxOrU5hQXko2I3v3IPUhtnd0AwW1WJjc7VkRR
	UtnCDrS0KEQosNNCR8Bko38J5AOoqZHuCRLRmdJnNrphJ898qfRFebHzDZg0hA==
X-Gm-Gg: AY/fxX5MCiGQ0TrTXPOkTDBK7WgwgPcEI6zPTCG7Cu5HmCQ46GcCKNinvYNEgQDfZZD
	vU2rpwhbfbGmq6fWnV7m1Q+VYPbRKGVvC4X/yx1FV7JoBasANb4Sjlr8AlW86SfIJdct+sayrHY
	oYnWNc3MCd74nBsrqZnUavPZGnJcr4NpoN74l/HaHG0XrfmoBWmRl4G7J15UylRgSQmOFDGy4Tj
	kV0s5Rems7hjqUKXR3INl+f3BYup84y2W87HGOr6oR8GsIrnKrNRHC4WzyMBGQZFBnlNNtunYfD
	KnmldyEduprI5jMc4Pt1m6NQhPZUE1Odj0fbHWmCV29uSxtb+3bXxamp4UoXTxXT07Z9gfF9/cj
	6a6Llgn1C9vaWGZScU0Dps/OH6RNiiEX4NnELdOGnsnZlnWfqao6M9Amh7JDw9KbFmW7zVGqmWz
	DiVS1BEaxVbgp0htkLkw==
X-Google-Smtp-Source: AGHT+IGbMA19THLYLtARMi9qkK5/RDR33ULXV3fkJ3QtoA761ihM2fPuKy/Uf5Xznt1BSXMSp2aj0w==
X-Received: by 2002:a5d:5d13:0:b0:42f:ba58:6599 with SMTP id ffacd0b85a97d-432bca4ae18mr3608244f8f.35.1767696114458;
        Tue, 06 Jan 2026 02:41:54 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm3583184f8f.39.2026.01.06.02.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:41:54 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 4/6] arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys
Date: Tue,  6 Jan 2026 10:41:46 +0000
Message-ID: <20260106104151.88020-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
References: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 10:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21329

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 9e95446b0cf93a91bc3b3b64c6d423f4024a6ff0 ]

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
[ Biju: Dropped duplicate SW_LCD_EN macro ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 36 +++++++++++++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      | 31 ++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 2454a9743df2..eed03e43ca6a 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -15,7 +15,16 @@
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
@@ -79,6 +88,29 @@ &i2c0 {
 	pinctrl-names = "default";
 };
 
+&keys {
+	key-sleep {
+		pinctrl-0 = <&nmi_pins>;
+		pinctrl-names = "default";
+
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
@@ -97,6 +129,10 @@ i2c0_pins: i2c0 {
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


