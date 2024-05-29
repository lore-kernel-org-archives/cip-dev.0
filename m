Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2AEC25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:57 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.8665.1716970314694833629
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hro1wynZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5241b49c0daso2086307e87.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970313; x=1717575113; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJkrxLihBg9QaOUwDXMfn5TlEaDwFFFO7H+jGPUoSnY=;
        b=hro1wynZgvCFiTHE/gDmZa3RKKlPQ3zT3BJAS1nbEeVyXInBCJyinien25MWaIvbPL
         KSam9BISCXnMHVCiRiei0ClHnmyGyLtXR5mt1u5iqBJMZFmwlbmA5v/ozRxKf8nAM5N8
         od2roPD+Hj7AfA7DgOvPjoZBadICOdip85Ddj1314Jnia+vVHbUR72NpgEbOgzM7X1Qz
         fmAaD8kQ+poKjOS31z3+ZyYA+oGZiZ/ROrxjPf/rRSy5zBREkk9E+9wuxnW6Pjm0cxwq
         JBRB2RfW6Mz56KdRNSO6eiDXXug8fVv+kAwM6vfE9TsCOdhBn0XaynySF+6tSgbuC3eF
         Y5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970313; x=1717575113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJkrxLihBg9QaOUwDXMfn5TlEaDwFFFO7H+jGPUoSnY=;
        b=bJWPM7tcq6+M+1licqF6xaH7HNuuDaf7mNQjX0dCkeUUyZpcT+ykrnfHW4r1ocl3Wc
         l0LVUKDx8nyDN28m06HqD6nOqzE1oaaGzL+W3DpTSIjlyqvEOYWoCYFmEx3t7XSq0DO+
         nllT/kyVKJhIX4/2LQdr3YIDHAzZiarorUxULNpOFOLX65IfXq2Tg5Ulhmgy0ub/vvL9
         me7bUUxK4OxhQZONvq2KiRlcsT+uRAvXwiG1NeUB4mJyuEooMEpd0KQEdVYrmvv2LRz2
         oKsyFy22L4+z6w1FmA0S/fgxXXIuFUT2of1XGgZuRiBkMV30u4qwAX+Pq/UKi3edF/Th
         DPwA==
X-Gm-Message-State: AOJu0YwS7FLrGnl0iUoXHzcqYwbm3LoLc8o5SveT5Ip2VwQLq9YBM8In
	f86StO2wQNCayvuGVju6ebcsp0NwyLEP8Ebxo5un+vaKHDRHRQA8X+ULOUUB0cc=
X-Google-Smtp-Source: AGHT+IEvUit3Ln56DwYXi++n9v026zh4LSkl8bbrm47Y3g3kBjJWtIN5aA0eTtu+/JIuTFtg7hqUBQ==
X-Received: by 2002:a05:6512:3da6:b0:529:b796:1c9 with SMTP id 2adb3069b0e04-529b7960883mr4178512e87.3.1716970311871;
        Wed, 29 May 2024 01:11:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 43/47] net: ravb: Fix registered interrupt names
Date: Wed, 29 May 2024 11:10:35 +0300
Message-Id: <20240529081039.639010-44-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16023

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
index c4ee77d41329..e86b4a006dc3 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2790,19 +2790,18 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
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
@@ -2812,9 +2811,9 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
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


