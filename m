Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F5C5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:57 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.6985.1748942391734555893
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XiuaiCZ5;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-606a4af1869so1325562a12.1
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942390; x=1749547190; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oV+j7m33T1Q0DgTmCkFhKLtTOMBcT4xpvMI4fefkLrA=;
        b=XiuaiCZ53E706T5TujSbFtVeGBTK11B0mtDLJLORoQ2Tp0TdKuukbOkgbOWvySZdv7
         lfR4iKcoawZQhnvc4QpG76fWAh5/Va38Y8LUKjENw9bsaRGyZ/94G17awoeACi0aeBaA
         hMk24tuksDDcZdZwCLYO5ElEc/QQQmq7Z1uuguYk5/Ok2GoHp/BiZVGKfrB3K+acfJiy
         r192loMD55U8p3UXfyr/fwtGb3UYmm+IJIZGwEO7VKakJyZVpiBGboD8A9v/wAs5Kw6h
         758uKkySa5EnhMg4QtwtgKcCdbLwJ8F0ydFnlSCSzNZ3JtPvtNI1YJI5RNu317p7ZwVa
         PQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942390; x=1749547190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oV+j7m33T1Q0DgTmCkFhKLtTOMBcT4xpvMI4fefkLrA=;
        b=kjoApBeZSK6v42NyqPnOgq+gHStzC4C0Lg0ueIDdTBZdFDZ866eEFDaPq4/m6wXj11
         HqHTu+XQ52qWrGa0EUkylJPo9KW+wsV9xQ/lAEUJZP1i7G68p+BKmRV9h48fguHSpmHu
         NVULde8Erfmhb77QSKW4jIwisHEOK4XsJdPf6dUNQDbQeJDShNlUWPtaJHkUW4hoLr53
         rYOhGJnKQyeW0boi8YP9FkFn5/rUO5SzDw77xs/TYkW4uyACbVUYeQQM2GJHk7p0nzzb
         clMXKmOlNvrpNX6k2KoPhtVQzNVasmcgIt6bUTSoeTeOX81fq9NBgh3VD2IpSG+rKGdv
         v/xg==
X-Forwarded-Encrypted: i=1; AJvYcCUp7Ckw//Od/IbFmJc+J29X1ef5H+gyz4lZucTwFERbkgVkhVoxSFiI7hMgfAOkn5nvZm6xgxOG@lists.cip-project.org
X-Gm-Message-State: AOJu0YyNjyvF0VelS2dwT7GCG3oxUcDsfDNM45HVZUIYTVpryOOVNULq
	dZHmGhKUroSk0Tp2vxA/H7ES5nbead+JYJ4dtnJ/0fUFRWZp3nUO1gMZsYncTYSHqpo=
X-Gm-Gg: ASbGnctVN4Wl2L65o4jvWw7OeAfNWosRnlA8tyb6ik8jv0m+Wns2CKOuDhABiYo7ntU
	2dlBqRAtpLcRGb2SHaYf7TPOd0muk2OiXoiNW1p5avHyqZmuTNDzYqrCoIO0UuH+WjhqyRX4E5Y
	ZJOcSDG/oBFco362zhI/Nre22LxDkziQ49hFl7WZwVwoVPjP+4bAcl6dOUza5RW97rFbJ/fiqio
	Oe1wWPaRl7/Y/uY2OL7F0hjA/XX2UopzzYKIIX3nS3nyLhZ8a3inc6wjMuNewH28Ntx8ItIOrVu
	4QyqEadhnYf76HI7EQ33xCe1MDNG2iKOauiuZj1CQC4AU0Gf7OUAkNufjWB9/ovLlmu5az5Z28s
	sTJ1XWg==
X-Google-Smtp-Source: AGHT+IH7BkT0CkGP7mj2j0+JQTloAp5dKlbMC5J3qOUVd6LSYeXYsXj0nf1wy6CzfBINN25Ev4D3GA==
X-Received: by 2002:a05:6402:510a:b0:605:878:3557 with SMTP id 4fb4d7f45d1cf-6057c602f61mr14059728a12.16.1748942389925;
        Tue, 03 Jun 2025 02:19:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5c5casm7301944a12.25.2025.06.03.02.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 7/8] arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
Date: Tue,  3 Jun 2025 12:19:39 +0300
Message-ID: <20250603091940.3917581-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18981

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


