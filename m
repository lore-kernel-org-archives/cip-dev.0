Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6809C4450A
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:06 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89974.1783073285269912619
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=T2Uu+apG;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c733f15aso3548895e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073283; x=1783678083; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDjXgPGB3H0+LbeKfIt2Dkvlt2cNTyRcg5IOck1Klyw=;
        b=T2Uu+apGw0le1ye3RASpgXMSu1Ebjizhq4oRwTLNLr57rnovPW0cQbgsc/ATGfYX0r
         s5njA4/dTz34QffQHfWML312YlZ7BgqaCD8YtSS+4PlIIzRBzJRNibpo+c2SVyazRD01
         ZoNqLiVC4iTmCiKp3op7VLSA/qdfnaCUKwyJHnWepEnMzGAQqBi8r8GLXv6okS5Z/Bbf
         GyO9eEc9tT/hnVIFF9tkAOlSDhgejCi+yNWhJNJTo9XAUCiSz1qpdiptr/namiOkAU53
         uv67BrGSnrl3X25l5nZs27bnHwbvVu1E/3+WHLFotSnM2Wq1Q9bylDTU8u+Yq8rp/jFm
         Chzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073283; x=1783678083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EDjXgPGB3H0+LbeKfIt2Dkvlt2cNTyRcg5IOck1Klyw=;
        b=bLOz6H65Hzjtzpv8eU8fp8WRyyvurHpLeAcrt6dW0hENA4pcI3QKqrihF0f8WRgSPp
         /5P97i5uagc3kYdR5YD9G3A6tMKM5At6QqseUWRfWm0WZufVH1zaYcyg+K0Bgf4X1xnM
         UWKR8MH+M3LyJ30FQRuAazGG3aQHnk3luCluj+gIG1eDiuMfBdqL1zZxAmIO+uJqrkjr
         cHJNBcLrZh5AfTP1JD8cgnOhZZ/gR4PAQQUMRhAGD2hzUMK+YpKMyqGF/NBk39x9FJ9t
         qLJJr3IqcPXLwxB5NReXthtZgCoLav14C6rVK69d+4VEdXKS8/yJkTVbyZivkhl1QTGF
         FuGA==
X-Gm-Message-State: AOJu0YwqArTYvvWPne+5Qej+nU7vJgWU74qV2i/k+BhXt5R3Gv+chfYs
	IfT7IG+zp1QMyEfdnt4JR2N648guGJcnBqDmfxAu1YOzZCI3LJEmLYaZDKq18CGR
X-Gm-Gg: AfdE7cmLLNoRFqpbDDnsQKk4I6wpI6tKkqN4+V3RXfCC7/WdJPdT2od5v4HH+tc/vqW
	DDvLxAlJRp1IkRYCI8nVs40cBwE2X8cx2uvzpVDinJdS5lvoUl3s8stlBbc/spRbfJzrXfFRTqB
	wopVnAN/jpCgU70Uw9pZ/Tf1JTbBsq3q3fTYNyzJllTknx/1ENEozF6S0qqzMplEBSQrVaesV8u
	b22rHhy2eYPEeVDuD+/w4xpJPZQLVHOGSjE9gDxShgYOYLR4RQ3E/VHK6j0lnaQNQM++eYAOlMx
	OkX0cxb2JYyhWjt4DZoxQSHAw5UUtUKo1HSAmUY1Ots5kpGyTGxkEQssWJ2yBsnpDrPB9052wG8
	lbc7wVBw017ylUI8KzImwAks8XNS7mHUiLL0Oy4NqbG79Itz9tJIWKb7yIhCeeTBg8nJRTpQ2j4
	9yCopsLhn1vofWYIc0GcS7MXxcpVW1RXY=
X-Received: by 2002:a05:600d:6402:10b0:492:7083:e5a with SMTP id 5b1f17b1804b1-493c2b981b6mr114662325e9.31.1783073283338;
        Fri, 03 Jul 2026 03:08:03 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:03 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 12/26] irqchip/renesas-rzg2l: Split set_type handler into separate IRQ and TINT functions
Date: Fri,  3 Jul 2026 11:07:31 +0100
Message-ID: <20260703100756.238233-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23404

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit d196aeb35efa2f2339b31f107c0ce35387946009 ]

The common rzg2l_irqc_set_type() handler uses hw_irq range checks to
dispatch to either rzg2l_irq_set_type() or rzg2l_tint_set_edge().

Split this into two dedicated handlers, rzg2l_irqc_irq_set_type() and
rzg2l_irqc_tint_set_type(), each calling only their respective type
configuration function without runtime conditionals.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-8-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 406b6ad45ef5..3704e58a0def 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -394,15 +394,20 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type)
+static int rzg2l_irqc_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d);
-	int ret = -EINVAL;
+	int ret = rzg2l_irq_set_type(d, type);
+
+	if (ret)
+		return ret;
+
+	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
+}
+
+static int rzg2l_irqc_tint_set_type(struct irq_data *d, unsigned int type)
+{
+	int ret = rzg2l_tint_set_edge(d, type);
 
-	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
-		ret = rzg2l_irq_set_type(d, type);
-	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
-		ret = rzg2l_tint_set_edge(d, type);
 	if (ret)
 		return ret;
 
@@ -451,7 +456,7 @@ static const struct irq_chip rzg2l_irqc_irq_chip = {
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_type		= rzg2l_irqc_set_type,
+	.irq_set_type		= rzg2l_irqc_irq_set_type,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
 				  IRQCHIP_SET_TYPE_MASKED |
@@ -468,7 +473,7 @@ static const struct irq_chip rzg2l_irqc_tint_chip = {
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_type		= rzg2l_irqc_set_type,
+	.irq_set_type		= rzg2l_irqc_tint_set_type,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
 				  IRQCHIP_SET_TYPE_MASKED |
@@ -485,7 +490,7 @@ static const struct irq_chip rzfive_irqc_irq_chip = {
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_type		= rzg2l_irqc_set_type,
+	.irq_set_type		= rzg2l_irqc_irq_set_type,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
 				  IRQCHIP_SET_TYPE_MASKED |
@@ -502,7 +507,7 @@ static const struct irq_chip rzfive_irqc_tint_chip = {
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_type		= rzg2l_irqc_set_type,
+	.irq_set_type		= rzg2l_irqc_tint_set_type,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
 				  IRQCHIP_SET_TYPE_MASKED |
-- 
2.43.0


