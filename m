Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E94FC25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:57 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.8675.1716970493472186778
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SEaaMCbr;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42121d28664so7256995e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970492; x=1717575292; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCO5NtharJrT6sPi0vv7NhSgcIhSp1Y1mRPbGfOczTY=;
        b=SEaaMCbrzhy1Hvx1Z3h0F6/pVP+MtMhvfSBUCMc6ue/rPglIKZooRWBK+rc2TDCdtf
         fXxfcFN7qsIHrM/0gN2IkvhCVTn3SIWXSTKBWGxXUadparMIbh4FlY0Ilpf1gI4YLYO/
         RTDq/OvB4DtmaOAdIfqYmJAO/OL4n7pPTI3VfEQkYftebItBLBT1O5pkRz32dBWIXaV7
         fBvO1b6fECV77TgnoYSz1TV3CCrzBs1cxoiGKrMIfJtIn0dd3ZPwtDKYG3D3BYnoqZDs
         LUbcKdtCQdr1qKoxAI1M9Hi3kSubuJMXfPE9iFN6n99HmKUuzGP4+/JoqD7yEuueVK9t
         4qPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970492; x=1717575292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCO5NtharJrT6sPi0vv7NhSgcIhSp1Y1mRPbGfOczTY=;
        b=R/ygW75nP87RfYS7/jatNne1ybY9GK5KBI9I4wLskxYr6bqUzcDtN52jjYAcwASUHf
         B/om6mxvqOWg0M4JBdV1n2cukpU82I1HmnZKo/2JKn/d50kAzmKIMwTShOHXCeIhEESZ
         IlRtt7+k5OMBUPUT9S96ad/ykf4O/ek8vUtyCbeRpWrf6vEtEiyZa7nAhMQsnYXOE5uV
         5FAmdRcfBXI/nj/YH7Jl+SJbOB9L6S1+PhUb0m9rGQuSxVSV2/t99+wcH8gSDImuxKNa
         tPxHz9cbf5KBYn7tR2ZVznZbMRDTBGjgsNxoFbNnS+XOTAPNmM7vN9Fdn8W6JwwLYXsK
         HmAQ==
X-Gm-Message-State: AOJu0YxzrK6dIRIrptsYE55ZwxighKMVHH8Z1/49pFAPs/LpE8cWgGPp
	+Z1STrp8ykY9/fQdLCnvdqgFsUZNPZn4CQmb3UuecXrNXai+tSdIyD+mhlQGtwM=
X-Google-Smtp-Source: AGHT+IHE8wUFijBndIGJSR+DdRCvuHamD0BGVny+KnRNZkkMOv3APvncchy+SbAJ7MYO6bUuMEVA6g==
X-Received: by 2002:a05:600c:211a:b0:420:112e:6c1 with SMTP id 5b1f17b1804b1-421089f4becmr115030105e9.13.1716970491970;
        Wed, 29 May 2024 01:14:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 09/33] net: ravb: Rely on PM domain to enable gptp_clk
Date: Wed, 29 May 2024 11:14:10 +0300
Message-Id: <20240529081434.639519-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16037

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e1da043f2b2d956818728ca74c8eacd17feccf5c upstream.

ravb_rzv2m_hw_info::gptp_ref_clk is enabled only for RZ/V2M. RZ/V2M
is an ARM64-based device which selects power domains by default and
CONFIG_PM. The RZ/V2M Ethernet DT node has proper power-domain binding
available in device tree from the commit that added the Ethernet node.
(4872ca1f92b0 ("arm64: dts: renesas: r9a09g011: Add ethernet nodes")).

Power domain support was available in the rzg2l-cpg.c driver when the
Ethernet DT node has been enabled in RZ/V2M device tree.
(ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")).

Thus, remove the explicit clock enable for gptp_clk (and treat it as the
other clocks are treated) as it is not needed and removing it doesn't
break the ABI according to the above explanations.

By removing the enable/disable operation from the driver we can add
runtime PM support (which operates on clocks) w/o the need to handle
the gptp_clk in the Ethernet driver functions like ravb_runtime_nop().
PM domain does all that is needed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 756ac4a07f60..e8df1eca96aa 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2800,7 +2800,6 @@ static int ravb_probe(struct platform_device *pdev)
 			error = PTR_ERR(priv->gptp_clk);
 			goto out_disable_refclk;
 		}
-		clk_prepare_enable(priv->gptp_clk);
 	}
 
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
@@ -2820,13 +2819,13 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Set AVB config mode */
 	error = ravb_set_config_mode(ndev);
 	if (error)
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
 		error = ravb_set_gti(ndev);
 		if (error)
-			goto out_disable_gptp_clk;
+			goto out_disable_refclk;
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
@@ -2846,7 +2845,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2909,8 +2908,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-out_disable_gptp_clk:
-	clk_disable_unprepare(priv->gptp_clk);
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
@@ -2945,7 +2942,6 @@ static int ravb_remove(struct platform_device *pdev)
 
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
-	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
 
 	pm_runtime_put_sync(&pdev->dev);
-- 
2.39.2


