Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2CCC61CE7
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 10:24:01 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.13342.1749032634369170658
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 03:23:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=T9NJJN6c;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6069d764980so1569923a12.0
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749032633; x=1749637433; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51raNVnzH5ZC7Tx9v2KIkIWS4UINpp0KCaspGeSxpFs=;
        b=T9NJJN6cSv+IFDzUdxxbruszFrvsX53U4w1RWGRZn0VHIz5bxAzy8PTV6u584kJrWa
         Xf3MNq28k/o8WJSOBYrNADx82GGRFm8AFZJjhiEZvvDev4ohEKtty0VimniFi62/oxaZ
         oMGSyO46PQ0w9eVE1BsNSgeN5ezZfVjSzFSYeau6iXrnLDlEGMbGNHQj8BpVAfWkrc2s
         qXmFaaTbLUDP3zikR1LKPQp6fsA2d/mfvG2YsSxhaWMWe71c/wwLWOHtzyTc9qzIfCG3
         bZCfQKVDIqtqvV78SqHAiL5zvfDimb9EmGc/x01d7e5Xld3XwiQxVfs1w0tluaxKlLbQ
         W5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032633; x=1749637433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51raNVnzH5ZC7Tx9v2KIkIWS4UINpp0KCaspGeSxpFs=;
        b=rQAIEeg/fEFboMEYodNRtXttFMyzxHrWcoSwCSFd2lWaRrg9/3ENxYqoeq1La5nfsc
         weoIg89dNDzQALQqswGHQE7gDyDAyJ6LGqAEFnfwJkKzLKxYLWn0q28EGCF/GoER+0lS
         NK+9CNFT67aJaWH/aMulHQxO73vQUEidHPGozk8wzeGDvw/VOFzfDufJTvRhQf8ZwFbD
         sE1VKpH4UWgjhpKgmvO3Pf1M3zniG/uYPXW2HYn61AYUeOHjFjZIyrTpaTfmyBVkYXgw
         OTMl4onIOj9a3ITdVE/qo3eM6HdKu1WzlevAEv4F5QphrZGeG1L+9GyxTh8dFSMVfUD6
         ai0A==
X-Forwarded-Encrypted: i=1; AJvYcCWr/K/rGVvPveg1e9nPg3ELHQ35LgBjDW0n+84JCM/sixPWZEvMeAZgWeXymuPowALs6q4yA45y@lists.cip-project.org
X-Gm-Message-State: AOJu0YwHkoQHTQlIlS8/V0cpJhWEC02yIbMRvggb73/F/z78RwqfBPzw
	z41fF9KTUFzmdKsb6UYT8PLmueo5n+wBCskDMo2i7wom5iS28LeK/SPNn7+GlKj0gW3IHP2LJ1d
	UKCRn
X-Gm-Gg: ASbGnctg1GuchWDWo1NSMJfurozHdlT9TJ4WWB/e29d/tBMe/ACmkwTgTfB4eA/FIWW
	ofF3KnbwG+lgjtd3lRFf5NyJzc6wmk7v1qLjBOwfnf9azYuOuCWx5O88bYxPd4mg7ZDlgl2mhgD
	oMnhWkk7h0DCFa0izKLCK405/hEK//rglC2IAy7Wh57Zz5U2fDAhAID/VEXkCTk/D4BCGF2N3TR
	5S//HE3IFEzDI13fbxnP/B9agEjJlxvCtS0/A4aZzAeO4WKPYd0ID+BvpNaCsHL6dh0s4OP0CUZ
	ABbhir4fdAkcqzYP1q2Q+bKEZDAWDKPAA1CSAqcuEV1lPEckvcOu1OYZsls/ktHwIKDmX6PI6Jn
	gpn3rC/EUbVdRmAeK
X-Google-Smtp-Source: AGHT+IFEc1xSLw+EOfYa8Ebm568mCKuwOV7FvoaPNJHGtusE9Dxn8hGoOoNBoRHjPthER+tObfCikw==
X-Received: by 2002:a17:907:7245:b0:ad8:5740:9932 with SMTP id a640c23a62f3a-adde606b27emr636729266b.26.1749032632601;
        Wed, 04 Jun 2025 03:23:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e760sm1087375166b.52.2025.06.04.03.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:23:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 7/8] arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
Date: Wed,  4 Jun 2025 13:23:40 +0300
Message-ID: <20250604102341.2524186-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 10:24:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19008

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

Changes in v2:
- none

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


