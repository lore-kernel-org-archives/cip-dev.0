Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B15C41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:12:07 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web11.8597.1716970317835745973
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bXMKIukn;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-529682e013dso2089033e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970316; x=1717575116; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+R7AZabC2j7Eqa8GxbK2zoq/iJA7/S2Tp64qTSI1+w=;
        b=bXMKIuknTaVfQVsboba53wgNpqjmqDLVCGsplf1Z0RDlPsxH4+WRg1Q+TPkN4MsQXH
         0M9SGONOcptWTA1WJDP1qqOCPn6yuDBhnU1cSxJ7CatZr9HyTiZ6XrL6u4lfpr9fWom6
         LYSxDtoQgzZ8LUnW2YzkVvfeBej589kxr21bm8zkhS4+Hok70pMHMMvHVxd0rtpARez/
         x8rhNr7ALAYyHNJ+KXfxNOZ/Jpa3M/ozPaOhvgVkgB6qaevE+gNXWbQK3tutS3HJ0DIu
         fvMFhrjd3p3CNa+otlgoaz5xauBw9Zp55T6/7jQAUENKXfXN5Q8Ehzh7q3Ha+jIE26gI
         PC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970316; x=1717575116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+R7AZabC2j7Eqa8GxbK2zoq/iJA7/S2Tp64qTSI1+w=;
        b=NPocHoGO9JpwLza3TG801ePJgFGsdtXkUp/Z7Tivz42x7moQ99FznxnSOTiACdnyfI
         ePIalXeQ5ZEe1qkVxyGoos4c8Mza5YLsM3ETBaBeL154CzG0KUbzqeDrnHtkNwATIQac
         SgHtn6WtYp7kAImH0kCWjk582y270dhGPlYVM79A8/cbv7WsdMsuDfXjW3R5SaU4I3Vs
         rYBJAjvkYF5xoeEIseWVK4mchE31mkDZl83WIuBabDtN5osqnMwSk41HD6vHDZDaD3SQ
         kEMahiHAzt0TyuK/IuTQEN9gkyF1+vM56JkKUp53OsBF9K6K4YuQ4DKJOV6eLKp8hq5V
         AEeg==
X-Gm-Message-State: AOJu0YyovFsFk2sL7t3y859HDnfGl9QV1H5N01I4UiVcPx2sc771j/4A
	aMx03il3lpqfZPJHRlS+3rYTy79TYZm2CeUDM4wXFn9TVmMSOExfAcwL3wMjsG4=
X-Google-Smtp-Source: AGHT+IH2ZrFI6S8EXAUQ6nREcX6S6jFGWZklQl6fg/DWer/gwEcFVZ6IH0+xzCc7B7/+iNKODLSl7w==
X-Received: by 2002:a19:f716:0:b0:51c:bd90:e60b with SMTP id 2adb3069b0e04-529649c5e74mr8563290e87.25.1716970316036;
        Wed, 29 May 2024 01:11:56 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 45/47] arm64: dts: renesas: rzg3s-smarc-som: Use switches' names to select on-board functionalities
Date: Wed, 29 May 2024 11:10:37 +0300
Message-Id: <20240529081039.639010-46-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:12:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16025

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 447765986dbfc321e37b13d7c276b106a469ec0b upstream.

The intention of the SW_SD0_DEV_SEL and SW_SD2_EN macros was to reflect the
state of the SW_CONFIG individual switches available on the RZ/G3S Smarc
Module, and at the same time to have a descriptive name for the switches
themselves.  Each individual switch is associated with a signal name,
which might be active-low or not on the board.  Using signal names
instead of SW_CONFIG switch names may be confusing for a user who just
playes with switches to select individual functionalities, but also for
an advanced user who looks at the schematics.  To avoid even further
confusion, use the switches' names here and instantiate them with an
ON/OFF state.  This should be simpler, even though the name of the
switches is not that intuitive.  The switches' names documentation
reflects the switches' purposes.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231207070700.4156557-11-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 01a4a9da7afc..f59094701a4a 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -9,23 +9,31 @@
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
 /*
- * Signals of SW_CONFIG switches:
- * @SW_SD0_DEV_SEL:
- *	0 - SD0 is connected to eMMC
- *	1 - SD0 is connected to uSD0 card
- * @SW_SD2_EN:
- *	0 - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
- *	1 - SD2 is connected to SoC
+ * On-board switches' states:
+ * @SW_OFF: switch's state is OFF
+ * @SW_ON:  switch's state is ON
  */
-#define SW_SD0_DEV_SEL	1
-#define SW_SD2_EN	1
+#define SW_OFF		0
+#define SW_ON		1
+
+/*
+ * SW_CONFIG[x] switches' states:
+ * @SW_CONFIG2:
+ *	SW_OFF - SD0 is connected to eMMC
+ *	SW_ON  - SD0 is connected to uSD0 card
+ * @SW_CONFIG3:
+ *	SW_OFF - SD2 is connected to SoC
+ *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
+ */
+#define SW_CONFIG2	SW_ON
+#define SW_CONFIG3	SW_OFF
 
 / {
 	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
 
 	aliases {
 		mmc0 = &sdhi0;
-#if SW_SD2_EN
+#if SW_CONFIG3 == SW_OFF
 		mmc2 = &sdhi2;
 #endif
 	};
@@ -50,7 +58,7 @@ vcc_sdhi0: regulator0 {
 		enable-active-high;
 	};
 
-#if SW_SD0_DEV_SEL
+#if SW_CONFIG2 == SW_ON
 	vccq_sdhi0: regulator1 {
 		compatible = "regulator-gpio";
 		regulator-name = "SDHI0 VccQ";
@@ -85,7 +93,7 @@ &extal_clk {
 	clock-frequency = <24000000>;
 };
 
-#if SW_SD0_DEV_SEL
+#if SW_CONFIG2 == SW_ON
 /* SD0 slot */
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
@@ -116,7 +124,7 @@ &sdhi0 {
 };
 #endif
 
-#if SW_SD2_EN
+#if SW_CONFIG3 == SW_OFF
 &sdhi2 {
 	pinctrl-0 = <&sdhi2_pins>;
 	pinctrl-names = "default";
-- 
2.39.2


