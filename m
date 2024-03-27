Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E844CCD1291
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.32510.1711528514906722303
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TDU7aMaw;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-341730bfc46so4606215f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528513; x=1712133313; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kCSbNWejHyTTzQYd+Nyj1hiMp1CRjypKtRG6SEDmCA=;
        b=TDU7aMawxAPnc4JLnykCTkArbeEQ6vdLJREpqMfi95V6c9uvAFji8gI5CBKdsQFp8R
         mnZUQNVVo5yqMccb3Tvb98zK5s8DRx6bXwO8KupDwQXsxrwUhUroyOtO2FroO5ZTJ4JO
         p/Bu37RgjklMi8d4FLe7kkaFq9B/U9BbwTmeEpIQQWHVX7bqGxx53JSn/JpXFvrpLcZD
         rO6yFrtF+GBGbMUWvXNdzJY+Uas2cxEApIFoI9tBHM9XhBA2t5+UsRlba16p3aWHL6k8
         1cmBZ8+xCsZN45d+KK07c4X2cx9Iz2FdfFBBmCuA7VF6TVyBCz7S2UzU+iED9NLntek2
         E0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528513; x=1712133313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kCSbNWejHyTTzQYd+Nyj1hiMp1CRjypKtRG6SEDmCA=;
        b=fanusRu1YwcsmPh5+THfqr5yXLxF1kSp4C1j1p/sTgd/1B2vmFO1d69C9gPDbHXfo5
         wbw81OEBzLD3bogBfc4uxCqMEwQqjuDfmMuVjaoWNRc/7WTzdSHdcOXVvD7ObPmRh7qh
         UORMifE1gnjFaLjvR1z0JzgAbKrD6hKppnJDyoALzDx2HW2YTmEd6+3n2D0m9YY83z4Q
         ZYjE9Kbmy7cXT7cKH0pPmFr9NsdbhpMfjazyblMRK42RbaBu5xlgAWFA6wVBb+PCh12q
         /ZBZzgJWn9BAN8/7/ALTgFZ0JE2P3apX5Jh68Ej7g4XuLyj6tpAz+2D7+3l7p6dzazWc
         O/ug==
X-Gm-Message-State: AOJu0YwC2VtoXvd461r1LXXkXQF6QNYViGJMF9P28cFKOI7K7PC+9Pvc
	sLR1g1DAxpiP2VpAgzMxBBADR9FNyXSh9TgP3Me33zae2ZNbKXL+PeGKj26Io+0=
X-Google-Smtp-Source: AGHT+IHp498OU3/GpHqtCtW7xBVhhOsJVFrI5v08IU4L/CJk7HgHscQa3Ze5Q95Qswo5+mRKMbUR1A==
X-Received: by 2002:a5d:58f3:0:b0:33e:1a98:46e2 with SMTP id f19-20020a5d58f3000000b0033e1a9846e2mr3146302wrd.28.1711528513400;
        Wed, 27 Mar 2024 01:35:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:12 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 03/13] irqchip/renesas-rzg2l: Convert to irq_data_get_irq_chip_data()
Date: Wed, 27 Mar 2024 10:34:58 +0200
Message-Id: <20240327083508.2229567-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15457

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8a4f44f3e9b05c38606b2ae02f933d6b64a340dd upstream.

Use the existing irq_data_get_irq_chip_data() helper instead of
open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/8e47cc6400e5a82c854c855948d2665a3a3197e3.1695819391.git.geert+renesas@glider.be
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 6390d1d78f2e..fe8d516f3614 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -130,8 +130,8 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
 	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
+		unsigned long tint = (uintptr_t)irq_data_get_irq_chip_data(d);
 		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
-		unsigned long tint = (uintptr_t)d->chip_data;
 		u32 offset = hw_irq - IRQC_TINT_START;
 		u32 tssr_offset = TSSR_OFFSET(offset);
 		u8 tssr_index = TSSR_INDEX(offset);
-- 
2.39.2


