Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7329C25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:07 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.8728.1716970504029151569
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SZ7LMJ4u;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421124a0b37so9464945e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970502; x=1717575302; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LI+5BEHN2iFwZUiRCKWA1Xw05yz4L5NMeEb8CtFOUDw=;
        b=SZ7LMJ4utJTBn4uxFrzBX0papDXL7Nl7Y8//mkh+XnBDo6wJhXe5r6nnXdV2JN2k4U
         qKIBk7puwAHLSo9IdbKT8DVuo18zOoINE8loFHvT32U87mpxbs8SUHNpEqfasjuy0r/5
         50Ayy4aRACtUrgHYYICVH9zLH3qZbymderf7HM9fEO4FziAjipbVR2zXXgG3EoQ+Qmrv
         OdokHYnYYv3F4TjqCUIaXuFa8eI60Z0q0ol0S0Y/4eYoDleJ+s8EYEaBAr6TJkSGG0Y4
         APGgIP/Fsb2ZbjrJPwTJd2QC5UjrlMuXxh0FStnt21njQQEVZGM1I4pSXx2qLseXkxIY
         1fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970502; x=1717575302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LI+5BEHN2iFwZUiRCKWA1Xw05yz4L5NMeEb8CtFOUDw=;
        b=g0sBuLLoPXKwWfGrPF6bElMcA6vPWcXX6wSd5ubZvGJop4ou+ToEwQXkYJjHLx+8TE
         9/k6RcYpzwe7MC8NtDHt9qaz2WdBTJWcxdN0zDrN7EQQEqlVTzhqapQacviHBk40zdfM
         yW2gB73TB3V+9Dx0BbXrzv2pf0Qf+Bc/ERSjyttE4CGqnlvdT81IyB1CIFBk4rgxy9Ha
         Yq9y0HcYSSBj2kTAKAfaQsSzO01Mr+FkGB/AJKxK2ER/54iBoKBjiAgTMcy1GKtqQsuu
         uqzKNjmxw1SjpR8+YrjDKkitT6soDlmZNDIJdDGA1InzS1XJPxNQ5mkpQv3o6doxDVDx
         kzhw==
X-Gm-Message-State: AOJu0YyVUrXScvC/dQuVZ2ZF6uR4de/NMKV/JNhKNlLnzsL+h0Qc0a0o
	PK/Kcqus2W/Vz1IZZ9hbkb8WTJRS/wpxXAr1YvcNj5pdg/DNLUNGh6KBFZdN8fY=
X-Google-Smtp-Source: AGHT+IGFKE25iJmqg8KKWetSX1HAs5W9S+WsyFFCoMhf6bL+mT9Ma4vMYOr7D+C6nZyu0Ttgl5+GEA==
X-Received: by 2002:a05:600c:3515:b0:421:20b7:5bd8 with SMTP id 5b1f17b1804b1-42120b75f55mr41092455e9.6.1716970502518;
        Wed, 29 May 2024 01:15:02 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:02 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 16/33] net: ravb: Move DBAT configuration to the driver's ndo_open API
Date: Wed, 29 May 2024 11:14:17 +0300
Message-Id: <20240529081434.639519-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16044

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cd1fb46e02de3c70d6379b00c0e860ca44954574 upstream.

DBAT setup was done in the driver's probe API. As some IP variants switch
to reset mode (and thus registers content is lost) when setting clocks
(due to module standby functionality) to be able to implement runtime PM
move the DBAT configuration in the driver's ndo_open API.

This commit prepares the code for the addition of runtime PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0e2014f172f2..b8b82ba03c5b 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1885,6 +1885,7 @@ static int ravb_open(struct net_device *ndev)
 		napi_enable(&priv->napi[RAVB_NC]);
 
 	ravb_set_delay_mode(ndev);
+	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Device init */
 	error = ravb_dmac_init(ndev);
@@ -2828,7 +2829,6 @@ static int ravb_probe(struct platform_device *pdev)
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
-	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Initialise HW timestamp list */
 	INIT_LIST_HEAD(&priv->ts_skb_list);
-- 
2.39.2


