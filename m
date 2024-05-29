Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86C0C27C44
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:46 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web11.8591.1716970301893269894
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=M8hWUt1s;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.172, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso23427921fa.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970300; x=1717575100; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkR7xmjaoy1EVxmzZGEcFv8IsT8bUsaxHqypmsKNPls=;
        b=M8hWUt1sBhzkuamwbgGYILPabukmrjVDA+rBPqKDCNYNqKGcA0wR8jC6sSVG69XxyJ
         Xf8kC7K4PUAuGR+vznw+xd+ttPdEvVu/tYdli2niKiuy2mo3ZmhRu3cJEdBMdLC6GEt3
         naTlQoTtFscFtkmJp9ZUe977hcPhZiPaAGkZXNnYG+qSxZBThNJdfykQFKXP16i6kVR+
         /0j+ISYPZvEGKbVDksxm8vn535z8gwdTb2DAxNbQ3zGBMP4FhXGw0kRsYAuchMUzgcTz
         YUh3NxvaI10fObFFJLK+c5TPmVS6XR3wpneHPIHQxVNfiozuzPUdZZtM8W2k9LHWYoy+
         5lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970300; x=1717575100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkR7xmjaoy1EVxmzZGEcFv8IsT8bUsaxHqypmsKNPls=;
        b=A3L5hTahIP0kKWFY3dfb//pWSxYoSbUm8jvromJfTVFMZTn4rwj2br7Z/y9PouZWZ/
         NS+5iJPWTGGIRKrEkNSnNz2qY8bbDfUf4wwHPQX3pf+CYaKH97Fq/vgyvygdBbtevnkT
         lATr9SB8Q0MvpN8q0PZLiEFCSH6NLweTp9yyTq62bmYy5ZQe+69Dt7PMUuQik+3p+jwH
         6oxpW5+3qM3+ZMEgz5SDOgG81ShAeeOS0a0E8ISbBsDmfeDgEZUKqqfD1T1sZi98OhjQ
         chrurcpTscExY41Pjaa0ZvmzTROqrCDOeBpweyJ1/fYpx67kg/bOAUU1Vc/CVevIa4pd
         wLTQ==
X-Gm-Message-State: AOJu0YxmVd+TJwOCloNO4EDUbxrpJD9iW0ifkU4Lv4Xd19d35pBhqAHL
	tgYzVSJtmNWzXXeLTuIPmKjIws26nfMUlDcXWeOQnQo6r9LiMHre0TdSg/O4vCWdsbMNXjlIYgV
	B7Ow=
X-Google-Smtp-Source: AGHT+IF0qArPCjLp8UATRexfHttH0nolSXfoCX5gDOdF/K5C1EahnY6zHWWeN/zMODn8KKWjSTR4gQ==
X-Received: by 2002:a2e:3c0f:0:b0:2ea:7f2e:cee9 with SMTP id 38308e7fff4ca-2ea7f2ed091mr2270851fa.26.1716970299823;
        Wed, 29 May 2024 01:11:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 35/47] net: ravb: Get rid of the temporary variable irq
Date: Wed, 29 May 2024 11:10:27 +0300
Message-Id: <20240529081039.639010-36-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16015

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a260f080660ef8bac97404dd0b9ddbe35a608426 upstream.

The 4th argument of ravb_setup_irq() is used to save the IRQ number that
will be further used by the driver code. Not all ravb_setup_irqs() calls
need to save the IRQ number. The previous code used to pass a dummy
variable as the 4th argument in case the IRQ is not needed for further
usage. That is not necessary as the code from ravb_setup_irq() can detect
by itself if the IRQ needs to be saved. Thus, get rid of the code that is
not needed.

Reported-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 29 +++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e3f475b73ea4..d9c6a4d048c8 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2750,24 +2750,27 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 	struct device *dev = &pdev->dev;
 	const char *dev_name;
 	unsigned long flags;
-	int error;
+	int error, irq_num;
 
 	if (irq_name) {
 		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
 		if (!dev_name)
 			return -ENOMEM;
 
-		*irq = platform_get_irq_byname(pdev, irq_name);
+		irq_num = platform_get_irq_byname(pdev, irq_name);
 		flags = 0;
 	} else {
 		dev_name = ndev->name;
-		*irq = platform_get_irq(pdev, 0);
+		irq_num = platform_get_irq(pdev, 0);
 		flags = IRQF_SHARED;
 	}
-	if (*irq < 0)
-		return *irq;
+	if (irq_num < 0)
+		return irq_num;
+
+	if (irq)
+		*irq = irq_num;
 
-	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
+	error = devm_request_irq(dev, irq_num, handler, flags, dev_name, ndev);
 	if (error)
 		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
 
@@ -2779,7 +2782,7 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device *ndev = priv->ndev;
 	const char *irq_name, *emac_irq_name;
-	int error, irq;
+	int error;
 
 	if (!info->multi_irqs)
 		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
@@ -2802,28 +2805,28 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 		return error;
 
 	if (info->err_mgmt_irqs) {
-		error = ravb_setup_irq(priv, "err_a", "err_a", &irq, ravb_multi_interrupt);
+		error = ravb_setup_irq(priv, "err_a", "err_a", NULL, ravb_multi_interrupt);
 		if (error)
 			return error;
 
-		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", &irq, ravb_multi_interrupt);
+		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", NULL, ravb_multi_interrupt);
 		if (error)
 			return error;
 	}
 
-	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", &irq, ravb_be_interrupt);
+	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", NULL, ravb_be_interrupt);
 	if (error)
 		return error;
 
-	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", &irq, ravb_nc_interrupt);
+	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", NULL, ravb_nc_interrupt);
 	if (error)
 		return error;
 
-	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", &irq, ravb_be_interrupt);
+	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", NULL, ravb_be_interrupt);
 	if (error)
 		return error;
 
-	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", &irq, ravb_nc_interrupt);
+	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", NULL, ravb_nc_interrupt);
 }
 
 static int ravb_probe(struct platform_device *pdev)
-- 
2.39.2


