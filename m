Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E70C44500
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:17 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89145.1783073292569045663
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=k8qZigdN;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b77b150aso2965605e9.2
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073291; x=1783678091; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LXsQYDPs7IW2jQj4KB1HOwgKUQ5pWkZwuRHxTvYpFy8=;
        b=k8qZigdNY89ul3yc6q7NX/7zqR8PfX3YBKFrAkAN7zDrwgGmMRjVRxwRdwSGbCRZSU
         ZT4m6HCWXeg5hWGXJ0hrGWLXmvLxGfUEte3MfVwGo6elMOHTdrWOc9fXpIQYspfZjOAx
         NihfVKib6AaBNalQtcMyv9gua/YcxszN5xjC9gbj+6ihAUYvDsmjkJvXLDbmtV4/hIQD
         n487agqxw5xEEJBZw/a3JyVViYWA0d+mLl0ugSkLGyIFfFyRX25D63EPqlnpNV9+0aXE
         EHqYMfphtVZ6WclhUZ5Z3CHPAFPQ8NSl5KVEJ6ifLV26rmA4/ivMFgDk8ZbeE6gD6YH9
         tg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073291; x=1783678091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LXsQYDPs7IW2jQj4KB1HOwgKUQ5pWkZwuRHxTvYpFy8=;
        b=I1PY4XiG34J8o+EXUFHeXa3wfXGOcBY2w3yTWZxMeapsqQ/o0984NyIgqs21vGFjOl
         S/KJiQXzkY7idonTK6WFhYFWYgglJL4RHLJrrrw1PYSPSLfjVdNlV6W/Ppk9pwwnL4br
         ObyOs5j18SSr8XHewNlGid5ZyhvgbTNwVYoGrIHeE9B+qahR3b+mQpeigoJ0jOB+Nadt
         mKDi/V3T6tP1IjxYfpOMWppn/cswv3DpW+E0Yfgo1789AId1uIQVwGkdgNfbLGFjT1Zo
         FlVT+z4KWIlN3geQAMGQLPTkQ0dWpW0A08xylLwMOufn0HoF9CSER0JMvjPdfSjIaQRz
         JXFw==
X-Gm-Message-State: AOJu0YyDiLAHmiHJMIyGhUfIYmQ9uKVRjy+MZDBamoDQHPvtKjzerVgF
	b69PvuXAieUEgMuRWWu48SXz+TWZd71btm4vNBYSDjGGEUWPNQeUkd4BCop3YO0y
X-Gm-Gg: AfdE7cky++WBh5WHyhVc3rXwn8GKJSjd7nUsAipdHhv60tEifhLtm+RRM/Cn62ecx+l
	T6kadvpehztsFuzta5nyfC0Y57btnE4Td18N6cSI4xpBS0gI6UFNc+GiFP+6exhOpvz261LoRyq
	kuF/qZ6tS6asw4djbWJNJ4bZNAOfFlvof3hYZP5TjGnbsnzkyJR2BXd3eIsZYN5zvoH6STvrYjp
	Rsr8XfJnVqaZEUDkKgvgVYzwe18mJ8DG30t6QTe/+XMxL9DWwWTqKfASRLtHu9U6H19A0vJ+C08
	yXmy+NHwm7zium3rbbOZPdTducAwND5pbhKRpESJwlmA7V7MfMmvhUUsDY3X4MOtYme1Oc7Az0B
	o8qEr8RsgVXE+JoaR28ZvdWth1Xhg1rchqB7HGIB3Y9E0mnX8Rcqt3K84rJJkqHct2MURQv8nBm
	Ci0wlLxau/80lvmbhu1C64
X-Received: by 2002:a05:600c:26d2:b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-493c3cedeb1mr78432375e9.25.1783073290727;
        Fri, 03 Jul 2026 03:08:10 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:10 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 25/26] irqchip/renesas-rzg2l: Clear the shared interrupt bit in rzg2l_irqc_free()
Date: Fri,  3 Jul 2026 11:07:44 +0100
Message-ID: <20260703100756.238233-26-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23417

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit d3689cd02c5de52ff5f3044169c482aee0dd5a78 ]

rzg2l_irqc_free() invokes irq_domain_free_irqs_common(), which internally
calls irq_domain_reset_irq_data(). That explicitly sets irq_data->hwirq to
0. Consequently, irqd_to_hwirq(d) returns 0 when called after it.

Since 0 falls outside the valid shared IRQ ranges,
rzg2l_irqc_is_shared_and_get_irq_num() evaluates to false, completely
bypassing the test_and_clear_bit() operation.

This leaves the bit set in priv->used_irqs, causing future allocations to
fail with -EBUSY.

Fix this by retrieving irq_data and caching hwirq before calling
irq_domain_free_irqs_common().

Fixes: e0fcae27ff57 ("irqchip/renesas-rzg2l: Add shared interrupt support")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260328103324.134131-2-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index cece433dc1fb..93510bcd79c2 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -695,15 +695,14 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 
 static void rzg2l_irqc_free(struct irq_domain *domain, unsigned int virq, unsigned int nr_irqs)
 {
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct rzg2l_irqc_priv *priv = domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 
-	if (priv->info.shared_irq_cnt) {
-		struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-
-		rzg2l_irqc_shared_irq_free(priv, irqd_to_hwirq(d));
-	}
+	if (priv->info.shared_irq_cnt)
+		rzg2l_irqc_shared_irq_free(priv, hwirq);
 }
 
 static const struct irq_domain_ops rzg2l_irqc_domain_ops = {
-- 
2.43.0


