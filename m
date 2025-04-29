Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1F3C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:37 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web11.20363.1745934514166197381
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:48:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=gTwfuWUI;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so9559684a12.0
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934512; x=1746539312; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo/vcjF64X7ZsuAoe3I68C3VPgc2cEmgB6i8lowYWjM=;
        b=gTwfuWUI17EcBh0X6FPI/piqf3aCv43YHdTO/5ZnCZn62QvUJXio4p2BKXJWE3swOL
         YlBWNqMTUD5pQo75405OhXIf95SocI86B1FnJgegh2sOGW5E2QUwbCL3MJGVUIrACxdh
         I9bFSEUnYDjY6urHRQ2RgzH3dEHrvbYUQUTDActaOHmLmjp5IPjazOyC5fneSXp5ctwN
         GnRj99qHpBR+B9R1JfQiAcAJpPaGyvHxZeq4CsHsmnQ3CZk4JWAkjfcTS7eT7NQIyXuz
         +pZ6AKI/GznDohMGMEf+HnR342w8cQqySQUQUpGVjW4Xlk0+8fQMnPj5C9Qk6Tg/KXBp
         aI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934512; x=1746539312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo/vcjF64X7ZsuAoe3I68C3VPgc2cEmgB6i8lowYWjM=;
        b=saINJB3A2dHljF5oPh0acP9q+jRlYUoM0nAEJqaNXTKxqbLtx8Dwl+WdabgsjUQEUY
         tl61OVdVEOntfLaeCa9FW+Yt+x+oCrfVWlDHwAR07fRZs9GNbwSDCTXyPXucWl0RQyvY
         7IlzxVqhq3doRRKz8ri5QJsckWGRvbs8uXFjhRWujkcQ8tua3eWUWTO1JFhna+g/sHFQ
         tD0CFUaXK3Q9AAr4w4pWGKx06Ta47wY56CJcBrtNvMzXxgm1TAOnvcKYixOTzWxowTfP
         3a1gS3ERMqgN0G9ZtAaON3BrgzGvt0J3y8BX7BnunVy+cimn7DsUp9FxhnWfzSyTMefo
         23bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVysBGPus3ur08aPD+W0vL2WKxdwSeOJ0JDfLPrmB32Q8d7AHB+gjzw6T/NL+QhSDjIMtyY/eje@lists.cip-project.org
X-Gm-Message-State: AOJu0Yyd4n3a+Tlkr3W/bzG+XUbPygcGmXSxfoUmXCyWHsu4uZB8txY2
	ZAHMaJAJYpqB515mbH/6VD5SfV/SJxw6WVOUMbDdoAT0y6ckdxc9DV1H2IaoAj0=
X-Gm-Gg: ASbGncsCR4IZBK79J818fGCX3SzIV7av3hTZxSdFtJF5FF8WsMUuDQAd8ZqHa+0bFyE
	+0PpKQg+VIFm9Y0K+qNtXZ8mOm4G0LCxgaMblBTxiZ6Sf1qYzVsDGzjtQPjID65tSCks45BefUQ
	AalCmDksnM7CCfwQXnhkMqRiehgYIY//I6M0OI3vkaC9O4iK5Ix4uRZBP+2XadOa5dZbyFeSJTZ
	MA27curfj3SIWe4dxffipmRnvHLBJySeQHj3YOwtrmZD2HhVcqYZx+ybmOqRTtCFXhjW06bWGOQ
	+nA7JlQz0ld2qQ1+i2FRtWRuyj3/TBGzZ6WZafuWCfonGV5U2fbWnqzG0tQIdXR0V/kMmGs=
X-Google-Smtp-Source: AGHT+IEESJqMdqQMS97Coacs7PE4AiBVpBqkkq0ZuRCMDDjVpg0rqP/GqU6YwFroRLMHiA6DiZWeew==
X-Received: by 2002:a17:907:7e8d:b0:ac7:391b:e685 with SMTP id a640c23a62f3a-ace84b10705mr1206991866b.59.1745934512502;
        Tue, 29 Apr 2025 06:48:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c898sm780033466b.7.2025.04.29.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:48:31 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 3/4] arm64: dts: renesas: rzg3s-smarc: Enable I2C0 node
Date: Tue, 29 Apr 2025 16:48:25 +0300
Message-ID: <20250429134826.2429916-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18738

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 268a99583372a0a2ae93d0969db0bf3f95d74049 upstream.

Enable I2C0 node.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240820101918.2384635-11-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index deb2ad37bb2e..7945d44e6ee1 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -11,6 +11,7 @@
 
 / {
 	aliases {
+		i2c0 = &i2c0;
 		serial0 = &scif0;
 		mmc1 = &sdhi1;
 	};
@@ -66,6 +67,12 @@ vccq_sdhi1: regulator-vccq-sdhi1 {
 	};
 };
 
+&i2c0 {
+	status = "okay";
+
+	clock-frequency = <1000000>;
+};
+
 &pinctrl {
 	key-1-gpio-hog {
 		gpio-hog;
-- 
2.43.0


