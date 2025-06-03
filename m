Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793F3C61CE8
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:20:17 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.7118.1748942416656746692
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:20:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Z7dELQbN;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad574992fcaso851699266b.1
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942415; x=1749547215; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oV+j7m33T1Q0DgTmCkFhKLtTOMBcT4xpvMI4fefkLrA=;
        b=Z7dELQbNmlpsWtxpA5MuucebDNJXLpRpqhKqOzEUUE2KNbO56Hy4Tp2sC+9d5H0ZbZ
         KCJ/DHivA1wCXcO1YH9phlyPOCuohkwOWQsPlWKWDrTm/gGmMawmEq6pjiFoNwhJJKWA
         TXcub0z6gkOjijsawXlY9d9lhvKbRRO8qgPRrGARGl/QKFssrre4CUFBY08ixdK1gEY8
         URq6a9acsqRw5vjprYPRQrzK5jWb+F8YAzuD/mqry6iogq7+k8HPcPLBH5mMm7LpjdKN
         AzZeN3nZT7nARfHUf+w/uXkQfzWxImnWRNw99TG4NcHYAlW5Tr7ZsTv7HAlHEB1PR2pO
         9fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942415; x=1749547215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oV+j7m33T1Q0DgTmCkFhKLtTOMBcT4xpvMI4fefkLrA=;
        b=Avk8VQfrWNGkohrkJ/3wV8Kp97Xhw+zcptf6Ap+EgOeHTrdIJRfqzA5jTaALZqtZQc
         GoCTn69/LRNyvg8BA9qUJJItil+WZZsQj7XiDwAgUejHi4abUXid6e/3t4c7+EPF4HzK
         KMX58LJ32Au6qWKwW6wOgalQqhYWwEFVuy3vBjDjp3oIuLxLtUpih1mKef99rvWTnfCt
         QoVG+REg8ijFuzgPlsKczOv8xRKtiOd0aLVULweq+aiyNeKUD8hqfgfyLILL/8lYQBjb
         UtTc2E856hnZ1UqkmiQrD2OXKSkg02baTHIDc5M3q7BtlEwOffLGMU4buvVk5Ir9AMOt
         FC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWn0MhrvdqTPaKjPo1IPP7hLtyAJ/bIgP9aXIHKat2CfBh0BhuHROMToS1lPtgwC7mEY0MBCiEC@lists.cip-project.org
X-Gm-Message-State: AOJu0YzlWQ70jBb16ROVl8JTjqW9d7mf++FfA5YymUkzjWZjRB1XXiAf
	54pzKbsNLxhIjT7sAniEqgSO9Moh5dYEwxDZkM25i3URA6i80NfA76LXOHaIVof4bGAusE33Dy9
	aMmAb
X-Gm-Gg: ASbGncvWLU+CZshzlslOQNvt942zNXO08GvO5++BOXnvgaCza4VG5Z/mn/67hSWp/bq
	ad/sX38FK3dFinh2me6AyBEgDuZxZWB+ydrwVMil5Fi/gXQ5ZfnTIGSrCg687vrE3BeOYg7b7ED
	nJpJ8bn0vBGki53bLogBCvXQgFvYpSOoL7h1LLtxxGKzoiKD245JbFNwd2MGSiaYl6jeY7AiDi5
	3k6KZElpZX4XK0CXYWwRGwdDQORE3CZq+L9SJwSQhLNKSlev/wfM4jCGAY5ZuYNCfdSNCtIiNOL
	05y1LlNYVYl1t8dtJRfcPovyqj3gcvGqMPrpO1TpYmddSzZSKTH7mq6U/YA85GbJV8nrzwOPHst
	OtMd4hUnmKBpcdOZw
X-Google-Smtp-Source: AGHT+IGJH+hvWabFaIgMvhAVrv5iJtCAN593U5FulYcrrvGLtpGbNL0FR+9nTfywolJW7C+HH2NsRg==
X-Received: by 2002:a17:907:fdca:b0:adb:2bb2:ee2 with SMTP id a640c23a62f3a-adb49547cb7mr994543066b.41.1748942415036;
        Tue, 03 Jun 2025 02:20:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2e220548sm817017266b.109.2025.06.03.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:20:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 6/7] arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
Date: Tue,  3 Jun 2025 12:20:04 +0300
Message-ID: <20250603092005.3917850-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:20:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18989

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


