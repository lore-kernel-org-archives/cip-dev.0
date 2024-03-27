Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F60CD128D
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.32513.1711528517278649678
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qf0bkbrv;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so362150f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528516; x=1712133316; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Fze5/lGaw9sDH4GuBtKEA1ITP5tQphUFfDdOOSgiPk=;
        b=qf0bkbrvyb8Q9+SjmgeQh6iE+UsqxYd4e6PmM+IXVlHNLA4YgfQg0DTUKD+YxZcgL/
         mz7l/R6q6j6HTDm5PZ7zkp1tMB4Z7qdDbnXiL9nVRtALQbP9391nelXHslnU3nQQeE+4
         5AK+OENBdHA8HqarvzVsjNgJpLmeaRlQ0xZrgNWUytEZM/bVl4/yD3r8SWcQHlLtOd79
         XWJyHolU80fnYO6R1X3u/5HKxCoKQSttHJqQei/fF5QdSdzrnHLoVgrw+kpwtiZV20Oj
         OzKAh/KPEC79LW1v5Nnag7SOSBtDAEW4FRLaZd1h0MQRcD+wi781DHpWOinBIjqTRrEd
         d0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528516; x=1712133316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Fze5/lGaw9sDH4GuBtKEA1ITP5tQphUFfDdOOSgiPk=;
        b=nXS6eKppOcVaDf8Mh15TijCV/3CqKauGgt1Mg6j8QMkH4TJ4jSD8qe5FG3mBXVlHSu
         zrHT61B0sC1VG3TdOh4FcAUnt/PdHrKwfG20m2KSQFxKkUC4bDZ13wGh8o+U8iDgvB+D
         p0IOvd9W2KrprrNqlK/JezVZ6TFN9RCmSezo2CJ908YNs1m8p0xyLEDEP755j6rwxfoI
         Yldu1VkD19IaWcFqo0uAXwRFpppCmzNRpfX8hgRh1ZZa4UYElcwJQJwARcd/cPZOv/W5
         WAumAuByJt00RkbY0hJvBUG1f20hdhu2uK4FRi7UfMsedaa4N8dVgKifqfSkcoPnkYDj
         dQBg==
X-Gm-Message-State: AOJu0YwT1Wnd2OE8Ip8ajyHWCk2B49BJCmwaQCmtbYxKlUSEdEWVsW+p
	SJR830Mi9aYc4KYiCeYhDCveaO9s9kPGXAC0PL1OMUzMDCRYjrEOCCwMXqtPJd0=
X-Google-Smtp-Source: AGHT+IElQHW/AxqYubxAUUlh+ekGMrzUjBZBrp3K0ZSJbdFbM9m4n0FTVxPmSCQblnYhiC929nypsw==
X-Received: by 2002:adf:f1c8:0:b0:33d:61c7:9b2c with SMTP id z8-20020adff1c8000000b0033d61c79b2cmr3362106wro.34.1711528515760;
        Wed, 27 Mar 2024 01:35:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 05/13] irqchip/renesas-rzg2l: Align struct member names to tabs
Date: Wed, 27 Mar 2024 10:35:00 +0200
Message-Id: <20240327083508.2229567-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15459

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 02f6507640173addeeb3af035d2c6f0b3cff1567 upstream.

Align struct member names to tabs to follow the requirements from
maintainer-tip file. 3 tabs were used at the moment as the next commits
will add a new member which requires 3 tabs for a better view.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index cc42cbd05762..90971ab06f0c 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -57,9 +57,9 @@
 #define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
 struct rzg2l_irqc_priv {
-	void __iomem *base;
-	struct irq_fwspec fwspec[IRQC_NUM_IRQ];
-	raw_spinlock_t lock;
+	void __iomem			*base;
+	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
+	raw_spinlock_t			lock;
 };
 
 static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
-- 
2.39.2


