Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79ABD6E2A8
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:35 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44888.1766071946725912218
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eJS09z2K;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2e77f519so543645f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071945; x=1766676745; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAUC78wbB7u+PKgJS3wc1ZuPZsehqOBpAU/uWi9SRdg=;
        b=eJS09z2KK0MrDa3qtXNHa95KdCUxZFmg5T2q5IG0SqfKKBzOMjO5C7wCiYmMVIhV5t
         CpYlXOYSKp2qkbooqbDMCXurFuH+WLDY+1y2hIuOjUhhKDo+SjeCqasekkvTBlYy7ry4
         AdTpH/9qmfZ7cBZNBq3g8MbmwBsf0HXlyClE5hyptW1WtMz6ynu1yynK186wiYdJmf6c
         gxOcmk2VE5E5JR2fXKsATHq0FIoGLel4jNv1dSj2s81LCbkuHW4FUNVfkP+jFOlr/ocw
         fhSmZSACA7SJkevUuI06MyjbJvOvWOA3mSux0EPTrTX1BKBLOqZ5Tuc2qSjlg15tXd7h
         YjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071945; x=1766676745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QAUC78wbB7u+PKgJS3wc1ZuPZsehqOBpAU/uWi9SRdg=;
        b=v8yT/J3zyDCPJsJt7V0ToAXJNwP+GTl4m8zWw4NBfesoRQ1RI7/zTz6PbeQVRRAJpc
         smLMwt9n6NwkPFHySGcwdTLU0dsWxax+dbGQbzEr8NNSOy6Xv5Z9z0vkc6eIeY428FMJ
         FutR5iuk0OErPymgQyICk8n1UJJI1L+uCxefTAGfCGnQkG+tlHjd0lZ4GEjcwKYoOMdV
         mqc5epPyePhdPdnq9J1hEcXxIHv3W/8vSaWgdNjHsOg6SKNr8GhOFC2s3PJ1Z41RFnZR
         HyauoZBKPPk5jMqa+YyvOi+eN5NyqAe8+nUuribhXdqzt8ZTW623zxYuX8GsIMxBUliD
         OsmQ==
X-Gm-Message-State: AOJu0YxU5wUHjcLb26voyY2DPE9A+x8iVmhBkbUp5y9Mke9eN4n0eHdN
	rhU1A/2dWsiVhXVnZmjKJLeE4lbDJ+1UUiSMPE5CM5AhpFbs9H5mmVzomrGSXw==
X-Gm-Gg: AY/fxX76DWE1qz5iwW8iS6XV0hudT9Jp+AXbjT/Z8QF0TwzftVcmVH/Rh9D+W86bwHp
	8IUMlXvMXH9xCYukPpOrj3xUpM3nUvevSToU1g8/iYjiPmztHrTPTwrlTWhzzVSJhCsNzdA9MXt
	YSVd1Z43HL2FWQWXFcqTPyu7++1a2L/p4fAA17zVdHYHcBaCzV2VZaABitDv067uR49kJ1v2KEC
	PkgEX1MwNmZZ7N4+zLU9Kc19Ivu4CXJM+cWx1kwdw2mxmdpZwJ7Eap2Zeo4/3lvblPxavtciUcZ
	YzsmiWqQy+isjAnYS/qyVuDYSvvBxM/sin/eGs/iWecnnRAmoZ00CFb6REIbdAcpKb5HODqHHJF
	u/hvFdWiSSle7Rq4XlzgZCQIrGA+njre/ShyYgOpxKdbUFMyvi95IamWZMUs+gvs+kHxbM/mxmh
	laveNRSN5j2biNM9+88g==
X-Google-Smtp-Source: AGHT+IG17VgTDfcKeotluK8J3YvIqPt7L5jY4Z1eyJaMXL7T3j0D3kmY6Wve7tnsDycx6CJjtcxQGA==
X-Received: by 2002:a05:6000:438a:b0:430:fa58:a03d with SMTP id ffacd0b85a97d-430fa58a71cmr18441465f8f.63.1766071944805;
        Thu, 18 Dec 2025 07:32:24 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm5637772f8f.40.2025.12.18.07.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:32:24 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 09/12] pinctrl: renesas: rzg2l: Remove useless wrappers
Date: Thu, 18 Dec 2025 15:31:58 +0000
Message-ID: <20251218153219.228506-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21134

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


