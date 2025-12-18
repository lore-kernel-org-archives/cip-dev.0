Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE661D6E2AA
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:35 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44889.1766071947139284156
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YiTOEkgK;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430fbb6012bso542920f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071945; x=1766676745; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB2GxY4tVhUrwuL1/r1V9foxX3/0P2viXtGynNjPxig=;
        b=YiTOEkgKrPbKBKKC0KQAkd4mP/ImJtkn0hjqyD7zsj79jq7GWXFxrnBcP6PeOLJrsy
         q7p5Q8RfuVxWOby5bSTcTS/JNxyX0A1ifUCS9WmbO3MkiW9dunNBfpZkO2oQXKk0Y4Ua
         k+BmYzgwKMJin8xM2JkSGFp0mLBvUPu2LP9JB4DxOHwCrooRqqMJBUuYuR92FRyp5Bjk
         tHpSH3J3Jc8dCa555z+NtiQKAj/pREUN30u29dybJ3tzhTOpXEtIMkmDSZMSzwttNf0T
         vsXW4eSSeTYYLFCWQ/lT+wpfxIEQvm+0yCEdg/AsobAFCPstUbsmU/59qHQOZl8sY2QK
         pkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071945; x=1766676745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jB2GxY4tVhUrwuL1/r1V9foxX3/0P2viXtGynNjPxig=;
        b=NAj4Tl3uvqBjUPjF/7yBvZuu3tFCr2garmOHaf4Xdv6YNMSxdUsYekgrivJtbAw1IZ
         00GBD5JOr8Rw2A5HeNM2CeTmIBMozwecNosa9RM8aiwKiFhTnBy3hHX+aTcTGhCAfIfG
         aiuc9n0o1CV+PiYMzsbd4Lvf1lmXDNPsAzDfvPDcYJDz8oxf6w55w9ZiFnuhJEV2y/ip
         8m1VUgbzBWXxdQo181niBXB50U+1OYTpLdtLZ6lHAbl7FBauK+u0E/udhK0ItwO6fgyg
         rVUfHbvt+F/TRWdjTjCkl78ssJZQlGa6ufnqPq3gm7IfTwJ7/SG4hiwVbnyTEf6ZTzX+
         Mvjw==
X-Gm-Message-State: AOJu0YwA6TmHEd67MNlkOspzfIwMlg6+PaI1xBEQFvMnUNtNY8txMV/I
	+Q9FawWhUppVyK7uH/j+l0NKYEUkI3CwIlYG3qWCq8nzYqcuMO/BoKzWQ2W7yQ==
X-Gm-Gg: AY/fxX7gbmf8JyhlEmGvEyyNa2UaqzTncv22Ma38dSL0AP52zBIxv2sk511hWxb/FdV
	IrCDXd/zXCAIIM3lZsaDTBNL1NQIdbX6BSPIJppBlXDJO+1NdtJgJAzS3ycjw6laAbbIKoiEkth
	wDCyRdvojdsbBeWZBD0HXPmii6NtFB+6wd3XqYsiPtt4slv9Hl2rvJNkfe6zI/bPEkK+doPVwEl
	Cq2QCpmM3V83q+0DMeq95LlpwxH1ma0wvPKGAsuImSuWPHTuY/qOYEOkVte33mQ7L+UdlvGkh+M
	6WH0VS6XU6Pht9fV9xRMa14lDYUobeqtF6KXD9QZgW83y95Aoyx8EDk9wyDSu2rGKM6eSXSIwie
	3KcidRoLwyH8/Lil+iZobjz13XkJr2fyyg08fFj5bu/Pkr8FZWCm/9Xav5P7+2RhheF6Dw9Q61J
	cE91bgz7t3PVNnlnpeyA==
X-Google-Smtp-Source: AGHT+IHnCu345uOqa9eRMEf8nX+srSHTQ3BNk8XvsuZJB7Pm9GnCXR2UIla0wNCZBdFU85DegAah8w==
X-Received: by 2002:a05:6000:2909:b0:42b:3ad7:fdd3 with SMTP id ffacd0b85a97d-42fb44ba20cmr23995377f8f.18.1766071945200;
        Thu, 18 Dec 2025 07:32:25 -0800 (PST)
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
Subject: [PATCH 6.1.y-cip 10/12] pinctrl: renesas: rzg2l: Refactor OEN register PWPR handling
Date: Thu, 18 Dec 2025 15:31:59 +0000
Message-ID: <20251218153219.228506-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21135

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


