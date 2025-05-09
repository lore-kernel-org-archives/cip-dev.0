Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0753AC3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:05 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web10.10409.1746783294914136433
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=cNK2KpUd;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac3b12e8518so385058866b.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783293; x=1747388093; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lipVXrQ0qSuGDd4QBNe1SvIwdGCW46HuWK3FmUCazms=;
        b=cNK2KpUdGe7lkCzjd3avcKtfKnrvMP0amrmz9KnKtlCf/663pMUPtR436EhSoewA14
         5Dn6pdaBeuOMXGOVcDwj1nrieIJl5ssmh17GYLnSN/LPGRgOUV/PfN37+gGmuQKKkY5L
         eow0BdqD3VSVhoXvEp1smaPjQkryaDBXQhv102/uJQP/Fh5iQMTeAauPOG5LisC9U/qw
         eIQ5s0k9CpxZjyO1Md6W97mIoh1Ku51EMfeiGKmyRArHPXkPRUJ+rRAXm/RLVqy2KQZH
         obeXqHunaVdzNk4MW5Ieuet5E8opqnU9BMzFwCdEcT0aYlXLIGDrNm2KB7i8nBxbgR8x
         vecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783293; x=1747388093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lipVXrQ0qSuGDd4QBNe1SvIwdGCW46HuWK3FmUCazms=;
        b=lkDlMVuE66XnvNHfiZVUW99uWGxmb4o3+wdwntTdyYHYnm5I5p692OeacIVsD5nIuV
         OX/05gh3TQYmmS4g3nQlkzfZG+hdLJCMzRQAKBJclZ/u1uq7s1tQ7h77ePPKBE5DvFaY
         F5B7fFBpe9AvKFZRmhgy44Uf76x7WFWoxwKuc2pQU+U0QDuvWFJuN1XQAdIL2rCxEXze
         Jpb1ZHnABIRbqrTuLT/uaE2Vjv8UYhIimcpUxwoRFKZBcqFRFCsWStQQfqsldkr8l1dg
         bpVGF6BIFnGGeiWLScEd7FLx8X5sW+S+dz2KmmUDNY4LeOJN1DEPuEKSGItWNgF36IyH
         X3hg==
X-Forwarded-Encrypted: i=1; AJvYcCVVI/SYELpgHRo95PD0Vc1rW2WkR6/l+XBMCNpt+iWpHKtx3l0NIEFecj+QrwQ0oN1Y+9iHRkEo@lists.cip-project.org
X-Gm-Message-State: AOJu0YwJ9QJmSkfEjcEaLuF/F24KsMxTo9A29fVQ7e9ijbynUr9fPul6
	N3eaVkXwqN3NNNTbKRrIO515TOMVZUDOD+0pxJeKaEQuAWQgXLDFFxDEE6ONwsM=
X-Gm-Gg: ASbGncsjZUQVODXsG/3q045xlAbNU1evNOVRFBAfb6xFQwCxqQBnKeE2wTEpJ+k/vou
	57WP8bEc1d/xKjETXhFnx5OYF1fz1JDXeXU2hUFN9GRVD54qQcyBbWB+jZvsAOtUsjDjbEJs+eU
	BJ279jb1WWE5Pv5slYSbJ87TUy5E+o5UhyBASsWhsOYaOCwiqhnB6JOjnoDtiFUlkht//qJOj8F
	opsTFcitG42dC2hwFfAfLbLmUiuEGr2S8r2PijhIbWNSzOhL0LACVW+AdPOCcsPoxi8JJ+d29wg
	xi2YEYkOcjYu7VrrsoBLQIhWh2pLuh1gHQYfktcUt6q1Ar3XeUHmSsd76OZpodO2x5vXRg==
X-Google-Smtp-Source: AGHT+IEFavZTsrl9S/N3GpygLzdzCK4/C6KKy/SCuWSbZeS7/K0XIGofyYTWVr9a6xIcMLOl4CBtgQ==
X-Received: by 2002:a17:907:7208:b0:ace:d7af:15e1 with SMTP id a640c23a62f3a-ad2190096d2mr255443866b.28.1746783293285;
        Fri, 09 May 2025 02:34:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 07/37] ASoC: da7213: Add suspend to RAM support
Date: Fri,  9 May 2025 12:34:12 +0300
Message-ID: <20250509093442.4015145-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18859

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 431e040065c814448ffcc2fac493f7dbbfb2e796 upstream.

Add suspend to RAM support. This uses the already available runtime PM
support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241106081826.1211088-25-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 807a8448bd27..61edcf70e717 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2221,6 +2221,7 @@ static int __maybe_unused da7213_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops da7213_pm = {
 	SET_RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static const struct i2c_device_id da7213_i2c_id[] = {
-- 
2.43.0


