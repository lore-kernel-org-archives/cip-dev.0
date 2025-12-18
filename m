Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D47ED6E2A9
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:25 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44877.1766071945203170078
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Opz26cs5;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47a8195e515so6839015e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071943; x=1766676743; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9cxxDTq0ZzRikcy2fC/Yfj5SqrBiS8HWxQiJdkqF8s=;
        b=Opz26cs5fVcBtJVlgO5M1jajLrO8U6AKBkGhvsXZndKDGfn1Cq/HGcYhQZDRIEaftE
         7nLQziddY4pf8H2Bqx6TNC3RGg7yg1331RDK/FYyTfb16y/DqGNyHGloXrxLC7YvEltg
         zJXGy+aRuxJVxBBlUZvi1IOhPG5KQiWFXPf0JETsvrDnnpc9jrsZ1FnpKCcGbvQ87w4V
         jFXJKpNsm7IKCy0kI7IEvTgeS6o3Dg1kMu/X3PMDdvuoM7nQjBbD9ifLQQbQrfTbKupt
         p6IACiHpfr7n2Ksx9BZVPO4JmYn9uFbvjFobX1f2uhZnOfWPu8hSWFDugvc8YawsrU4r
         Slpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071943; x=1766676743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W9cxxDTq0ZzRikcy2fC/Yfj5SqrBiS8HWxQiJdkqF8s=;
        b=YPUKli4MARcznYW5jvD1cZ+50gn3k5OGpsjkLrEezUzC/YbF1ov/4absCikmpQ/qN7
         RQ3HZdsj3/5W5SA5eDjRtm68VvXAA9KT0NOSC1wQWW7HZ6Nl1Tn5Tirl2FIvFG+kOSoa
         0Wquh1QfwWYxOpG67dVTjOvYmCZndpmfZFPPTyr2prVq5AW+C5cJoJ6bq0pL52APlMTw
         W3C07KViwZdfX7GiKK6bDMIQEU/d2ClnoKkCnKg5SccEALgM3UqItixr4QFF3ymV9DQW
         y7A9e+RbVozag2aaWLsmVOplk+jLaFRQUv7yIAby9w+tBylZWEebyHEOT6dp2F/eA3TY
         WcYg==
X-Gm-Message-State: AOJu0YyRLoKmhwoIVzwF1JmX1fYI8OT+63/X76h2uwG04X5N5rvMM5z7
	0zYZjVG7CRW7WTwNlkbhKJbXxTjS/mcIFVmj/4ombrOLU6fSG+Eu/Nl6p3u3Ng==
X-Gm-Gg: AY/fxX5SLcVrT+KebUBV+l+uaPKwwuZryLMrZQqaq3bV0JDCduePuu1weEB6E/MbqZI
	rSwhpqkIfzwubCae7nZtnXOch8WM1ZOa6lW0iYNxZaKcYkOH5KA0zfM1QnJzf+ViRvw76y/yRAG
	mUoSoHaKfyOSbIbVWaEYJdOJyTmu1PgQnsXjAluQmEe5YoYbPWX2nvZpUIF8l63423c4qKSZv2n
	VMzDqex4x4J/q5qZpvAUPlPUbGiH8aNqy6+6+3qniu6RfpOL4nlxybgegf5GeYcco58MdZaK2aC
	0En9qwkzfYo/nfBA7JPmJBNj8L0tDFdrFSwYGv/A7bYvm+qqM5t3v2Nuf6zsSc/H6i+MQlYnhdT
	rCruCiADG9GvCV7zyrrv8So/BljfQWit019Y2Hgz7OYvLDhF8yNaqG1a9CTK3/uYoI0BggwckNo
	vq32Be07oIZm9/OvccZA==
X-Google-Smtp-Source: AGHT+IH5gVAi6lfXQEg7lqcDhjESxBKcO/YRyDNQJV2h0g4oGrEgggRjCMFHy8AtzI29TUWPBk3Orw==
X-Received: by 2002:a05:600c:c490:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-47a9877c6f1mr158101945e9.0.1766071943316;
        Thu, 18 Dec 2025 07:32:23 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm5637772f8f.40.2025.12.18.07.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:32:23 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/12] pinctrl: renesas: rzg2l: Drop unnecessary pin configurations
Date: Thu, 18 Dec 2025 15:31:55 +0000
Message-ID: <20251218153219.228506-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21131

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


