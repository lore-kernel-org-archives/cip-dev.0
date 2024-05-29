Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A91C25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:38 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.8740.1716970528237232882
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SiEox9A7;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42011507a54so3475035e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970527; x=1717575327; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+R7AZabC2j7Eqa8GxbK2zoq/iJA7/S2Tp64qTSI1+w=;
        b=SiEox9A76Kyuu0e7Z0H+qrClZC7fxK6/r126Txd2pGXHVVRZ0c0J/TDjF6RtgYqhT/
         djxlf6VgSId6O07K6aOma+YMgXx5fN+8IetLPXgpHe9/d1Cr/l3YEgu/MOHX1mOZmzM2
         BQgUanmDVhb0d+Ai8duSrSgx88JrZCItSGOaNKZR621AUB7OEG5leXof4hVRsAOmnpKz
         v2g5moUE2aW0La86wkjVjgw/ZcXtMmKKf/aMEw8TvtbKvWynttEm5wv/eUYBokDc+lVv
         9+8bVyq+Ai/j6hljzk1j+V4xyj/gD7rHZOQk/u8paQ3mp2P8Fyc9KDsvLPT1KtWBz5qs
         Zf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970527; x=1717575327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+R7AZabC2j7Eqa8GxbK2zoq/iJA7/S2Tp64qTSI1+w=;
        b=nusrqXdmoFXe7nwy3ZU0krmKX1z7opkoyGwAjLLlLRBU2OUoAR86aVAOY2bZVLMl/l
         Dk7Zfr2RA3V8NMMxIZqnw6R6NH87yEN656cVCJ05BGtug7B33Kxh50T7+IxeJSsRFVzX
         ErW9Vn8M0DvAgJKQBAq5gS7TBa/JhQonopc5nEQY/r6DoXSLUvO3XeaAUpnhd1ZFPFmb
         I7AzswHNqNobCVWVZt47O3dLmQ5MmdznxrOh1OYIx3/17MmtOfbe9SPmPuMpHD6VIZcR
         qxipwQMnHezXlNA6JrlyYN9wntlIiMsYXE+l5jXo3aTf09QD2NX3SwGAL+nD1aIK5o+R
         6yJw==
X-Gm-Message-State: AOJu0YyJJWuXnAFzjfr3svLZE4CWnvCEl0GdRgubHqMLWzjaiDma+khn
	hu2e3jhkVDf5Eh6MnDN+l76puPQNOMXnMAtfflKq1+vr0uz2VXv9SK82K7RmYNnkN4ZLylefSIt
	rJXI=
X-Google-Smtp-Source: AGHT+IGY14JxJdUbCkwxWF0bv7DgWc14qu3IFrqe8167ikXg4OX+uDW6PdHaFoLMV1kt0/VlVZJaOA==
X-Received: by 2002:a05:600c:5103:b0:41f:9edf:de50 with SMTP id 5b1f17b1804b1-42122b274c7mr10331625e9.15.1716970526726;
        Wed, 29 May 2024 01:15:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:26 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 31/33] arm64: dts: renesas: rzg3s-smarc-som: Use switches' names to select on-board functionalities
Date: Wed, 29 May 2024 11:14:32 +0300
Message-Id: <20240529081434.639519-32-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16059

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


