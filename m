Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B433CC71135
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:40 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.7129.1749809792469458087
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SbeKaIvX;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad8826c05f2so357008766b.3
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809791; x=1750414591; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Bhs/8MG2abcQjmEjEFUoZtv87uzfkj79ialQChZF0M=;
        b=SbeKaIvX1UaSA7Lll3rbZM2lsQ1KeCne16Ggx2dp3Xs9KSq/31HiNxQPA6sfoJXNNc
         BOp5SXUDxoCGxd2jNX1dSUu3ycnAGfGzjxAU81g/71boadjqfcCc3hwimPRNb2IChhTY
         T4W+jo1kiSA6KV5OooqKH8OYY11DI5834EhB6uywmMLPloISI/3qRUtKQsbzlftGS717
         TgTd8y3QaF6BwoyKhlK/vWBtXEbWmfun3jdKZnJ+Gqu7Y8HTwRd5/kYKD0HsQPKm7KI7
         SQTKl4N5gqk5xY4E2zlkJwtb6GfoeYRc++yd0R8KmMjOeAY9yiZCF1YBgisTBe6BNz+8
         HgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809791; x=1750414591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Bhs/8MG2abcQjmEjEFUoZtv87uzfkj79ialQChZF0M=;
        b=IBehcA3/jLFmVZNs/Gx+HJ7x/DObdsVwfm0ET346MWn+ZWXRvBpGw1G0OmjRytKlfg
         6aAW+6jixXi35+RV0Q8V20eW+jNtTweRO8z7pp6FnBUu7udkYZ6EzSmRvIy7OI3cEreQ
         mymZQbpZ5i5ydbr5rqVkLHKdqCMiqQ0TkKaQ2Frq0MmXFHH2rTtnvUbt0Nm5kCpsjm72
         y7OO2C14ScdDVw91oITZkjj1ATlO6tDc3pTuAAeT6PXxcpiWAEAd6XY/9yk6LopY3S60
         tso3C6osjSrSLQCexXlZllrVyAIMowSvoS7ZOuNvBIUrNB52alPVRJ4KNQzMoapzIfHP
         ImEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkisqCLr1nxyerHAMNViGtTw6Ti5ZscuFRDmFr3A/unXNBPCgm9FyLaqANbUsb5tzi9ujXjUjA@lists.cip-project.org
X-Gm-Message-State: AOJu0YzIkgl/0PsuiuaFTyUy7PWzuODaW7cDojg6CMkUb8drbYQlDhok
	0ObXr7hfOPd8igleMlYlEmyCt3y83yEumRHNLDdLII5MkBxrmN6tCq2ux/fF8q4+XyC1RtqakuX
	nXBeZ
X-Gm-Gg: ASbGncsfrSdCEzIH9Edu8tNTaohN9A2RJFdYCBqUhPcZPkYF7cEyC46zUzBGyyxp033
	rA3k+NJLDXhnxtZfh/Twq+1YE6dBFdTrv06ejnc96+yC/33mfDGW3OyUFKTXCgO8bjutBBfAY9y
	zFk5ef1qy8JMC+S5mxf5+9yatA8mi09kQmIIGpWt3f85bz9hgDI+WKrH4CBFGD4ccl1ZjuXFF9T
	+6ML0xDlItI7VFopVl+itfW1ntDByu6sGHiAl0xlBX+MaOw/CSQYE8t1di31Cgr1FIzv37iRGBK
	RvA2/2Msc50NtpAmG6A30Q+jxgN5nRucqbFBNMQZQl61apeEgq+ibpk37Z9C91sIPJkKDAxS5d+
	Ulr/Y3lXLkhhbBikL
X-Google-Smtp-Source: AGHT+IGU+czgr34bqws1RYqF9toBKc1akqnOtmIkb33bMmxBQo7NrB5xXiG6TWS595lcb515zu+G3A==
X-Received: by 2002:a17:906:9f86:b0:ade:40cb:2517 with SMTP id a640c23a62f3a-adec5cb2532mr207084666b.30.1749809790816;
        Fri, 13 Jun 2025 03:16:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 14/14] arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
Date: Fri, 13 Jun 2025 13:16:13 +0300
Message-ID: <20250613101613.296649-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19083

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 8cbf69bc74e1f365b0ef8caf5dd2ac994ce965e0 upstream.

Enable ADC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241206111337.726244-16-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 7c40532fc869..3d707c9c6e46 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -84,6 +84,10 @@ x3_clk: x3-clock {
 	};
 };
 
+&adc {
+	status = "okay";
+};
+
 #if SW_CONFIG3 == SW_ON
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
-- 
2.43.0


