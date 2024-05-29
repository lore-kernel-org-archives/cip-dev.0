Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD68C27C44
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:07 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.8686.1716970506047651372
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dvuqGRJC;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42120fc8cbfso11579135e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970504; x=1717575304; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flqdFv4StWiFTBBlyfk23JzdtIVP1RU0VCG9/2qjmE0=;
        b=dvuqGRJCu4/SpRb1S3mDVHmofgD3SCJyAVKVhbjAEC5WgiFjadBmzYibEergORY+Hg
         hCgeTfI4Tg6o2sN02VLvJiT8oISp6nxkefDucJXLL8p4gibT013yph2IoPN75VhgPNTM
         1MttSIaN2DkYhK6mOjmGnT0o2g1bNwjW6l4cbDkiC4ApdDQq7AkxnAPOHll8ER7UL2VH
         YQr63yrxrcaA4f1q9T4+rytZuAIfFl+6woO5s9QhvZuXnu/x2s/H+k6l3qULqlSMnbLL
         3e4VAghhksNrSxsJ2MDOZGi5eUEXqvZl8AINIfNeYozF15HJjSCSy4uuejR/G7jjTjt8
         mpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970504; x=1717575304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flqdFv4StWiFTBBlyfk23JzdtIVP1RU0VCG9/2qjmE0=;
        b=u+2VLe+gL2GqlByKvWEo7qX6vOc4gkjVyV+roDAm1IQTJG8BCJLU8cYG2h91g/FxCy
         unB63TjDe4fYw0rXmIAV+vGD8bn4GNN4572ehT8OGD/ep0n0emLDDx1Zs/qNFhXzazcY
         aeECK4fP9lKuvUq4+2PoJtQjaAcL/KD3YLtjFrkPgqHVR5UqlB2tHhHNdukc4LqkTx9q
         KzNU6/zNoq4J6w9+u603Nc553zNuL8FfaGQXcbglKQNTsQvpMwBwKNh4TddnJ+Su2/kH
         kTtIpEJU5ODa3VNfGqmINpcuo5IvD9jKZ050K6hzo/ETZ4bu00mh/AHIpbWtREIQwp1S
         E0rQ==
X-Gm-Message-State: AOJu0YyIwOKMzJwcbUx7t8ZwpgpLgsLE74eEEoeJS27P0zD7VwKEuAeN
	EiWYiULjar6j98p+rzEYFVpBdKOxtDhI9szj2vlLUtP8FNq6Y6IjWc/ay8+2H5Q2SJ+6/b2gvpm
	Q04E=
X-Google-Smtp-Source: AGHT+IEwRUAQbgEP6OGFkezlSh6V4ldqx03A4Z2TBxxg1t3uehlxdUU9z8u0UsysG+jOY/w88VYGHA==
X-Received: by 2002:a05:600c:56d5:b0:41f:ed4c:b8b6 with SMTP id 5b1f17b1804b1-42108a0cac4mr116464165e9.38.1716970504501;
        Wed, 29 May 2024 01:15:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:04 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 17/33] net: ravb: Move PTP initialization in the driver's ndo_open API for ccc_gac platorms
Date: Wed, 29 May 2024 11:14:18 +0300
Message-Id: <20240529081434.639519-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16045

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a6a85ba36fd0d3e5595a4fcf57e0811826254ff7 upstream.

The initialization sequence for PTP is the same for platforms with ccc_gac
and gptp (according to "Figure 50.71 Flow of gPTP Initialization (Normal,
Common to All Modes)" of the R-Car Series, 3rd generation hardware
manual and "Figure 37A.53 Flow of gPTP Initialization (Normal, Common to
All Modes)" of the RZ/G Series hardware manual).

As some IP variants switch to reset mode (and thus the registers content is
lost) when setting clocks (due to module standby functionality) to be able
to implement runtime PM, move the PTP initialization to the driver's
ndo_open API.

This commit prepares the code for the addition of runtime PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index b8b82ba03c5b..cb6e9bf8bddc 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1896,7 +1896,7 @@ static int ravb_open(struct net_device *ndev)
 	ravb_set_gti(ndev);
 
 	/* Initialise PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	/* PHY control start */
@@ -1910,7 +1910,7 @@ static int ravb_open(struct net_device *ndev)
 
 out_ptp_stop:
 	/* Stop PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
 out_napi_off:
@@ -2220,7 +2220,7 @@ static int ravb_close(struct net_device *ndev)
 	ravb_write(ndev, 0, TIC);
 
 	/* Stop PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
 	/* Set the config mode to stop the AVB-DMAC's processes */
@@ -2833,10 +2833,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Initialise HW timestamp list */
 	INIT_LIST_HEAD(&priv->ts_skb_list);
 
-	/* Initialise PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_init(ndev, pdev);
-
 	/* Debug message level */
 	priv->msg_enable = RAVB_DEF_MSG_ENABLE;
 
@@ -2881,10 +2877,6 @@ static int ravb_probe(struct platform_device *pdev)
 out_dma_free:
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
-
-	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
 out_rpm_put:
 	pm_runtime_put(&pdev->dev);
 out_rpm_disable:
@@ -2910,10 +2902,6 @@ static int ravb_remove(struct platform_device *pdev)
 
 	ravb_mdio_release(priv);
 
-	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-- 
2.39.2


