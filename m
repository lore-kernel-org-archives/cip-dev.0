Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD27CDC183
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88527.1767701185494432946
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kMjH+Hn5;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso7302555e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701184; x=1768305984; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAUC78wbB7u+PKgJS3wc1ZuPZsehqOBpAU/uWi9SRdg=;
        b=kMjH+Hn5c982yMscPNU7YiqSQNRePwN6U+nYPVBhgUx59gY6oKdNr9vwPIrDXTEgyj
         cedjC+yAnPEGU2tvU3oaohnW/EpMs6OGyLtPhYfrIIplNsgmxBGV101CsdbLlumS2tTr
         k+XySKjuuyhhxloPUaTiQJZyaulbGljo6rNLi4AQE9g3hJOKW/L48y0eAngDZ77b5qb0
         17DkEE/KByKlBxu8tIOe2LFvuWv/bQej4Vu0MNeYwmrCqL8ZqKZtcGLVcFCHUlzILTQE
         +g/9DPiWPlBB0sc1LLfwo2geo4oGAX5Iwi2apa6RKFUbT8FHaWLaLXEeYcM3krTG7Vkg
         9wDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701184; x=1768305984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QAUC78wbB7u+PKgJS3wc1ZuPZsehqOBpAU/uWi9SRdg=;
        b=EOal6sU65gHnEzFKs0HZIthquc6zk0dwbbv4qlV2VSFePastR1oBJmQgVQ+K1LYyF/
         DHo4rLgtTqgQHn+r1bcQxppzLs3v3ujGj5Sar3snbIgwhBCsWDu0mypS23CNRkF+lvM9
         DWLSSC4oo5ZKvFy1NWjx6JnBXe0nxLBj+fxdXBiJeocHR/8KqFGtpvebqKLUGGWNhDk/
         jSgbci+nGb3Yfa1BXspnbS3Kgddx1gMMosqzYtRtRLmrmQE9PlbsuCzmpWfuUhrpZ68W
         hbx9zDUtaqrHp6+73SIs0PLjZ+uBwtM8Xvv9S2mzZACoLF5Lt6Wvbw76KRJbfx/1vBj1
         9yXQ==
X-Gm-Message-State: AOJu0YwzEloma+wmuSLOuJ7n6/mo37Npm6FJDdT7TdLTmXyWqkMiTmr7
	M+WDyR3naBUWiQ0nje5eOalB2R2tkTCpoKxRnBoaaud17CyeYG6+jYkasCb2Xg==
X-Gm-Gg: AY/fxX7sNkPwMvDyIhoDpx7uXSKGv8JMwL7SXHHk2/BL3A9CXfJul1ICTysLbpBlUsk
	J3FG7JwPTFIWjtp8Ayt9roM6uuKPJyGP6pQR7s/Gt+m5VR4b/jg0/SEPbKM7KzWdbJJAb4idhxt
	2yLopxtnbVE39IaG6uaJ4b9VTg2pagHzMmd6WJRkWxNW9EY+BH07zEGQaOCzL8lXoi47SW+gYxc
	ryIJeXyemt8o85IlZkyyUSCC2lGI19WhppGw+VaoanVNg2AvJdw7sPBvoClrIvrxVlfBKmwaJA0
	CwoXJFUmON9OWaLk5NVaXXU0Jh6/trLrOQ42hy7Y6HiFcdnTTUsrj5GBkrwn98Q+PYxSznh4gUR
	ors1kJA6ONV5leofjjng3QSR/Vv6BRUHJehjNE30MWkEwAlmjwpQUhUaeDl6I6sscPMnM5c8EqS
	AjAhGT2p8curshPZCfQA==
X-Google-Smtp-Source: AGHT+IEsIR4BuTItZXiOKs8WjZULDHe6Ji1m2LW3ivJz5whth908/cXCM/dfFNwESUwCT7jjzWHdeA==
X-Received: by 2002:a05:600c:3542:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-47d7f0975c2mr30525655e9.19.1767701183565;
        Tue, 06 Jan 2026 04:06:23 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:23 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 09/13] pinctrl: renesas: rzg2l: Remove useless wrappers
Date: Tue,  6 Jan 2026 12:06:06 +0000
Message-ID: <20260106120618.181104-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21369

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

[ Upstream commit a5fad3aeff41f89ac94230d66ee5f9c1526cb3ce ]

rzg2l_gpio_irq_set_type() and rzg2l_gpio_irqc_eoi() only call the
equivalent parent functions, replace their usage with the parent
functions and remove them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251022074100.1994447-1-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 90ad19adb3c7..71a71145d323 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2492,16 +2492,6 @@ static void rzg2l_gpio_irq_enable(struct irq_data *d)
 	__rzg2l_gpio_irq_enable(d, true);
 }
 
-static int rzg2l_gpio_irq_set_type(struct irq_data *d, unsigned int type)
-{
-	return irq_chip_set_type_parent(d, type);
-}
-
-static void rzg2l_gpio_irqc_eoi(struct irq_data *d)
-{
-	irq_chip_eoi_parent(d);
-}
-
 static void rzg2l_gpio_irq_print_chip(struct irq_data *data, struct seq_file *p)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
@@ -2537,8 +2527,8 @@ static const struct irq_chip rzg2l_gpio_irqchip = {
 	.irq_enable = rzg2l_gpio_irq_enable,
 	.irq_mask = irq_chip_mask_parent,
 	.irq_unmask = irq_chip_unmask_parent,
-	.irq_set_type = rzg2l_gpio_irq_set_type,
-	.irq_eoi = rzg2l_gpio_irqc_eoi,
+	.irq_set_type = irq_chip_set_type_parent,
+	.irq_eoi = irq_chip_eoi_parent,
 	.irq_print_chip = rzg2l_gpio_irq_print_chip,
 	.irq_set_affinity = irq_chip_set_affinity_parent,
 	.irq_set_wake = rzg2l_gpio_irq_set_wake,
@@ -2638,7 +2628,7 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 		 * interrupt.
 		 */
 		raw_spin_lock_irqsave(&pctrl->lock, flags);
-		ret = rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
+		ret = irq_chip_set_type_parent(data, irqd_get_trigger_type(data));
 		if (!ret && !irqd_irq_disabled(data))
 			__rzg2l_gpio_irq_enable(data, false);
 		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-- 
2.43.0


