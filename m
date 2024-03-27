Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351E9CD12A0
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.32300.1711527504375496332
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=oDC3DkPO;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4149529f410so2113095e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527503; x=1712132303; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXhsOYL+B+HtTzFlbtmT77Lo94wVvQRAj6kUPbLYrjo=;
        b=oDC3DkPOyuLs7oA7lfEPPpg2tplXMIEV8QREeq80L2Gp4p2MX47qGomK+dZcVD6dwE
         3CY2KNm46AHElZI3AdNogNIlFRLoc71mOdKP8lTukUraJB3u+y/l+fTwgiazBWGG9eFf
         lyCmM4y0Vi4ByH3IkGqVLkCm46N0PKVTvPkvU79hqqAM5LwCbrGAY61BA57fjVHpWXW9
         wogJlJdqT0Rw5reLI7q7d4V5Mgbpl4n5yjUQZGndItLP7UQTLNp4Q6GR5Yra4wIslmfJ
         1EA1VnlJBS+zbdHLiljxLw6qDH8i9/jaVbEWT8qX2MbYPcmfOl2HZDolwBulGbqWhGqH
         ch3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527503; x=1712132303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXhsOYL+B+HtTzFlbtmT77Lo94wVvQRAj6kUPbLYrjo=;
        b=Rq61674fTUJpsB2cQByObHe/+2hdfeQQO3suzcBG6DY4fnBjS5ZCIB4J153l4/xYE3
         yqe8ozB6b0AWhHQc7/A1l2lFzUcSXYfSnD6Tt1kNBQ4zrJSm0gOERUqNe6D0Zi8uY+8w
         ksr41pZS0ogQpAI8q7QrNEIILMdOBlhEsdxzTVO5t2gIDZES9S7gogextyr0FPSSQ3nS
         d5nA+Mk3MynPfyhU/ZgwTmbP/VAme3/B/+GFgqhmpXU20+Sw8a+lVHg68Bwxpcf5EhRa
         V2qok7gIIwh7GMRIBBHHvpxtH+Q0pqVXHoL7RMGTNsSn2WMJNOXNPMv4UgSjlUD06bGA
         pwRQ==
X-Gm-Message-State: AOJu0YwNLxlrHzYM2u0Hb8jruIaSdoG3f8a7aJwxGMIt4bLGUkYO/aZ4
	YZl1QV88Q799tEeSL8TsclH1ARYYc1oOIs9YO/K8URPq67GwxCDWqix5AM9iRFQ=
X-Google-Smtp-Source: AGHT+IHhwsHNXfuaMIFZ5u2uloYVEkFUe2gABTxmowJw97m+LLQRl2f8vzW62LKONo0OCoxT1yzfBA==
X-Received: by 2002:a05:600c:458e:b0:412:d68c:8229 with SMTP id r14-20020a05600c458e00b00412d68c8229mr1709747wmo.39.1711527502820;
        Wed, 27 Mar 2024 01:18:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 21/36] irqchip/renesas-rzg2l: Flush posted write in irq_eoi()
Date: Wed, 27 Mar 2024 10:17:41 +0200
Message-Id: <20240327081756.2228036-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15438

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9eec61df55c51415409c7cc47e9a1c8de94a0522 upstream.

The irq_eoi() callback of the RZ/G2L interrupt chip clears the relevant
interrupt cause bit in the TSCR register by writing to it.

This write is not sufficient because the write is posted and therefore not
guaranteed to immediately clear the bit. Due to that delay the CPU can
raise the just handled interrupt again.

Prevent this by reading the register back which causes the posted write to
be flushed to the hardware before the read completes.

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 42ad81708b72..79ce7ab4d164 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -87,8 +87,14 @@ static void rzg2l_irq_eoi(struct irq_data *d)
 	 * ISCR can only be cleared if the type is falling-edge, rising-edge or
 	 * falling/rising-edge.
 	 */
-	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq)))
+	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq))) {
 		writel_relaxed(iscr & ~bit, priv->base + ISCR);
+		/*
+		 * Enforce that the posted write is flushed to prevent that the
+		 * just handled interrupt is raised again.
+		 */
+		readl_relaxed(priv->base + ISCR);
+	}
 }
 
 static void rzg2l_tint_eoi(struct irq_data *d)
@@ -99,8 +105,14 @@ static void rzg2l_tint_eoi(struct irq_data *d)
 	u32 reg;
 
 	reg = readl_relaxed(priv->base + TSCR);
-	if (reg & bit)
+	if (reg & bit) {
 		writel_relaxed(reg & ~bit, priv->base + TSCR);
+		/*
+		 * Enforce that the posted write is flushed to prevent that the
+		 * just handled interrupt is raised again.
+		 */
+		readl_relaxed(priv->base + TSCR);
+	}
 }
 
 static void rzg2l_irqc_eoi(struct irq_data *d)
-- 
2.39.2


