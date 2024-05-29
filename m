Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB494C41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:17 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web11.8694.1716970515996967224
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Ft22xNus;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.178, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso24600861fa.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970514; x=1717575314; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KDj+olPLtQu7WEkEryeqpt/CH2UFi8TsRtFvELNoN0=;
        b=Ft22xNusd6W2e9rAYca2JtzshBfX4bItxBtry5qtpJjPmoFZTTmiNa1W/D2I8ohpYA
         XzJjTGcnhewr3rzP8nZ9sH+wJPPLJB32th+U2hbyH24w+4he8h/fh3UhAXlw7r0kBoYF
         Z8ZNeDXGk2Uo5uBmDXOm+3NlRhMmnb7xuMAVUY/VFQXFTunbMZIyzdlfHVtE9ljqIvFf
         nbwshB82lleV8B1L3ArKAqYAI8F46IVyBxJb35dzjzwDHaLOmdgofVLycS2ENVn9tmlg
         +oCFnGPwiMjAzDtv4d4j830RloCrwAV1ym7ChTUWjn7aYaEdRr2zVAaWY8YFDNjX3Wo3
         AvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970514; x=1717575314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KDj+olPLtQu7WEkEryeqpt/CH2UFi8TsRtFvELNoN0=;
        b=hAU8mXNAgXRz0Cy0MW7Kt+cdfnp2ngOBxBSe+Ciw7FT0fYfcfyt0DCFEacNEpTcSPL
         fCyhGO5j0tVZl46BacxJXRp4oU1Mgo+2OY1dlvWCrP+H9cMc93c1+30IMoQLs82CiRzN
         HgqZOSr8G31hFKPNHSe4npxSpQoDkS0Kz8BIEmHGGsH+0OIUNeKHmBDMvD7dgWc6REFH
         ijNmMxjs8ld1AkbDbj+UPJZjfrQVAam4NNc0h7Bft/aXcJ925up1uSta7hlOzsatyUtt
         negDLUykWerz3ggqRyqwvCGfTqSqf7Szq/6BmtYpYzt+Q18fR/1MMpUm/5XclTf1Egxh
         FCsw==
X-Gm-Message-State: AOJu0YyEdsgiRUTVLUw09iMHpJ/RTub5wSWLyQ8tUJj00+SxybW5qw9L
	zqfa28TGGQLOMhKQxeet79tdvvQSXQvVpCCvR3w0abc/WLT77SK72UJbpHPydas=
X-Google-Smtp-Source: AGHT+IGbQy9dHpU8zy4H4GCnDNOz35wCKJCIA8uBp86DfVAC7razn64+WLr0f3VmMvqvv5HYNCrpVg==
X-Received: by 2002:a2e:9e50:0:b0:2e1:fa3f:67bd with SMTP id 38308e7fff4ca-2e95b256672mr112796701fa.36.1716970514192;
        Wed, 29 May 2024 01:15:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 23/33] net: ravb: Get rid of the temporary variable irq
Date: Wed, 29 May 2024 11:14:24 +0300
Message-Id: <20240529081434.639519-24-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16051

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
index 548bd436c51a..e206b5b21ffd 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2767,24 +2767,27 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
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
 
@@ -2796,7 +2799,7 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device *ndev = priv->ndev;
 	const char *irq_name, *emac_irq_name;
-	int error, irq;
+	int error;
 
 	if (!info->multi_irqs)
 		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
@@ -2819,28 +2822,28 @@ static int ravb_setup_irqs(struct ravb_private *priv)
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


