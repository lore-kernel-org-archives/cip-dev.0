Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A325CC25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:36 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.8652.1716970289878943453
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fgWgNYE+;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ab11ecdbaso628291e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970288; x=1717575088; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfcBhCscqGDBPpr7CIU+4ogWKdubLdnw3XpPXtdGBSc=;
        b=fgWgNYE+4Ac2J7EbfVgDpTK0igwNASfzCwAaWd+cIO+1lMhJAInxlI0MlzS8k5Dcph
         jtwR78vL4Bwvy7uhpEO/mofxRyepQcvbeQ5+96VpnwpNaHL0Dvhr+ig4+3xteVR7cuvb
         uRbPPZiVXl1W9DPqTWK0H4g3Snx0imPGyEtjPqWov63aWQmJ01K0Dx7uk1YW8YuZYWNK
         mvXn36Kx3yLxuiJuzC26IFMOXxTcOUy3uqnuwrWz53JQt38f7aupzJY5bOoQIf/ebLJP
         IyqKrnOHrV/l7cu/A59xr24Nfqj7wyyf7GUCbQrfMRRPWCG/zB8aoB8+ZhtpD9jFb1tc
         ceqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970288; x=1717575088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfcBhCscqGDBPpr7CIU+4ogWKdubLdnw3XpPXtdGBSc=;
        b=H+/EGfGHnYL8OtKZGSVojNtELf7sR/NSU/FX+xtJGcV2WwsXZR/OR8icf78anrP0Os
         pq6EXu8k4Y9XUWYg9CBJMuRIioomfGO6d5196Z1+gLb+hcqNu196tHG5PpzB/p2AXmzu
         /59xAIbYJ+StaTcCyCKq+g/yv3oBTAOLwkJYtNzQgCpL+T/yHXUE0K+poElql6ouyK5q
         0nLw9dIPK6GFfmT+t0/cB5woRKdkx1Mh5DIIYfcmKFp22ZluLoHSyZDBfsbAPz/rTH2J
         2AJrnarSLnyI0raO7OAFkgvzxfAlPZkgxGpVGMNoIHk52aKD3229ISgK1GkaBMOOnrIp
         pEaQ==
X-Gm-Message-State: AOJu0Ywn/lBc5ILAo7rPzt1XptcUygt0y2KYMK/VwbbySdSaLPULzZ2F
	Xh9pwFyJ3X0ejjMQ8iDX74p7cwOWXk2VncPCuw6ZuipdjGFauso65orXIgzLgwo=
X-Google-Smtp-Source: AGHT+IEMIWH+Y4qk8SZDsmwCT3x6hgWJfmrhT3Yrlq7oZmUI3OF6AUpJKTngB7me8x+OECKBjtvPzg==
X-Received: by 2002:a05:6512:1309:b0:523:90df:a9c6 with SMTP id 2adb3069b0e04-529661f2e0emr9626925e87.50.1716970288092;
        Wed, 29 May 2024 01:11:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 28/47] net: ravb: Move DBAT configuration to the driver's ndo_open API
Date: Wed, 29 May 2024 11:10:20 +0300
Message-Id: <20240529081039.639010-29-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16008

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
index bf909302ecf4..1989320b84c7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1875,6 +1875,7 @@ static int ravb_open(struct net_device *ndev)
 		napi_enable(&priv->napi[RAVB_NC]);
 
 	ravb_set_delay_mode(ndev);
+	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Device init */
 	error = ravb_dmac_init(ndev);
@@ -2811,7 +2812,6 @@ static int ravb_probe(struct platform_device *pdev)
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
-	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Initialise HW timestamp list */
 	INIT_LIST_HEAD(&priv->ts_skb_list);
-- 
2.39.2


