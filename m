Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57070D7876E
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 12:29:29 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15748.1766147361113686517
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 04:29:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ecHto8Gb;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b735487129fso299650966b.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 04:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766147359; x=1766752159; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpBlHOFgyECFugPPqbLrjL7Xh4V+JnofWU4/JLoX/b4=;
        b=ecHto8GbT9mioEYCUb4EGs152ouGbac1vYEM0WZLecGSzaKAR84uLUUa4um5+84Pkv
         sdLquV8NUlgbtBkus+COw+PPl7SUkcQYjjO6qPjhgDlpbeVGYU1Ce1PB5CFZUXhBW1Jq
         y+SDUUL3LysFJWwUpd6YRFQwSaPmePDdYbjg7ie5cPQqNBOuaUHVhWGsCWoOiyBJyldI
         mIgSQAG4djEjWGSHro9LYQ8GRGJkkk+eSxvY53dr2trEixUR2QWBsBrsDbnLtGlzFCxq
         X1VJCZylRuhQNdKUsXWE0ufhvN1lI4n+SwwNo9OsHv2TQpqK1W+UCKv2hEAYxCPQ6+yQ
         qHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766147359; x=1766752159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpBlHOFgyECFugPPqbLrjL7Xh4V+JnofWU4/JLoX/b4=;
        b=sK/Q0akSz2alSlsJ0xRaPRgohhj90eK+g5jKB7gzDTrAmBmVrxM9M3dC2A42KJWr2I
         XdtmKkunhj/pU1q4tRt/YLu9qzIPUOXWlYWdnz4qKuBTH1FA1F3rpGtxhfrn2Hhei+EZ
         ym0YYzbO1IwUZnVoVxJh8Jzv44paEElMhEsbem5lXtJJNnNtsmUOSSCItKv13KvPUSvC
         7TVE0sj8uEAFbBOulZ8epH7ns9JneEh9Vws/R0QOSNBnuPRRwFNrsToNaTm7Yb75NRyw
         FPd9K3pOCeqhVGFGxiJZ0UFhzkovBwjrZZ6ztIq968CZN0CO1kPaPsmWR92YYBye59e8
         vGdA==
X-Gm-Message-State: AOJu0Ywn0GHH5v0MdbdZ2QIPTnn0P5hRmv7O4rPaq2uN/DIF+BgN8xKc
	A0jRWM1Y0/GjLfr3qAD7d+HxJ3ioP83dIplcLciFJlL2mMO129ArCT597EH4rw==
X-Gm-Gg: AY/fxX7XeXk0kt3bPQE4YzvXOcEDvnFc1y2ND/KDRMT3ES7vze514IMdwwlKSkf6Tf6
	004yOTWeJctaoX5Fq9DufwG/XRSYOKEKP5M1QvNYITUCaJ/NIecVnrHrLf80X7wyPzT03UtCHbK
	KCExYUXnRjb2qBnl6GG95ekkkRbCiEIU6qS4erM5+SrfBWjawkQE3LH+yBnPMwMWlvfR1vu0lIp
	4IiXK9xv7FFW1GY6ezM05rk0+qaBbk8IjsdpL3pCQdBheTI5vgAPZcfucTC9j4XWM9b7QR98XbK
	kOhbgvyKLnehlOPQxGQmNe3Uqv2pPb2WWRszjQa0Cfil7XUw6yKGnPr8c3OktpqwNMJqhUbgSzS
	BGFepVxsdFu4FU9WD5BkUIuNB2+YJp9rUWJaoTBJu4QaT9K0dezclYiKXiH6+2L2yw6sVpW0rF4
	Y8+rK3zpqERWVYe+ih5N8EnoJfdytMyXml5w==
X-Google-Smtp-Source: AGHT+IFpYOQjU+ctlhsXvwM+m3uC2wczGfKH3NrkgZSh/NQqwv+YemDASHJrMOOJetxsvsrqLR4cdg==
X-Received: by 2002:a17:907:3d42:b0:b73:a0b9:181a with SMTP id a640c23a62f3a-b80371df391mr278492866b.54.1766147358926;
        Fri, 19 Dec 2025 04:29:18 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bb1:f7ee:1376:35e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f511fesm223648666b.65.2025.12.19.04.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:29:18 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/5] pinctrl: renesas: rzg2l: Drop unnecessary pin configurations
Date: Fri, 19 Dec 2025 12:29:09 +0000
Message-ID: <20251219122916.129256-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 12:29:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21177

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit fb8a7900dcba3764902ff9f0b3824f8818b3f4df ]

There is no need to reconfigure a pin if the pin's configuration
values are the same as the reset values.  E.g. the PS0 pin configuration
for the NMI function is PMC = 1 and PFC = 0, which is the same as the
reset values.  Currently the code is first setting it to GPIO HI-Z state
and then again reconfiguring to the NMI function, leading to spurious
IRQs.  Fix this by dropping unnecessary pin configuration from the
driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250909104247.3309-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[ Biju: replaced raw_spin_unlock_irqrestore()->spin_unlock_irqrestore() as
there will be a stable fixes patch later to use raw_spin_*()]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 8b5a8f0b2c4d..d6f69532a0e7 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -541,9 +541,16 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
 	unsigned long flags;
-	u32 reg;
+	u32 reg, pfc;
 
+	/* Switching to GPIO is not required if reset value is same as func */
 	spin_lock_irqsave(&pctrl->lock, flags);
+	reg = readb(pctrl->base + PMC(off));
+	pfc = readl(pctrl->base + PFC(off));
+	if ((reg & BIT(pin)) && (((pfc >> (pin * 4)) & PFC_MASK) == func)) {
+		spin_unlock_irqrestore(&pctrl->lock, flags);
+		return;
+	}
 
 	/* Set pin to 'Non-use (Hi-Z input protection)'  */
 	reg = readw(pctrl->base + PM(off));
@@ -557,9 +564,8 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
 
 	/* Select Pin function mode with PFC register */
-	reg = readl(pctrl->base + PFC(off));
-	reg &= ~(PFC_MASK << (pin * 4));
-	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
+	pfc &= ~(PFC_MASK << (pin * 4));
+	writel(pfc | (func << (pin * 4)), pctrl->base + PFC(off));
 
 	/* Switch to Peripheral pin function with PMC register */
 	reg = readb(pctrl->base + PMC(off));
@@ -3111,11 +3117,18 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
 		pm = readw(pctrl->base + PM(off));
 		for_each_set_bit(pin, &pinmap, max_pin) {
 			struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
+			u32 pfc_val, pfc_mask;
 
 			/* Nothing to do if PFC was not configured before. */
 			if (!(cache->pmc[port] & BIT(pin)))
 				continue;
 
+			pfc_val = readl(pctrl->base + PFC(off));
+			pfc_mask = PFC_MASK << (pin * 4);
+			/* Nothing to do if reset value of the pin is same as cached value */
+			if ((cache->pfc[port] & pfc_mask) == (pfc_val & pfc_mask))
+				continue;
+
 			/* Set pin to 'Non-use (Hi-Z input protection)' */
 			pm &= ~(PM_MASK << (pin * 2));
 			writew(pm, pctrl->base + PM(off));
@@ -3125,8 +3138,8 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
 			writeb(pmc, pctrl->base + PMC(off));
 
 			/* Select Pin function mode. */
-			pfc &= ~(PFC_MASK << (pin * 4));
-			pfc |= (cache->pfc[port] & (PFC_MASK << (pin * 4)));
+			pfc &= ~pfc_mask;
+			pfc |= (cache->pfc[port] & pfc_mask);
 			writel(pfc, pctrl->base + PFC(off));
 
 			/* Switch to Peripheral pin function. */
-- 
2.43.0


