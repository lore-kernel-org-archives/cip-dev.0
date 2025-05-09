Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4EFC3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:54 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.10373.1746783229192387266
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Z541jnEn;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fcac09313cso599804a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783227; x=1747388027; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQCxHGlXkJFuz25OTUzYak+J+Sm4Ff0uFyP1j43GUDQ=;
        b=Z541jnEng4PGm89TV5r9/bI+Onnfi7WPBMZ6KF0CNyVCVOJcZfvph0t+TYwV+TTBUz
         zPOEn987pj7pu5EabW27eJglb/tYxeJA4BG8JYV4I5ikXa6p6SrGXoDkEjd9KXzd3rKR
         NZA+/NSDYOwgWNl9UC1k2FQr+XYRoNyT+F0V2WFFnTGGVNpQP5DZvY1nrpIbMaWs/aMy
         FSHOPlp1awnHTg9ItrpPb/xamEpe93FXiDClAd09jdi4hWH7wqqS5yaXZw3isnKXd5KC
         ncrc2mxSP2oGqPKPpxd6bpZdBM487cHoED6RzyTjp8UZlDUKY7s9pZuN0tVl7Zkim6zs
         /k7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783227; x=1747388027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQCxHGlXkJFuz25OTUzYak+J+Sm4Ff0uFyP1j43GUDQ=;
        b=lPmcFY4+7lTts8yUQymAZLTwvKLn/f+3QTg1H5gMWf2sdIeI9fgK2/WPNvXoFsvF6t
         paig9OCPgm6jj2gGVhFg68A2fJyTRAYLbvV8Jj3xuzBat2CC8FOSuxbwYzSXQJF+pPap
         xowEp6tdaL1h5k2uqks4QZJwnyB3SfJW1UjAKNMKV5HYhqMKsfrcmxxXwV96jibWk3wW
         YFC1pB4jggmWN0XbQivCGLGAr2KXL7QA5DENZq9IPVXENFqzbjgtx3jZg9tFVxPs5qLb
         nA0+lQIXwChJFgVEfIT3lSt85yTBx/RJsdg/xIpHSxHLd0JIPr0Y3Iypz2FWvtNxqf8G
         SVxw==
X-Forwarded-Encrypted: i=1; AJvYcCWIAZS0psW+cHkI/J4IUuP4EA39ILi9rCEZhWHBb+em9Oqu0WIiA23YmdVF16pd8LqiXCrwvO+m@lists.cip-project.org
X-Gm-Message-State: AOJu0Ywfd3XQ/EM+QsFH4dB6NoyNVjApvYkAu/2fJALllimhIvqtAzzO
	xxlmxyl5uFi0KrfdPRE/N5dYBJeEbZbEXIUZhL/3DNPnq3XdzOdV/1a4/SP5q58=
X-Gm-Gg: ASbGncsoC6+/hAG8I//3NogaoCUsatBMQtCCI2rrARolkasWtfIKHsL9ZQoeVjglFYm
	9Yp9X1BXDUmk+yBmlI7WAYB5MRvi2w2AbS7/XNmT1VUE6xtGKNsRzwYvI8hvkIU0zrSuNhs9Rm/
	Yvjh+0qwhCcqaI7+O+iC69jwKE5diaFlLtr5KyUtoPDVVr46Qt4Rm8EUS2sQ0qMqZVYnJT2GylX
	ndAW5eYeZHF912W6aUOevpjbygCKIM2fMsPWx19uKDBeNRNBwHN/5TqKdGh427jkJ4BMtQzXYIq
	iQEVfJCkGFGPaonnEaRrMCudDYK5p8aHWnzghBa433mzSdj4jz6p6ZGjq7u3E0y6zSNosg==
X-Google-Smtp-Source: AGHT+IGoi8oV9HlqyVO4Bxb1XsMfiBZkJ8WVDR2roCjZqzvQwRnrqyvrv17nHeNSFzZ7HeseMii23w==
X-Received: by 2002:a05:6402:2684:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5fca07ee2b1mr1889772a12.23.1746783227580;
        Fri, 09 May 2025 02:33:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 18/34] ASoC: renesas: rz-ssi: Use readl_poll_timeout_atomic()
Date: Fri,  9 May 2025 12:33:02 +0300
Message-ID: <20250509093318.4014916-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18835

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 4bf77dfa3308b7cfda29d9c4ead1dc32f1ceefa9 upstream.

Use readl_poll_timeout_atomic() instead of hardcoding something similar.
While at it replace dev_info() with dev_warn_ratelimited() as the
rz_ssi_set_idle() can also be called from IRQ context and if the SSI
idle is not properly set this is at least a warning for user.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-11-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 33800ee587fd..997ac3897862 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
@@ -317,7 +318,8 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 
 static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
 {
-	int timeout;
+	u32 tmp;
+	int ret;
 
 	/* Disable irqs */
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
@@ -330,15 +332,9 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
 			      SSISR_RUIRQ), 0);
 
 	/* Wait for idle */
-	timeout = 100;
-	while (--timeout) {
-		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
-			break;
-		udelay(1);
-	}
-
-	if (!timeout)
-		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
+	ret = readl_poll_timeout_atomic(ssi->base + SSISR, tmp, (tmp & SSISR_IIRQ), 1, 100);
+	if (ret)
+		dev_warn_ratelimited(ssi->dev, "timeout waiting for SSI idle\n");
 
 	/* Hold FIFOs in reset */
 	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
-- 
2.43.0


