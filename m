Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52901C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:25 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.10420.1746783315327510047
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=UfKTfqP0;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acb615228a4so575054066b.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783314; x=1747388114; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oApYAWMTBqrBTyY1Kl/d8XBxeLGgBXtQiFLhI8S536U=;
        b=UfKTfqP0+8LEaJKNk0X6c8A//gfL9NlbSBBCzyw0dt32/sfmamFT0mtKLLsWF14QTI
         txHczI9AIrM7DOgFmSkz1a0fPZqtPuA6dHMQvR7tngkMx+VlqQC6/cS3sZeg/g9dZhym
         6jGuBRZ8T7K8UDPLfDR1eyHEamYPZ4xQZZL95ZffpedOuP7iYe96+Auv69lAo+8z+Ppb
         Nd7FWdJRdnhjRZe87knEV5E4XAxpjzJcsnMcZ8tCTK5PvaudVpCEFqx+mY1ICikbtd7b
         93rJ/YCokPtz5RSD9psL7aduH9HBRFXQsEfF88zdzcoPGyVTle0xqBxjguH5nppXzM7m
         2X1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783314; x=1747388114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oApYAWMTBqrBTyY1Kl/d8XBxeLGgBXtQiFLhI8S536U=;
        b=cXItu8rpK/3t5kt+NDMD62h7KMqOdbIT6rCqF2fbUgODZWCpAm1tS2FLoxMPuc3pKu
         ZXfJN5moGko0X1PalKShXNZNrFUxWFJC2qVR4tek/GANitO/pO/6tRQ4nK9hafFlTQl+
         jdjJTtEkXdhQ/LYWNHrLxPVZbnslEH/XMcioCHXVzp9yH1F1MAdZb3Fwc7xS8vs588/e
         AG9b+R9/PFxoDA3bydGHm4i6gsJg3Vx3DNNwVagbmsS3EPFLP8vxiuEogzZkqyce3pM5
         8piT8ulw/ArIcmJeb7d4uDEGq9GMU9YAjJLxdqM78HeRLUEVtsFbXoxVWtxRxaliQtQO
         7RbA==
X-Forwarded-Encrypted: i=1; AJvYcCXPLZCQEnb2Q89Hr4xnuWQrkDW3MjHautUQL2l+Kl3lLRYwgyXX0SMNUsKoJ3VvYv/xHHCXDzcb@lists.cip-project.org
X-Gm-Message-State: AOJu0YxGn9FeZEpqI+poH34jznmISAfkTvuJrJaJ5ec5oEhqSgM+Orje
	yAM6aizNi2XQrFdpcy5ltAFvZU/3+on+/iPgiap89p1erhw+OHTpHB8JQ3GIOeg=
X-Gm-Gg: ASbGncvEYk+yT6sdoxFalR6/r+RGJQwrfilrr7sFw8bLsjcXYIQLoZptLBP7ptCNgaC
	oNdODsYixBVDWcVh8mQJI9g2hXLtYSNcsK9Fh+Egg8UvuJpQTGSmywlNWF3kwrNITxheNHloWIV
	Ci+Wm9Gxfc43v4v2fi2zSwLmmxd9gfd50Tj5OsNFZtMblpxJOYENePQ93EXzSYfCXpFkAEKV5le
	Rzy0UEZxA+0E7mZGPetRj+EKpdVbDmnFQ93GsGoonQATtoP1HmwKXC8TlE3gXJZdD97FNi9Fcjd
	upasrm4aPCV/RiwT5T7zPFK1pF3Y1qzHl4kQ0FX55IEUxZoorhyBqbSwnDv3w4hW9qMQaQ==
X-Google-Smtp-Source: AGHT+IH++zNRQAZ4XyIIwTJrrj3p+KRQLdCGcqP8aejnAJJB46QSWVAl3QEmeBdJUNRyYNkkt2paaA==
X-Received: by 2002:a17:907:97c4:b0:ad2:134d:d64e with SMTP id a640c23a62f3a-ad21b425d82mr200250366b.19.1746783313629;
        Fri, 09 May 2025 02:35:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:12 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 21/37] ASoC: renesas: rz-ssi: Use readl_poll_timeout_atomic()
Date: Fri,  9 May 2025 12:34:26 +0300
Message-ID: <20250509093442.4015145-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18873

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
index ff8c04d4c07f..2b9e649d641f 100644
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


