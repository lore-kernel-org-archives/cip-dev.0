Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F89C43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:28 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90773.1783076367635698828
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=OrssriAs;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4629051c946so286822f8f.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076366; x=1783681166; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ3qZYf+3LCB0jcdwsE/i1/oubyANoQD26/zpQ4+y9U=;
        b=OrssriAsbqiEVZA2nzpW2nTd0RsiMCrD8NUWxt83MXwRVk5hn56AIx9gONa0RkqEJt
         ubWDlR8CK2IYeTL+KEYp0iQQ6ZNeL1ZUBqREhvfoX3ZaDoGV0tslUM/NKjADN1BLGrwi
         lBOLG+yJ2kfOza7Cp7xso6F2BrYmReDWNjZJsYrx+zjpnx1gTKXuZ58AnEdR+ETjgKoh
         KYMrrSPp96bqIemEMf9xGwG0wXr6HSGCjV4ewaXF0FXDm+oFA7MvzSvd6vK9TybUeNjx
         6EwJ6f4OxKUa4iyWqMtSYMa8h5BPJh1CINoLjqEAAj+62gLVPMHn6n+NYR3Myo+GpeGB
         pANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076366; x=1783681166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJ3qZYf+3LCB0jcdwsE/i1/oubyANoQD26/zpQ4+y9U=;
        b=HfzHo/uTsy7yK19e6XLvkx2GRH3+YOMcMC8tAj+mY1UgaGmjujLUsnTrtTy10Mn0OM
         voNKSnqvsvNH1xgxPK1du3qTZG9dqzIyWir0XYcujkO9Q1YQp6t4eeK91xFv0/vi+cqG
         ud6SCuTfjMD45gvbU4TuZLi1yD8t5DLbIAglMghgUaKUCzK2IIQ4UAZAIDyiRYDHl2oL
         4IbGaxzlDKsQLlPXEsoBUQ8GjfsPDEykMNtbUxIOb6HQOfQwHIP1MFEURHrjTBbd/HeU
         X1Hma3GR2zhHXZzEBbN5BIa6DYyuHv0CQvfybKNHztnOfdjy7gUgRk24tDFPL0e5t5G6
         H0tw==
X-Gm-Message-State: AOJu0Ywei5u3A4lZVcDelUFRfU+NorBCiYtY+rgPwe0pitr4k2WJUecO
	GsXk+LC6UrDbCOA04YElEWKy6giRv+h7qovRY6Z0tynOo2SxVy0bPm3BDP4VZ5wn
X-Gm-Gg: AfdE7ck8uW/UQIsED5Vgo9Gg+IDRkLR0OPNE4OfoyUbbJkZi1ROpL4QVvphca//DDg4
	RWEaJ80QUgaigL4f4z1u1Jew66WcFkdOAh4+wONbVXy/uRx3cSiABXb14IJ8MgMOLNMnnvyrpQF
	LMgMq4rWD/T0dl9+cKm4t/GKy/6DaGSlr7xeBxIkiaqQV7ajCTOCyhPH2p6xFG6Br5HOeUMRvj/
	0181iNV1Cc73IN/jywEiljnqtCsbX1poc/0nssPofc8MDaRQIHIWbp13X5TbiuKG2auB/BWK364
	d4D/9LZhXxG+NF+RD53zA6EosRpzyblua+InPTUHGUjb9MrKEP1PJX5NQt3nEJxNXP/VkZGe4eD
	ex80eB0yGyLRTX9/O7RzARcmfqsdKxscAiSL7wn+yTLNAbX3BGxZf6RYf6wAJunP+aVgCcNG9YH
	APmD2i95vQHtwNts1WB39m
X-Received: by 2002:a05:6000:2203:b0:478:7019:e5ef with SMTP id ffacd0b85a97d-47936f19492mr5185756f8f.21.1783076365755;
        Fri, 03 Jul 2026 03:59:25 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:25 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/23] pinctrl: renesas: rzg2l: Refactor OEN register PWPR handling
Date: Fri,  3 Jul 2026 11:58:54 +0100
Message-ID: <20260703105923.251255-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23422

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
index 78fca49baf4a..ad51cf232aed 100644
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
@@ -3215,7 +3234,6 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
 	unsigned long flags;
-	u8 pwpr;
 	int ret;
 
 	if (!atomic_read(&pctrl->wakeup_path)) {
@@ -3225,16 +3243,11 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
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


