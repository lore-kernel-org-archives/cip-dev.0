Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94981CD12B5
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.32294.1711527494946785717
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=agODiMBW;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-414866f92beso20678995e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527493; x=1712132293; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TrED0DZ9NtpPniaJV6I4bOFHL4c2f3zdXrlJxAizjg=;
        b=agODiMBW0iSI/4tjZr0vPoYcVZiNsJUpoy8qeXreyups0mIYBHCDVjEf0x34XAbjis
         fLjJfLIBi2lyuGRMCxUkB6q0Y57opIqnTlN7PUGoaZDNEgCBbCTkNWTwWqeRYQG4i00j
         MNZJhWFxYmlM1dpYGIJNVVpasNpLZa9InKT3ULzZKcB43rEgzEF9tY2l+chQFTDQh35c
         EU/isDPqxkrujUjc58KwtP5jg5NwFotF2kT9uehrtGJu7/9z2V9puj+8reJi0jetoM23
         9KnAYaAuKuc9rhcxs7gx1SdnKbW8iRRa6/GSxBnsd1swrRhIf0a+2eblJoeJPo0dJR3L
         DIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527493; x=1712132293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TrED0DZ9NtpPniaJV6I4bOFHL4c2f3zdXrlJxAizjg=;
        b=EWXqs8ZUonWNaYS6SDa+1/cpspDFMt8f/dp9LB17T/in4PRURh08OGc4HqoJR44tcX
         C/OjB0q0vXU7XeFFgQQs1CSXLlTwyKshZ5kgkUjCPMYEgkpra1f6osfJzm/ZcH/86x9C
         yriVjHyOXUvg1sWkz6OwrT7oGjn126alezv9jcGsWgmroX3W+qy6fpyUwYiQPUgMvgPu
         Q4A+DQKJNxsDNXzUoeL13gWBZo0usZXktxMqVz6nPzZWOCh3fkviNbsTVEC+NrM+P1Bo
         LiAKbcLFpXPb/aPIeIBvVG8QdMF+HqEYTrD7RMQyEO14Z2ZcUqz/UWgxOXdaVX4TYM5N
         EXSg==
X-Gm-Message-State: AOJu0YxSY8Em1A9nCQ2yLEs0yimCq3v2DJBR2Djalq44xpqC3pDQUBzC
	+RGAwWHrjyWagrIlFkki7Q33L1gFF99mIp0UAP40G2jiU14ZWdvjBbA+T5Xg8DtHh5WszjnXhWs
	d
X-Google-Smtp-Source: AGHT+IGINvshjG5YIehnXh5Ub5dCqTmCsrn7dTfJM8B6nj1gSU11TfL5y8IGIC96AaYmaFtHd+TzWg==
X-Received: by 2002:a05:600c:b59:b0:414:8be4:7f24 with SMTP id k25-20020a05600c0b5900b004148be47f24mr1422017wmr.13.1711527493359;
        Wed, 27 Mar 2024 01:18:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 13/36] irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source
Date: Wed, 27 Mar 2024 10:17:33 +0200
Message-Id: <20240327081756.2228036-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15430

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9b8df572ba3f4e544366196820a719a40774433e upstream.

The logic to clear the TINT interrupt source in rzg2l_irqc_irq_disable()
is wrong as the mask is correct only for LSB on the TSSR register.
This issue is found when testing with two TINT interrupt sources. So fix
the logic for all TINTs by using the macro TSSEL_SHIFT() to multiply
tssr_offset with 8.

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230918122411.237635-2-biju.das.jz@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 17c9f8fd41a8..24701d38c022 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -119,7 +119,7 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &= ~(TSSEL_MASK << tssr_offset);
+		reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
-- 
2.39.2


