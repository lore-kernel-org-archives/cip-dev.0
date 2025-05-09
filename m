Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04218C3ABCF
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:55 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web10.10407.1746783291182079273
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Z1pyoZIq;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acae7e7587dso276492266b.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783289; x=1747388089; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/Y/IMirM1chB0vnlvNOa67uROpPmju1qMja6bTYjHw=;
        b=Z1pyoZIqIqt/mHZBnHwIrilC7Zm/uc7ZKnqUGiqvCxqD9rvf+mnUcljDSUt2AC/Uww
         k8Hfx5UdQZd23AsBn0YBlYQmJlVCHA36CSzazTkQqFgbX7yUyiORIaj6hFQ76FZh8vYC
         xOoOLGhXTV9zwNTS23jeabfnWQbmVbTEKpfOuCf2w3G0iPp1hYvoHMOH4/twEL70XzdN
         apeuaAYASl1jjxoMpdgAd/jR4LKumETyFGU4x/svqki/o9oaO1ax1B8g5lgLt/gr4zcK
         Yzci61rHvZB2q3jLF+eEYrQJiHSW6YqyxfHjlDJF32t/szZlnP8OBcvvgQR29nPepKlP
         Xg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783289; x=1747388089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/Y/IMirM1chB0vnlvNOa67uROpPmju1qMja6bTYjHw=;
        b=cBFgL+6jliTOc5TlEu4J9CI9HMX1PIIaNIRUfoAd9Ppick26KDyTC9JobVahB5Z3qY
         g0IBjHs1ESxBlDtx+tmRMqUfJCZ+OUOK5wKeUAmSgnrg8PLtJ8y4Q6ymGfLlHXlhwNYl
         n4mVcRqxV1KkdmySeZAlP1Mb5sLojubhHKbW71MItgDn6NnCyO3R4rt/Zj+O06QsP9XH
         UdQAyHpKyPTk7HhCyVfq15yiNAEFWx3LV0DsFO76ia0ufiKN59u7LVnpGjKlTN1CWZpE
         Eh1L4Ftkos4OcfdOLrIwp+KvgFW49SbKAvtt7ZHmF3hoStSqsoaD3mP8gyXH+g5A4sDz
         Ns2w==
X-Forwarded-Encrypted: i=1; AJvYcCUl+/AB9EDNfQUhLhtJQEHFZWSJ7X5dy7C6iRYoGK7qeGW9ejYuWuo+08yRJggJPU8ME4OZO2I0@lists.cip-project.org
X-Gm-Message-State: AOJu0YyjVCkCg4FY/dphccwW5EwymcKQdcNqoen2puE9f6NRFhghHl1H
	50nUQrHUxUObZTW41h881/wHQvbuE/9NYYZJqwlK9bbjCzoP8zJJw0agJXLwcBA=
X-Gm-Gg: ASbGncvqL7exvrM/4GhvgsBCBOdUFU+rWVM38fo87Fk2W7GuveQs/pEwa4w9PCQV13f
	E+7fXpty9SgCFnHBWpUDTEuk+nWYTGiPmMC9d3WWelyQfxpkL7JqbCuktFGIpdibsFktQKWYfxf
	/pjagDzS2YSGKbxQFURrgp+h9BwBmp2+ZYhiLLZFZNH+Qtv4W9JyrplzIfuyR5HspqFkhS21/jZ
	6RvD6dYUcY6d18vo272FipdTsgg1hlruvZEVd+XjArjfNaYaSByeSi6ocxrTM8vrMkr+2SzDW4g
	50X7F/ArvQLJ5sB5etkD2y2ETkHr+BXZRB8KaRxnVuLQ1nI8nva141Yey4HtOpUKeEtKsA==
X-Google-Smtp-Source: AGHT+IEEXvWtckSSeYmdmmNvxokxVd5sjiVQx5cnXS6tkjaVBsm3gKkPYVrsu+m+QPzxHbHlZILdBA==
X-Received: by 2002:a17:907:a646:b0:ace:d848:2242 with SMTP id a640c23a62f3a-ad2192d4a2bmr250319566b.58.1746783289503;
        Fri, 09 May 2025 02:34:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 04/37] ASoC: codecs: da7213: Simplify mclk initialization
Date: Fri,  9 May 2025 12:34:09 +0300
Message-ID: <20250509093442.4015145-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18856

From: Cezary Rojewski <cezary.rojewski@intel.com>

commit e2cb72d28740516cb03fa072e14b2f1a6eceef61 upstream.

Most of clk_xxx() functions do check if provided clk-pointer is
non-NULL. These do not check if the pointer is an error-pointer.
Providing such to a clk_xxx() results in a panic.

By utilizing _optional() variant of devm_clk_get() the driver code is
both simplified and more robust. There is no need to remember about
IS_ERR(clk) checks each time mclk is accessed.

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://msgid.link/r/20240221152516.852353-2-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 8a30221a20a1..911348ba8ad7 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2083,18 +2083,14 @@ static int da7213_probe(struct snd_soc_component *component)
 	pm_runtime_put_sync(component->dev);
 
 	/* Check if MCLK provided */
-	da7213->mclk = devm_clk_get(component->dev, "mclk");
-	if (IS_ERR(da7213->mclk)) {
-		if (PTR_ERR(da7213->mclk) != -ENOENT)
-			return PTR_ERR(da7213->mclk);
-		else
-			da7213->mclk = NULL;
-	} else {
+	da7213->mclk = devm_clk_get_optional(component->dev, "mclk");
+	if (IS_ERR(da7213->mclk))
+		return PTR_ERR(da7213->mclk);
+	if (da7213->mclk)
 		/* Do automatic PLL handling assuming fixed clock until
 		 * set_pll() has been called. This makes the codec usable
 		 * with the simple-audio-card driver. */
 		da7213->fixed_clk_auto_pll = true;
-	}
 
 	/* Default infinite tone gen, start/stop by Kcontrol */
 	snd_soc_component_write(component, DA7213_TONE_GEN_CYCLES, DA7213_BEEP_CYCLES_MASK);
-- 
2.43.0


