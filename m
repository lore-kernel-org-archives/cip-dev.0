Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83183CCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:38:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18661.1762169900237480921
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:38:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: zEBf9wZdQCaRt5xEybtz7w==
X-CSE-MsgGUID: xxgZUzbxQ9edTaXT32WCyA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Nov 2025 20:38:37 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0BA7641A027C;
	Mon,  3 Nov 2025 20:38:35 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.12.y-cip 10/22] pinctrl: renesas: rzg2l: Fix OEN resume
Date: Mon,  3 Nov 2025 12:37:54 +0100
Message-ID: <20251103113817.36331-11-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:38:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20328

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 30247fc3254a4502465ab809d49e2167ace5a6f2 ]

Writing to the PFC_OEN register is controlled by the write protect
register (PWPR).  Currently the OEN register write in resume() is done
without enabling write access in PWPR leading to incorrect operation.

Fixes: cd39805be85b ("pinctrl: renesas: rzg2l: Unify OEN handling across RZ/{G2L,V2H,V2N}")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[geert: Move spin_*lock*() calls inside if-statements]
Link: https://lore.kernel.org/20250817143024.165471-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 2a87d0352fc1..1ea2dc1608b3 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -3158,6 +3158,8 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
+	unsigned long flags;
+	u8 pwpr;
 	int ret;
 
 	if (!atomic_read(&pctrl->wakeup_path)) {
@@ -3167,7 +3169,16 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 	}
 
 	writeb(cache->qspi, pctrl->base + QSPI);
+	if (pctrl->data->hwcfg->oen_pwpr_lock) {
+		spin_lock_irqsave(&pctrl->lock, flags);
+		pwpr = readb(pctrl->base + regs->pwpr);
+		writeb(pwpr | PWPR_REGWE_B, pctrl->base + regs->pwpr);
+	}
 	writeb(cache->oen, pctrl->base + pctrl->data->hwcfg->regs.oen);
+	if (pctrl->data->hwcfg->oen_pwpr_lock) {
+		writeb(pwpr & ~PWPR_REGWE_B, pctrl->base + regs->pwpr);
+		spin_unlock_irqrestore(&pctrl->lock, flags);
+	}
 	for (u8 i = 0; i < 2; i++) {
 		if (regs->sd_ch)
 			writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
-- 
2.25.1


