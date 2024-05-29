Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D88EC27C44
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:26 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web10.8649.1716970285143418129
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=nr+ablj/;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-529b79609cbso2727431e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970283; x=1717575083; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBPXQ9NOH2876e4EiDZm2RUzMP8Z/F3D9PjVHBqj9oE=;
        b=nr+ablj/A0gBjSxPB1B2s/JzxMUe+xFFG1SreLx+77MkilUu51WA8AgoUqBH5Mj+g3
         E9L9nBrKL4PZFOQnkkfCKcZcbpX+ybZBi6SeJh7ajYh4UEmyusH0JkG2c8wc+bhzGxuz
         q/bUjAPXj8NDagCH10sKqaBSXzrq1FM9bwCDsvcr5cNzuZjLGvLM3H2NBoA6AlTTmaeD
         C7en9PAuDeDSkrQs8ytd7MMEnQy1NfCqOw8P5+/eEfAhmdgL2zI+WHDSMiE1mCAKuiWf
         9pRcC92vk7oS2fWC1YsYLj/oKPYfA8/hdUti86lXiboOtxUQWF6JozkdE7i/189z9Fuv
         UF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970283; x=1717575083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBPXQ9NOH2876e4EiDZm2RUzMP8Z/F3D9PjVHBqj9oE=;
        b=Cqi6JsKhAlU4uGbPwg66jtDN5wbr3dqFRZbC64C/0GNNXlSeedVIbiGVCHhMHjGB90
         RHlzzMrskw3lz9jty1hnnhrrT0E5D/0zA2U9ptIa919CShxn70d6UpP05Y9g/vJ+Vu8d
         efN4tNd5VQHiR4HmYo1zK2HjGN1C5a7ZfvIXyE8lLi7zAxjon4NY3DsP0gGglp0e1t0a
         y5jug6ygSU4RdILoz0NRtrxZeQFKZOsjCvUQRY6PfO3tkea0TPhoBeii6DD0OoaXzouO
         ufsnqS0Tyjz+6Z+qX7kK/7KDCFEdVjp376RDzlS9M2g1EJB2Px+Bmm+V/q6URTBosR29
         9Jkw==
X-Gm-Message-State: AOJu0YzE4fl2IwfXW+gbu2ucRyALgKXfmuwl5f0M+NIUGkHe6IsBc2JR
	OjXp0FDISLdi/G3SYWupJkEzORmGCie6z0TxK0Tvag0Q/Q2m6ZqbmrcXL2jx5AM=
X-Google-Smtp-Source: AGHT+IHsOETF0S3WpgQJPNWwvTxX/Xa+9nentbG1j55NMPgqKzx9GNWYXBj9D2jIRKzpzN8RgSMFCw==
X-Received: by 2002:a19:914d:0:b0:518:dfed:f021 with SMTP id 2adb3069b0e04-529645e2b3dmr9022089e87.24.1716970283265;
        Wed, 29 May 2024 01:11:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 25/47] net: ravb: Move getting/requesting IRQs in the probe() method
Date: Wed, 29 May 2024 11:10:17 +0300
Message-Id: <20240529081039.639010-26-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16005

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 32f012b8c01ca9fd26a28134cc2165ead93c22d0 upstream.

The runtime PM implementation will disable clocks at the end of
ravb_probe(). As some IP variants switch to reset mode as a result of
setting module standby through clock disable APIs, to implement runtime PM
the resource parsing and requesting are moved in the probe function and IP
settings are moved in the open function. This is done because at the end of
the probe some IP variants will switch anyway to reset mode and the
registers content is lost. Also keeping only register settings operations
in the ravb_open()/ravb_close() functions will make them faster.

Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
the interface is open. As now getting/requesting IRQs is done in a single
place there is no need to keep intermediary data (like ravb_rx_irqs[] and
ravb_tx_irqs[] arrays or IRQs in struct ravb_private).

In order to avoid accessing the IP registers while the IP is runtime
suspended (e.g. in the timeframe b/w the probe requests shared IRQs and
IP clocks are enabled) in the interrupt handlers were introduced
pm_runtime_active() checks. The device runtime PM usage counter has been
incremented to avoid disabling the device's clocks while the check is in
progress (if any).

This is a preparatory change to add runtime PM support for all IP variants.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |   4 -
 drivers/net/ethernet/renesas/ravb_main.c | 299 ++++++++++-------------
 2 files changed, 130 insertions(+), 173 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 29b8b163a3ca..2226c757fa9a 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1089,10 +1089,6 @@ struct ravb_private {
 	int msg_enable;
 	int speed;
 	int emac_irq;
-	int erra_irq;
-	int mgmta_irq;
-	int rx_irqs[NUM_RX_QUEUE];
-	int tx_irqs[NUM_TX_QUEUE];
 
 	unsigned no_avb_link:1;
 	unsigned avb_link_active_low:1;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 112939f13577..7dbd8130fdc1 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -40,16 +40,6 @@
 		 NETIF_MSG_RX_ERR | \
 		 NETIF_MSG_TX_ERR)
 
-static const char *ravb_rx_irqs[NUM_RX_QUEUE] = {
-	"ch0", /* RAVB_BE */
-	"ch1", /* RAVB_NC */
-};
-
-static const char *ravb_tx_irqs[NUM_TX_QUEUE] = {
-	"ch18", /* RAVB_BE */
-	"ch19", /* RAVB_NC */
-};
-
 void ravb_modify(struct net_device *ndev, enum ravb_reg reg, u32 clear,
 		 u32 set)
 {
@@ -1086,11 +1076,23 @@ static irqreturn_t ravb_emac_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
+	irqreturn_t result = IRQ_HANDLED;
+
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev))) {
+		result = IRQ_NONE;
+		goto out_rpm_put;
+	}
 
 	spin_lock(&priv->lock);
 	ravb_emac_interrupt_unlocked(ndev);
 	spin_unlock(&priv->lock);
-	return IRQ_HANDLED;
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
+	return result;
 }
 
 /* Error interrupt handler */
@@ -1170,9 +1172,15 @@ static irqreturn_t ravb_interrupt(int irq, void *dev_id)
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = &priv->pdev->dev;
 	irqreturn_t result = IRQ_NONE;
 	u32 iss;
 
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev)))
+		goto out_rpm_put;
+
 	spin_lock(&priv->lock);
 	/* Get interrupt status */
 	iss = ravb_read(ndev, ISS);
@@ -1216,6 +1224,9 @@ static irqreturn_t ravb_interrupt(int irq, void *dev_id)
 	}
 
 	spin_unlock(&priv->lock);
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return result;
 }
 
@@ -1224,9 +1235,15 @@ static irqreturn_t ravb_multi_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
 	irqreturn_t result = IRQ_NONE;
 	u32 iss;
 
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev)))
+		goto out_rpm_put;
+
 	spin_lock(&priv->lock);
 	/* Get interrupt status */
 	iss = ravb_read(ndev, ISS);
@@ -1248,6 +1265,9 @@ static irqreturn_t ravb_multi_interrupt(int irq, void *dev_id)
 	}
 
 	spin_unlock(&priv->lock);
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return result;
 }
 
@@ -1255,8 +1275,14 @@ static irqreturn_t ravb_dma_interrupt(int irq, void *dev_id, int q)
 {
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
 	irqreturn_t result = IRQ_NONE;
 
+	pm_runtime_get_noresume(dev);
+
+	if (unlikely(!pm_runtime_active(dev)))
+		goto out_rpm_put;
+
 	spin_lock(&priv->lock);
 
 	/* Network control/Best effort queue RX/TX */
@@ -1264,6 +1290,9 @@ static irqreturn_t ravb_dma_interrupt(int irq, void *dev_id, int q)
 		result = IRQ_HANDLED;
 
 	spin_unlock(&priv->lock);
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return result;
 }
 
@@ -1737,85 +1766,21 @@ static const struct ethtool_ops ravb_ethtool_ops = {
 	.set_wol		= ravb_set_wol,
 };
 
-static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
-				struct net_device *ndev, struct device *dev,
-				const char *ch)
-{
-	char *name;
-	int error;
-
-	name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
-	if (!name)
-		return -ENOMEM;
-	error = request_irq(irq, handler, 0, name, ndev);
-	if (error)
-		netdev_err(ndev, "cannot request IRQ %s\n", name);
-
-	return error;
-}
-
 /* Network device open function for Ethernet AVB */
 static int ravb_open(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	struct platform_device *pdev = priv->pdev;
-	struct device *dev = &pdev->dev;
 	int error;
 
 	napi_enable(&priv->napi[RAVB_BE]);
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
-	if (!info->multi_irqs) {
-		error = request_irq(ndev->irq, ravb_interrupt, IRQF_SHARED,
-				    ndev->name, ndev);
-		if (error) {
-			netdev_err(ndev, "cannot request IRQ\n");
-			goto out_napi_off;
-		}
-	} else {
-		error = ravb_hook_irq(ndev->irq, ravb_multi_interrupt, ndev,
-				      dev, "ch22:multi");
-		if (error)
-			goto out_napi_off;
-		error = ravb_hook_irq(priv->emac_irq, ravb_emac_interrupt, ndev,
-				      dev, "ch24:emac");
-		if (error)
-			goto out_free_irq;
-		error = ravb_hook_irq(priv->rx_irqs[RAVB_BE], ravb_be_interrupt,
-				      ndev, dev, "ch0:rx_be");
-		if (error)
-			goto out_free_irq_emac;
-		error = ravb_hook_irq(priv->tx_irqs[RAVB_BE], ravb_be_interrupt,
-				      ndev, dev, "ch18:tx_be");
-		if (error)
-			goto out_free_irq_be_rx;
-		error = ravb_hook_irq(priv->rx_irqs[RAVB_NC], ravb_nc_interrupt,
-				      ndev, dev, "ch1:rx_nc");
-		if (error)
-			goto out_free_irq_be_tx;
-		error = ravb_hook_irq(priv->tx_irqs[RAVB_NC], ravb_nc_interrupt,
-				      ndev, dev, "ch19:tx_nc");
-		if (error)
-			goto out_free_irq_nc_rx;
-
-		if (info->err_mgmt_irqs) {
-			error = ravb_hook_irq(priv->erra_irq, ravb_multi_interrupt,
-					      ndev, dev, "err_a");
-			if (error)
-				goto out_free_irq_nc_tx;
-			error = ravb_hook_irq(priv->mgmta_irq, ravb_multi_interrupt,
-					      ndev, dev, "mgmt_a");
-			if (error)
-				goto out_free_irq_erra;
-		}
-	}
-
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
-		goto out_free_irq_mgmta;
+		goto out_napi_off;
 	ravb_emac_init(ndev);
 
 	/* Initialise PTP Clock driver */
@@ -1836,26 +1801,6 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
-out_free_irq_mgmta:
-	if (!info->multi_irqs)
-		goto out_free_irq;
-	if (info->err_mgmt_irqs)
-		free_irq(priv->mgmta_irq, ndev);
-out_free_irq_erra:
-	if (info->err_mgmt_irqs)
-		free_irq(priv->erra_irq, ndev);
-out_free_irq_nc_tx:
-	free_irq(priv->tx_irqs[RAVB_NC], ndev);
-out_free_irq_nc_rx:
-	free_irq(priv->rx_irqs[RAVB_NC], ndev);
-out_free_irq_be_tx:
-	free_irq(priv->tx_irqs[RAVB_BE], ndev);
-out_free_irq_be_rx:
-	free_irq(priv->rx_irqs[RAVB_BE], ndev);
-out_free_irq_emac:
-	free_irq(priv->emac_irq, ndev);
-out_free_irq:
-	free_irq(ndev->irq, ndev);
 out_napi_off:
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
@@ -2190,19 +2135,6 @@ static int ravb_close(struct net_device *ndev)
 
 	cancel_work_sync(&priv->work);
 
-	if (info->multi_irqs) {
-		free_irq(priv->tx_irqs[RAVB_NC], ndev);
-		free_irq(priv->rx_irqs[RAVB_NC], ndev);
-		free_irq(priv->tx_irqs[RAVB_BE], ndev);
-		free_irq(priv->rx_irqs[RAVB_BE], ndev);
-		free_irq(priv->emac_irq, ndev);
-		if (info->err_mgmt_irqs) {
-			free_irq(priv->erra_irq, ndev);
-			free_irq(priv->mgmta_irq, ndev);
-		}
-	}
-	free_irq(ndev->irq, ndev);
-
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
 	napi_disable(&priv->napi[RAVB_BE]);
@@ -2619,6 +2551,90 @@ static void ravb_parse_delay_mode(struct device_node *np, struct net_device *nde
 	}
 }
 
+static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
+			  const char *ch, int *irq, irq_handler_t handler)
+{
+	struct platform_device *pdev = priv->pdev;
+	struct net_device *ndev = priv->ndev;
+	struct device *dev = &pdev->dev;
+	const char *dev_name;
+	unsigned long flags;
+	int error;
+
+	if (irq_name) {
+		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
+		if (!dev_name)
+			return -ENOMEM;
+
+		*irq = platform_get_irq_byname(pdev, irq_name);
+		flags = 0;
+	} else {
+		dev_name = ndev->name;
+		*irq = platform_get_irq(pdev, 0);
+		flags = IRQF_SHARED;
+	}
+	if (*irq < 0)
+		return *irq;
+
+	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
+	if (error)
+		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
+
+	return error;
+}
+
+static int ravb_setup_irqs(struct ravb_private *priv)
+{
+	const struct ravb_hw_info *info = priv->info;
+	struct net_device *ndev = priv->ndev;
+	const char *irq_name, *emac_irq_name;
+	int error, irq;
+
+	if (!info->multi_irqs)
+		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
+
+	if (info->err_mgmt_irqs) {
+		irq_name = "dia";
+		emac_irq_name = "line3";
+	} else {
+		irq_name = "ch22";
+		emac_irq_name = "ch24";
+	}
+
+	error = ravb_setup_irq(priv, irq_name, "ch22:multi", &ndev->irq, ravb_multi_interrupt);
+	if (error)
+		return error;
+
+	error = ravb_setup_irq(priv, emac_irq_name, "ch24:emac", &priv->emac_irq,
+			       ravb_emac_interrupt);
+	if (error)
+		return error;
+
+	if (info->err_mgmt_irqs) {
+		error = ravb_setup_irq(priv, "err_a", "err_a", &irq, ravb_multi_interrupt);
+		if (error)
+			return error;
+
+		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", &irq, ravb_multi_interrupt);
+		if (error)
+			return error;
+	}
+
+	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", &irq, ravb_be_interrupt);
+	if (error)
+		return error;
+
+	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", &irq, ravb_nc_interrupt);
+	if (error)
+		return error;
+
+	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", &irq, ravb_be_interrupt);
+	if (error)
+		return error;
+
+	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", &irq, ravb_nc_interrupt);
+}
+
 static void ravb_set_delay_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2638,9 +2654,8 @@ static int ravb_probe(struct platform_device *pdev)
 	struct reset_control *rstc;
 	struct ravb_private *priv;
 	struct net_device *ndev;
-	int error, irq, q;
 	struct resource *res;
-	int i;
+	int error, q;
 
 	if (!np) {
 		dev_err(&pdev->dev,
@@ -2667,20 +2682,6 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_free_netdev;
 
-	if (info->multi_irqs) {
-		if (info->err_mgmt_irqs)
-			irq = platform_get_irq_byname(pdev, "dia");
-		else
-			irq = platform_get_irq_byname(pdev, "ch22");
-	} else {
-		irq = platform_get_irq(pdev, 0);
-	}
-	if (irq < 0) {
-		error = irq;
-		goto out_reset_assert;
-	}
-	ndev->irq = irq;
-
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	priv = netdev_priv(ndev);
@@ -2695,6 +2696,10 @@ static int ravb_probe(struct platform_device *pdev)
 		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
 	}
 
+	error = ravb_setup_irqs(priv);
+	if (error)
+		goto out_reset_assert;
+
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		error = PTR_ERR(priv->clk);
@@ -2742,50 +2747,6 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->avb_link_active_low =
 		of_property_read_bool(np, "renesas,ether-link-active-low");
 
-	if (info->multi_irqs) {
-		if (info->err_mgmt_irqs)
-			irq = platform_get_irq_byname(pdev, "line3");
-		else
-			irq = platform_get_irq_byname(pdev, "ch24");
-		if (irq < 0) {
-			error = irq;
-			goto out_rpm_put;
-		}
-		priv->emac_irq = irq;
-		for (i = 0; i < NUM_RX_QUEUE; i++) {
-			irq = platform_get_irq_byname(pdev, ravb_rx_irqs[i]);
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->rx_irqs[i] = irq;
-		}
-		for (i = 0; i < NUM_TX_QUEUE; i++) {
-			irq = platform_get_irq_byname(pdev, ravb_tx_irqs[i]);
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->tx_irqs[i] = irq;
-		}
-
-		if (info->err_mgmt_irqs) {
-			irq = platform_get_irq_byname(pdev, "err_a");
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->erra_irq = irq;
-
-			irq = platform_get_irq_byname(pdev, "mgmt_a");
-			if (irq < 0) {
-				error = irq;
-				goto out_rpm_put;
-			}
-			priv->mgmta_irq = irq;
-		}
-	}
-
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
-- 
2.39.2


