Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AF5CDC17E
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88502.1767701185965497844
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gyTEysLr;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47774d3536dso8452165e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701184; x=1768305984; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB2GxY4tVhUrwuL1/r1V9foxX3/0P2viXtGynNjPxig=;
        b=gyTEysLroMIZueg7ic6FdbAVkkyiL4MX5Rumz00Rpt9vIMssGrYtjBBYeBK+Ud3b10
         eqheuXtolts0+kFCu0+ycaDUYD6zhWwqYdZYkVL+R7lwYJ0Tc3hpInulRbhfvsczhH/D
         kdCGb9P9a+to+6mOpilrbVjLMunhxOoc8hrZ7U6K3KyQ3A7xbzhg3lWoP2chMYP5wqKO
         bKktkouuYEFg03h2TL2HwXctyiK1JlZyPzvvJRHk+B/3PJ87UA8l/c17rKf/HnLdCvgR
         HbNuozL6x9G/Rf6f14ZHo/mZwyy9gI8fxxPXvfPZST3BDkPB2p9az160iHEQCd9Nk6ZN
         tVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701184; x=1768305984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jB2GxY4tVhUrwuL1/r1V9foxX3/0P2viXtGynNjPxig=;
        b=XKiCnr0a+tcTP4c/BdTOFgOOEh1qCv/MainjFNhTc9Zh3iHI8fZQUCH4Xpv9LJ0A/g
         IUqirGKfDV0Lx6V3Tol0H8qBkNnbLHormKgzvpB4yP6X6hxvavEejIQphZ4lWjBuFXGY
         hDtm6mQo6jIrPVfdRkD6kT7KvxHAry3aLAYXkh2OSJxQ4QEM8+SSO0noHR83an0Vxz7H
         T9iy3oyyqda0Qj5rUiFJEvrE6Z7ZFzWo5Y2hJtCzNNS7K0aXVi7i41LIusEZvPAYA59r
         ymsyA+rmwiLqTDthJzQqTMSMdGPoOJiWhopbItzxSlEMxioqvLZecsGjNklRX1uxo6Ki
         0Fkg==
X-Gm-Message-State: AOJu0YwFjcRX1n6967q2R6+mrtBortmg57lAYHZVJrLrcV/SPU6H9w1p
	ChpQHtmqk+onyb9yF9Lt3kA8a3wMRNDyf/bgagmeJphLs5LTGTObiIoBloJ/dQ==
X-Gm-Gg: AY/fxX6Xkq6xsr4gzSZUeV9McEbBEoDTucXjm6OAdV8Hje8pDMeMiUdz0P6EBx9YwpX
	YwKsb6XgVswCDcIKYZr9lisLrhPoPm2HDClh7T4mN4QDNwMhrgiLtmqm5vQPmz4wvcNoLRyUdXt
	M8R0yuOdy3SRQaMQ/GGMkivju/klxiHz+odzgwiygYa+64+GmmhRlYNpziDf/wthvlZ/27AAg5N
	bkFtiQKHBea0GIUBfOeP00GjwHxNwRT7SX6ILP2UenLKw3NLUuNLMhOTQKYpVnN5yZ88zb9U/FN
	9g1Ccro9yja5kcF1pq41OQWs9JmMQ1hRrr9P8v47wql1WPZm/gkQKiC1mIO6lIRYmYgEuJaLu+O
	QEP8mbyEPUmI7nJlcbapMLKtRCzWc7xnB6DvN27sM9f7RkO1LaOy+2eS0JhpjNqUimYNU75IHJ9
	Pnn877xm06lMfSKnGH+tI6jl0CW4Mq
X-Google-Smtp-Source: AGHT+IGQQ+dL43q5tm+CjKOaQ4ga5dxZ3ZUPKiaQXkvHPnYxKPfHK6OS7zE96qXxru935/hDJ0vhmA==
X-Received: by 2002:a05:600c:8883:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-47d7f41f0b1mr22264175e9.14.1767701184035;
        Tue, 06 Jan 2026 04:06:24 -0800 (PST)
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
Subject: [PATCH 6.1.y-cip v2 10/13] pinctrl: renesas: rzg2l: Refactor OEN register PWPR handling
Date: Tue,  6 Jan 2026 12:06:07 +0000
Message-ID: <20260106120618.181104-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21370

From: John Madieu <john.madieu.xa@bp.renesas.com>

[ Upstream commit 3b0cf6ab35909d7ac8d561e18159c62d42d914c2 ]

Extract the OEN register write with PWPR protection logic into a helper
function to eliminate code duplication between rzg2l_write_oen() and
rzg2l_pinctrl_resume_noirq().

Introduce rzg2l_oen_write_with_pwpr() helper that encapsulates the
PWPR unlock, OEN register write, and PWPR lock sequence. This helper
must be called with pctrl->lock already held by the caller.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/cip-dev/OS9PR01MB16368C765305362F5F4132759FFC4A@OS9PR01MB16368.jpnprd01.prod.outlook.com/T/#u
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251106080758.36645-1-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 53 +++++++++++++++----------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 71a71145d323..f139e12ddd0f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1112,13 +1112,37 @@ static int rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 	return !(readb(pctrl->base + pctrl->data->hwcfg->regs.oen) & BIT(bit));
 }
 
-static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oen)
+/**
+ * rzg2l_oen_write_with_pwpr - Write to OEN register with PWPR protection
+ * @pctrl: pinctrl driver data
+ * @val: value to write to OEN register
+ *
+ * Writes to the OEN register, handling PWPR write protection if required
+ * by the hardware configuration. Must be called with pctrl->lock held.
+ */
+static void rzg2l_oen_write_with_pwpr(struct rzg2l_pinctrl *pctrl, u8 val)
 {
 	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
+	u16 oen_offset = pctrl->data->hwcfg->regs.oen;
+	u8 pwpr;
+
+	if (pctrl->data->hwcfg->oen_pwpr_lock) {
+		pwpr = readb(pctrl->base + regs->pwpr);
+		writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
+	}
+
+	writeb(val, pctrl->base + oen_offset);
+
+	if (pctrl->data->hwcfg->oen_pwpr_lock)
+		writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
+}
+
+static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oen)
+{
 	u16 oen_offset = pctrl->data->hwcfg->regs.oen;
 	unsigned long flags;
-	u8 val, pwpr;
 	int bit;
+	u8 val;
 
 	if (!pctrl->data->pin_to_oen_bit)
 		return -EOPNOTSUPP;
@@ -1133,13 +1157,8 @@ static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, unsigned int _pin, u8 oe
 		val &= ~BIT(bit);
 	else
 		val |= BIT(bit);
-	if (pctrl->data->hwcfg->oen_pwpr_lock) {
-		pwpr = readb(pctrl->base + regs->pwpr);
-		writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
-	}
-	writeb(val, pctrl->base + oen_offset);
-	if (pctrl->data->hwcfg->oen_pwpr_lock)
-		writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
+
+	rzg2l_oen_write_with_pwpr(pctrl, val);
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
@@ -3198,7 +3217,6 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
 	unsigned long flags;
-	u8 pwpr;
 	int ret;
 
 	if (!atomic_read(&pctrl->wakeup_path)) {
@@ -3208,16 +3226,11 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 	}
 
 	writeb(cache->qspi, pctrl->base + QSPI);
-	if (pctrl->data->hwcfg->oen_pwpr_lock) {
-		raw_spin_lock_irqsave(&pctrl->lock, flags);
-		pwpr = readb(pctrl->base + regs->pwpr);
-		writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
-	}
-	writeb(cache->oen, pctrl->base + pctrl->data->hwcfg->regs.oen);
-	if (pctrl->data->hwcfg->oen_pwpr_lock) {
-		writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
-		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-	}
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	rzg2l_oen_write_with_pwpr(pctrl, cache->oen);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
 	for (u8 i = 0; i < 2; i++) {
 		if (regs->sd_ch)
 			writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
-- 
2.43.0


