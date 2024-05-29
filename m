Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0363C25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:36 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.8653.1716970291094705567
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=HsvtnmSG;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5295e488248so2130646e87.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970289; x=1717575089; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUHTj+LaLoksDFk973VDojZyuJWn7SJL62EdH4Nj4m4=;
        b=HsvtnmSGCEdMQ+ZRPlpJCAcmWXkH0FPfVTRv+P0lUiksMKbnc2Nury7nSaILYqwPbg
         9/6Tc4d0S3U/GIU/Qdynr9Uz1SfLUD7Q6OXmBP6OV8UzENmZP6iFRZilfNxIlxUxmR4O
         FC5+2dptPVKmvFPOIVMNVA9WuGMtQNTG0BdPyssvCa5Trs8pvuYZrURLgQ2bDnLXwMng
         t9w3jZuDprsniE26kguVW5Nxjve34copxTiDjxJWb+OYKSiUzozheCh/OYdit1c0o6ma
         gbcdsuVD88/Z6gfty7Sz8O6Ih585cM8Bz3Ib6tuJLHAxVPO0DxqgtSAr87THmmUfbDeF
         1Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970289; x=1717575089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUHTj+LaLoksDFk973VDojZyuJWn7SJL62EdH4Nj4m4=;
        b=a35uhFlS0AfUqJFnUZyc6zhGZsnefru0Vl0aTxWdQVgkD/6js83vO1LWjYufNUMzaD
         t8Huh032+KEe/qvQSDr3uC3NDA00OD8daVXHBvfzFR5kwxLobRUGFlUH3HQeH0OKYcQM
         czUYcquUxQLE5VcKqMwtgHkM1k2sfsya7suipzdPubjTPnE0G7NPFdQ00Sdl1+qTMPFr
         yk4dxjg8HjClWZ8aKxkwq8zjT6Tp9K8aIEOIapnCGUEgFlU6ahwKtYfNZ2WvkJ4/pHd5
         EoA88L2AWonfqiZGY9ahjLThJrSDS9XdFctNr7MPuyQttL+mrxmVf8CGjbhQeoFBTyKb
         wHVw==
X-Gm-Message-State: AOJu0YwnIo8Et35UrrEHIjkAGO5mFqYgKXE0pHILfQil+yCXW1iCp2Ot
	o3FgDsA65rgNAFGSRvUSuqlwp76oVRWFW9djTXOA2Ab8TUbP5MJQI8C5x17nWzc=
X-Google-Smtp-Source: AGHT+IEiCdgzl55r8olKsWHD+lbRa2BEMwOeu7412rDA8/5PjovX8hq0uDQjLwpL0myC2dAg8zICAQ==
X-Received: by 2002:ac2:4d10:0:b0:523:bbcd:ed5f with SMTP id 2adb3069b0e04-52964bb2cb3mr8022848e87.33.1716970289383;
        Wed, 29 May 2024 01:11:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 29/47] net: ravb: Move PTP initialization in the driver's ndo_open API for ccc_gac platorms
Date: Wed, 29 May 2024 11:10:21 +0300
Message-Id: <20240529081039.639010-30-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16009

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
index 1989320b84c7..b3c7defac9a2 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1886,7 +1886,7 @@ static int ravb_open(struct net_device *ndev)
 	ravb_set_gti(ndev);
 
 	/* Initialise PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	/* PHY control start */
@@ -1900,7 +1900,7 @@ static int ravb_open(struct net_device *ndev)
 
 out_ptp_stop:
 	/* Stop PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
 out_napi_off:
@@ -2210,7 +2210,7 @@ static int ravb_close(struct net_device *ndev)
 	ravb_write(ndev, 0, TIC);
 
 	/* Stop PTP Clock driver */
-	if (info->gptp)
+	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
 	/* Set the config mode to stop the AVB-DMAC's processes */
@@ -2816,10 +2816,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Initialise HW timestamp list */
 	INIT_LIST_HEAD(&priv->ts_skb_list);
 
-	/* Initialise PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_init(ndev, pdev);
-
 	/* Debug message level */
 	priv->msg_enable = RAVB_DEF_MSG_ENABLE;
 
@@ -2864,10 +2860,6 @@ static int ravb_probe(struct platform_device *pdev)
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
@@ -2893,10 +2885,6 @@ static int ravb_remove(struct platform_device *pdev)
 
 	ravb_mdio_release(priv);
 
-	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-- 
2.39.2


