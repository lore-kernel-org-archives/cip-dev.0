Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE5C27C50
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:16 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.8573.1716970268016269243
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Wnylr+ei;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42120e3911eso12040265e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970266; x=1717575066; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIlnHj9VBbONH267YeDVwHcJgFeFOsKkBKHMRk/Tg1o=;
        b=Wnylr+ei0MYVJyNWSarW9TP7FKQ1w6ENT+Rw2UOcYexQyjqXVNsihHq4Jtfm9wuLsp
         WUHcPeuaXqnxk27OJVGFYlOUuMeln3f/GAeAHkd7kGo0MI/KNHm7gKvtCqzOmsQd6zx1
         UQyNMKsWzOW05W1qDfUuZPpkXEe+q5HQYSCAHBfEwLbe/2IrawEHwUvzSuO5dvrrhRqe
         u6CCvf+vQ1hlsWZXK7qHCmpKhieUH4GG1bBaUbimuoTJKZtJC4X/pgIxU1kgte9PXNnd
         ZzypdCihd1BwYxStxjVv3crhvKoD+/dvorfPN1IecFEExg0dlpZz0EtZKPa+VDl+zEfc
         ib0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970266; x=1717575066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIlnHj9VBbONH267YeDVwHcJgFeFOsKkBKHMRk/Tg1o=;
        b=blDWG6kGNTlwPf/nzNj8RcwitYScS1OI6RKPxAFfQdBDBgodwW26V1NQVb/DfpZTl3
         g7ZLwkZ6FQ/hHX1T9l8VRCNk8hLbq4x3t/LsK8b/qWuiaOkuPQEWjn3668WWFjInegwE
         JyFmSj2YbekaCZEhZ9ajD2BJTalijHlHG6q4LAXrk5FHqekVqlf810P1bVEoxgwJsFUX
         2ktVVG3+33G4sopWrmlJvz042zm5d0BijoVMC+CPLAWrhsPSxWP2bGE/reV+bvISaJnI
         1c428qjbAXQQU+EHl+WwPMjRy3dmTt9OPHfRciadapXsRTsJ8N9vMtpuuiWgNeJ2CvVh
         x5yA==
X-Gm-Message-State: AOJu0Yx9FSj9Jej17A++Tpsap6J+2I8AkYoZqh4e6H5hiuEQnf57UQwd
	bCZx2RQ6zYpAd6RwxBmiZFmIHaCNXGePfq93xZ4zCvtLcQB+QghIYYe2X7BK4cw=
X-Google-Smtp-Source: AGHT+IFmaTy0aFfpK4A+bvsgoV7A6jjl5YrS2f2gb2B6+tqsU4H5pyZdOk1CcnjHyn9dcd31CxHOww==
X-Received: by 2002:a05:600c:3b1d:b0:421:129e:98a0 with SMTP id 5b1f17b1804b1-421129e9a97mr75441775e9.19.1716970266423;
        Wed, 29 May 2024 01:11:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 14/47] net: ravb: Wait for operating mode to be applied
Date: Wed, 29 May 2024 11:10:06 +0300
Message-Id: <20240529081039.639010-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15994

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 9039cd4c61635b2d541009a7cd5e2cc052402f28 upstream.

CSR.OPS bits specify the current operating mode and (according to
documentation) they are updated by HW when the operating mode change
request is processed. To comply with this check CSR.OPS before proceeding.

Commit introduces ravb_set_opmode() that does all the necessities for
setting the operating mode (set CCC.OPC (and CCC.GAC, CCC.CSEL, if any) and
wait for CSR.OPS) and call it where needed. This should comply with all the
HW manuals requirements as different manual variants specify that different
modes need to be checked in CSR.OPS when setting CCC.OPC.

If gPTP active in config mode is supported and it needs to be enabled, the
CCC.GAC and CCC.CSEL needs to be configured along with CCC.OPC in the same
write access. For this, ravb_set_opmode() allows passing GAC and CSEL as
part of opmode and the function updates accordingly CCC register.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 65 +++++++++++++++---------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 9362f60a584d..1420c41b6480 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -69,16 +69,27 @@ int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value)
 	return -ETIMEDOUT;
 }
 
-static int ravb_config(struct net_device *ndev)
+static int ravb_set_opmode(struct net_device *ndev, u32 opmode)
 {
+	u32 csr_ops = 1U << (opmode & CCC_OPC);
+	u32 ccc_mask = CCC_OPC;
 	int error;
 
-	/* Set config mode */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
-	/* Check if the operating mode is changed to the config mode */
-	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_CONFIG);
-	if (error)
-		netdev_err(ndev, "failed to switch device to config mode\n");
+	/* If gPTP active in config mode is supported it needs to be configured
+	 * along with CSEL and operating mode in the same access. This is a
+	 * hardware limitation.
+	 */
+	if (opmode & CCC_GAC)
+		ccc_mask |= CCC_GAC | CCC_CSEL;
+
+	/* Set operating mode */
+	ravb_modify(ndev, CCC, ccc_mask, opmode);
+	/* Check if the operating mode is changed to the requested one */
+	error = ravb_wait(ndev, CSR, CSR_OPS, csr_ops);
+	if (error) {
+		netdev_err(ndev, "failed to switch device to requested mode (%u)\n",
+			   opmode & CCC_OPC);
+	}
 
 	return error;
 }
@@ -672,7 +683,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 	int error;
 
 	/* Set CONFIG mode */
-	error = ravb_config(ndev);
+	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 	if (error)
 		return error;
 
@@ -681,9 +692,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 		return error;
 
 	/* Setting the control will start the AVB-DMAC process. */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_OPERATION);
-
-	return 0;
+	return ravb_set_opmode(ndev, CCC_OPC_OPERATION);
 }
 
 static void ravb_get_tx_tstamp(struct net_device *ndev)
@@ -1045,7 +1054,7 @@ static int ravb_stop_dma(struct net_device *ndev)
 		return error;
 
 	/* Stop AVB-DMAC process */
-	return ravb_config(ndev);
+	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 }
 
 /* E-MAC interrupt handler */
@@ -2572,21 +2581,25 @@ static int ravb_set_gti(struct net_device *ndev)
 	return 0;
 }
 
-static void ravb_set_config_mode(struct net_device *ndev)
+static int ravb_set_config_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int error;
 
 	if (info->gptp) {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+		if (error)
+			return error;
 		/* Set CSEL value */
 		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
 	} else if (info->ccc_gac) {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG |
-			    CCC_GAC | CCC_CSEL_HPB);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
 	} else {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 	}
+
+	return error;
 }
 
 /* Set tx and rx clock internal delay modes */
@@ -2806,7 +2819,9 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &ravb_ethtool_ops;
 
 	/* Set AVB config mode */
-	ravb_set_config_mode(ndev);
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		goto out_disable_gptp_clk;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
@@ -2929,8 +2944,7 @@ static int ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	/* Set reset mode */
-	ravb_write(ndev, CCC_OPC_RESET, CCC);
+	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
 	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
@@ -3017,8 +3031,11 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	int ret = 0;
 
 	/* If WoL is enabled set reset mode to rearm the WoL logic */
-	if (priv->wol_enabled)
-		ravb_write(ndev, CCC_OPC_RESET, CCC);
+	if (priv->wol_enabled) {
+		ret = ravb_set_opmode(ndev, CCC_OPC_RESET);
+		if (ret)
+			return ret;
+	}
 
 	/* All register have been reset to default values.
 	 * Restore all registers which where setup at probe time and
@@ -3026,7 +3043,9 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	 */
 
 	/* Set AVB config mode */
-	ravb_set_config_mode(ndev);
+	ret = ravb_set_config_mode(ndev);
+	if (ret)
+		return ret;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
-- 
2.39.2


