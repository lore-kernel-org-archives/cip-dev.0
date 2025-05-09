Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C719C3ABCF
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:23 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.10321.1746783138230946728
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hGT8aRHp;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fbf007ea38so3127218a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783137; x=1747387937; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYTxQQWI+GlDlJIpDucyc32RcZuSdIU/aFLCwgLbj5M=;
        b=hGT8aRHpcAYzA5ULHP6Wir0gelICJ9MXXJruP9bms9GXEigwnpZ2xSpEbIJC265a7Y
         SZ/NlZqeaTo91RkoUKzsNHD0SOfuNgx2oAHxy+lpqq68mL5kOAzg3OCwQQuMlnPjXaeP
         HQadYrwzk8kx40HAZ1I98QZSqdwZ7vlXKfL7A8OMVIFKTEK9+J+pc6D1bkw6b7qqWolA
         0jJ/dcHBv/zZsZ3mBods/dnQWVuZi7HsusBcv6nzW37HURBEssjUhSzC1FUZAOO+9N13
         hpCi/jInrzR9o2JP6ZI085jt9WCz4hLpSOMCcNzqQ+Yr0l2sF3lslm7JQ0amb9Zl737L
         PBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783137; x=1747387937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYTxQQWI+GlDlJIpDucyc32RcZuSdIU/aFLCwgLbj5M=;
        b=j9nPJM2d7ZisZtkyfpUcnu/xtPIoXWTjiCBu2/BfzW+VdktTcsV4LQVj2xM0qTm6Nh
         aHe2EDnzzi30V13BKBY93p0ryiXaRPC53Wl/pc+J8kP8xoVuJtSrj9s/Uk5ugloOVETJ
         bOSsVHV/78LgCFtVWsscflNrYbiyssqjg/Z+0wxZUUz7MaKN50PTNMIzt4kB11bBaheZ
         7oOa3wEN8ugZ5MyizWAIYvNVShdN2QepMYc3ZmmnDDCC01SM2U25uNEkc27uN0bHmqqF
         gbW1018W+Fh8/Nu/K5owr/qijIuglYYEjP6dpa9XKuUkMSYE85PrDeoh3xeKx2pJaKoe
         lmZA==
X-Forwarded-Encrypted: i=1; AJvYcCXdRrbrUxJ48kbkMrhHO/OLsqtoLvyf/WUgz9kMWNg8kx+19bI6OKBSdHRE2uUbE/ZrEr7cStha@lists.cip-project.org
X-Gm-Message-State: AOJu0YwNbmqb7cGzKLEq+5T4+QjPyoe/RUyZKa9IZ1LhoYlRa5i0jzQQ
	XXDCQlGnY84M799OiZc4OWkDSOfFYHaWUUdNU7kZGSqN1CH9OqU1ZZGLbqStYNo=
X-Gm-Gg: ASbGncuV+XrpdB16yRtts+8NdLVZ9v+IKEPwroSj6M7DuQ/cUWuGy9IBWozvYzzpRu9
	f8axG2ICKLQjxiIGeU4u7bV/7wRxpi7BK9PJopNVJsRyumgJWpyH2SxbshR6sRCbr12gFNeJ9O9
	HSsaRjhNFI42SsJTQe+BCsC6wxUAHQQcq9l+pqCUrB/O18bJTrbLtUxWIkbe8l3F81zosC7xYpA
	J2fd0jUezEfWzcJ5Yqu2gAg9uoSd2djDZjCf9NgwFY3LiCHW0z9tetbWEle+/q/fOF//k6ChhnW
	iQ43B87No2Eiwscl5pxDwINQT0OlK0/WU7re7+gb3bYUQDUSuHfX2paNnN7JKXBjcOrIhA==
X-Google-Smtp-Source: AGHT+IE++zxy8TRBx8cd4adzR5xU1TygOAfOeDZ/m/oEzeKPeTYnvzeVNFq+NxlgxXqzvb8d6n2nfw==
X-Received: by 2002:a05:6402:2745:b0:5fc:f:7316 with SMTP id 4fb4d7f45d1cf-5fca0732967mr2212730a12.7.1746783136587;
        Fri, 09 May 2025 02:32:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 09/29] ASoC: renesas: rz-ssi: Fix typo on SSI_RATES macro comment
Date: Fri,  9 May 2025 12:31:43 +0300
Message-ID: <20250509093203.4014750-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18796

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
index 4f483bfa584f..97147faa6b2f 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -71,7 +71,7 @@
 #define PREALLOC_BUFFER		(SZ_32K)
 #define PREALLOC_BUFFER_MAX	(SZ_32K)
 
-#define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-44.1kHz */
+#define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-48kHz */
 #define SSI_FMTS		SNDRV_PCM_FMTBIT_S16_LE
 #define SSI_CHAN_MIN		2
 #define SSI_CHAN_MAX		2
-- 
2.43.0


