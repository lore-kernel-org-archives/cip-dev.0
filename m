Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5BEC47BE0
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 10:41:57 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87304.1767696116047610155
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 02:41:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Hr+uw5cL;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so375821f8f.2
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696114; x=1768300914; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHpfRzHBLlqTvnsIQ0RF7TFQaEwXnI3lmOcPLRGw3sw=;
        b=Hr+uw5cLtTcDe5MVX0s7xLol+/VP8xdXlVL9akyuzo19KA5SQzdSNhWf0Ds/TvPY5r
         0jPUqPk30kzblILm/wCv5iZCoJXPiotyZQrtvVS9PYD6pfJvzYDuMwBXATGRL8mZ7j14
         8ZhbvbPlxNyAyVrIhZ/d/cPwdVanHz2LrF1pnde+dOA2fvGQL3zBKI6PouTC18W/Lzsv
         tPR2AO1SrnAEesY/DZA7ri38XMQROemWTzeK4DX1RQaKvdDG7v571slUX1/54F9Xhvv6
         KM1KtlGh3juotMaDnHyJ+RES30NYAFyj0MoDdOo5vJJK83jxoB+UGHQn9J4LExyJRYs4
         uSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696114; x=1768300914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHpfRzHBLlqTvnsIQ0RF7TFQaEwXnI3lmOcPLRGw3sw=;
        b=f1rcRtx5MWYtHu0rf2dKV8l+cuNDT89c6BbEHGT0MO3CjcPhwPCntgxksc2f5g9is9
         Gl3apHZkMDCfhWZR5YCtjV25jHUr2xNxZbbr124NrE7H/qsgyAGeMSS6GVT4OTAHrnIU
         jQxjiDXr6Xk0v1fl/Scf7iZOSE1ztbY/ROyfSeobdMWqq9yZdfvv1RQRGloFtx66negK
         OWKKxDdUsdfdU0iz/byDYYEKjP/9GsyMUBRQdkkDS4sncDZIGIbZjy9G/BAb/5qMON/8
         VkMbngjrIUQ38qCcLdgEFC/sEN/fnNc/4muEeOvLSbhRJs3xLJNNJded19qwDfJRW+1C
         lTJQ==
X-Gm-Message-State: AOJu0YyomKdSPJ+6aFoUV6O4sJmvUN5XVhcuYkaepVcSECCDa+e9c6Im
	k6cgMdXoNA7cCXxSuA3v75uuN+lRtb4fS1ajf1aDm1VCoqScPzTYzMY7hq1Hlw==
X-Gm-Gg: AY/fxX59GacKX4U69UwJaiwl1LA4EVygFibyOmLyIF/05Vhj39ateNfJFvhsoC0d1aZ
	WC8NGFyuMW8zEZnzMJjyVBnFhSrOijTo7gLreKFJQYE6+SDN16JMxVb7BzJIfGYHjDNH94rp0kW
	kHN+Y7z2RfX9wMnKAFR4pYAJyKjKRcFO/gLsmNyT9pPCYdHRHcw5dQAArQw3sJS72IiEykvFgRd
	Akw9B+lQ0qLiq3IKenOb7XrycP/oj4Iu5pCkIpcV5jx9LJbT1PzGdStBe0K8uUqaqgd+02ANDk6
	J2FjsIDRCTHVxw8t9RUJIM8XTeNMdapqVrWimHfX7EhL5dnQ27DrfP3jA+pqvH/CidCdshximNP
	hXfoVgDB843oFfe7zWn7YGRRG32YNJPYzWONxTpMDVzKJSdtkurI0MbBaRpzwsKhxoVNPWeyKvJ
	VGc7pbkSVW+3d0Zr5eCw==
X-Google-Smtp-Source: AGHT+IHSQ5cZzcsu21pOqTiURu7HVAbadxXxizMuCP+ni5aubQ40Kd+PmPrCyP0l0oXbvyrvJSUy8w==
X-Received: by 2002:a05:6000:2305:b0:431:5ac:1df with SMTP id ffacd0b85a97d-432bca19dfemr3624317f8f.11.1767696114014;
        Tue, 06 Jan 2026 02:41:54 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm3583184f8f.39.2026.01.06.02.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:41:53 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 3/6] pinctrl: renesas: rzg2l: Drop unnecessary pin configurations
Date: Tue,  6 Jan 2026 10:41:45 +0000
Message-ID: <20260106104151.88020-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
References: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 10:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21328

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit fb8a7900dcba3764902ff9f0b3824f8818b3f4df ]

There is no need to reconfigure a pin if the pin's configuration
values are the same as the reset values.  E.g. the PS0 pin configuration
for the NMI function is PMC = 1 and PFC = 0, which is the same as the
reset values.  Currently the code is first setting it to GPIO HI-Z state
and then again reconfiguring to the NMI function, leading to spurious
IRQs.  Fix this by dropping unnecessary pin configuration from the
driver.

[ Biju: replaced raw_spin_unlock_irqrestore()->spin_unlock_irqrestore() as
there will be a stable fixes patch later to use raw_spin_*()]

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250909104247.3309-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 4a442317f495..afe51c72e133 100644
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
@@ -3115,11 +3121,18 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
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
@@ -3129,8 +3142,8 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
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


