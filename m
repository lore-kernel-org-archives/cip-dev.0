Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B07CD1283
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.32438.1711527497181731267
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LKxWpGfc;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-414946b418dso2237885e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527495; x=1712132295; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Naezq1Kf17hunjBvl5IksexI6PZLahnE0c3B5nFYe8o=;
        b=LKxWpGfcVVj7MqLAVh270fbkvBv+AFcT/LLz5y7vmlxqaUW+bc0jY3mZrpV3zLzWdl
         QQM5PxKUibycgC0Zfo2ilvzaKAPhyzUzCfzJJ34/g7rWW66zdyS6G07Tm57Gqk7sneqG
         k6nM4SJlHnEMN2/s3c7eIAWL7BZ3R4r8d/ktwisKC3sXnN7O9daofHBUXeztUqcUop5s
         rIIp0dac0i0eOjlb5qVzU9gTr20pg0lNRhOAM9345lQdjpOHXCAaE2t21xn4tFZWVuOo
         EyNbxljnOeHyV+PvUDm9l94lte2oVlwUwZEbv9ArrjmQ1o6vf+UBc/3FB8O9edC4DJkM
         M1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527495; x=1712132295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Naezq1Kf17hunjBvl5IksexI6PZLahnE0c3B5nFYe8o=;
        b=Hl6HYiziZH3/1SRaOzeTFkUf9+x4EeT5ENNCnixbW9k8VlHtel41j229DBy1mI8w1f
         wDI7E1srW2FGPpQn7r+97wAnoqWxevVZrsqtszW1GTj66hiuJIdtIulCsVGelLpJiBKo
         3pXKenMwZ86K/WH5qODlkRdTpDx1nKfsOV2qEHJCsPhNyOiW6bHa91pEcs6p9ZxA1XzY
         gGbHuxLnZ5VerCxFB2euZYnJel7BqrvgkgkNOWCH28+Ke0DxK9aUbxlgBQI0xSWJ+HlY
         oLm4vJo3xxEO5Cmm8y5lR8f0koYscbU4fEII0yx539WRh8XlZ2L2gax5pO2KOuRDWS/R
         VZjg==
X-Gm-Message-State: AOJu0YwbtXPv7f24XgyvF6Si2Tdnv1H/FVdoS5CIhrrwmkvXbfnSCPMv
	6/nvC2FLt9lE8uQlpm/Yb34UKGFqeLq9++2NsjLB8Rm0kgBkA64ADKzZgwtKgME=
X-Google-Smtp-Source: AGHT+IH5AIot9NiGEBEM8uOoiiAJlhDTkDyjNfjqBxLjWx20hDeO3bkipA44zWGwLkbyZgZhAGhKgg==
X-Received: by 2002:a05:600c:4fd6:b0:414:82a8:24c with SMTP id o22-20020a05600c4fd600b0041482a8024cmr2560966wmq.29.1711527495683;
        Wed, 27 Mar 2024 01:18:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 15/36] irqchip/renesas-rzg2l: Enhance driver to support interrupt affinity setting
Date: Wed, 27 Mar 2024 10:17:35 +0200
Message-Id: <20240327081756.2228036-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15432

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f881feb180fd0563809b62faa3f7da234e81d42b upstream.

Add support to set the affinity of the IRQC interrupt by implementing
the irq_set_affinity callback via the parent interrupt chip.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231011195324.66807-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 67856b865e98..93c0d2707fcf 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -248,6 +248,7 @@ static struct irq_chip irqc_chip = {
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= rzg2l_irqc_set_type,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
 				  IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE,
-- 
2.39.2


