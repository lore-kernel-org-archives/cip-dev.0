Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48EED6E2AC
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:35 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44890.1766071947634249114
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EWoV8c4V;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so693336f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071946; x=1766676746; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9gcyAmONJvcSeAyMOSi4MZwKzr2poWI7MDjUwfkKY4=;
        b=EWoV8c4VfN1Bt8ZjZjJUa8FN8hrW9qwbQhVEVRsDwiALCoovEkGDEHN98le+S9EONR
         HMT6J2SKjJ61gywOg5USMAGXqrjLx6fo9ctLbJImCaMY24LYQfsRvcgPYcDzw33x7HNH
         L+1N1InZKQcBN2kvAKtLTY7/e0ZP//4P+eGLiESbDj5qjwx//KnV/W7VqgqWWtFpIrZr
         LBWlO6dEtUf3PHoUQviw4n+8B2HfjhkPR/lY5f/7PmMXrUEb/Bi1WbIZ9zzwRXFl9QZP
         OeDkgE8EF3b4Vg/bwC6s9JdixmG8m9OVA7kIqY2hOJDalubAHtseAmE2eNKMvK5ILByq
         LpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071946; x=1766676746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b9gcyAmONJvcSeAyMOSi4MZwKzr2poWI7MDjUwfkKY4=;
        b=RHr8S233f6SVOrUex5BAttk9y0MOezBD4v/lwffslOfGWkGR0GGjVe4tv1qyMpwWE7
         RAkQqJnxsy8zr3kuOBw2Q4yf96+PGwXROacIwocjGe4ASUOhdFk+RdO7RpVDxqhmAFWJ
         bHD5/qZxR2VDI6yKy/hmVhFXXfN8obDcz3Zwbry4Yo1R5kKS1xK1gPd3LuOZ3Ua0KRQL
         ntgipy/5G5RIQRjemulpB99JPSSxmBLt9GJsOLJQ8CwH4O/+mIsZkmf4iQKgN8oNdHf6
         spk4dcY0C3ynir1I5xsCXHQ3hQ8y71wUFOH7r9kBAPu6DoC6Z8PQLn+ly42lqHPEBQPq
         kSNw==
X-Gm-Message-State: AOJu0YyHhOuJYyG0Fo0RNxqwgPZeZqHLmvlc2wQyhXBC7QxKVVTkc2Hq
	W/9+/IFF2t7Ati0U8/WAFuEyqwx2Ax8dHjuqMdTCr2heTpy/PamIcI/q6vI8Xg==
X-Gm-Gg: AY/fxX5dQfPA0XH15/f8DeOn27aXI7hM2bkR43eU+HdKnSYdF2XrDXSKZSvC/sFHKWW
	CSB27hPfGrjkMmgmsW7Ys9EablqMdSBXo8Ii0wsII5xadxBwA2KQiLjJhn6cDecaVP+lvRUvut+
	2fEXXn5XuO2lpZaNQpEg2ebkLBH1wNurzSojNMVqoeb22X9eRzaeobhEYAOB7T4Qdv/AFX1+5K1
	izkjbKj9nPpO6KfiRR1kNtaznUtKjzvYJJuVyV45WzMapxgF2MLDBWZbNovqE3YFkBSU1NosXrO
	aMFpT+gSQUj9yBxixL9G5SZJSglHICN05pVJvFJlowuzbbpgeEhz9GjM1qnMdxQdZ5ffAWYdZpc
	bTovxGGsoJ25gi9T92nX3aQ1zE3klHbiqOx+DCswSsNkA2vfqhIVUqHyrHjWtYwSYoqZTP3gqSQ
	4q6RYaRyuRHMqNv3K3Mw==
X-Google-Smtp-Source: AGHT+IFKMgjWZrSRKfkNNygdDzwxj0XmZKAh52z2JfWaoAX0aXT/eE591u+Hd3sjg5simipVfxBl5A==
X-Received: by 2002:a5d:5f54:0:b0:42b:2ee0:569f with SMTP id ffacd0b85a97d-42fb48ffb94mr23584910f8f.33.1766071945742;
        Thu, 18 Dec 2025 07:32:25 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm5637772f8f.40.2025.12.18.07.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:32:25 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 11/12] arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys
Date: Thu, 18 Dec 2025 15:32:00 +0000
Message-ID: <20251218153219.228506-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21136

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
[Biju: Squashed the commit 3e5df910b592d4 ("arm64: dts: renesas:
r9a09g047e57-smarc: Fix gpio key's pin control node"]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 37 +++++++++++++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      | 31 ++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index f9d73f30abfe..a855c2a31578 100644
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
@@ -82,6 +92,29 @@ &i2c0 {
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
 &ov5645 {
 	enable-gpios = <&pinctrl RZG3E_GPIO(D, 6) GPIO_ACTIVE_HIGH>;
 	reset-gpios = <&pinctrl RZG3E_GPIO(D, 7) GPIO_ACTIVE_LOW>;
@@ -105,6 +138,10 @@ i2c0_pins: i2c0 {
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


