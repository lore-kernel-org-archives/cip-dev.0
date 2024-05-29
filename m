Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497C5C27C44
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:16 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web11.8575.1716970272611886580
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=UCizq0hN;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52a6ef5e731so765183e87.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970271; x=1717575071; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVoK2RgdcMTKBoqzAy0bfobXWH9WMI+Aknn/n1mx1X0=;
        b=UCizq0hNO/hInr7Uzm5PPw07UUAIMHtq2VWsuTPGYsEUGAiJeMR8FzLrQhyIrhhuh8
         qxnfqkm9tW1AqMjiYT7DlFuyXZ0pMbqHlN/trbOzaxTHsCsO1b06KO6PvvCt1yet2l0O
         1mvDRPvPbHIuNvsYNmOA9w827fyqKksC84dVChItlFaJHkNbiTfgMvQDFKDvgcoDyT18
         +K41zT54qf8tI/PTSeOBVcR0szfMLW/sVtRas+I70WqgWdaiRevS7JVFkWSSOalKsSau
         GL4WEhoLqL6eFKutrIfbQvHKvp5N1iT8V6Hgzau/onCXLxiYdWscgldBnBVINTQJk6f2
         aYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970271; x=1717575071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVoK2RgdcMTKBoqzAy0bfobXWH9WMI+Aknn/n1mx1X0=;
        b=gZ1Bsja22iUACNoo3RyIAw1yBf8ZfQTAZ/esV9JFFE8Ld+5YRxZ2Eql7tF1xPAK8if
         5UY9WyeLw6yRnzh+X0tHSWXFt+kcbad5hA1ab3HMZb6UTNiA2eU9qiocVf4UI7+1ilBP
         Eqxk1/XjCiey/A8wHqW168XtRdnROSWTqxhzRsF6wOxXcc2FNFROIDZGUgsaFSC7OW1g
         J0OlzkOuTmPqke81r7fbwkoa+dDzc3D99R/BPj/l9PbZm1zTHXR4u88DIbH4BLefN0eH
         WsZWmvOLzSbvHTlPlpy1dgqDDXHwK/PL0iUsxSFBcGCfHteHRIiaM53KAQJ+PI2maSO5
         vzpg==
X-Gm-Message-State: AOJu0YxUwJB2oZiL1ITnQdraiqGS85cE0rm+/rmo5pjc4cbjjLVfzW7J
	3nBisDCRrev0hOc5Z/bMCNXrwPDn9D6Qiuajm6XFQgrieiYybXh+wD0zHmSfFdE=
X-Google-Smtp-Source: AGHT+IGc/qmbrbqg3WBLiqd6/RRlszlVWv4YZHw5OCAvGtXNWCXmTKzXzGbgtg8AjXuA48A2d+cmAA==
X-Received: by 2002:a19:7705:0:b0:523:bb4c:7b99 with SMTP id 2adb3069b0e04-5296420821fmr8959178e87.8.1716970270833;
        Wed, 29 May 2024 01:11:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 17/47] ravb: ravb_close() always returns 0
Date: Wed, 29 May 2024 11:10:09 +0300
Message-Id: <20240529081039.639010-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15997

From: Sergey Shtylyov <s.shtylyov@omp.ru>

commit be94a51f3e5eee72ba4251c1b1c463872b03cf54 upstream.

ravb_close() always returns 0, hence the check in ravb_wol_restore() is
pointless (however, we cannot change the prototype of ravb_close() as it
implements the driver's ndo_stop() method).

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 9b6594ef011b..0c803f697825 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2979,7 +2979,6 @@ static int ravb_wol_restore(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	int ret;
 
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
@@ -2988,9 +2987,7 @@ static int ravb_wol_restore(struct net_device *ndev)
 	/* Disable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, 0);
 
-	ret = ravb_close(ndev);
-	if (ret < 0)
-		return ret;
+	ravb_close(ndev);
 
 	return disable_irq_wake(priv->emac_irq);
 }
-- 
2.39.2


