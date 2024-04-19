Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435AFC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:38 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.15314.1713514711147304953
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=OCC+G5Ck;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5568bef315so312470866b.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514709; x=1714119509; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHVzgjXbfTrCSny9eYfxnklDdEKzyWdujMDMUKZpe4k=;
        b=OCC+G5CkjpB+ey2EzjEcfz54hSV4NBrdR2ADsTmBTJ8Ieyfx2zwc3e6wAgpjrVqNcp
         OTr2uKIOgFtwAMKRSrJcC9yXHyqEtBELvSXbMkn6l+MJhhKoN8LfG/jdUTL8WSZTuTxl
         prwKlXMbHALsHTYGeTtxJyPaUuC0EKVLcmSNwWm4/n5Wm38RTdbAEZp35RfSARUIZ60s
         31ku0ZIlkMMvEGp3OyEHEuZNioL/XRfjTW9H3PNrIPqd/ZNYIqGHVXRgG7asLC9x8Eyf
         z96jKzYk10GkCdrE0EiewRG8IKmAcxAJjGWGxgcb8rPPYkptEEH03q0/FD2GmXu9qoUY
         SVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514709; x=1714119509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHVzgjXbfTrCSny9eYfxnklDdEKzyWdujMDMUKZpe4k=;
        b=hRWGwI2b5XFgGNgPQn2PZchfTQjt1Yr797cO9fYso8plz5nKrONYKcGNKLBkrYsZeR
         PKir5Rci5nULCLeJfXkSZsemB63mB++lnJAfST808eJEC9om0RP/cKxvM+WRQZIJ/MVd
         TjFlxJP9UQx4z2/VP2YHFLXKwo4ldvAp/1FAoi7qgquPtEs6j69+4Lv0Kvg6rIg0CO3m
         21Y51nGf5UheyZX/IYKqp8c+aa7IfeWLkVFYnwL/vftsMEiP6pQG5Qz7KS1Id0MXq6lz
         bebspon2jaVzjbEJ2gtFbUNATbd/XuZzG59Kyj/ClQ74TG+ovUCQzITFjF3Y3/cnSxZv
         wD7w==
X-Gm-Message-State: AOJu0Yxu4JgyWOdqhsDZzh2FzPVjym+Gzb80BVn+GAvhYr9crzZSnavw
	j/9R6P1WQY0QMWm9gxNbTronK81nLuIcRQNBfESn0qEWigecXJ0g7JIc/Bf7gAA=
X-Google-Smtp-Source: AGHT+IH2Euux8EDy52EQsQVMyKmlwc24OrVxraFsuIlh8+Jb0JQ9qPpNUPSpNkIMuOe1dmCn98dnxg==
X-Received: by 2002:a17:906:b041:b0:a55:5520:f43f with SMTP id bj1-20020a170906b04100b00a555520f43fmr3548636ejb.10.1713514709482;
        Fri, 19 Apr 2024 01:18:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 30/53] pinctrl: renesas: rzg2l: Make reverse order of enable() for disable()
Date: Fri, 19 Apr 2024 11:17:19 +0300
Message-Id: <20240419081742.3496709-31-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15617

From: Biju Das <biju.das.jz@bp.renesas.com>

commit dd462cf53e4dff0f4eba5e6650e31ceddec74c6f upstream.

We usually do reverse order of enable() for disable(). Currently, the
ordering of irq_chip_disable_parent() is not correct in
rzg2l_gpio_irq_disable(). Fix the incorrect order.

Fixes: db2e5f21a48e ("pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO interrupt")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230918123355.262115-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index e1d1142637ae..4802c6b1302a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1171,6 +1171,8 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	u32 port;
 	u8 bit;
 
+	irq_chip_disable_parent(d);
+
 	port = RZG2L_PIN_ID_TO_PORT(hwirq);
 	bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 
@@ -1185,7 +1187,6 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	gpiochip_disable_irq(gc, hwirq);
-	irq_chip_disable_parent(d);
 }
 
 static void rzg2l_gpio_irq_enable(struct irq_data *d)
-- 
2.39.2


