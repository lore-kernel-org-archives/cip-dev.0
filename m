Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCB9C27C6E
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:31 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.42769.1717769364128561761
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=QUMvy6h+;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a2f27090aso5434741a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769362; x=1718374162; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u9EFSWCFzBU6PBuVFaluzhvL7+pBPGLLnR+2pKY/QU=;
        b=QUMvy6h+wax9ddVo7aQ5uRpQkGejG+AsKFTJeTfPTJgEtEl6psZqiYNTkMyr3jCCgE
         z3s5VKx2P2AbKYTVHR7QZH3kU3Xxxq0FoRul1xwFBd10468M/vj6V+jPaJDCl51yIqQr
         nIwPHwMM91RHNITwnJ2Q7DKMbiArMrafCAah3FzpedjGoSaTpfHt2T6YSXNxXz55U5Lc
         3hofG93ASjQaLuIgKWC8fGeGF2yHqDMoo8bZaI2xJIkEpm0c8WxOMEaejX4gK62rfBIo
         dmZfdlbXj+NlH29T/fyUIOkcDe1Az4OgeYaIXfB1ta5MtuxXn+9r4Niu5KzlRHkLgu4I
         BrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769362; x=1718374162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u9EFSWCFzBU6PBuVFaluzhvL7+pBPGLLnR+2pKY/QU=;
        b=JjiLfo31/oH62hI62s0nifIXd9p8no/SRaN3AB5J1rSImGL1hfqbSjwkx7AUxVHxY7
         w/rG942keTmTiBVvAonNomOD4XMZ8qIqMWrpxQBkduPT6hrYCsSUB8ZQzOxoIHmOxbxB
         ATca0IrxNPsFI5TIPgNb5fGdThxJKqTv6VEjpRTv4m6iPMv1HrUN0LTb7eh4TpLvdzXU
         ha6GonP2rJ18rJjtiGJWnTY7II48P4JgmwnXEfd6IUvfGrhhM5hPvFgnVMFDbAskgQPk
         G6QmnqIkqTZwzoRZ6SoB7oY8bFHFp3CZRTvxepuI+SK4znvY2PIj2I58QHIWQ2ku0tvU
         AxMA==
X-Gm-Message-State: AOJu0Ywdba/FnxkjvWBscLgriIDiA+ivFxKEFplCj0MnDqAVcW9mfiaA
	c9vSK6tVnr/Lym8WEDg8PS0zbgyobrGYpeYSPvhIMI9fT30KQ+grAK0APt0bYlk=
X-Google-Smtp-Source: AGHT+IGsVT0CuBOlPF4mdCMxOLqtwos/kE3ap1Zid3/oHU1xdMBLO3dGXWuT2h9xTYCfU0iAOnSWVg==
X-Received: by 2002:a17:906:c254:b0:a6c:70f3:de0f with SMTP id a640c23a62f3a-a6cbc6ca035mr236133066b.28.1717769362561;
        Fri, 07 Jun 2024 07:09:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 16/17] arm64: dts: renesas: rzg3s-smarc: Add gpio keys
Date: Fri,  7 Jun 2024 17:08:55 +0300
Message-Id: <20240607140856.2497508-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16177

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


