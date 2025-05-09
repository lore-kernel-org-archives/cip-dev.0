Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F92C3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:34 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.10360.1746783208218730821
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZZba8Kbo;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5fc5bc05f99so3292234a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783206; x=1747388006; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcQbwswAvGD5pFRp5A8DbNmTlTvL7wvbddM8yIKhsCs=;
        b=ZZba8KboXZUkg4tuk10obKuzczA5a2ep7POgFrmclvpuVyI8CkiMBPWaXUWRW8wuRG
         qbcUqYU/HkaKZKV7FUa6H3pekrfwPrLfor49OLPaIRF/zwzMjoR1cOA5i9SIOCxi3BNk
         Ll841xYanWStxfra0C/KEO0T0i8+1FGqYgiSTXjWPHH9HUoOTgeZsg7yQRF2WxGMoUlI
         kazrOuDK/zXKjkW5LHJ5wbp/tBMn5SKkTrngt/GvGIVsAuH29HdyhQ1OKpCX9cHsv1u3
         u0M0n32V8QRqq7NrsQLWKxYLfDWv8Zf7n+1lFR5pnB550rNWR6q/73fe+Flo53XHmJ6c
         jKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783206; x=1747388006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcQbwswAvGD5pFRp5A8DbNmTlTvL7wvbddM8yIKhsCs=;
        b=tROkFVPWcKXJ14pCwBpmCrUQDeZnJtlOvLpkSUXk+8XBwx5tAQFE39QYiaZxrczeYd
         M6EzWE59oaCtQELfK0yQCvecrezM9zmUdDbga9wHfG48VqrbsfHbAua4kYmtT/YlxBgU
         WK1jopWhBTVXlj9KEhBdaw2Wo4m0N4iiiM6VVPodhk1XV7POynWwkpQmdiNIuMj64bSm
         QXl5LRWFbodI9EgwpvXx9JOeGQm9Gb46qrYSbquvee2pcJK1j2pjK3Yl38AlnDpJjYjQ
         RGn8LBI7vtcTSPhnHLg1k1f3eZw7wi66qAmEYboQfRfg2grB3xS1V2WO8ZKtJv+lYYv+
         smDg==
X-Forwarded-Encrypted: i=1; AJvYcCWzj9GAfWQUjZfkIxEU4CYMu0izw8u0PJNwndDwcO4G5MX7fpOFGY3Kvr584irm1Y5/aaXXmxYu@lists.cip-project.org
X-Gm-Message-State: AOJu0YwFec3jsjZpid3LM3J9PfiV3TrCMnXv4H+h5JU2IVnItHzltH0D
	u+9HqNwikDGkrNXZKfu6LCE8opQgL5pmxMa+ACv13zlkyZfbSMeSUCkfkNlb5wc=
X-Gm-Gg: ASbGncssMozyv+eCJOz1p3lsjXR/doeuS/MfZyC4sZjlANrL72t0hPoNHAkQawum+0Q
	+wRJncKqILFxfdfLsh4UlftvIYsBMVmyA8P936/ZT+7xVjVEQikDvXUKiWNa1dKkg4MK/iC5JSf
	r3gnZHumr4SLTA2aiTroWmO8/zRJl5eCmsVXkE/Qixmgz+Bfh1h3gPRU9+vQDR12yatmNiV1kyz
	N4OSRNDezUU5US3yBIoUTsuK+r64bEDhLIOgusm/hE4FLDpZLzUnzhfFddKlKuW4dACoNDtEgQB
	G2V3ahjcg8647NhxyxDiE0d4S/KL3yG+da3SK26bb8RZ6JswV9rBXOOXTWvg030yKrACYA==
X-Google-Smtp-Source: AGHT+IEKQpnAeS+nlEAcQy9X91sg8zwB1IOs5+GuKkzmA6khJPQawxeEc3KIOfj4vQo+ikE9XgkLkw==
X-Received: by 2002:a05:6402:90c:b0:5fc:8f93:4f73 with SMTP id 4fb4d7f45d1cf-5fca081b032mr1957071a12.34.1746783206620;
        Fri, 09 May 2025 02:33:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 05/34] ASoC: da7213: Return directly the value of regcache_sync()
Date: Fri,  9 May 2025 12:32:49 +0300
Message-ID: <20250509093318.4014916-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18822

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 841256954037ad80a57b8fa17a794ae9a01b2e23 upstream.

Return directly the value of the regcache_sync() in
da7213_runtime_resume(). In case of any failures this will inform the
runtime resume process.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241106081826.1211088-24-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 85ff374cb646..21ce3e3fb9f0 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2218,8 +2218,7 @@ static int __maybe_unused da7213_runtime_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 	regcache_cache_only(da7213->regmap, false);
-	regcache_sync(da7213->regmap);
-	return 0;
+	return regcache_sync(da7213->regmap);
 }
 
 static const struct dev_pm_ops da7213_pm = {
-- 
2.43.0


