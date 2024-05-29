Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E51C25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:28 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.8737.1716970523798817253
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XK9lQqdM;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42108739ed8so21282625e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970522; x=1717575322; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96bl+9LhPvuZnxppNjKplTrxYcU7Jo/nTvttXBYjZes=;
        b=XK9lQqdMb2yOKYAmumVjtF6VW7PX24rxJfJ0BLtPXS1Z23oy3GOb7TPXRULsibchIh
         reuTSE5aM/LgbMfQNrBci+ZiKX0HDTVxxygWKRghpD60UI20KX3HKgbLbbPN/XJ4I3a/
         mWme5MlFIf+nMtkXePQVNAGlNQOcCRRiOG99X8p1eslUwZVO8t9pS/mx9GACZnxUlGZY
         xkFVpadlD9Jt190aegtuQ3XpeyVCBgQJetiYSjh40K2uUubEqXPhtofZzqjl21mjrUSY
         WbPGVvf6uobHag4UMoCwHj5GLDteBALt4QdaqZjD9IsIuty4BDIwVAHOALfpHrvShqEX
         XnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970522; x=1717575322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96bl+9LhPvuZnxppNjKplTrxYcU7Jo/nTvttXBYjZes=;
        b=wHrCgtTYLcUVECHr62ZGiRdjVkccYpdySH1yq4FNAIDkvHHgCCgn5wZ38C3AfXu5wo
         M8mh/4QgsHfeZyyJLRmbyyJ+u3F6J+5wem2dt4RVbkRFUd/VI5th+mjuRgLgVO7m3SUp
         0j7ghCY1Jygz1lIoDbm9QOARWy2Jim7jZJZH1RCmnn1t93BGAX3l8OecNHCEEoIjA8/X
         sYhSVxJLNU4v5XObUWvreFn1u8Najais66KD7OzQ3cXur2T0Aye2VicR2UmQxND39K0W
         DnILWvJ8b2fF6IVLKhtZswDeN4/FWJHrT+FxAcXvbpjcsV1HzMqbwIobLfYr3+a0TslX
         6WBA==
X-Gm-Message-State: AOJu0Yxp35bWGpDQhHHf2vk2Jcsb4ZyDHGh9uzsLfI8rbXzise6vO+xR
	ond3KygzfGOSVst9NjnlJr9iIsGVzogVWgz36EtmoX063rKIurtHs2q97tA0i2o=
X-Google-Smtp-Source: AGHT+IFzGWnuN1qLGt7E8qyupeSQYkeWde/F3WSkvty4jyEck2tioE4FtGr6dv4RmToE2fkShfInUg==
X-Received: by 2002:a05:600c:19d0:b0:421:20ac:1244 with SMTP id 5b1f17b1804b1-42120ac12d2mr37114875e9.22.1716970522284;
        Wed, 29 May 2024 01:15:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 28/33] net: ravb: Add runtime PM support
Date: Wed, 29 May 2024 11:14:29 +0300
Message-Id: <20240529081434.639519-29-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16056

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 48f894ab07c444b9b26a0913d2032de663f4aecb upstream.

Add runtime PM support for the ravb driver. As the driver is used by
different IP variants, with different behaviors, to be able to have the
runtime PM support available for all devices, the preparatory commits
moved all the resources parsing and allocations in the driver's probe
function and kept the settings for ravb_open(). This is due to the fact
that on some IP variants-platforms tuples disabling/enabling the clocks
will switch the IP to the reset operation mode where register contents is
lost and reconfiguration needs to be done. For this the rabv_open()
function enables the clocks, switches the IP to configuration mode, applies
all the register settings and switches the IP to the operational mode. At
the end of ravb_open() IP is ready to send/receive data.

In ravb_close() necessary reverts are done (compared with ravb_open()), the
IP is switched to reset mode and clocks are disabled.

The ethtool APIs or IOCTLs that might execute while the interface is down
are either cached (and applied in ravb_open()) or rejected (as at that time
the IP is in reset mode). Keeping the IP in the reset mode also increases
the power saved (according to the hardware manual).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
[claudiu.beznea: return error in case pm_runtime_resume_and_get() call
 from ravb_remove() fails]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 54 ++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a9adf5f67d8b..892912716488 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1959,16 +1959,21 @@ static int ravb_open(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = &priv->pdev->dev;
 	int error;
 
 	napi_enable(&priv->napi[RAVB_BE]);
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
+	error = pm_runtime_resume_and_get(dev);
+	if (error < 0)
+		goto out_napi_off;
+
 	/* Set AVB config mode */
 	error = ravb_set_config_mode(ndev);
 	if (error)
-		goto out_napi_off;
+		goto out_rpm_put;
 
 	ravb_set_delay_mode(ndev);
 	ravb_write(ndev, priv->desc_bat_dma, DBAT);
@@ -2002,6 +2007,9 @@ static int ravb_open(struct net_device *ndev)
 	ravb_stop_dma(ndev);
 out_set_reset:
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
+out_rpm_put:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 out_napi_off:
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
@@ -2342,6 +2350,8 @@ static int ravb_close(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 	struct ravb_tstamp_skb *ts_skb, *ts_skb2;
+	struct device *dev = &priv->pdev->dev;
+	int error;
 
 	netif_tx_stop_all_queues(ndev);
 
@@ -2391,7 +2401,14 @@ static int ravb_close(struct net_device *ndev)
 	ravb_get_stats(ndev);
 
 	/* Set reset mode. */
-	return ravb_set_opmode(ndev, CCC_OPC_RESET);
+	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
+	if (error)
+		return error;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 }
 
 static int ravb_hwtstamp_get(struct net_device *ndev, struct ifreq *req)
@@ -2946,6 +2963,8 @@ static int ravb_probe(struct platform_device *pdev)
 	clk_prepare(priv->refclk);
 
 	platform_set_drvdata(pdev, ndev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
+	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	error = pm_runtime_resume_and_get(&pdev->dev);
 	if (error < 0)
@@ -3051,6 +3070,9 @@ static int ravb_probe(struct platform_device *pdev)
 	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
 		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 out_napi_del:
@@ -3068,6 +3090,7 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	clk_unprepare(priv->refclk);
 out_reset_assert:
 	reset_control_assert(rstc);
@@ -3081,6 +3104,12 @@ static int ravb_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = &priv->pdev->dev;
+	int error;
+
+	error = pm_runtime_resume_and_get(dev);
+	if (error < 0)
+		return error;
 
 	unregister_netdev(ndev);
 	if (info->nc_queues)
@@ -3092,8 +3121,9 @@ static int ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	clk_unprepare(priv->refclk);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
@@ -3177,6 +3207,10 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = pm_runtime_force_suspend(&priv->pdev->dev);
+	if (ret)
+		return ret;
+
 reset_assert:
 	return reset_control_assert(priv->rstc);
 }
@@ -3199,16 +3233,28 @@ static int __maybe_unused ravb_resume(struct device *dev)
 		ret = ravb_wol_restore(ndev);
 		if (ret)
 			return ret;
+	} else {
+		ret = pm_runtime_force_resume(dev);
+		if (ret)
+			return ret;
 	}
 
 	/* Reopening the interface will restore the device to the working state. */
 	ret = ravb_open(ndev);
 	if (ret < 0)
-		return ret;
+		goto out_rpm_put;
 
 	ravb_set_rx_mode(ndev);
 	netif_device_attach(ndev);
 
+	return 0;
+
+out_rpm_put:
+	if (!priv->wol_enabled) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+
 	return ret;
 }
 
-- 
2.39.2


