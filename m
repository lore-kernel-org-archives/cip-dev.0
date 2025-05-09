Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FBEC3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:14 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.10392.1746783249582344660
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bkWDpfy2;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fc9c49c8adso1063268a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783248; x=1747388048; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJm98Jl9ofslVtnTO+qJZhQyNp2+8Z6clTV3t0I6FUI=;
        b=bkWDpfy2AHMD+95nbwyT9CrIdj68G935Nb0tEkW95XuYSmSgj7ShbPItj7XLhUYvOs
         De0fUUxhS3BPgKERvAJpF9X1zQs/2OZNrvnsrQy1Z+L1sdMQvlkkRW32tFOrNPIfk+KZ
         QJ+gj8RmO4L5NuAEAzza4hw8rhut18GhtV8Ly/g/WBpooPj/6NwU6xBDnw80Ckd5G6ve
         VXZt5/RCeb7O3FgdrnrSdlNY43itr8mKIQ0pgzGatB6fupX0s/gMA4w0v7mex+JTTboz
         j+1aPEilsC50bLGv8fQFMa5e+cQxkb000HqIE5TCQrQIdjst7+4MOR2S8k3tNMfw272O
         8NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783248; x=1747388048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJm98Jl9ofslVtnTO+qJZhQyNp2+8Z6clTV3t0I6FUI=;
        b=kFUNc0FNSMpwSttJ0MtuhyEGBZA2r6hc4wRg0OMEhmN56uUCdbZrk8sNsi9NJCiCl2
         qkLGSqG7xFSssFyWNJCagAJDnLkNSGQpE/76wFg6t0J8kLZdV8Cl5nr9p8925MEsJad9
         lOsGjIHGqxxwudn4wvvOnjqCm2O8sZrmzWMIj28okURTV7ZblUZt32FeMD+0Cnbfb8XE
         uTsRTVnr27Qupey7l362J04dvfFQbMtfhRSOZGhg+GQ3bBzdKQLHAxhvtiTp3Q+NZP3N
         V00sOaZXfjNb5mc2ygAxzRlMLAmZmZWPSQhA7RgdInjCk1MwAgC4BlFpwPR2ZvGxfusU
         CmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCu+5Rdd7qCNB1SAjSQfn6E/WLCyygGr4i9aO9PPRlfKtFPiyogya3ryJ1rcTzYDCy0WbD2g85@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy6uDNixUVaO2VWc8iXWbEZL7iH2VXDyaEoyt2gNVIen920hS1o
	XDX1B0vJc2oaV762F7peBdEs2giGxzqTX4h00efz6UQuXLx4J1aekkWeUXfq+4w=
X-Gm-Gg: ASbGncvVXMsTsr2ESE2lG8/J0oPvuT/v9JFj033eg4xnENT2flW1RoHibFtTHH6JaV9
	6Gon6W7VE2iRY+JctD+Pa6mwvtiZezmO9GPnKHYR9O2aPL+DKPcziI552CcZ5eR+0sjq99Z/P3Y
	N8r2HvsSSyg5C3yP3FLZxQiu9VI9m8nfZptOcBG5s9ltmKQbtLp5a0B4kldb0011X0uuVgqqxpM
	eFyaIeU3+sK9oUMhBBcgQXT9WIKVtuwHUn7WA5MpW/JAfdScIYAF5f1BUrA2Blgc4t3jvrGt5GM
	+9xSfnnkkAuTq4SJGqsWJhiRcoCclxMfmdAQbOUDsRbj2riNfYyiNzzYJRga9UdKhak0mg==
X-Google-Smtp-Source: AGHT+IFGQZyQQ9kD0y5ZKScYDHC0O8tZyA9vHZWAiHgkyRkD6/6qd+mgIQ5gjrNKw2Z6l6J82DiFug==
X-Received: by 2002:a05:6402:2396:b0:5fc:a51a:9c03 with SMTP id 4fb4d7f45d1cf-5fca51a9f9fmr1137263a12.0.1746783247978;
        Fri, 09 May 2025 02:34:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:07 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 33/34] arm64: dts: renesas: rzg3s-smarc: Enable SSI3
Date: Fri,  9 May 2025 12:33:17 +0300
Message-ID: <20250509093318.4014916-34-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18850

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 558a25c2ee3815c3d59d4dd9440a1cb3a78d20ab upstream.

Enable SSI3.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241210170953.2936724-24-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index a3e0d995a58a..12cd3772148b 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -67,6 +67,10 @@ vccq_sdhi1: regulator-vccq-sdhi1 {
 	};
 };
 
+&audio_clk2 {
+	clock-frequency = <12288000>;
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -95,6 +99,11 @@ da7212: codec@1a {
 };
 
 &pinctrl {
+	audio_clock_pins: audio-clock {
+		pins = "AUDIO_CLK1", "AUDIO_CLK2";
+		input-enable;
+	};
+
 	key-1-gpio-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(18, 0) GPIO_ACTIVE_LOW>;
@@ -152,6 +161,13 @@ cd {
 			pinmux = <RZG2L_PORT_PINMUX(0, 2, 1)>; /* SD1_CD */
 		};
 	};
+
+	ssi3_pins: ssi3 {
+		pinmux = <RZG2L_PORT_PINMUX(18, 2, 8)>, /* BCK */
+			 <RZG2L_PORT_PINMUX(18, 3, 8)>, /* RCK */
+			 <RZG2L_PORT_PINMUX(18, 4, 8)>, /* TXD */
+			 <RZG2L_PORT_PINMUX(18, 5, 8)>; /* RXD */
+	};
 };
 
 &scif0 {
@@ -172,3 +188,12 @@ &sdhi1 {
 	max-frequency = <125000000>;
 	status = "okay";
 };
+
+&ssi3 {
+	clocks = <&cpg CPG_MOD R9A08G045_SSI3_PCLK2>,
+		 <&cpg CPG_MOD R9A08G045_SSI3_PCLK_SFR>,
+		 <&versa3 2>, <&audio_clk2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&ssi3_pins>, <&audio_clock_pins>;
+	status = "okay";
+};
-- 
2.43.0


