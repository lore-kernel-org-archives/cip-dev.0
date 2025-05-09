Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C7BC3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:44 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.10299.1746783221465376267
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KRssR7br;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fbeadf2275so3406507a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783220; x=1747388020; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+QMq7VxzplR9tCeIiSAfksyTQwfaS/ho5zCPmKglQc=;
        b=KRssR7brUi8SNi31DhRYQFzfN9w93lnTgYM9XkqFRuL3Je4va4Y1049F111TsiZfgC
         C2RQojlOs4tb/3Cfi/c1qEQLo/ZRoidaZ4Y4Er9HM3nG3eVVtuGz6nNb7qWEbewKE+kh
         IEPMKlNbz6wtbhuGtZqM5FIPKrEgcq3IZL30f4/kzho2bDW3t/ZTsi1U42tVv1zoAHrL
         N/qy04cXVxvVcwtdIs88862GFS2wFZVXnaCK6tuwBmo6PDN4kBKeTpJtHot0dr9QJ9lx
         8EYiTta/a9Xqv24yo/AEC9sb7pxawwTXR+yycEttK+IDSxnHewq7mRiWFQS2VRcNcyI3
         cPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783220; x=1747388020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+QMq7VxzplR9tCeIiSAfksyTQwfaS/ho5zCPmKglQc=;
        b=dE2YwddDpVdIIITFZJkwqZM6MywMTNMCBuxH4N6jSF7IDPnIYvo83G5E8lM6CjW4fX
         9wC89bkl6v1RDPkKla/lYeFw4wd+fH9b7eetMkAFV2gmU1C1C/drmLp7+SnMwRAnfm7b
         TPgW1u7Y8ESdEdCU5RC2GN8BTxbVzOzxf6PIYCq0+g3ZgAuoOISQKufccxGnKzg1irOl
         BPK/h48VPNXBYdqtkb8m/vNjCBpuS3DhmVZN0P23oEMV9tmvT2bDwV/ymeoGmHoipLJ3
         pX83SpexhjiIOk7o6BD25CbRaDXCPHz5CmVUTaNtU1l52nWeX0HQPdEG9pkzXS0uzpdP
         /Jqw==
X-Forwarded-Encrypted: i=1; AJvYcCVN1NazBLix1Mmp+eUrzqNnKO7Gp8R9fQbvpI/dDSfk5IYeA9rphzvLkZYdodhooIPOd1+IMwy2@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz7Dk1m/86cDZ/TguqFvjntnM2EVSpjIAqDD8hUlGALm7froZM3
	3veqhaEHTvdq8TxjMVDEtElmz8SZSbdd1To/dBKcWbyS7w0hhP2NVRJ2z22t9q0qOSv1Aejcx9R
	4
X-Gm-Gg: ASbGncsWT2Mv1haoiwRQ1Hcld9mfMCoVcCv4ui/RhRvDGi0tb2p0a+v8YIrTKYfE+s4
	m2/Q4ZCUuT9P2h20AK9TlIE2R9zhHBhRP3wnyT2fFWWbUT8qOVhuosWvaQb8ay/XvOM7vrRBEEy
	63tBoGtmXas+dp/YV+DSPgIIFeg2Gm1EpZzmAHSYgKWo2AEKvhCp8lN3jSqtNVBbpJ2irzu7TAy
	mMtxTcMUmHe0omqKbDDSd4wRrwcjrNu5jUTi+RwaP0bLHFkzmB+oJwoW7t1PM6kIm7O2kZdhsvx
	3v7J+AvYj7a8kLM7Gb71wgTowrRHd+63y2ofyR09TYVFCoHw+rHnS8awL+OlhIa9eNv9eg==
X-Google-Smtp-Source: AGHT+IH4jX6VBS7xqkM+vEyjuA3uOlHkhu3+furmXAeIaDvuW/eVl4WvaTqAkA8RuLM0hRZrivaaHg==
X-Received: by 2002:a05:6402:348f:b0:5fa:9222:e875 with SMTP id 4fb4d7f45d1cf-5fca0792de0mr2105603a12.18.1746783219794;
        Fri, 09 May 2025 02:33:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:38 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 15/34] ASoC: renesas: rz-ssi: Fix typo on SSI_RATES macro comment
Date: Fri,  9 May 2025 12:32:59 +0300
Message-ID: <20250509093318.4014916-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18832

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 100c6b22d6c70adabdf45dcb346d7d853bff6a30 upstream.

The SSI_RATES macro covers 8KHz-48KHz audio frequencies. Update macro
comment to reflect it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index a8e7b76b5b2a..f9436153109e 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -72,7 +72,7 @@
 #define PREALLOC_BUFFER		(SZ_32K)
 #define PREALLOC_BUFFER_MAX	(SZ_32K)
 
-#define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-44.1kHz */
+#define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-48kHz */
 #define SSI_FMTS		SNDRV_PCM_FMTBIT_S16_LE
 #define SSI_CHAN_MIN		2
 #define SSI_CHAN_MAX		2
-- 
2.43.0


