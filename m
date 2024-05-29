Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D36C27C44
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:36 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.8654.1716970292240721373
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=cnOA4Z70;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4210aa0154eso9498465e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970291; x=1717575091; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caqnFdvNHcL/9oR4yU50B9YaYGJzmvmNugRh3DbyxVQ=;
        b=cnOA4Z70R6j0cxUf5r72MD+1Sz5Og0litvtDEk31gRu9BL1swfiOCFVeJfk+XTwisU
         ZmMEAGB/8o5swh2c5CS/2AgQTxJAio8X7bvtlOAHIOdJqAOJ6L91+pmK9DBW39617N0D
         OXi5O9bpT/Ic0Lgukcy5S+LeWCVpCy85JhS2RUDyyGFmMgV1pCZfRzhmHZFnRwyEDgv2
         wjgHoDOXiOfYlJS4mzD0CQCCUekv43AG/On2+/35Ze0p/sQou1DcyoXzHLx5rTNoH5UT
         WQq7HavApufQJmtbXjnzxdKxj+tTjJlC2ZdG/8aX7yp3XuakFRzUuj14dX0CUwcfJkVW
         yL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970291; x=1717575091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caqnFdvNHcL/9oR4yU50B9YaYGJzmvmNugRh3DbyxVQ=;
        b=dNGd+Is43fzMVHt14ZqBJeIXXdjST6/zlogNqvVXaz2pMBKvVPXUiIDvY2fiQfvQZa
         MsyLGPNcYvtxzKb1uXBNTl01yY6PXhxidZoD0gZjMAjYVqs49KFoHNC36F6f3nuHirMV
         oUJUQJF8yNMc258zMjN0E9Gykq+0wrdBKhD3+4U1cn+XMmVtMDeQYDPZcwQFQPvVGlhU
         2vREx/gDxHDRGqopwrOiIqE21sMKVranq/rAy9x+uAKngbLkpyZ/D2L9DPOd4eAhX1Lz
         KrQmPDp5iDH92DfLbV26MUhZvD0sunJBZdKu3jYjiq31JMyo+wvm8oZdKRaKAhncSTCk
         f3tQ==
X-Gm-Message-State: AOJu0Yy14tCdLVlQFdRHGEDt/gOuZjETFWuDQkg1H9iSQX12EijEGY+r
	deHknDGXdSF2dr8UA5rcsnLbBB/wg20nRQkEzJ+1dZPM1EronaCN/exqoy2hCpM=
X-Google-Smtp-Source: AGHT+IEFxuZlRjfF0tSpG1rHJNmUo1qC5yiXZ0C4mAwcaCh49RmspukGO+SumUmNNlbnGGZA3g6h6w==
X-Received: by 2002:a1c:4c18:0:b0:417:e00c:fdb8 with SMTP id 5b1f17b1804b1-421089d5133mr166016065e9.1.1716970290631;
        Wed, 29 May 2024 01:11:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 30/47] net: ravb: Set config mode in ndo_open and reset mode in ndo_close
Date: Wed, 29 May 2024 11:10:22 +0300
Message-Id: <20240529081039.639010-31-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16010

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 76fd52c1007785fcea1d3405907cec940d44f403 upstream.

As some IP variants switch to reset mode (and thus the register contents is
lost) when setting clocks (due to module standby functionality) to be able
to implement runtime PM and save more power, set the IP's operating mode to
reset at the end of the probe. Along with it, in the ndo_open API the IP
will be switched to configuration, then operation mode. In the ndo_close
API, the IP will be switched back to reset mode. This allows implementing
runtime PM and, along with it, save more power when the IP is not used.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[claudiu.beznea: fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 78 ++++++++++++++----------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index b3c7defac9a2..597c303610ca 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1766,6 +1766,27 @@ static const struct ethtool_ops ravb_ethtool_ops = {
 	.set_wol		= ravb_set_wol,
 };
 
+static int ravb_set_config_mode(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+	int error;
+
+	if (info->gptp) {
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+		if (error)
+			return error;
+		/* Set CSEL value */
+		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
+	} else if (info->ccc_gac) {
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
+	} else {
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+	}
+
+	return error;
+}
+
 static void ravb_set_gti(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -1874,13 +1895,19 @@ static int ravb_open(struct net_device *ndev)
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
+	/* Set AVB config mode */
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		goto out_napi_off;
+
 	ravb_set_delay_mode(ndev);
 	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
-		goto out_napi_off;
+		goto out_set_reset;
+
 	ravb_emac_init(ndev);
 
 	ravb_set_gti(ndev);
@@ -1903,6 +1930,8 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
+out_set_reset:
+	ravb_set_opmode(ndev, CCC_OPC_RESET);
 out_napi_off:
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
@@ -2246,7 +2275,8 @@ static int ravb_close(struct net_device *ndev)
 	if (info->nc_queues)
 		ravb_ring_free(ndev, RAVB_NC);
 
-	return 0;
+	/* Set reset mode. */
+	return ravb_set_opmode(ndev, CCC_OPC_RESET);
 }
 
 static int ravb_hwtstamp_get(struct net_device *ndev, struct ifreq *req)
@@ -2569,27 +2599,6 @@ static const struct of_device_id ravb_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ravb_match_table);
 
-static int ravb_set_config_mode(struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
-	int error;
-
-	if (info->gptp) {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
-		if (error)
-			return error;
-		/* Set CSEL value */
-		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
-	} else if (info->ccc_gac) {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
-	} else {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
-	}
-
-	return error;
-}
-
 static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 			  const char *ch, int *irq, irq_handler_t handler)
 {
@@ -2788,11 +2797,6 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &ravb_netdev_ops;
 	ndev->ethtool_ops = &ravb_ethtool_ops;
 
-	/* Set AVB config mode */
-	error = ravb_set_config_mode(ndev);
-	if (error)
-		goto out_rpm_put;
-
 	error = ravb_compute_gti(ndev);
 	if (error)
 		goto out_rpm_put;
@@ -2819,6 +2823,11 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Debug message level */
 	priv->msg_enable = RAVB_DEF_MSG_ENABLE;
 
+	/* Set config mode as this is needed for PHY initialization. */
+	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+	if (error)
+		goto out_rpm_put;
+
 	/* Read and set MAC address */
 	ravb_read_mac_address(ndev, of_get_mac_address(np));
 	if (!is_valid_ether_addr(ndev->dev_addr)) {
@@ -2831,9 +2840,14 @@ static int ravb_probe(struct platform_device *pdev)
 	error = ravb_mdio_init(priv);
 	if (error) {
 		dev_err(&pdev->dev, "failed to initialize MDIO\n");
-		goto out_dma_free;
+		goto out_reset_mode;
 	}
 
+	/* Undo previous switch to config opmode. */
+	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
+	if (error)
+		goto out_mdio_release;
+
 	netif_napi_add(ndev, &priv->napi[RAVB_BE], ravb_poll, 64);
 	if (info->nc_queues)
 		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll, 64);
@@ -2856,8 +2870,10 @@ static int ravb_probe(struct platform_device *pdev)
 		netif_napi_del(&priv->napi[RAVB_NC]);
 
 	netif_napi_del(&priv->napi[RAVB_BE]);
+out_mdio_release:
 	ravb_mdio_release(priv);
-out_dma_free:
+out_reset_mode:
+	ravb_set_opmode(ndev, CCC_OPC_RESET);
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 out_rpm_put:
@@ -2888,8 +2904,6 @@ static int ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	ravb_set_opmode(ndev, CCC_OPC_RESET);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_unprepare(priv->refclk);
-- 
2.39.2


