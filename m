Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFA4C5518E
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:14 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2482.1785575713395121318
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=p3MCODkz;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso3407815e9.0
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575712; x=1786180512; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GxUxoXGo0J2tQQ04w9Rvf5K7vrJYItGy9ieJpZhWzko=;
        b=p3MCODkzvFwB5PzL3KCRlU5YNrzxBHLOLhfw5wzhA4xBqe5DylwHjGqF4W6JodSC6I
         VS482Vp0bJEJIggaCMyBCG2NHqCqC6mHAe91mz0ZIalw7Rd+4auiHP/dxZF7yMX5w8z8
         Vl2O3Ee9c6SAAG1+Rpa3b2WxKvPEZ8A1sc0QuZH+MEkxqy/snLshYK0YoH6uwycSgvI2
         CnRx7rZSqjBBr3iwqMzNKU6zpIgQ6oTXSH91j/8N+9eWMLQTQT24nxLnaOFXAMOQZhEg
         jtJVVtltDIv5AymukAU18JNmK5BA3JRqBDvIqzNgQPU6+pXl9CB5Y1ZANgtJDpa8HlqF
         lWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575712; x=1786180512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GxUxoXGo0J2tQQ04w9Rvf5K7vrJYItGy9ieJpZhWzko=;
        b=YjQBPjSADOFx1MVIR2nW1DGV5tEZtJzDLe+MWM2oMropaOwIW5xPodmGN6pBbB/W2W
         orYD6kq6jYzKt4OQQhdMV33TFKMBb0P+WKOg/NfWZJYwrO/IQkhLGzcU5kWSWyXCqcgy
         GYQqN0wy+m0Edo8H2z0HwAxpy0PTAyN0FphHsPcyKFMFRCs9VIHrsOgUGDggvU4sjKJE
         4ESpltanSd5iT1LY5bRcNekfwVu20tASsZgF7NRei7h1fTKtiZuMj8vqi/5/NVFk1YWx
         tw66Qs+Fm76v8cs5tJzh2BFUgdUwIjpKlNyLLqg2xad3zxoKqMWjjKJXUeO2k4JWhKre
         kG7w==
X-Gm-Message-State: AOJu0YyKR1VxwZknaNdMSrWc3TonlkVzwZGnlbenXtxKcobSLGAdqZIw
	Hg07LGlRO33eNZO1mKS3ODaS5CbjvbZwbgz7uvHGNjkOQG7Yh1vjEzgiiXMnww==
X-Gm-Gg: AR+sD12pfty97N4de1D3/DqfI/ZPx25janeiHEErhLLF+wp7MAd9N5N2N8pcp3qwRyF
	vdrzg9pDvng7hKmtKbDvZjiQjC6bYHxzQtw0igyAlZU647CHyupZiUTf94es9bg9ll/Ccwee62I
	nmE0ylMW3eeszZySv80OqFN55rrvP6jzr5ncDfzYsrb12afK18f9fCd2zPWgtQDrnpaRxpnY/mv
	GghBUF7jk6Hf4xoMZLX8DutHXz4GXRB/hy7LFPRcysgbts+T6GfCWW6EV/UKdEFfwrwT7HHVA1v
	0LJGuHTjw1j6isF5Tq9LlcVHuXeZjNjnF8WSlW0AWqAoc5FMVAgUP3KkuS1Fn4q9frzxcTAxF5S
	EFGliNlUGzotjEUDql1Bb9EFe4H4THxdTJLN5DdruR0tEzo8C/ozO75bVpbvBNS+w6MZpfWci1T
	7W96WdQqbRSGM1NAqlkSbr1GrCeZQLMw0tx3v8mOEEroUZchgMgDP83m8OP9/537Y+XH8K2TSyS
	KiUW4DOgnAgEw==
X-Received: by 2002:a05:600c:8b48:b0:498:261:dd93 with SMTP id 5b1f17b1804b1-4980c67ab9cmr32617425e9.18.1785575711534;
        Sat, 01 Aug 2026 02:15:11 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:11 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 15/19] arm64: dts: renesas: r9a08g046l48-smarc: Enable I2C{2,3} devices
Date: Sat,  1 Aug 2026 10:14:46 +0100
Message-ID: <20260801091458.14026-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23842

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 3f9c7afdfa60eb726c7f8fb8529ab6519a104db8 ]

Enable I2C{2,3} on the RZ/G3L SMARC EVK board.  I2C3 is enabled by
setting SW SYS.2 to the OFF position.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260528070239.33352-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 29 +++++++++++++++++++
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     |  4 +++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
index ef00e316fbde..1512b7df39bd 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
@@ -11,6 +11,7 @@
 #define RZ_BOOT_MODE3		1
 #define SW_DPI_EN		0
 #define SW_GPIO4		1
+#define SW_I3C_EN		0
 
 #define PMOD_GPIO4		0
 #define PMOD_GPIO6		0
@@ -33,10 +34,28 @@ / {
 		     "renesas,r9a08g046l48", "renesas,r9a08g046";
 
 	aliases {
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
 		serial3 = &scif0;
 	};
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+#if !SW_I3C_EN
+&i2c3 {
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+#endif
+
 &keys {
 #if !RZ_BOOT_MODE3 || !SW_GPIO4 || PMOD_GPIO4
 	/delete-node/ key-1;
@@ -52,6 +71,16 @@ &keys {
 };
 
 &pinctrl {
+	i2c2_pins: i2c2 {
+		pinmux = <RZG3L_PORT_PINMUX(A, 4, 4)>, /* RIIC2_SCL */
+			 <RZG3L_PORT_PINMUX(A, 5, 4)>; /* RIIC2_SDA */
+	};
+
+	i2c3_pins: i2c3 {
+		pinmux = <RZG3L_PORT_PINMUX(2, 0, 4)>, /* RIIC3_SCL */
+			 <RZG3L_PORT_PINMUX(2, 1, 4)>; /* RIIC3_SDA */
+	};
+
 	scif0_pins: scif0 {
 		pins = "SCIF0_TXD", "SCIF0_RXD";
 		power-source = <1800>;
diff --git a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
index 06c6ccac5ad2..17bf44778398 100644
--- a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
@@ -9,6 +9,10 @@
  * Please set the below switch position on the SoM and the corresponding macro
  * on the board DTS:
  *
+ * Switch position SYS.2, Macro SW_I3C_EN:
+ *      0 - SMARC_I2C_GP is enabled
+ *      1 - I3C is enabled
+ *
  * Switch position SYS.5, Macro SW_DPI_EN:
  *      0 - Select multiple SMARC signals active
  *      1 - Select LCD
-- 
2.43.0


