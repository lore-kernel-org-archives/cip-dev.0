Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D7C27C50
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:18 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web11.8690.1716970511295560509
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=O/S9aLv9;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52962423ed8so2090128e87.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970509; x=1717575309; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q63jGnRIRAKnf3BnFcXOiOV6g8h6lJPpV6e7ogRxN+c=;
        b=O/S9aLv92zoy8WkC8g8rVdBomA6gVj7sBeMvzl4hJCdfIxfXqzDuAGIwX8Zmv/XDmT
         duso+uHZQ6XD5lalE2ZC0tY9Hup7TK9JCkGliOS8KXm866gCYxrXRyGAisSxsq+FUea5
         ZlEVxrT+sjWA3tuklmTs4TtUIAkLHqrI1Zba8Faf9XXHbC1hWwD6AAUHH3p38UFK+stC
         nNooloT13Tj8xaxVJ/il5XYM2NnE+fER0ZIzoCb6RU8xSC58y8t3GEHGQQPJK06kMiKM
         pCM8QwdIRTyiMlCiFyUWI0j4X68MSSKK7szgkSmKNg/HzUtx03N7LiygRhaqtfkMVkGI
         QG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970509; x=1717575309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q63jGnRIRAKnf3BnFcXOiOV6g8h6lJPpV6e7ogRxN+c=;
        b=YjmXIDdV15f9AVIjU9MRpeLc+tshW13HJuZFtS8ASNIvrAiz/3AGHyl5PQIv9l1U6y
         Rh360YNl2Rgtw1mT6zkmLELid/hEddLYJ9CikWDGP+Rg/ATVicD+QMvmxIgGB0ANuzFe
         Ibr1zhs3ahsVXaDNcH1y4no/+pkNVvO/Uj/rYgU0weI2R576b99rq49ZbmNVkfNp/RDH
         cEfE2D88OI/t+Aog69N0MfnTjj6gJQ7gLf/cfZxIqUbC0IqsBfSmLnf6A3jeIkm6vNL0
         tvadukEREkUhtBO6p7DyJU2rWD+VIHcXpQBnWsYV+hAcrtRTYCYNF+qFybogMDVdwaAS
         0ITA==
X-Gm-Message-State: AOJu0YxnSuc+arHP7ckNhpIHXFpMnkyUcFrHyVtStxiCpPoLxuMeshjr
	ByrCFfg8JDsrPUz6NsAPQ1lfJdCLhxsiy/Lj36a08jgCAkdODOXAMMKE9P8RJus=
X-Google-Smtp-Source: AGHT+IHZnFNaEa7CGCPfKn44DVh19JLw1TcKq5Uu5U8NfUlSr9KWSgNseqa9O7hUEd7Cp4NWW3taiQ==
X-Received: by 2002:a05:6512:3f09:b0:529:ac49:45d1 with SMTP id 2adb3069b0e04-529ac494708mr8560822e87.66.1716970509428;
        Wed, 29 May 2024 01:15:09 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 20/33] net: ravb: Simplify ravb_resume()
Date: Wed, 29 May 2024 11:14:21 +0300
Message-Id: <20240529081434.639519-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16048

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
index 38b6807428c8..511352a93cbc 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2961,6 +2961,20 @@ static int ravb_wol_restore(struct net_device *ndev)
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
@@ -3000,53 +3014,29 @@ static int __maybe_unused ravb_resume(struct device *dev)
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


