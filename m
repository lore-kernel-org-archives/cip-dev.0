Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB24FCD128B
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.32517.1711528521518579148
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=R/n/IrQk;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41488f9708fso20351755e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528520; x=1712133320; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5Dudfu5jvncBoxABSbnmSnuPj4UMJnxtxSyuwyBwyc=;
        b=R/n/IrQkttlkCxs7pM/GHbRMgqe/30xyS115zExYPdIBV0IbyCHsehVEsjKhNB0gJ5
         Xnokl5NeZmE7qL43iNyqfwtpxMi+LpLqa93C6RbuuqCU7LEx1t5MerxGiovPxmNTsc0i
         Ev5hP4/ZX45Cnyjme0Fe91OgTLlxVSlfyL2V1Qc6o/CSNsa1qzAEzrJpzOvfHmo9zWjd
         7kgKq/8G+b2Uq7JS27b8ZwQoykydyUDTTJP6ItLh87ywI4LhJprIy+aRCdgNxwPeO7cf
         gCd0euKaP+kzjjGRuUdivHqDnRnpEneJEaW+9JBH/okp8z4XQAb2zfMx1lLQFTARgKy/
         3MjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528520; x=1712133320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5Dudfu5jvncBoxABSbnmSnuPj4UMJnxtxSyuwyBwyc=;
        b=TjMRoT6r+SAn7gPsSyeIV/a251lWrsauaxkJcbHGl0/sjv8KhHaRxFPKT0yJ2PbRfb
         BwDkHVAOylEEDuxEG/6T0Uw4AQwRHgd+hHBAF28vE7Fu6cMAqCqw5ZOdJmJlGxGNXxek
         2JoXy1R1CDMX4SaTGOIOAvN8Tyzm6PMbPmq4ZkKa08JGvGYlEfq33inSL80+bVTj89in
         37k76imvZjioPcNbRuTCsdw20SkEI2kvSOx4GvkO3/jt+/hxagRnrftjsE1mtABtEMAm
         mz/RBFc10a9NLrI3BibWlKqLo6281Ngv+TCm+zwgRjGCCb5FcChQb1kkzhhdS7cnMMvE
         pXEA==
X-Gm-Message-State: AOJu0Yw557xbHwIBFE9xKHsX8wWace/d5ctf2Xx4KIglEwAIzrW2V2pi
	Tfwigc0tVbaSdV+q7p0IQlInMgNmwLx+Go5pYaJL/fc7TG6HU+ksJ48oMIY1YC/arTPXUTEBAjR
	a
X-Google-Smtp-Source: AGHT+IFVGvmTahV7Dy0rTfqT8hkWGs1dEoBGPxBdLfH9sLVphgV5TPIE2ysEautDolJPWrvjbcmQ8w==
X-Received: by 2002:a05:600c:1391:b0:414:7ddd:b92e with SMTP id u17-20020a05600c139100b004147dddb92emr1292563wmf.39.1711528519947;
        Wed, 27 Mar 2024 01:35:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:19 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 09/13] irqchip/renesas-rzg2l: Flush posted write in irq_eoi()
Date: Wed, 27 Mar 2024 10:35:04 +0200
Message-Id: <20240327083508.2229567-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15463

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
index 34add75080e0..552bc7fa7cff 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -86,8 +86,14 @@ static void rzg2l_irq_eoi(struct irq_data *d)
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
@@ -98,8 +104,14 @@ static void rzg2l_tint_eoi(struct irq_data *d)
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


