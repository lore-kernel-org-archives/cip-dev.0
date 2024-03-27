Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A93CD12B4
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.32433.1711527490489761232
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=HokYqtc4;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so3120275e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527489; x=1712132289; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToSucKwbPqdoHraBZXnmWdJqUnwHYMVZqR4ncg2CPCA=;
        b=HokYqtc4eP34cGmgp3o3OodsYz/pkBHwk1EZQymk0a9DRxLEdRLSxgrDYVxlaGtymR
         PAMlaPcFt39ikk/4ROoc4pH65E1NLu2HI3cEilxSWzWLKG7tdkEAwZAftOEWSXynGFOe
         Ob9l24cO/mbAJj8wytaW/Cp+KPLX2NVSUNvlZiRymQ8z/lXZBpHuVaFyL5a6CHKzx9kR
         AEy34xhMwc/L9GTNo4B1gJWJD5IvVURM3HLeHpTn6G6t23V4omA4ND78lr7YG20J+WXP
         KE+VWG5O02nNSGuZuMrmrHna1HE5Tu9u6tySK+lEZEB+L/Ss0NZ+g+GYYiGRiRhkTrsR
         l8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527489; x=1712132289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToSucKwbPqdoHraBZXnmWdJqUnwHYMVZqR4ncg2CPCA=;
        b=hBD4V+tmAiiSwF/2fu0n52Wpjw6fF13tbzog49d6t/JJFYz7Hgkd/MNwH9g6eP/XC2
         hSg+bcO5VViavs4mtmmWzcOJi0d/ZfdVXRhkVGMKYSKM7M2xNeUKW8K4QlNbxidUMk11
         Lqygz+THgNGSDDyVo21pk/NnA0g7yzzfkFTI6qnBTp/Y5k5fnlaFxFHNO01tqbr5NanD
         IsFBdIEPVCWC9HUHPLAOu2rqM6P//bGJGFia911S2JQU0ADK86c6kTBIAPorJqYcSw0b
         YmHitAQSNYJMlZQ+QnLcBPSD3+8H1DkNlefl+T0WIaUjyZwjKv6jawaSvuqBBCU5RP6s
         RWeg==
X-Gm-Message-State: AOJu0YzRKEc2i8ht4uoa8a7A8jLzPacxcVFmq3wvSzZK6W5JM1Wb22S2
	diz0csBiNOWinvqPHSWuVmzwim8Kco2xMHtLGH7wt/I7aokWe0isbek2wOGOQoY=
X-Google-Smtp-Source: AGHT+IHwTaREpG2JprD9rgxprvxPQoamwTm7+w8ySz9s7XENRqfX4i0hVxQhqIUlhPcEJBfGdK9XKg==
X-Received: by 2002:a05:600c:354d:b0:414:8849:947e with SMTP id i13-20020a05600c354d00b004148849947emr3420724wmq.3.1711527488978;
        Wed, 27 Mar 2024 01:18:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 09/36] irqdomain: Make of_phandle_args_to_fwspec() generally available
Date: Wed, 27 Mar 2024 10:17:29 +0200
Message-Id: <20240327081756.2228036-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15426

From: Marc Zyngier <maz@kernel.org>

commit 8b0b9d113ac2dfedf8daff18429b56f9de6d0fea upstream.

of_phandle_args_to_fwspec() can be generally useful to code extracting a DT
of_phandle and using an irq_fwspec to use the hierarchical irqdomain API.

Make it visible to the rest of the kernel, including modules.

Link: https://lore.kernel.org/r/20210929163847.2807812-2-maz@kernel.org
Tested-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/irqdomain.h | 4 ++++
 kernel/irq/irqdomain.c    | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 9b9743f7538c..7871b4adeb3a 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -66,6 +66,10 @@ struct irq_fwspec {
 	u32 param[IRQ_DOMAIN_IRQ_SPEC_PARAMS];
 };
 
+/* Conversion function from of_phandle_args fields to fwspec  */
+void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
+			       unsigned int count, struct irq_fwspec *fwspec);
+
 /*
  * Should several domains have the same device node, but serve
  * different purposes (for example one domain is for PCI/MSI, and the
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index fd3f7c16c299..b9fda33a2148 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -784,9 +784,8 @@ static int irq_domain_translate(struct irq_domain *d,
 	return 0;
 }
 
-static void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
-				      unsigned int count,
-				      struct irq_fwspec *fwspec)
+void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
+			       unsigned int count, struct irq_fwspec *fwspec)
 {
 	int i;
 
@@ -796,6 +795,7 @@ static void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 	for (i = 0; i < count; i++)
 		fwspec->param[i] = args[i];
 }
+EXPORT_SYMBOL_GPL(of_phandle_args_to_fwspec);
 
 unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 {
-- 
2.39.2


