Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898E4C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:45 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.10430.1746783335390419864
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hVx4Cm5B;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad21c5d9db2so117533466b.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783334; x=1747388134; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEBj5d87ux2Awn66tt088YNHJZJ5WQlQlrf42ZtGcNQ=;
        b=hVx4Cm5B7hZcK4OZwEPvbAwd+aEM0J6guBYvLZ3jU20kNuz3+5xN5LRTt/apxekmeI
         2X7l7mQZGYOottU17F+LGCD2PeqB9IKmaFmkQ7jaXyCxE+h/vXXK3Aet/EWdshkulOE5
         R2fccn7wEwAjPusbmzGRNemlE/5QL7BIGxvepmpQ1z5zSuOM00q1ovjS4C3eXJKEeRjO
         7eQgjt9X/zolWPal9R7ef/m149Yr8WXTVyUCUScqj53m46WZH9w/J3kOCwIHq1UwoYZx
         pby5M//EXMKskcg9546lYUl3MX2WnZd5FQuPBgIjSoq9HanHTm6Ol+mT9xUErOhURRnM
         5SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783334; x=1747388134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEBj5d87ux2Awn66tt088YNHJZJ5WQlQlrf42ZtGcNQ=;
        b=cAtDk45pP2Lj4bKgkwDOt7oLoZ1dP6aUiWKPWu4M5w6OHMR/DOtdbwheJlSTB5X4XB
         RzEmzqpyB0oJuDy9a6diiQ7NZiAAdtFtSPqgWUuKMZysQdwbqwiH6m9ZMj0dW/USlTln
         8nJ6jX6rWmIVlxtKB5rsBiTUk+2Bhmt7TrPdE5D+lLNE7fUYwCN8r26a/uB/vvg4IPh5
         eD1cuiY8LrrvLq7axczAtN5cJjG6RCa2W8F3Lr9PfxJn4LexykGX/6sw5M24YsTaom79
         vZbtL8ShUKoTFTUm/BHKJA0yfmyrKJuHbrVo55wAxqYh2tcjDzrSvgqmKk5hRBoMbEow
         BMuw==
X-Forwarded-Encrypted: i=1; AJvYcCUkW711/LOf15cwle8InhcNsvFvzL857NsPFeBGD/itLbiUBROosJ/UQ8v4faia3idd/wvz4EaG@lists.cip-project.org
X-Gm-Message-State: AOJu0YxKHxd41xIKyfzhhTb8YhTfixq+4RG7Z3gcVFbrB6reV0Lc9Ash
	S8U1iVSD5cBy9lLPd+J14K/KGIcEkqoPA5bJWYY1YzOlo2LBG/pfJhrU+K1B65DAmFNdXtoZEb0
	m
X-Gm-Gg: ASbGncuHWhZUnt/3ZaBWTD3hluOwIFBuKof2bWwPoS/fUjG1PNlEglRVxxfVjaxFq3P
	kv1TQ00YS/bV8P4/EpDtSg6DunTMtyU0MbSK/EG+e+iCVKcfwFTfh5ynEu1mA1TITNs5gkER4f+
	zUkNTtqipcxoZqHxOPht+0lGhhO1+H84ILKqTBaRD/K0oo+Y7ZSzaRon5KdYTYgahE9Xxuq+Iho
	c11XMhlge8WC2OuFvwjBsOw/KqahfGHMws7cNmjBrH9UbDL3E5r2Jd1YF/VeTah/5ydqK/hxDFr
	njLRrxQ6F4AlFqocnq28kd9CFHCp/rb+jEtbKBAzzDmjYnd5rwMsdUYt1N/rbnYD+96afooBmph
	696hk
X-Google-Smtp-Source: AGHT+IEfE5S9ZP0Gs0G1qLHFFTGew5U7OjMbG007cLR5vntKMwqqtGwhkeK0rECtgWad/FUPoDRRCg==
X-Received: by 2002:a17:907:a08d:b0:ac6:f6e2:7703 with SMTP id a640c23a62f3a-ad218f2aac9mr189208266b.8.1746783333772;
        Fri, 09 May 2025 02:35:33 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 34/37] arm64: dts: renesas: rzg3s-smarc-som: Add versa3 clock generator node
Date: Fri,  9 May 2025 12:34:39 +0300
Message-ID: <20250509093442.4015145-35-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18886

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a94253232b0454ae3f45e2a941bbc0a1d5bdb955 upstream.

Add versa3 clock generator node. It provides the clocks for the Ethernet
PHY, PCIe, audio devices.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241210170953.2936724-22-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 0f8efaeb163b..5f5c6b23a504 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -92,6 +92,12 @@ vcc_sdhi2: regulator2 {
 		gpios = <&pinctrl RZG2L_GPIO(8, 1) GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	x3_clk: x3-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
 };
 
 #if SW_CONFIG3 == SW_ON
@@ -154,6 +160,30 @@ &extal_clk {
 
 &i2c1 {
 	status = "okay";
+
+	versa3: clock-generator@68 {
+		compatible = "renesas,5l35023";
+		reg = <0x68>;
+		clocks = <&x3_clk>;
+		#clock-cells = <1>;
+		assigned-clocks = <&versa3 0>,
+				  <&versa3 1>,
+				  <&versa3 2>,
+				  <&versa3 3>,
+				  <&versa3 4>,
+				  <&versa3 5>;
+		assigned-clock-rates = <24000000>,
+				       <12288000>,
+				       <11289600>,
+				       <25000000>,
+				       <100000000>,
+				       <100000000>;
+		renesas,settings = [
+		  80 00 11 19 4c 42 dc 2f 06 7d 20 1a 5f 1e f2 27
+		  00 40 00 00 00 00 00 00 06 0c 19 02 3f f0 90 86
+		  a0 80 30 30 9c
+		];
+	};
 };
 
 #if SW_CONFIG2 == SW_ON
-- 
2.43.0


