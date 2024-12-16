Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BFEE77183
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 13:07:09 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.55922.1734354427802065767
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Dec 2024 05:07:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YZdLXuPj;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso27977365e9.3
        for <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 05:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734354426; x=1734959226; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7rsxAKpyeq00ECZuc2+hi4RN3M/8Bca1fJvEHfhDyQ=;
        b=YZdLXuPjGonfPzRcpxgw/9aM4poeRD/gPx4OOaMvR8o1u182sujPGjDKsSmKJaKY3d
         6drb2U2+jgySfSVCoWHcnbKOV9ijKXGv6nySlgVyw1I5RiV3Zoa4LNNDRIdpx6w+zpnq
         LjLFf/a2cAY27bv4EWNum4i5WknJLauhCwGlVpPXAwQ0QrXdrbA4ATQOrLk9cVc7+CZA
         1JpyHqAjpZHbI5JJz80S8m8JwvN8Q1cCr67qjr/aNUkkRQZawYBCOa48dV/8wHQfV1RF
         D9CDE6Z8+Po3lwmL/b2NPnuedJRihKF7hFGOg9TGkJEwizvJbi8dHNjDbpkEvvjfMJVo
         MGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354426; x=1734959226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7rsxAKpyeq00ECZuc2+hi4RN3M/8Bca1fJvEHfhDyQ=;
        b=IWQywdWf3CTBPZBM645y5+DgkGSQxjQsLCFpIH5egymMHykhdeSs9YtXkjNYbfYjN2
         uuJbPKoKd3ObkipD5RI66CbW0fSyfEz2ocgEIC+fqDcdVBAXn6RZ7biuCNxiMEXJdSo7
         plLNT32Mxb3DzTUGr54mF4pPJRsDMD5jvb5R+HvhdLA7vo3W/fwLcS8gEIdUXPNgqVQX
         JVN/dWK0vwOo1nMiF4Ui5o+aV9zdN4EKp7VCwV+XQfALsG+/Wrr3TYyYo+uuC4REyNry
         /Al6tE49+Bpl8oxbIt3Vfgzi/c8Gud+/73zV5u6NGzX+kowgVjDncNnnLs3NWIIp/Nxz
         iRnA==
X-Forwarded-Encrypted: i=1; AJvYcCUveSZQ1m3NlFUT1LjJZ8YtDmN+U/IiqvF15N1y9JV3lVc+1AG6QMgewdG3E55TGEKJ0oQlXq+P@lists.cip-project.org
X-Gm-Message-State: AOJu0YxGmYXUEi04dGzcrViv1Pmz7XcASBhdUcKDVL+z+IrXEUgSeFOk
	n7e7NTEMHND3MUzmh53h8WrlrYP8Kodde6indw6qm2ysuRaBfZrnD8v88iaMVpkA2syk6LXARTc
	S
X-Gm-Gg: ASbGncvf5gZ2eqVBq7Dr2jSMoCNw6ARZliu8M2v4DsOCj5PrjuMtlvYTWcdU0PhztqG
	aHhP7+L9+AShYlhyUHkvk7XcAJkim9Osv/PqQt2Q6uqb74bKpPY9IDFHfhwwlVhDAKdZj75gDLj
	iYu7IB6CAQiwyMitUJiWxNGqAGFfOZHNDyHkLN9e191hjZTr+ivnDz0tW+YUKYsfWwBbvbrHfav
	eKZDduFDUpvYgbPBUyg1XS1XRicMAah9uUGNlLGH0TKmRsIOy8acawRTtoCAOI0Hnzzx8Njp7HV
	I2zqpPt9o08=
X-Google-Smtp-Source: AGHT+IGMoNBxwYZqRGtfVERYC2WZdSchpTsMMoLqQKJ4h1CDuxiGRFI93GCXywhM3KEyhRBYDV2UiA==
X-Received: by 2002:a5d:584a:0:b0:385:f13c:570a with SMTP id ffacd0b85a97d-38880af13d4mr11493942f8f.7.1734354426230;
        Mon, 16 Dec 2024 05:07:06 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c806115asm8031374f8f.107.2024.12.16.05.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:07:05 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 3/3] pinctrl: renesas: rzg2l: Use spin_{lock,unlock}_irq{save,restore}
Date: Mon, 16 Dec 2024 15:07:00 +0200
Message-ID: <20241216130700.321518-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216130700.321518-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241216130700.321518-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 13:07:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17430

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
index ba3cbaf22f70..4e95cf53d0cd 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2067,11 +2067,11 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
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


