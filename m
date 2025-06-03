Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433B5C677C4
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:17 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.6971.1748942354399212618
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RUxOMnq2;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acae7e7587dso768407166b.2
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942353; x=1749547153; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oV+j7m33T1Q0DgTmCkFhKLtTOMBcT4xpvMI4fefkLrA=;
        b=RUxOMnq2SdCxIARXkcf8tXPgWN9RU/lwlpL+25wltl6RXXM0Mu0XMPuT/QzREdhUxj
         yf0Kf5oUa8QIH452NXrgymEyFwze2pMTjIMHDoJk7/ksCUx6X/R1UuL7NO5BM5iouIGD
         gB9KTe+vNy5o2Wrh/YeWxICOOxyqNActCAb+P21162KfbitHaoaEK/P4quZUvApMlo7k
         Z8fHZRwJhC/oxQtos1qqRzqxFqN3yY0OoTi3aB6kpyGD/bD0n0BKRPWuflRdahbEAzdA
         gYJ3713Y7tWaWXlge7i9VgnTdUUtkrRW75RMCwOW86QzB+uc/lZkD65Y6UbXp8HkRd82
         CLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942353; x=1749547153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oV+j7m33T1Q0DgTmCkFhKLtTOMBcT4xpvMI4fefkLrA=;
        b=uNVXqY+n4x+1qorDJlUeXk5W8l9+42D3DqJt2MQXfxEnFZzbXrG/N0QYSPHaJtWtnJ
         ghDD5g6bGjBoXRoqCGoh+rbYsPaFc8mHkrLCcTVy24VMAiKzPl1bslIaaGGloQOsfnb9
         7Kw8V8GnA1tZ5x8vmHPX4UbxCrtUcHoEZ62k5pzWumDKrAa4+fiuwOS8bZ5OkYwDi6d+
         PuAolJx9MetnuzcrdNLhjd9GNgHI3tvGUD0t5rZB3o9izczul5V3BYLmdH9bdllyBCu3
         hL1WZcr7r1fEKk27GCbXwXebWQAT+9rOyXreho5ZE3ZPAJ/NR6JrOsHwJrKf2HI962Dv
         FSDg==
X-Forwarded-Encrypted: i=1; AJvYcCWE8jhyCBLhxh5puCoFUbg+ix30vYkbUhlS/mZYUPs28ydMvrBVTHZdhchrm9sTEUipTzVSddDS@lists.cip-project.org
X-Gm-Message-State: AOJu0YzC4dmra7NhcPu29L30lmdhNJ2OcvcbpvbdndpIcsA9nv7qsmWN
	gQYuZBlvEtsN60KihCG3n1OzmPxb2XecgbMrn2K6HRNSXWsYuReNT15HbDrlep+Y3V8=
X-Gm-Gg: ASbGnctYMvbl6RWDsGXOFNOPRwCWic3+TgQSfCws4WVR/W3jnP/iuLGmyl3/jeQBfnS
	uRcjjoHBxSIX0MxHLxsgXbLtTxvn1qJZnimIgdkDKy+L4oegqxtgxKMOEejh5z3B0tcuxcDo2Yd
	gl6GMt8733wyylgCi14fft1nlvaCE04LVNsZUofFN+drAgZq8rD7694kc/jTgI/c0O8jafWHg78
	Jbo6X5TeVIssjV/GM1ZPfT0hdhWyN3z5QVy724xf6yoo+Gs3P60WkGI9k9NS+I7dwOlE1nYcIjT
	Ob0ht6tpeALt5d1MLlbvVqo7veC4G5+8PTG6eT/J6q8CH5RxlurW20rG/OB/H2awed8sqJ6pPfU
	MeZ9oEA==
X-Google-Smtp-Source: AGHT+IFJRFdQ1TT/2mn19lfGT/fBu2aW8XohIGJwHUf8uMT5z6UFkwLl/fvDL65QCi3prfZwkgdvdA==
X-Received: by 2002:a17:907:60c9:b0:ad8:93a3:29b7 with SMTP id a640c23a62f3a-adb493cb68bmr1172763766b.18.1748942352651;
        Tue, 03 Jun 2025 02:19:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fecd2sm918093866b.36.2025.06.03.02.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:12 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 7/8] arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
Date: Tue,  3 Jun 2025 12:19:02 +0300
Message-ID: <20250603091903.3917202-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18972

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit ec32d57b4bbf27d91c55c7a258bdb87690993ea6 upstream.

Enable SCIF3.  It is routed to the SER1_UART interface on the RZ SMARC
Carrier II board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250120130936.1080069-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 3c810db81861..34adfbf2ec76 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -12,6 +12,7 @@
 / {
 	aliases {
 		i2c0 = &i2c0;
+		serial1 = &scif3;
 		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
@@ -152,6 +153,11 @@ scif0_pins: scif0 {
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
 	};
 
+	scif3_pins: scif3 {
+		pinmux = <RZG2L_PORT_PINMUX(17, 2, 7)>, /* RXD */
+			 <RZG2L_PORT_PINMUX(17, 3, 7)>; /* TXD */
+	};
+
 	sdhi1_pins: sd1 {
 		data {
 			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
@@ -198,6 +204,12 @@ &scif0 {
 	status = "okay";
 };
 
+&scif3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif3_pins>;
+	status = "okay";
+};
+
 &sdhi1 {
 	pinctrl-0 = <&sdhi1_pins>;
 	pinctrl-1 = <&sdhi1_pins_uhs>;
-- 
2.43.0


