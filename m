Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FD4CD129B
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.32298.1711527503047064819
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dDsQ2DeA;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so3121875e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527501; x=1712132301; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLP+HVJJ7s5UZD+KSb9E1ZKiN9ypwYNuAxgrkj2sWko=;
        b=dDsQ2DeAgfDI4BZigc14X01Zc7L90TyM850bXDX+AThIxDrWHFWXgQbigV2Q5/6AOq
         EIP6dRgDI1HlGC2Dza5gPi87oKtd5z/Kop0w04rQF/o7fzs2sWhk8BS0jGaAqWayhHja
         l062BvRriy6ZAQUA0XWIP4XEoFET6bOhQl7eykkpIe26DdFmxGkKYlNcwN+ecyYRNrLz
         DkYK+iRENZdafkEY+FTh95pwtq5W8ooKujvClJTkUCHXQH/8iajdRHOx4j27T5XY8cMR
         vDwiZpX2cIu5kh+q2Zs7m4euaUZrc0AI8e947AsJIhekTFMtldhaGpli59RbFM7c0SmC
         tYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527501; x=1712132301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLP+HVJJ7s5UZD+KSb9E1ZKiN9ypwYNuAxgrkj2sWko=;
        b=vfdWN6l+PS9kaALH4Yj0V5mLbNwlUR/+GNbH1pjrPt5tjQsDsA6BY+tQ79DKNiSFDD
         IJR2hp2IwRs6IqRT52an8RIObPUoOPsp51LOmDUdMdW0012sS6POMQjazPN2cY1T3PBw
         CtF4pF3qPFfKcei5fSvwHoW3Qt6SankgDi+/wZHRYNHNLSaylssT/IJXgK4TLNR/51BF
         49NsXBn5lveigzXafYvStU/doYZHgb3RHNG0OB1Q59PsEw6MfrAiAG2kA+42ljHB6F4I
         Q2ru0IViDimDS1MceNfPCIn1GnDiHXWBBdVLhRSecIfGC1BsAEqtPv4QdL3LW/xlWT3m
         BGwA==
X-Gm-Message-State: AOJu0YyO9aDzrte3tu5/Stl5kRyZDzUFEgsSA2kAQQlFilOo3qzr53z/
	eN9Pshzk7b4HaI8OVkgW+MwlPPr93YE5uhjQ+OJifucHg5Ah4vxS0NU1mpXpZGc=
X-Google-Smtp-Source: AGHT+IE4NBddhf9U6wpMJ8Aq2dk0vWaTHcfzV9GIo+h1TtmEe1YOKnu/0iRVf2/7bnCreEyjEPGOOg==
X-Received: by 2002:a05:600c:1c9a:b0:414:89c7:c0af with SMTP id k26-20020a05600c1c9a00b0041489c7c0afmr3184622wms.13.1711527501505;
        Wed, 27 Mar 2024 01:18:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 20/36] irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset based on register's index
Date: Wed, 27 Mar 2024 10:17:40 +0200
Message-Id: <20240327081756.2228036-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15437

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2eca4731cc66563b3919d8753dbd74d18c39f662 upstream.

There are 2 TITSR registers available on the IA55 interrupt controller.

Add a macro that retrieves the TITSR register offset based on it's
index. This macro is useful in when adding suspend/resume support so both
TITSR registers can be accessed in a for loop.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231120111820.87398-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index b87d7ea46b40..42ad81708b72 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -29,8 +29,7 @@
 #define ISCR				0x10
 #define IITSR				0x14
 #define TSCR				0x20
-#define TITSR0				0x24
-#define TITSR1				0x28
+#define TITSR(n)			(0x24 + (n) * 4)
 #define TITSR0_MAX_INT			16
 #define TITSEL_WIDTH			0x2
 #define TSSR(n)				(0x30 + ((n) * 4))
@@ -201,8 +200,7 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	u32 titseln = hwirq - IRQC_TINT_START;
-	u32 offset;
-	u8 sense;
+	u8 index, sense;
 	u32 reg;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -218,17 +216,17 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	offset = TITSR0;
+	index = 0;
 	if (titseln >= TITSR0_MAX_INT) {
 		titseln -= TITSR0_MAX_INT;
-		offset = TITSR1;
+		index = 1;
 	}
 
 	raw_spin_lock(&priv->lock);
-	reg = readl_relaxed(priv->base + offset);
+	reg = readl_relaxed(priv->base + TITSR(index));
 	reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
 	reg |= sense << (titseln * TITSEL_WIDTH);
-	writel_relaxed(reg, priv->base + offset);
+	writel_relaxed(reg, priv->base + TITSR(index));
 	raw_spin_unlock(&priv->lock);
 
 	return 0;
-- 
2.39.2


