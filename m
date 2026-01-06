Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCF9CDC185
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88526.1767701184156797150
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l2uTmPq4;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so6522735e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701182; x=1768305982; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9cxxDTq0ZzRikcy2fC/Yfj5SqrBiS8HWxQiJdkqF8s=;
        b=l2uTmPq499Ir/zObzRuiJ6VNpFrcDNeve4f3Y+Yvox5XJC0sGpHHOEl5B7T751QxkT
         USFaboor8CndhkRXXjnhnvFJTYcL1YpOBRz3dcq/ce/vHKa3Kt7+FZDdyLhh9LuJKq/1
         XBpv4q+yJ8JQpxIbxrS+F4FUDwtO5ksDunxRsQaZOzOdHk9ABpMXLb0V+VSGTQS9ZMme
         wZ4g6qAsMj+cGfHmtQtXNZdlLS61ZGkOlt2coYRX6q/rm+P2bsUA/oian8gasde9ycTy
         6u8BjHDb5W2rmdxE1diIJ2LL5Lq3JCswHwTSJ5SnmbXTHHh9b7HOzQcygMw74ibNIsSn
         80pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701182; x=1768305982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W9cxxDTq0ZzRikcy2fC/Yfj5SqrBiS8HWxQiJdkqF8s=;
        b=nb+Hmj+/KborCd4B//3U/83phGp4a/8Su8axFWrzBquBDB4xY/cjpMpoodGFugQmot
         ZCJPvREZ6Mwf87EfvP1ojiCy1oFLhvy7h7CM617zyZdOghbRe5IT8e1zk+Vs1wL6YIjd
         pvNx/wriaDRwEJ6PKoPRRyJSFqEB6PlTlL74SdMBjDQ3j5eDCFbTO00grSS8LpOVCRt9
         hWVgECyFQk62d52JpqBorNhpLbzTMJgZfD6Tw+3iZPF/V6IwnKrc+SYfOPs3yw/ELiiO
         CScIGZ2oE8fRjrPa74j+jOUn3SV1cab94NFE0sdr5KKi0TU8AO8VzaOEyvDxEFcWjoc/
         iMSg==
X-Gm-Message-State: AOJu0YzkrpE8cpc4K79dTN5sgaBpZdk7GgkiJuy/7xn0AaCj9WNsVCD+
	rT5PaEXOiqBqw4Kj1+mGcG5DR+wgmSvT3Y4W5rs7eBUoNsnm7XgStJND6F6PMg==
X-Gm-Gg: AY/fxX5SJgXGIYK5iJMt9t6Ok1BV46szKYWmqdxKccgUT+/icJUzNTyT/i+uRrafCYl
	OxEUOGqQ/thEuuGdCACnQJBV0QXXwJLQ8Ss60mndIBq2F9SBs03TIsrW3ELkIDDN4Mo3t8Cn4fc
	O+Cc9sXboKRv4QLTWQSoHGw/2v0Niv1CBRGsdnfMW6+8dx32pSycFDgeMc7N4tcLIRTzB5J3j8x
	GrSAbb+/+EE+Ym4VQdluOGoHBBQ+EOK1lyrdyI6I6MRmCyYpMfguX/WmiyU6dtGQDceBLQn2fn9
	zi9WGVe4+2MQ5K89IAO/+MC9k/F2AY1KzlXTZhcnrv86VB+YW6ECbqHr5AYIoAYTdIXBNCXxR26
	V06mL5ET9TuizHyzk3xnpSHMPqvfXDEOpqqk/mrN68TMC4zsWFZ5fbi9X8UK/wHC89VydJKvrNp
	yIOD8V5MvIU5QNAqSwnw==
X-Google-Smtp-Source: AGHT+IGBwCiXjFkl/nQlfZ2yFzzVfdlN1YM40FfaBCURh8nybBRo6W/rgPCgTL3UJfEzphz+wecu1A==
X-Received: by 2002:a05:600c:6095:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-47d7f077b2amr27600155e9.14.1767701182197;
        Tue, 06 Jan 2026 04:06:22 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:21 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 06/13] pinctrl: renesas: rzg2l: Drop unnecessary pin configurations
Date: Tue,  6 Jan 2026 12:06:03 +0000
Message-ID: <20260106120618.181104-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21366

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
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 7b22921e6840..6a87da0ee50e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -540,9 +540,16 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
 	unsigned long flags;
-	u32 reg;
+	u32 reg, pfc;
 
+	/* Switching to GPIO is not required if reset value is same as func */
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	reg = readb(pctrl->base + PMC(off));
+	pfc = readl(pctrl->base + PFC(off));
+	if ((reg & BIT(pin)) && (((pfc >> (pin * 4)) & PFC_MASK) == func)) {
+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+		return;
+	}
 
 	/* Set pin to 'Non-use (Hi-Z input protection)'  */
 	reg = readw(pctrl->base + PM(off));
@@ -556,9 +563,8 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
 
 	/* Select Pin function mode with PFC register */
-	reg = readl(pctrl->base + PFC(off));
-	reg &= ~(PFC_MASK << (pin * 4));
-	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
+	pfc &= ~(PFC_MASK << (pin * 4));
+	writel(pfc | (func << (pin * 4)), pctrl->base + PFC(off));
 
 	/* Switch to Peripheral pin function with PMC register */
 	reg = readb(pctrl->base + PMC(off));
@@ -3128,11 +3134,18 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_pinctrl *pctrl)
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
@@ -3142,8 +3155,8 @@ static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_pinctrl *pctrl)
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


