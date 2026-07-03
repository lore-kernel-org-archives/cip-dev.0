Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0E0C44506
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:17 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89140.1783073287584090324
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=X1vMF2Ox;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b691cb44so2620085e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073286; x=1783678086; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNNRvDa9hV9UAXNbqdOgk0WjRgJ4C/Qf3jTdvgaAL+c=;
        b=X1vMF2OxPDCGO42hF7Dm3Parcz/O8gUEu/X7lsBCTJYQWIDMsXaeNeuV3DFq6TMdOu
         5z2kjG2aT2vIPLOjPjGDVcK9g4aqzcZSWcuLGhGur4xV8Eldqf1Yk5nsZCMgNPKev6jX
         0uPZ+xYsvzEfzSOkTrPB1tHKg+gYP7bR9/DKGeAPB75dN2Kid+p3qXmKt52wW7qNi1+s
         dcv4H4gkcDOrrnHVH0zT48macjZ4+/LT8RsytsO2REH7gB9yaumKBPShkeNgSn7wPoJV
         znAaff7/g0tRe3wfzbIZ4+Et7kN3fIBFNBza0hhw0rF6+bSvZogK2d4xbfyyxpmhz2Xc
         2y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073286; x=1783678086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LNNRvDa9hV9UAXNbqdOgk0WjRgJ4C/Qf3jTdvgaAL+c=;
        b=prTYTSfkSe0FhZj0Q0asO+fB8fJIlnRAo00SNW1LEfcrjlALvStv56ecDIYs0PlRQo
         sIuWlcXM2a3xDoDV2R5uo+PrS4408bvvwPmhYvppUe2PAfjk66EzoIhdQkXTRsuXKgKe
         Y1Thzfm0f/GskyPTu9vSYIZIr6qCQVDZxm2vS4XZ8oy+41SRTkBE9jw6ZfNKQjbWpBRY
         sIBrQc4l3k5XDZMYXUCsO2WLZTh3FJaMiRXaAFNLOnujLhzFd9o+9e9CpAk88v8VqbAy
         of8Ao/KxNlHCbnPguNhSkUB5NeUICQ69TleiqUZqwg05WQVaRtAv6GrJ/9gfYuv6ZZ8a
         BGBg==
X-Gm-Message-State: AOJu0YyBx9y7wZow9wP88AdR3EW53E5zDdgr1qxk4UZcDQdrl61xewCH
	/0zWjayuPI4zV9sFivaI9Jk5W9bWodSukc3VjoK+dLP0ogsFq6pO0OfKIidOGv4P
X-Gm-Gg: AfdE7cnbdcYiINoqyqk0dYEaSqUVpZQTlOzM+ZsrOGeKKJXqKt6hAjpgM/7SXkQqFBH
	7+JiwxFs9bTySWcYfl+6ElRgCR0gdXj+dUUev6/1u1gH3x4Mt7Syp8/KsVec7rL5iYCfBKLB2P7
	dIl6cffTh2ZhS1Mf3psxTtr04UKQZvxA/xYsQ3g4AyFCVvsloA5OEJBkMytX8lTBTUMZdvR2tAv
	g6+t+vkLq4wfTmBHabCMKmRaK85sbIeiUTjDQ3jzDmwshiAbJu/gMeam7FWzMBGNji5mh+k69oh
	oh+dgGv0x5mOgY/DfBDhpVHturdmMzIHhGUkC7TPh9Ri8V2AOqiE4gsrgAAe240+pLb6W9CguUg
	u5bbe3JCrbiqC3MT0VPMI7v4h3UXKzbsiH/qEQjZQI+hh5aa3PLMkTIYRRN4C6EBmZjeYxLeuqv
	8vlIjsgxcD6Rmgkt4mSbwR
X-Received: by 2002:a05:600c:5808:b0:493:aa0a:45b0 with SMTP id 5b1f17b1804b1-493c2b855famr96398585e9.23.1783073285742;
        Fri, 03 Jul 2026 03:08:05 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:05 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 16/26] irqchip/renesas-rzg2l: Dynamically allocate fwspec array
Date: Fri,  3 Jul 2026 11:07:35 +0100
Message-ID: <20260703100756.238233-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23408

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit b8e06e4e419bd3dd99f832d728f17007ada3359c ]

The total number of interrupts in RZ/G2L and RZ/G3L SoC are different. The
RZ/G3L has 16 external interrupts whereas RZ/G2L has only 8 external
interrupts. Dynamically allocate fwspec memory instead of static allocation
to support both SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-12-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 1511e6bcbc4e..42a13ee0a50b 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -82,7 +82,7 @@ static struct rzg2l_irqc_priv {
 	void __iomem			*base;
 	const struct irq_chip		*irq_chip;
 	const struct irq_chip		*tint_chip;
-	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
+	struct irq_fwspec		*fwspec;
 	raw_spinlock_t			lock;
 	struct rzg2l_irqc_reg_cache	cache;
 } *rzg2l_irqc_data;
@@ -630,6 +630,11 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	if (IS_ERR(rzg2l_irqc_data->base))
 		return PTR_ERR(rzg2l_irqc_data->base);
 
+	rzg2l_irqc_data->fwspec = devm_kcalloc(&pdev->dev, IRQC_NUM_IRQ,
+					       sizeof(*rzg2l_irqc_data->fwspec), GFP_KERNEL);
+	if (!rzg2l_irqc_data->fwspec)
+		return -ENOMEM;
+
 	ret = rzg2l_irqc_parse_interrupts(rzg2l_irqc_data, node);
 	if (ret)
 		return dev_err_probe(dev, ret, "cannot parse interrupts: %d\n", ret);
-- 
2.43.0


