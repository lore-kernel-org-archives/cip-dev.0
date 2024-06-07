Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DB5C41513
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:40 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.42978.1717769258438855445
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ay57b3L/;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a20ccafc6so2572755a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769257; x=1718374057; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u9EFSWCFzBU6PBuVFaluzhvL7+pBPGLLnR+2pKY/QU=;
        b=ay57b3L/eyD6dQACmzhXIc2DpZ1vL8achwkMYYjxL09eg+g+9gObRyi4p3FObzxLaX
         401jGbD2eBGbWYxUWmnTaEgnQV5Y8Ywj2XgMaFV9lQwT3xdr1ei09CMieCNfySIOcwVb
         oPvxklhvZokOke+Er8rXxbRPkuSjMAnR3lN+jp+6c+zhi6gahHSdapbyyuYEtTmtewL2
         3GxndRhVU+LAi6yFkIpfziiP/7BVmDwIuFLh4rzd91/HxjRhHIDVY1upUFX8Ie6RI8pB
         byBXrCPFSxRFXpO3NYJ62jDtJfZ5sT9jpyAwq9DtqPIqvxvkdY7SAEDyI0MK/Dr8YNXS
         JBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769257; x=1718374057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u9EFSWCFzBU6PBuVFaluzhvL7+pBPGLLnR+2pKY/QU=;
        b=ro3tV3zp4YzjIBCVikj4mtIjquXKXCqfh2HTyswjZuL9qLRd+hQI21u8ST6apC+GRQ
         Smm/kNgAtlH0CNHY7ndb5VYLHjBp3aBBILIMZIb8MV1oeYdv9WPT5L+gx7C3oY/fzhG0
         VxFe6SPo5k0sYylZE8JhVfsHW+nqPXUbtF/MIPcpdcmBN2Ub3a1+yiczLwOuakv9Ej7K
         D19Y4g62SPnFRAPh9Edk17mA1l+3BoYMDJNaCOknNc1kb3ekib1gFcpCREiEayxqCZot
         tso9lj8xXbCphmjDYHdILNbgSqB1Xcb+Mu1BG+nLQG+8jXfwyx6XeZXaNpNcVYZ5VzSp
         0krg==
X-Gm-Message-State: AOJu0YxdGpUHOkYPrVRP13IshbaDeLT54JshhelTXqbenZqWlgM1FyKi
	wTIKBpN1cgf/giP6iAeHH5wG0eFgA7yW3Uu/242Z18SUsq09Y/jTh7bHJw/cEgY=
X-Google-Smtp-Source: AGHT+IF3Qk+RoPL5Hf+5Z8bctPgjVAIkwAG17onqVYh15wesWG9OGbTEewnuSpHqALMSyEo59puaYA==
X-Received: by 2002:a50:875e:0:b0:578:6832:8c38 with SMTP id 4fb4d7f45d1cf-57c50930461mr1580637a12.24.1717769256882;
        Fri, 07 Jun 2024 07:07:36 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:35 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 16/19] arm64: dts: renesas: rzg3s-smarc: Add gpio keys
Date: Fri,  7 Jun 2024 17:07:08 +0300
Message-Id: <20240607140711.2497286-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16157

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 347c80f7c7b207ad8cb183822df75f70b7dc0773 upstream.

RZ SMARC Carrier II board has 3 user buttons called USER_SW1, USER_SW2,
USER_SW3. Add a DT node in device tree to propertly instantiate the
gpio-keys driver for these buttons.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231227130810.2744550-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 214520137230..deb2ad37bb2e 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
 / {
@@ -14,6 +15,37 @@ aliases {
 		mmc1 = &sdhi1;
 	};
 
+	keys {
+		compatible = "gpio-keys";
+
+		key-1 {
+			interrupts = <RZG2L_GPIO(18, 0) IRQ_TYPE_EDGE_FALLING>;
+			interrupt-parent = <&pinctrl>;
+			linux,code = <KEY_1>;
+			label = "USER_SW1";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-2 {
+			interrupts = <RZG2L_GPIO(0, 1) IRQ_TYPE_EDGE_FALLING>;
+			interrupt-parent = <&pinctrl>;
+			linux,code = <KEY_2>;
+			label = "USER_SW2";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+
+		key-3 {
+			interrupts = <RZG2L_GPIO(0, 3) IRQ_TYPE_EDGE_FALLING>;
+			interrupt-parent = <&pinctrl>;
+			linux,code = <KEY_3>;
+			label = "USER_SW3";
+			wakeup-source;
+			debounce-interval = <20>;
+		};
+	};
+
 	vcc_sdhi1: regulator-vcc-sdhi1 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHI1 Vcc";
@@ -35,6 +67,27 @@ vccq_sdhi1: regulator-vccq-sdhi1 {
 };
 
 &pinctrl {
+	key-1-gpio-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(18, 0) GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "key-1-gpio-irq";
+	};
+
+	key-2-gpio-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(0, 1) GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "key-2-gpio-irq";
+	};
+
+	key-3-gpio-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(0, 3) GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "key-3-gpio-irq";
+	};
+
 	scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* RXD */
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
-- 
2.39.2


