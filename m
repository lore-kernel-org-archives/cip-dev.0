Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE086E77180
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 13:06:29 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.56095.1734354386560917811
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Dec 2024 05:06:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GJJ4pzbk;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e2880606so3743279f8f.3
        for <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 05:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734354385; x=1734959185; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLlQCh0HX0cVC6kM9GpwGw6elBRg1QLkSxJ9ZnrkPwY=;
        b=GJJ4pzbkqA+/azFo5x1fCdChrJx/dRh59ySMaUgSSXVM88FpCBRIakqXUslG1Z1sND
         Xp6qaS4kaCxkv8BhSBCK4/6+CgXdwwCAJYlhygExB/FRctBsM2gsSnXBiKmdr+Fkvtcc
         ZUk6g+J9aldHvCslIvj7SDMMmE63nr/zoSm+lDKbnm7bLITA8uqa3xkdi76NKOsuyz4o
         BdIABKPR9E7DXEntaQJHJ40PBYj9jjDxlldMXftlwtxoIxBmPYfjgAb8Y/iBR9U/hdsH
         m/tedidRq9DpBNmk78IDF0BJdq9fCkt7X87cC0XsrIZVKb6F5wmpblEjIPqQRlp2mcyZ
         oK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354385; x=1734959185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLlQCh0HX0cVC6kM9GpwGw6elBRg1QLkSxJ9ZnrkPwY=;
        b=AY58oKULe52a7QSnrDIrUJSHLdjtKm0QhifidtYz5seism3FOzAvabbyacitz7vbSH
         so5e+oAF/2uvBeYZAUl4TPxnTbuox2jp0y2JJuySnVbWwyx3zKCG5AYcb4fnPxI+CDDq
         EjuVJxPwxNi+8dNzcylDKiHcvQT+hl0STHSPLvdyR4WM1MUyTCAu07ARVXhwdI/uUGNL
         k3+60c/RQfVcTvXTtZjM84IQxGxJn8FdqW/3Q6n3To3j03b3HST9lTqbrWlHfDPgV6NP
         WXUH/KRKfAU9jMNmGMH9gXNYb6n6iqj+PbLrhUTfdI7mN/uZGRq/iGY9ZGVFA8D4ETkt
         cCfg==
X-Forwarded-Encrypted: i=1; AJvYcCXhpDO54YOiITkgz+gkHQ1qMGgZEVc17VN3Qk/FhkYwdgyJ0mh+SKmXXk5m209zc1HtnpwxOKYV@lists.cip-project.org
X-Gm-Message-State: AOJu0YxEOLAnmMF8nlJYfaN2i4fq69B51U0qh9dtVGJYdC8o3/8ml2J4
	HHjrd6Khi/jKnJbNiw7H1rKqaEjjEdsNhif3u3RhoAPZSQDrDOJopJ1d2MwV93c=
X-Gm-Gg: ASbGnctDVlY6Avp6E9Eek/e30qZ4I1H7mk/XqSv2dwJk6K5dt2qGpppNUjv+DicHZCk
	nZgLSAQ9xxHBySYF4Kz8VytfB9jI0PI+Pn50SlsQNsJWcAJ+BC+MkUaJhWRYM/QJEOjymEqXavU
	Z2vf2L38LGDSk1zlBsyQN4tV6FyfRVRjrW6+12L2L/fVInEme5IGe8BQ77fUflnL1Ttay3UTMD/
	yqwMCgF4eWd9Ap96mV5T0OaAGDEz5jpVhCZu3P+b0UXDBEebLVEU/VrqZUMLbrZGXPxvnH5NCF4
	Mw/t2trAxoI=
X-Google-Smtp-Source: AGHT+IEixKLak7mytIbs727yT2Fftb++3VRVtXhlUVfLwCgi7sP421K/EV1t2qk9HWsNTJeTQrvT4g==
X-Received: by 2002:a5d:69ce:0:b0:388:c61d:43e4 with SMTP id ffacd0b85a97d-388c61d4939mr7387966f8f.45.1734354384796;
        Mon, 16 Dec 2024 05:06:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801233asm8346252f8f.9.2024.12.16.05.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:06:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 3/3] pinctrl: renesas: rzg2l: Use spin_{lock,unlock}_irq{save,restore}
Date: Mon, 16 Dec 2024 15:06:19 +0200
Message-ID: <20241216130619.321397-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216130619.321397-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241216130619.321397-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 13:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17426

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a39741d38c048a48ae0d65226d9548005a088f5f upstream.

On PREEMPT_RT kernels the spinlock_t maps to an rtmutex. Using
raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() on
&pctrl->lock.rlock breaks the PREEMPT_RT builds. To fix this use
spin_lock_irqsave()/spin_unlock_irqrestore() on &pctrl->lock.

Fixes: 02cd2d3be1c3 ("pinctrl: renesas: rzg2l: Configure the interrupt type on resume")
Reported-by: Diederik de Haas <didi.debian@cknow.org>
Closes: https://lore.kernel.org/all/131999629.KQPSlr0Zke@bagend
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240522055421.2842689-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 517868e4c289..cbb4780fb2d0 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2068,11 +2068,11 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 		 * This has to be atomically executed to protect against a concurrent
 		 * interrupt.
 		 */
-		raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
+		spin_lock_irqsave(&pctrl->lock, flags);
 		ret = rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
 		if (!ret && !irqd_irq_disabled(data))
 			rzg2l_gpio_irq_enable(data);
-		raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
+		spin_unlock_irqrestore(&pctrl->lock, flags);
 
 		if (ret)
 			dev_crit(pctrl->dev, "Failed to set IRQ type for virq=%u\n", virq);
-- 
2.43.0


