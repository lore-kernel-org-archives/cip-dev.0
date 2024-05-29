Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FCEC25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:07 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.8682.1716970501884236567
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rKSZbIdH;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4202ca70270so21129325e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970500; x=1717575300; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAGctp94e/ryCox7b57FlaGxB1SgSwkrD25f2n+iPzM=;
        b=rKSZbIdHJAKTm60EAK1E5zWeQeq/B+zQ8EP+Q0efRSEmHRG1DFG6RCeqxNsXWl+jdj
         VgmE+vO57Thm7XEPv7m7sKtsMdOX50xz33opNtXZ1fNpII4EB9GA8kAMFP3mnNsSeYyc
         OdSZuuooU9uSnz8fWlLWC5EYDtqJXZS23t6nvvW2CRRFBV2IvlnB0vHNMvLULHlqxSew
         usF/gfn0tRk0k0xPkLJP7ddrjm3XvEYam5vkD/Nc2Lf+4LG3VaTnXl/hR2Ze9ZQcb9u5
         w21p1O4MMXV9PyosfInvwRKGl5Ww1gJNuX7S5cepFLVKHtmz02DfxrVLUgAqQrk7JT8p
         5rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970500; x=1717575300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAGctp94e/ryCox7b57FlaGxB1SgSwkrD25f2n+iPzM=;
        b=FMC3QMQ5DLSdjCHqQ7NivA7WOVzZAnlhxgZMcQFSxK4rfvokpl3wQ9j9SD2Om+nqDu
         KDhNHaB5vKQ5e8OLnizV+BfghtYqboR8DLwjHpZw5EZU33aG1Q3FKIvzlKdBW4ilXikk
         kfc9b3vFh6IBPS5x+JEHO8RP1GJ7M/1hwq+LI9rD0K7kO9zCtvxZDU9AaA7ZaCTJh4XW
         sukJOImmkV7QfvrEQEM041Jt8MMCL4akgnUZ9+pj47xa7M4PKwy0sPhRNtvZOQYktW8L
         tgc0AB1rbVujSVugesnHzPR8z6bPW7tpOKrtPtK/7YtFtmoC7+0U6xguI8x+b0KGp0OU
         Pr6w==
X-Gm-Message-State: AOJu0YynjEIxL4CAmbwJ3niirVHSbtg9ULhMKxG94f+AGWr2JJvcCAnL
	DxcEeLFXY4ZFVi1vCruEqH+dS8CYE53vSkAswSav/IAIoqVqSYse079xtMNUVqo=
X-Google-Smtp-Source: AGHT+IGrl8EbBi8zFIebMpFkIOgD44aR64dJl+5jRwzjg/M+OCXcmRR7pgaoHX7WdLOvGDAoH475uQ==
X-Received: by 2002:a05:600c:1c02:b0:41c:23f3:65fa with SMTP id 5b1f17b1804b1-42108a99cf6mr127864255e9.28.1716970500375;
        Wed, 29 May 2024 01:15:00 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 15/33] net: ravb: Move delay mode set in the driver's ndo_open API
Date: Wed, 29 May 2024 11:14:16 +0300
Message-Id: <20240529081434.639519-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16043

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 23698a9abb629009b42ef419072e567b43ca6866 upstream.

Delay parsing and setting were done in the driver's probe API. As some IP
variants switch to reset mode (and thus the register contents is lost) when
setting clocks (due to module standby functionality) to be able to
implement runtime PM keep the delay parsing in the driver's probe function
and move the delay applying function to the driver's ndo_open API.

Along with it, ravb_parse_delay_mode() function was moved close to
ravb_set_delay_mode() function to have the delay specific code in the
same place.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 107 ++++++++++++-----------
 1 file changed, 56 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 90a61e2e1a77..0e2014f172f2 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1820,6 +1820,59 @@ static int ravb_compute_gti(struct net_device *ndev)
 	return 0;
 }
 
+/* Set tx and rx clock internal delay modes */
+static void ravb_parse_delay_mode(struct device_node *np, struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	bool explicit_delay = false;
+	u32 delay;
+
+	if (!priv->info->internal_delay)
+		return;
+
+	if (!of_property_read_u32(np, "rx-internal-delay-ps", &delay)) {
+		/* Valid values are 0 and 1800, according to DT bindings */
+		priv->rxcidm = !!delay;
+		explicit_delay = true;
+	}
+	if (!of_property_read_u32(np, "tx-internal-delay-ps", &delay)) {
+		/* Valid values are 0 and 2000, according to DT bindings */
+		priv->txcidm = !!delay;
+		explicit_delay = true;
+	}
+
+	if (explicit_delay)
+		return;
+
+	/* Fall back to legacy rgmii-*id behavior */
+	if (priv->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
+	    priv->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID) {
+		priv->rxcidm = 1;
+		priv->rgmii_override = 1;
+	}
+
+	if (priv->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
+	    priv->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID) {
+		priv->txcidm = 1;
+		priv->rgmii_override = 1;
+	}
+}
+
+static void ravb_set_delay_mode(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	u32 set = 0;
+
+	if (!priv->info->internal_delay)
+		return;
+
+	if (priv->rxcidm)
+		set |= APSR_RDM;
+	if (priv->txcidm)
+		set |= APSR_TDM;
+	ravb_modify(ndev, APSR, APSR_RDM | APSR_TDM, set);
+}
+
 /* Network device open function for Ethernet AVB */
 static int ravb_open(struct net_device *ndev)
 {
@@ -1831,6 +1884,8 @@ static int ravb_open(struct net_device *ndev)
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
+	ravb_set_delay_mode(ndev);
+
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
@@ -2551,41 +2606,6 @@ static int ravb_set_config_mode(struct net_device *ndev)
 	return error;
 }
 
-/* Set tx and rx clock internal delay modes */
-static void ravb_parse_delay_mode(struct device_node *np, struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	bool explicit_delay = false;
-	u32 delay;
-
-	if (!of_property_read_u32(np, "rx-internal-delay-ps", &delay)) {
-		/* Valid values are 0 and 1800, according to DT bindings */
-		priv->rxcidm = !!delay;
-		explicit_delay = true;
-	}
-	if (!of_property_read_u32(np, "tx-internal-delay-ps", &delay)) {
-		/* Valid values are 0 and 2000, according to DT bindings */
-		priv->txcidm = !!delay;
-		explicit_delay = true;
-	}
-
-	if (explicit_delay)
-		return;
-
-	/* Fall back to legacy rgmii-*id behavior */
-	if (priv->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
-	    priv->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID) {
-		priv->rxcidm = 1;
-		priv->rgmii_override = 1;
-	}
-
-	if (priv->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
-	    priv->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID) {
-		priv->txcidm = 1;
-		priv->rgmii_override = 1;
-	}
-}
-
 static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 			  const char *ch, int *irq, irq_handler_t handler)
 {
@@ -2670,18 +2690,6 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", &irq, ravb_nc_interrupt);
 }
 
-static void ravb_set_delay_mode(struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	u32 set = 0;
-
-	if (priv->rxcidm)
-		set |= APSR_RDM;
-	if (priv->txcidm)
-		set |= APSR_TDM;
-	ravb_modify(ndev, APSR, APSR_RDM | APSR_TDM, set);
-}
-
 static int ravb_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -2805,10 +2813,7 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_rpm_put;
 
-	if (info->internal_delay) {
-		ravb_parse_delay_mode(np, ndev);
-		ravb_set_delay_mode(ndev);
-	}
+	ravb_parse_delay_mode(np, ndev);
 
 	/* Allocate descriptor base address table */
 	priv->desc_bat_size = sizeof(struct ravb_desc) * DBAT_ENTRY_NUM;
-- 
2.39.2


