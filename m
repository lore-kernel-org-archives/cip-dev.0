Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ED6C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:55 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.10339.1746783293705940383
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mPJP+nzV;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acbb85ce788so222735866b.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783292; x=1747388092; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsMvE5miyVifTrKKlkDGiAqFWOCN8eOS43Dm1tXl9NI=;
        b=mPJP+nzVQouG6UFbuUPHjVdZxikNCSJaGwFOghrXvROcerb5oAsq1eEWa22ZItkqEv
         tJiodr5PzP9Owegiy2Ei91r/73SXKkY5YJFyW8SpT+CQoiEyyMOdsn7h3WGRToEmgjBA
         KiLSg0vqUvdTi88QdgKXuECYsv0w6ihp/9DhzBGBIpaa4gtlNcQnHGch1ebHWUO8ou+V
         TSWssw1pp2e3nw9d2gm3l7TR6o6d8iSrUq/STokychrYujNaW+18/5gsOX6KG5tTMHzy
         AbHkI9GiYww9BJ23aoN6OdaZGoAbdhsr/zGBgVHJ38aF+3fUlg74V0TCy229qsveaPtH
         himA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783292; x=1747388092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsMvE5miyVifTrKKlkDGiAqFWOCN8eOS43Dm1tXl9NI=;
        b=kYj8VYGxUEc8eToZT5kcysyuPjvEuvmpqb7Dk/WFRq7B5S3md8A/bnTxSlldU/UxzU
         fxU0eI+7w+V71T2M++/29NlHRXfSgR8JgsA4XFP9OfIzfQ3fp/OakvwCYIuffcAExmLP
         K+PLUGFxMzq2iZCUxrsPDIgURHiU7aAr5FPwFW20Ppn87pqpLqD3WipmWkoqIduCyDDj
         wtSDjxxoSkKbrVF6FVQItIIPLRrpTzxcfzX9vc5Eq53X98ZRTe6D18vRX/9PfmZqBGmr
         qZYJQ7T8u6jvWWbZf4cr9qObapACVkC7T2VFmX2p03HF10xMd3uq9CgQPQWxCe4Hc4yF
         CogQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhwrZYSHKYtRqj8WESPvfVDL+FbmCV4zXWX1smVt8oX/vaJSRxvmdzv9hmM/3tiznhXkDsQEKf@lists.cip-project.org
X-Gm-Message-State: AOJu0YwD4IofFUeRlf2B6Hv48YLTjbjdl7YH+2FZD1RCpl2eUKPWsEGI
	9cEklZRhZlLRXwwwk2c2uTIs7UuYm5CQ/vy1c6rW8CrjlBJDZ/G0MeETeM5t35FPQGgpxDhaKvj
	1
X-Gm-Gg: ASbGncswHk1OYn53jeD0sPx2yhy+KSmU13wqLNw0uPsZi/RV61vsH4VKkG5s+NOQDNj
	PbtDJxIfi74bnkAwrHp5f+0CF0WHs82eb8o7c484kEtGOK7dNxSDJLCiLJ+LrooutL76uf7BHtz
	/WPDRqfDJuJ16ar/SJGXTQTgr0ohtTv1xpW7KAGsx8xNKMJTmBhOL0+XLcBfwljO8wQFsGRCIFm
	tNf/lC2paKAsNUXMSQ7PM0bwpPjJwCTXkw8brx1iw1CgCysAUOZzNn643hSharnvgR+NxXE4VKS
	RMD2Ln63ZX2O5zZxR4coSX5WHc2HK+TTfuRP08zoaeNRpN+2ZvohYudqok+e3ed9wAuyqA==
X-Google-Smtp-Source: AGHT+IGISkeJ8VYRDUjvf+5WNY/oFec2IY4cof2XZyz6d5S9q7FCXorM9uoYkmfIdrckHvpKIDxheQ==
X-Received: by 2002:a17:907:9801:b0:ace:dd27:7c68 with SMTP id a640c23a62f3a-ad2191697dcmr278338866b.46.1746783292006;
        Fri, 09 May 2025 02:34:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 06/37] ASoC: da7213: Return directly the value of regcache_sync()
Date: Fri,  9 May 2025 12:34:11 +0300
Message-ID: <20250509093442.4015145-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18858

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
index d4b0e48f818c..807a8448bd27 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2216,8 +2216,7 @@ static int __maybe_unused da7213_runtime_resume(struct device *dev)
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


