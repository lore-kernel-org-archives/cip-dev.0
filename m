Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F68C41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:38 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.8739.1716970525281164728
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bBsPqH1U;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420180b5898so14220875e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970524; x=1717575324; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltMf6eyaa/TH5/lhMSvHsLYulQevnP3C5oUythagMSg=;
        b=bBsPqH1ULBC7Hi9E/Zixe3hRLWugNZizCWMVNbiLTj4gwcDkcQzxTVjt+nP73U6WaF
         jBokLrwiV99ywZ9neqnP13KKar2zGTjNiUmlJkRZplqftNRQCHzF/H2VSCsEq4W5B9us
         Z5PghmR2Rksd7K+Dvxr+2QTzL7wjebdZkWNSBuMffSIpi0lao8K47LCW/4jN/0TaMksY
         2Fd8bLrTVtHH/4j55XbkVeYEk1csmauZMIxm+VxTZ51WG1Gov0GshV901OrumlWYYZlV
         ddKh10CeFh0t6QRkFddAPOeTnD6kERXnz/fQShm2xEGRpZHtpUrBxHJv2CxjX18tmhqr
         WCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970524; x=1717575324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltMf6eyaa/TH5/lhMSvHsLYulQevnP3C5oUythagMSg=;
        b=HtVlVXUr1GvC99j4Z6Enl7vjMcPDwzlPmxwe1UefrzkElCrrGPeDeeKVBybffbRxnJ
         3xgufDfCAU6cokmDUZ6CuWqaPBFgQEs89LtBr1kBb4sSBX29wNPCSBBkLL5BMfQRUNHk
         PFNI3RtZpmXftPz9oThMmYTZUTRDRQ9HEIWgQHpX4bkiSrGOpajiy3hk+Ro9G/oNqDb8
         s+scQGGQqkxJY5CI5/s5dGZMX7GEYPFs5L9Nfur4GPGxh+zDPwFtuDXscMEqcsx+7aya
         hAuJV8R3IfbyWnEjHMYc2Ihv+JDjkxgZyV0r97oGf0XDGHz4DHRmJPFsY7Z2Uc5vKm7U
         N1wQ==
X-Gm-Message-State: AOJu0Ywwz9AX5YNG16RXBLEZw1ZEbLlki0LgAlbVm9UcLRCKWhnasU3N
	XOTwe+05txLnuiDnUOWRYh1pieiByfY6jTKa0QEJT3r9tvKqRaVos0pEBdVlSaI=
X-Google-Smtp-Source: AGHT+IHDhoudKFdk5QqeMdEk7OLEzR/S110zd6aLrrlIgDsdq6XsMwVo93I35mYTJx6EgI0kniHynA==
X-Received: by 2002:a7b:c5d0:0:b0:420:29dd:84d0 with SMTP id 5b1f17b1804b1-42108a00091mr111447845e9.29.1716970523771;
        Wed, 29 May 2024 01:15:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:23 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 29/33] net: ravb: Fix registered interrupt names
Date: Wed, 29 May 2024 11:14:30 +0300
Message-Id: <20240529081434.639519-30-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16057

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 0c81ea5a8e231fa120e3f76aa9ea99fa3950cc59 upstream.

As interrupts are now requested from ravb_probe(), before calling
register_netdev(), ndev->name still contains the template "eth%d",
leading to funny names in /proc/interrupts.  E.g. on R-Car E3:

	89:  0      0  GICv2  93 Level  eth%d:ch22:multi
	90:  0      3  GICv2  95 Level  eth%d:ch24:emac
	91:  0  23484  GICv2  71 Level  eth%d:ch0:rx_be
	92:  0      0  GICv2  72 Level  eth%d:ch1:rx_nc
	93:  0  13735  GICv2  89 Level  eth%d:ch18:tx_be
	94:  0      0  GICv2  90 Level  eth%d:ch19:tx_nc

Worse, on platforms with multiple RAVB instances (e.g. R-Car V4H), all
interrupts have similar names.

Fix this by using the device name instead, like is done in several other
drivers:

	89:  0      0  GICv2  93 Level  e6800000.ethernet:ch22:multi
	90:  0      1  GICv2  95 Level  e6800000.ethernet:ch24:emac
	91:  0  28578  GICv2  71 Level  e6800000.ethernet:ch0:rx_be
	92:  0      0  GICv2  72 Level  e6800000.ethernet:ch1:rx_nc
	93:  0  14044  GICv2  89 Level  e6800000.ethernet:ch18:tx_be
	94:  0      0  GICv2  90 Level  e6800000.ethernet:ch19:tx_nc

Rename the local variable dev_name, as it shadows the dev_name()
function, and pre-initialize it, to simplify the code.

Fixes: 32f012b8c01ca9fd ("net: ravb: Move getting/requesting IRQs in the probe() method")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/cde67b68adf115b3cf0b44c32334ae00b2fbb321.1713944647.git.geert+renesas@glider.be
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 892912716488..dda7fb410657 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2807,19 +2807,18 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 	struct platform_device *pdev = priv->pdev;
 	struct net_device *ndev = priv->ndev;
 	struct device *dev = &pdev->dev;
-	const char *dev_name;
+	const char *devname = dev_name(dev);
 	unsigned long flags;
 	int error, irq_num;
 
 	if (irq_name) {
-		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
-		if (!dev_name)
+		devname = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", devname, ch);
+		if (!devname)
 			return -ENOMEM;
 
 		irq_num = platform_get_irq_byname(pdev, irq_name);
 		flags = 0;
 	} else {
-		dev_name = ndev->name;
 		irq_num = platform_get_irq(pdev, 0);
 		flags = IRQF_SHARED;
 	}
@@ -2829,9 +2828,9 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 	if (irq)
 		*irq = irq_num;
 
-	error = devm_request_irq(dev, irq_num, handler, flags, dev_name, ndev);
+	error = devm_request_irq(dev, irq_num, handler, flags, devname, ndev);
 	if (error)
-		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
+		netdev_err(ndev, "cannot request IRQ %s\n", devname);
 
 	return error;
 }
-- 
2.39.2


