Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E03C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:33 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.10325.1746783143967384825
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=UJzRgzdq;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so3446029a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783142; x=1747387942; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVKAYYttqNVwPKJgmRg1++JMMq3VEvSL3Uf/5y7Pbdw=;
        b=UJzRgzdq2QVFNtiEnRlSaq3Xl4yyoQ23SGCUierAZcJpvVaCKT+XvtGChEP8liufX5
         /VT9d0o5X5V3e4isQZauMYSenq1LPKWMoyIW+Gs6nPKVGRlDUtvOi0ABqB0mJOq95urG
         BgSIKInPTt+2LQOVSchLJtwOVdLO3Mmc5mzwxx0SspNAHg1HbkempvPFXjqScmF7OYWq
         bT0E/0e69k4/cP4D457Z3fju+XEYzkf7qWhmxpbdXrhJl67ZVRJgKItPC+D/1qiqAVlA
         QDxojstC/umzcpYRKrOjmFO6cpuXWLer6SGymMYQfTiiqfvI6jtXWLBrE7x0Pw7VsZz9
         B2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783142; x=1747387942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVKAYYttqNVwPKJgmRg1++JMMq3VEvSL3Uf/5y7Pbdw=;
        b=bBx5EFY7c2747vcknZCogZDsLM3unMtEmk/RPPcV520sdwHHE0btixjU5X7RmdjCno
         cMkaW6AcJRTa/gyVgzco4+G9KBv8hiGLGxARm0sc7/5t3e9571yzg/MOdi/CwortttIj
         UWnlMAJCN/y2YCH82VWDt9RyCE0kbFOW4lPfb4FhG9VzMRlXmS/8CXEsegssfhohUh8h
         W5zUHMfrqnsfvv8zl0n3BPK0zEn6zkPBo+2QEjOZS3MVaB901o98prwhgBfQt9p7wplP
         0zhXUGkZ1k+saQezftTzeLyHJ0nYRUnOZJIy8KxBtMSkgjrgxgr7v4dJEqyaazygJ6pQ
         8aRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDKI6L4JRr1fKc32JzcY2GIqjUCYF7LSgbmrWTh6KNg6cBcp7WN5dJrchZ4UG0WX8ry1iWxL/3@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxo7BBTmuZ0tHXlnLcdBkyG0nuATcEB6p1xhiu3X3gmgmYosaCB
	zH6HNOwkS/PD2lnEAyGPZ2zfLN4doC8bJGs06z9Ps163jGU+o+RJ9QqPFGl8A0A=
X-Gm-Gg: ASbGncs3mYeaDhrazsb1en0A1+D7MO/QRQ8Ck2gZXMteFRWjOeimNWAOE2Rn3jrYpAT
	PWyiLOp2qiWQBqMF2TpfP1qYoFDnclyCbHUa1lOXPG6aSG4sgX8l03AuNp5i8vev6oRFmiTh5+F
	9Th4SzyhDlcnmH15teN/mA+qrvasLBxgrdKfS3yrlft7whB4q123xYb9AN/sMnTlUahaW2ITwk2
	b3UrDTYA70hK04Bq6eu1eoHAdSmImTP5dyvmiercab7Xn5ML6k4ONoaREjfwXCyJTRQu9KVYKWI
	n2ukA0OJJ3umvYgxChZZlag99M2N0YnzbT8CHZBFAYz/6jcXqaNx1k2Qh1stCfAP9zqfO93EueZ
	gAfu8
X-Google-Smtp-Source: AGHT+IGi2LZA/u4j4hn0t6vq4awdwbkqV9KThHMdXLc65cNpO3TP/ceg4ESOMaWxI/XppHGm5R7m/A==
X-Received: by 2002:a05:6402:4403:b0:5fb:2eb7:60ca with SMTP id 4fb4d7f45d1cf-5fca073080bmr2136815a12.4.1746783142314;
        Fri, 09 May 2025 02:32:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 13/29] ASoC: renesas: rz-ssi: Use readl_poll_timeout_atomic()
Date: Fri,  9 May 2025 12:31:47 +0300
Message-ID: <20250509093203.4014750-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18800

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
index c475d32dc76e..f3a07ac51501 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -308,7 +309,8 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 
 static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
 {
-	int timeout;
+	u32 tmp;
+	int ret;
 
 	/* Disable irqs */
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
@@ -321,15 +323,9 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
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


