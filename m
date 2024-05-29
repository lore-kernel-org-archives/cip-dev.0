Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA859C41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:46 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.8587.1716970296581846941
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Anwv2ISh;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4211e42e362so15725115e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970295; x=1717575095; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zuh9Nnb5kLz1Nta1Z19AlO8/bBYYXcZgLTiw/AQamgU=;
        b=Anwv2IShWzNsZsW3L6OyjnKpHxpBQ15f7+1Ho3ttADwvPntrDXQspXx8+m5GmuAlLi
         204h68iQKeePItKfinyOPffKM1SBf1QPA372OO1WvyfdtsrUgNcZ+1BuKEWdBg6DD7ry
         4w27WMvXeu9KoWXl/Qn9Fqb/QlUV1CBlgnEQyBXpboTMM/QQnRdKUr2ZHfbStB+gx/FC
         HTYR4h23nkMv+BwPk/rGFfx9mJ5HUqPoc3YL0hSzeqnwWqHJ26+7KPRWtdtig0zbHFVY
         SBSH5kSA7zwOyrjzqHoABlR6yVGtjrANrdBOREIZiuO7s7vKB1TK3AQwMM6XDC4ROe5O
         nKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970295; x=1717575095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zuh9Nnb5kLz1Nta1Z19AlO8/bBYYXcZgLTiw/AQamgU=;
        b=riNwOQ1UvyIgv6WG1lqALz9RqlHznnXe9ydZhvXWTkowiUQirN8dAx/c7+C3lDJ3fb
         P+iTt4Y1VH95JRzZp/2qYOQ2LSgfJEPJynZZBPuvG2MWxCcLJx4NKu2kcaUzzqakv5Sf
         gYaHZCp5oNqbmsCc6Q12ht6xS+FtabbAdg6HCmjqj46/drDg1gYHhFH04NXd0chc20e3
         kMJkAnEWT/MkL5f20VVMa9k5Z+H/54Fta/npKqPi56vZnKJG4fXR3alsQ91ozjlOLphH
         3Gu+YAUV575+K5fXFtXV8QpQ9ro+4L6TiG5V8RhDtDmPW/exlOvjbkzLc9MVCztUQuUh
         4H5g==
X-Gm-Message-State: AOJu0Yy0O7JCvDfW0qhwk19icUr/y8mmGL5hAvxTgpGH6VabePxN9LQ2
	tgWBrLQR0Dj0NEmlRKbi7m8MatJQdU3PeUSvpyjG49fLrnuGox0pPcHaJZKXeO0=
X-Google-Smtp-Source: AGHT+IH1931hlWqse831Rz6uDl6Um/yjXFnzSFo0LHJvMVzXnFp55+c5EWDIxzfBtC79NsnguqoPcA==
X-Received: by 2002:a05:600c:5690:b0:41c:3e1:9db9 with SMTP id 5b1f17b1804b1-42108aa8a00mr110047075e9.27.1716970295053;
        Wed, 29 May 2024 01:11:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 32/47] net: ravb: Simplify ravb_resume()
Date: Wed, 29 May 2024 11:10:24 +0300
Message-Id: <20240529081039.639010-33-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16012

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e95273fe4d02a6096ba5fe8287bcd9513396ec71 upstream.

Remove explicit calls to functions that are called by ravb_open(). There is
no need to have them doubled now that the ravb_open() already contains
what is needed for the interface configuration. Along with it,
configurations needed by PTP were moved to ravb_wol_restore(). With this,
code in ravb_resume() becomes simpler.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 58 ++++++++++--------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 2a7ff0037676..478c75c94f50 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2944,6 +2944,20 @@ static int ravb_wol_restore(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int error;
+
+	/* Set reset mode to rearm the WoL logic. */
+	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
+	if (error)
+		return error;
+
+	/* Set AVB config mode. */
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		return error;
+
+	if (priv->info->ccc_gac)
+		ravb_ptp_init(ndev, priv->pdev);
 
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
@@ -2983,53 +2997,29 @@ static int __maybe_unused ravb_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	int ret;
 
 	ret = reset_control_deassert(priv->rstc);
 	if (ret)
 		return ret;
 
-	/* If WoL is enabled set reset mode to rearm the WoL logic */
+	if (!netif_running(ndev))
+		return 0;
+
+	/* If WoL is enabled restore the interface. */
 	if (priv->wol_enabled) {
-		ret = ravb_set_opmode(ndev, CCC_OPC_RESET);
+		ret = ravb_wol_restore(ndev);
 		if (ret)
 			return ret;
 	}
 
-	/* All register have been reset to default values.
-	 * Restore all registers which where setup at probe time and
-	 * reopen device if it was running before system suspended.
-	 */
-
-	/* Set AVB config mode */
-	ret = ravb_set_config_mode(ndev);
-	if (ret)
+	/* Reopening the interface will restore the device to the working state. */
+	ret = ravb_open(ndev);
+	if (ret < 0)
 		return ret;
 
-	ravb_set_gti(ndev);
-
-	if (info->internal_delay)
-		ravb_set_delay_mode(ndev);
-
-	/* Restore descriptor base address table */
-	ravb_write(ndev, priv->desc_bat_dma, DBAT);
-
-	if (priv->info->ccc_gac)
-		ravb_ptp_init(ndev, priv->pdev);
-
-	if (netif_running(ndev)) {
-		if (priv->wol_enabled) {
-			ret = ravb_wol_restore(ndev);
-			if (ret)
-				return ret;
-		}
-		ret = ravb_open(ndev);
-		if (ret < 0)
-			return ret;
-		ravb_set_rx_mode(ndev);
-		netif_device_attach(ndev);
-	}
+	ravb_set_rx_mode(ndev);
+	netif_device_attach(ndev);
 
 	return ret;
 }
-- 
2.39.2


