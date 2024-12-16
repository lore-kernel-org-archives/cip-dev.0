Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8BEE7717F
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 13:07:09 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.56106.1734354426714214844
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Dec 2024 05:07:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=g6azNOSY;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862a921123so3128159f8f.3
        for <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 05:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734354425; x=1734959225; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxBBZrgxDQ7cVYwEE/dFGOtE9BFJpsGkbnqDlewkFP0=;
        b=g6azNOSYTUcqfVJsGRlgyKAcP4IY4K8xSFzDnhPrGWGzzlWPLnujaIhy+OVCB82B9t
         NcwTUxzeUBAT8J6owykSSQ40i3HkuGcD4WJSKMcfATgUZKW4uccWgXDMN2c/6koLYtYi
         QqYV6Q6jMfOfg6pPDe4tJuuk6xsC+88IQ3fMjzjB6eiDACnPlzIoC8J4sgRn+a1Ll4oL
         THf+7Dp+3nZtLbZzd1hlJGgyo16vn7Hy3GIiq8hQydWds/GIDjNBXgoAV6oQa/ojAeXz
         iAEpuw3UoYEH/IdmqFyLUFUOHIdosCWq9jJJzRlvDw9VvR7uKCkHqzMMG1knZQdyB1Ya
         NajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354425; x=1734959225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxBBZrgxDQ7cVYwEE/dFGOtE9BFJpsGkbnqDlewkFP0=;
        b=nv79pZz3Kh1rKLMTSwMEQwf/V4+jKSb5jIBFPSoykjV3RKWAuWAJ14LhLamey71VfD
         JUeoxd6mUIJjdZ5G0f31QcMUUptpCFK2xO/K6H9bQwTd/hALYFOwVxO48hHlOPFEuLI9
         tsMf5l1dYMFkFBmjeNMpajz5Qa5EPde1nHw2twRpJ0O79qYiucE4/o2fWeX/PljoefEU
         AmnMSI/uExbxO5/q2tfqVh/ZdWtIPJw3+BJX6wMBzn2hf7gqkKthPEKj1hdHMwOWKCxO
         0UPH4V757AYVksqe5Xs1cwHnLfyaxhPiNjroihoxMksFEQMk2Y84U+/ZFWuewqwLPoKs
         A4XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH2ossYZqvPovBxQ6+m/MkQBtJ/uj2K3NQlSNi6FIL8o5/mso9o6VcDApGduSWOr5REIf9RbbC@lists.cip-project.org
X-Gm-Message-State: AOJu0YxFaqg9ZUkwlDXMOtXDTLkYHPt/z/5BjV0QbCKnr6U35zEYh/Nd
	oVJybYGwl/QRcs9P9QbH468Q73/cpfTJPF+BdGL0OEE4InCEkrHdBqk+zK5pbfx8GM1fOZ0vZ3j
	b
X-Gm-Gg: ASbGncuNopuvWNm7TuON+/XK9oj2WrPEsL5pVjWkPQ9OXASZZQ2pOhCxKKqPq/ZiKju
	LOdzoC7ErlUuDPgN7slrBaXao9WdefcblprASwrch1/VOQbvGGdKKmps+Yr0vAa3kWjgADnjkOG
	dfgvACCM2qCV3mIt9MI6QYY91xe4v/5g1+Vsa8LR96J2smqetKYSfCmjb7yLShjgrpnLsU61/VY
	wObY86iYn+YDV1c9KgUKrGLtjAtlnkmh6vSxwNTEzFjhfF9XDin1FpnSCw2sY8WXeyYuuLYG2HE
	JjG8rvrJSLY=
X-Google-Smtp-Source: AGHT+IGcxRTRoPnViT2mNX0RGlV/PqwA3NEen9d5c8Z3g1gzDihv13eU8309sK7mxuCfu7Jy3kECWQ==
X-Received: by 2002:a05:6000:471d:b0:385:f0c9:4b66 with SMTP id ffacd0b85a97d-38880adb0bemr11069881f8f.33.1734354424799;
        Mon, 16 Dec 2024 05:07:04 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806115asm8031374f8f.107.2024.12.16.05.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:07:04 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 2/3] pinctrl: renesas: rzg2l: Configure the interrupt type on resume
Date: Mon, 16 Dec 2024 15:06:59 +0200
Message-ID: <20241216130700.321518-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216130700.321518-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241216130700.321518-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 13:07:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17429

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 02cd2d3be1c31a3fd328ee83e576340d34bc57d9 upstream.

Commit dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT
source at the same time") removed the setup of TINT from
rzg2l_irqc_irq_enable().  To address the spurious interrupt issue the
setup of TINT has been moved in rzg2l_tint_set_edge() through
rzg2l_disable_tint_and_set_tint_source().  With this, the interrupts are
not properly re-configured after a suspend-to-RAM cycle.  To address
this issue and avoid spurious interrupts while resumming set the
interrupt type before enabling it.

Fixes: dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240419063822.3467424-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index b69730c9a80f..ba3cbaf22f70 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2043,7 +2043,9 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 
 	for (i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
 		struct irq_data *data;
+		unsigned long flags;
 		unsigned int virq;
+		int ret;
 
 		if (!pctrl->hwirq[i])
 			continue;
@@ -2061,17 +2063,18 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 			continue;
 		}
 
-		if (!irqd_irq_disabled(data)) {
-			unsigned long flags;
-
-			/*
-			 * This has to be atomically executed to protect against a concurrent
-			 * interrupt.
-			 */
-			raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
+		/*
+		 * This has to be atomically executed to protect against a concurrent
+		 * interrupt.
+		 */
+		raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
+		ret = rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
+		if (!ret && !irqd_irq_disabled(data))
 			rzg2l_gpio_irq_enable(data);
-			raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
-		}
+		raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
+
+		if (ret)
+			dev_crit(pctrl->dev, "Failed to set IRQ type for virq=%u\n", virq);
 	}
 }
 
-- 
2.43.0


