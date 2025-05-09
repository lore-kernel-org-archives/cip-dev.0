Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA15CC3ABCC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:14 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web10.10391.1746783248499443261
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EHgwCKPj;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fc3f0a5506so3509280a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783247; x=1747388047; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ic3VWRg+Tx+9QorcnyOQSpel/Owgst1VfdRVhpveFps=;
        b=EHgwCKPjyphl5kDq9DCiJEC4Wbl7Dom+Dx9lmMDU/3H4ui0ZGKYrtdVwNreyRt7Sii
         enT52dYHzDfGVwonEU+mshnlp5oOIY6PB46zsrhpsHocuUrEwIMC+HqEd9OUz/Xz97kB
         sgrTKb0lwoEZwVnZaQNyEeo1Q/JQFyhgWueyZERwCJ17ztUssmfN4ih6jXDmL2YjZSfP
         snI1fTNnUtUGAGs+LS/CzMUyhvThhXv+bCw3jLI0W106pZL0pE52ZE0tlW9imJxhu4Pl
         Jp1eUaqe4uAks8PRtjcgdYqiKE901ZYf646EoXddrKvvm5Kef2B8dcGTkXl8JP3Zh5Xg
         ejyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783247; x=1747388047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ic3VWRg+Tx+9QorcnyOQSpel/Owgst1VfdRVhpveFps=;
        b=jC4rFt3BbEmkFpn7ryHtydn80NGL8XYljWinYc4BYhKnjA+n8dG9ahxGDmBnFye/V+
         xA3Ei4iSrZUfTkM1JupjoLlf12czpwepoGJiPdb3bFU7hyiQJpiCctpFRa3Fu9jnVqQ8
         VlQDpH7DD6jhBOjEsI434HinT3ehfUTXfOUeauaPzGuvN9qS5HCWxm3cb7iInP6sxbo+
         DG+M/WOAsLTeG7HHxFb60NHzwQyP6AWTIZUnuvuLiuAI6gxLpuvGgEUGW4a5ZQp5dT/a
         MH+H9xyMkPCXGPB03tttJ57C4YNmNt97tlZkPxFbxMoV2lEH7FFjpj/FvqqiIo1a8+xu
         tgTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9EnHxtlCXYRTO2B3ieNJblp6n38m/soy5Y9gbhoQ5X2FrZwsM5n94hd4nxW8h4tcIHWJT1eVU@lists.cip-project.org
X-Gm-Message-State: AOJu0YxKNijRPejlNp+RKYx2WTBw/h2IJg4DHkwyQ6NsCxCEHcnTeKF/
	EGii0UAlLghtBRiLzH7wpG18mKAFs+NrQXw4gDI0ZtoKhJuy7xwg2ISYNPnWobE=
X-Gm-Gg: ASbGnctpO7TRABkoXs9QiiFlSpeA7QqnTDufaJCDqrOE5T8y9+PdpYU/l1Md33qg3KD
	cph2UkwWcj7MYqn+ysRjLnCLZYP8H7kh/gGjB+tcka0aUFb4ltTEMZSrCkNEUbTt+FaEevplG8e
	RVsUcaXm+EkWnQaJypSSH1/Fn1Qtl+1u0MqQ+r0VJjEeNQQmfqMu7ZIM7m/TDf2BwxXQLLB8Zzw
	xVJbKXsvkuGDEpr8LJRSIoBzPO5ies7eEJrHyh6EIQjVxEFClov3f7aThoHwEk6VQcYKwouS9IF
	cDF2XnX1aycngGigC2hXsjzmDEn0IWBebKpWAAZihGb4TVHEQtIdq+Xi0B0t4VAon1TAqA==
X-Google-Smtp-Source: AGHT+IEzdgbaoftywlrbyG+rgzMU5sMD/3/HVNdpqA/BrcDc1XjU3TjO25Ac0tbxyXF94kWPC8QijQ==
X-Received: by 2002:a05:6402:518b:b0:5f6:2249:d424 with SMTP id 4fb4d7f45d1cf-5fca07ed756mr1976806a12.24.1746783246885;
        Fri, 09 May 2025 02:34:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 32/34] arm64: dts: renesas: Add da7212 audio codec node
Date: Fri,  9 May 2025 12:33:16 +0300
Message-ID: <20250509093318.4014916-33-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18849

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c3de00ac31f76b8e3af9f7a85c2da29c1b72babf upstream.

Add the da7212 audio codec node. Along with it regulators nodes were
reworked to be able to re-use them on da7212.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241210170953.2936724-23-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 17 ++++++++++-----
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 21 +++++++++++++++++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 5f5c6b23a504..4c594773c4b8 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -63,7 +63,6 @@ vcc_sdhi0: regulator0 {
 		enable-active-high;
 	};
 
-#if SW_CONFIG2 == SW_ON
 	vccq_sdhi0: regulator1 {
 		compatible = "regulator-gpio";
 		regulator-name = "SDHI0 VccQ";
@@ -73,8 +72,8 @@ vccq_sdhi0: regulator1 {
 		gpios-states = <1>;
 		states = <3300000 1>, <1800000 0>;
 	};
-#else
-	reg_1p8v: regulator1 {
+
+	reg_1p8v: regulator2 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
 		regulator-min-microvolt = <1800000>;
@@ -82,9 +81,17 @@ reg_1p8v: regulator1 {
 		regulator-boot-on;
 		regulator-always-on;
 	};
-#endif
 
-	vcc_sdhi2: regulator2 {
+	reg_3p3v: regulator3 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc_sdhi2: regulator4 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHI2 Vcc";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 7945d44e6ee1..a3e0d995a58a 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -71,6 +71,27 @@ &i2c0 {
 	status = "okay";
 
 	clock-frequency = <1000000>;
+
+	da7212: codec@1a {
+		compatible = "dlg,da7212";
+		reg = <0x1a>;
+
+		clocks = <&versa3 1>;
+		clock-names = "mclk";
+
+		#sound-dai-cells = <0>;
+
+		dlg,micbias1-lvl = <2500>;
+		dlg,micbias2-lvl = <2500>;
+		dlg,dmic-data-sel = "lrise_rfall";
+		dlg,dmic-samplephase = "between_clkedge";
+		dlg,dmic-clkrate = <3000000>;
+
+		VDDA-supply = <&reg_1p8v>;
+		VDDSP-supply = <&reg_3p3v>;
+		VDDMIC-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_1p8v>;
+	};
 };
 
 &pinctrl {
-- 
2.43.0


