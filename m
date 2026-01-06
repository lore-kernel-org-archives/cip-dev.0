Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2EBCDC179
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88528.1767701186378782931
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DnQRyYHz;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso4274315e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701184; x=1768305984; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgfUCKoKF7FCpBX4qAv/7Qi2CNo8BfT8QRC82hD4XZM=;
        b=DnQRyYHz6a/ip3nvdtQzk4oREHnNrQfrBh9OYTqhQuTaEsMgRZzXCgR24PFcZzgUX3
         xHpM/zm5q1jgTzNh0t+l2AR6eIiFgUovmAJ2Ix6apDx06Vj4BKDw1aGuD4l3+7d9B7dt
         XyFDmoIFOVCokhjrA8JUi9OCh+ulPmFNouYXn/usnFGdFZDtFuO3kAN8bKn3zMC8iaYE
         uLrIcnsNmjV4QiO8XEiP3WpK/gDMZxXd+BMEbVhP6qf+6eFvAG0Uz0cvdDLrt7cHtSN9
         YBNEhMz3tHJWmxF9Ib/6P1RvtR4GMqM88jUsrXhRP4Mf7RwPY0NQtXKm9txIgDtBVtIs
         dxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701184; x=1768305984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SgfUCKoKF7FCpBX4qAv/7Qi2CNo8BfT8QRC82hD4XZM=;
        b=b+sc4Fakng6EMqUdqrVa9BVe1NWuIznBvRNs/JMjjVM886t5Ufr5F1TsiIKX/2d86E
         TVgjKPKZdIylDk/B6WautJ1ciFm9H08KDKP6qPlm4i/WKQKY+lHGOkuQdDbZye9Z4xL8
         jthUcWpP8TBuwOfXJu1tL5W1U8w3DtCubE0wV/OJoiwGJM5qna2YyRUptBOw2tiDKgdj
         yMdSF7Rtw/RlNu36ldkJEd7GUvr6QJ2qh/P3NLCyAWmx0fyHuhL/+hVG4AhJffWMjVBZ
         iwJ9WI3JlxiIBBXXk4SaxSkw8maSZBvDrS1Cm+HRmbtqGBOxyFRWIs3akQhPnIanW7QO
         pqCg==
X-Gm-Message-State: AOJu0Yy/i9mSMbDMSRJKdrH6YYzx+hTBzhNEPtvZMW2WxKGAlbj/9qZ3
	KzFb60BaAWTpSDTV2aSBCabk6fz206KtIhMAJtzb7avpk3vtNJmbHfrFz7uh7A==
X-Gm-Gg: AY/fxX7qVXINwnrG3I55OX33tvY7CJkBJS+2NczQNK0sPi2If2FsuAbWdfF5SwiAAuG
	fAL7xwDA/A2+HIkqBC6mJAk3zgYyGPVF5dWA2lE79is/+N+JwoapjTwbJ2tVDM7XB5y8VAPCsku
	ZmzuTHsYz0k3HyK+u3TmGX9JU3cx9RzmhT9KurBYXKo5JzG4KozDwwCVDGf8j/oJpPhQJgvCt4h
	3eryZFOh0+RPjwkx8mgW43IEht2WmKEyvqucKoBmq+TFaFlJq+vuQPzSqj/CPOO2P3dUZGJmsuc
	hU7bsOuKN1Gv3uNkbTLZR9Kte66heuut2IcqVEXXo6IhDBKd1Tzzrsb+xtOmQhDu9AyQhL2hxbP
	2JyD7Pn1ufhDmPUOM1B4P+8sA9VCmPJpV+QWtZyUYpkD9qx3kHayb0We9AAPj0gZPK9SnStCJhk
	XIUrVShBRsz7YsQ6RufQ==
X-Google-Smtp-Source: AGHT+IE6gpeRcgNgn8Uat2P0RgGBguq4gqk9o8wsVQfSlmkWw2U5U4cUmIaDGhnGe83C1NS3hyUeuQ==
X-Received: by 2002:a05:600c:500d:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-47d7f076080mr28588845e9.13.1767701184445;
        Tue, 06 Jan 2026 04:06:24 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:24 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 11/13] arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys
Date: Tue,  6 Jan 2026 12:06:08 +0000
Message-ID: <20260106120618.181104-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21371

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
index f9d73f30abfe..ae4f35298036 100644
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
@@ -82,6 +91,29 @@ &i2c0 {
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
 &ov5645 {
 	enable-gpios = <&pinctrl RZG3E_GPIO(D, 6) GPIO_ACTIVE_HIGH>;
 	reset-gpios = <&pinctrl RZG3E_GPIO(D, 7) GPIO_ACTIVE_LOW>;
@@ -105,6 +137,10 @@ i2c0_pins: i2c0 {
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


