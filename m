Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEB9C43602
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:17 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89981.1783073292195265956
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nKSbIREx;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c486f012so1758175e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073290; x=1783678090; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkvCLUt6eLp++s0doFZMgrlrCDvAfxG9GPjkRSPcDLs=;
        b=nKSbIRExI1T3RXogjycVg5ztAwbRbQeJviJLnhB1nkgf4EM74EUvZwh98BviYLcPme
         fnntBG7PagX22Mw/Qf7itipwTrdhxK0sY/e9evo4vsdl9sUdPJlXfOSBw/NETa5Xao8r
         WYE8xJNhHkEopeQjrhba5gHnBhkgd22f5MGf2MeNBSnEz6Yh0X3OlqFzaEdbkzCsfP+G
         a9CNwEaU1oKRudrkoEAu0ak8eUCrGP+5pMMD2HpB09eegMfld+2qHfQrrmmVoOdl7Hps
         HtqA1qgkLVzlcoaiiN2DI7l9SwoWxqRtcCFYzkoUs7H1H3VFKpCK9+8snMHpd08H8H5X
         AsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073290; x=1783678090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DkvCLUt6eLp++s0doFZMgrlrCDvAfxG9GPjkRSPcDLs=;
        b=S68mVhK0+Coeza+hOUlJZdf78/lnsPHq8yqlEZe4LsWE8q+Fa6hh/CNpecnc0qsAKK
         b5ttXy0FQS6ujyZyua/gl2gqAIwhuzh4WV3vFCO2iv+iHRwukbUVPHedzNw4uB5gb6kX
         KeHPCRsvJaLySNyRneO1ZuIBxmCI+6NHMzB4gm7SjpLk4sEqjDpp3C4t/L6AxnaIuSMI
         8kT105Mdl5MFqIo12c5Uoz21QJhzvwtLq61lMylm+zM9vT5C+D1XEJHTmvid6psla4Gs
         VOIdCiKNaHK5bSbwJSagYb+44D5yFi7MbMi4hOdp7A+UOGTWKFuXLz8bYlD6rT5gLtfT
         Owbg==
X-Gm-Message-State: AOJu0Yxs/vJffzZx6YF70IsbUX9a5LB5ZbJn/UtNc9lHZRFeHuRHu6Im
	AIPU7ZnfzqBlqacSte43vTasDDY4ODO4l0YmADZwmT89flfVGxOxM1DO5umb432v
X-Gm-Gg: AfdE7ckvwNKd1TcqBVt5FRxXJe2njAN589uVXrFqGou9jl4zzvg/8UqtScAtaHhMj3r
	/bgvH7I9wDtOfa1Xv4PjKNSQ6lArJjOy/IMgf0GhTJFU0vLxV9b40KR4ZyeWVNFsFf6x4SbQR1Q
	Vw6lSv5MlzPzFJqhfT8J/7p/oB6XP9e7mL5krBUMW34YpwL3eGzQBW84aFVLQnN2Mcz28rw+GtA
	+IZz/2cq/ccjwJGmpLNdr2YG3Mxs6IWSi0e+7eyskl0l6hTLSb4KfkkIRJaeigaFoI0NKJK1E2+
	2D1F92NgbfGbkXNQmcyW96hfgLY1UAe7pXp6Vm4zGPPkEOvDmIi15sjqAkC9yavy4Z8XIs12BdU
	Gn2rbHEDkVkDoMnJjioQmm7SyEN2iQET+4rIGpXuP3zCaRGPo3/2GNU4z/9HfBfaA3MJYKFe/ET
	FxA/nkmHogqin1a+RI5WjQpn2jx5dYwkU=
X-Received: by 2002:a05:600c:c165:b0:493:c9b9:415f with SMTP id 5b1f17b1804b1-493c9f22778mr40230445e9.25.1783073290273;
        Fri, 03 Jul 2026 03:08:10 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:10 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 24/26] irqchip/renesas-rzg2l: Replace raw_spin_{lock,unlock} with guard() in rzg2l_irq_set_type()
Date: Fri,  3 Jul 2026 11:07:43 +0100
Message-ID: <20260703100756.238233-25-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23416

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 9fd2170d70178faa0427adaa9d2dfdbfa231d1b7 ]

Simplify the locking logic in rzg2l_irq_set_type() by using guard(),
eliminating the need for an explicit unlock call.

[ tglx: Remove the pointless cleanup.h include. The spinlock guards come
  	from spinlock.h ]

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260328103324.134131-3-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index f97d8f170634..cece433dc1fb 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -374,14 +374,13 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	raw_spin_lock(&priv->lock);
+	guard(raw_spinlock)(&priv->lock);
 	tmp = readl_relaxed(priv->base + IITSR);
 	tmp &= ~IITSR_IITSEL_MASK(iitseln);
 	tmp |= IITSR_IITSEL(iitseln, sense);
 	if (clear_irq_int)
 		rzg2l_clear_irq_int(priv, hwirq);
 	writel_relaxed(tmp, priv->base + IITSR);
-	raw_spin_unlock(&priv->lock);
 
 	return 0;
 }
-- 
2.43.0


