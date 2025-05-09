Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55B8C3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:14 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.10389.1746783247196551101
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rcnwDa4E;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so3013245a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783245; x=1747388045; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEBj5d87ux2Awn66tt088YNHJZJ5WQlQlrf42ZtGcNQ=;
        b=rcnwDa4E/vUghMDgIUIlljSrBzdLHKoTHlqVlcdvuUvIJvoCqvqq4P0EtNdMpM9C6I
         CQnuPVT3E/yVuxEKjyky6KnaOlNAaFQg9dtRQKoNQC9Q20F4JGx4A/UG8sGBAfcn2HQD
         pC/IQ+PZPiI63vdcBXRXRQELD9DO8uJYmPFIJRmqguVMC+R8Rp3CuvJGPc3Ge/e5XlG1
         4AqVhJZ3+ZCLz2VCWdEHuu98NLH87CM2X0VUaJNz7jT1wvWJVt2Krfz02Vvz7EzTv3Wx
         TraxddAzFT4UjEBz+Gc5r62yugdvOpHTAm012kW0mrzU2UlGFtoFf5nrO0sXwtzG1K1H
         xpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783245; x=1747388045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEBj5d87ux2Awn66tt088YNHJZJ5WQlQlrf42ZtGcNQ=;
        b=VZCq+zIWDUVR5s81JjpDZBcRlN4V9j0RGD7pBp4BUFwOmnYIouiWnYZr0riaTW99xr
         JnQpTx/5jKnilvhKLghUeI9RhPHYEVP1lOnFMLycC52WT5lTP+Iydxs0ZULPQ+LnomCO
         hMy6audTDq1DaeXT1/49W//aQmRBTUpQF9HguH5KG7Fokbdo9hVirI8ikp39TF0tlBD3
         7XRYiX3ZGV7NHJGD99XvZljfod4OeeOq6msAEHAnXji3nqbFiGG24bdNwo51+fn8bWrV
         I8I/jLRfDkXf4hMcWDRuy69brUt8jxl4wROxqRmLrykWsdOGHXqZAMr/WDssJ4PW31lr
         aPmg==
X-Forwarded-Encrypted: i=1; AJvYcCXbFVpuMUtUe1unbDHnvhi1sFmmZ+zvgfxeavYMi8f9KMExhwHWzEFguU/AzomAn48mWAfTMt/s@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw//zj4ySrA9lbYfXT9zF2KuwmQtkJJSAJLokl6Zyrqc12dji+l
	ta1RQpc6+x1mG40c+ehFLkgTlWgvGeJbJktup47w+CeNFp3Di4psKf8m6YIJuXo=
X-Gm-Gg: ASbGncsvCQjT9DdtogBOJ0kh0nFTwPYWxATgNe7XAna6xC57s/atBQGJ93ufMDGId67
	o65jT0w4639v0M49/owXqob7ZvSSzdxoQqSLIGFAH2hBHS7NcIm4cggMh83nbZjAQOxXmHsMf2q
	TXO8UpV0gaGo4USj0E0XoXvS+8kL04s7Go7WZPB4UpXLvp/wJnTvjpY6iCg+0qu94hmCfx7jCzk
	JEuwWeb3PCrLznZzvl559EYj7f18h2U8gHhDowwFezze9YAmNAUw9HjcIFWvqc5kBX7mHp42CBS
	SJNH6Mmh4CfzLF8c2y/UKMf7IKgHMOhvLpR/ftq/4yoOtbCnTsYUzcKseo1/4tFtbs75Rrd5Vms
	RfCbj
X-Google-Smtp-Source: AGHT+IH7xWnrEfOxh5nr84XtPdcLQjXf6Ytbcuwtx9eQtTjz3aofCENkSwarP+tAmeUOTSqWpUZQJg==
X-Received: by 2002:a05:6402:1ed5:b0:5fb:fb49:9d07 with SMTP id 4fb4d7f45d1cf-5fca0730817mr2077602a12.1.1746783245583;
        Fri, 09 May 2025 02:34:05 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:04 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 31/34] arm64: dts: renesas: rzg3s-smarc-som: Add versa3 clock generator node
Date: Fri,  9 May 2025 12:33:15 +0300
Message-ID: <20250509093318.4014916-32-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18848

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


