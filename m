Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14C2C27C50
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:36 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.8651.1716970287837874687
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=J/g10uwT;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421205e8cdeso17850085e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970286; x=1717575086; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRrU0pGZBsg0mzUc306/MK+O5INNBVcPjrNHmdsScdc=;
        b=J/g10uwTcgWmA7tK+7ikPwX5AL3PkoQD9na5eDvia/YUyxZnqQXr0yJ6f1xfcHaM/c
         oJOGGcnC6ISqCb56wlfOmC7Q36ig0qyXZxyZwKOWStXTVDLh+sIdCB3HkxBEJk4W/cdo
         iqkTS8fMwHXK1qtldMJzrAAsXBgdEbGpYethi2MNbXHtmFeU56U3qo+gOyPff1COxMXa
         XjDqGDnEnR4Ts312oyzZAsD4Tq/w/YrsRad03PZH4cMVg7vP78A1vWKAA8x/FDOB+eMv
         On5y/PxbyAU1U2s+Be2AIlINcB8vcxur0iNCuINPibRNF3OYNmAJD0FBQ1S484A5q3Hc
         driw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970286; x=1717575086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRrU0pGZBsg0mzUc306/MK+O5INNBVcPjrNHmdsScdc=;
        b=INmq3omc/Rdn4B6VjK4me9DNZ8RpVfOTb1RpSF08B/Zl23kNaV3/yvbe7HGTtT4kID
         BFqVTbYa66D8hnEec0zxx3lY8x8EtP47wcDNvD/p1p2LyB58mp5vG8gNpIJJzwhDQHRW
         Fh8m/GikxeMNhYYCS9oEokBn/eCqhrehje38ZnNDK1Sg0FkNF4k0Jw8d24bjJfhmfItQ
         i/Dc8wh4fz8k5Fepbj/fe7/3X1V7EM8WCpKmfUwXBrbEAEev/j7PUhDaMlQisTyTA6M4
         kb85WTtOUW1CKp61Unjo9jQgIQQzaqWPi+3RbhipWQ6gLOdDWNRWeC3+mnzTLmRwmeEC
         JtaQ==
X-Gm-Message-State: AOJu0YwLjhAmL2ImRKTbyd0sUDTCknWXcRr7TphBr9N0DfaINRdkC1ca
	vCeQCwYXkzGodVbm3m+dZypXOXOPSo7LE7rzZpOHudg1HkW0mtwT5cAaHWjNUIs=
X-Google-Smtp-Source: AGHT+IFv9jz2L0/wamXxzaIyFDGrWuxkcW1VubDrM+U643FYDRf957SJccxXiEqajC83LIiXlNroCg==
X-Received: by 2002:a05:600c:46d1:b0:421:2429:7e46 with SMTP id 5b1f17b1804b1-42124297ec6mr10497375e9.13.1716970286246;
        Wed, 29 May 2024 01:11:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 27/47] net: ravb: Move delay mode set in the driver's ndo_open API
Date: Wed, 29 May 2024 11:10:19 +0300
Message-Id: <20240529081039.639010-28-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16007

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
index 2e96ce403da0..bf909302ecf4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1810,6 +1810,59 @@ static int ravb_compute_gti(struct net_device *ndev)
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
@@ -1821,6 +1874,8 @@ static int ravb_open(struct net_device *ndev)
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
+	ravb_set_delay_mode(ndev);
+
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
@@ -2534,41 +2589,6 @@ static int ravb_set_config_mode(struct net_device *ndev)
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
@@ -2653,18 +2673,6 @@ static int ravb_setup_irqs(struct ravb_private *priv)
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
@@ -2788,10 +2796,7 @@ static int ravb_probe(struct platform_device *pdev)
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


