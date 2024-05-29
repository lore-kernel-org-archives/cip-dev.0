Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ABAC41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:26 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.8646.1716970279103936959
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GGqKNZ6m;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.173, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e95a1f9c53so21263171fa.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970277; x=1717575077; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/3xBresTmjspqu22A2IKtdhVbktNBoVmxHYo5+aEYI=;
        b=GGqKNZ6m6k6JqzxgdFetf5vMjUMnlr9fBFN1EOQouxdfdv66lpfvWcT+aWV9bzpYTq
         86vTmSRrDlqG/ZS8bpd3XFOBZfQx7WkdhHUVRaiv/yI3IYq4ZpLvJvUWxJK7CKfC5Ay/
         JdXbV9m5EAWnE/yv1w6NqKM/q1z4pos9VwFUw7idNvCsL6OjbEFlczTnZB+7MGmIXDDw
         a8+3hniuzPigBreInvBGFIIgAMr0FQkXv7ALFYKq1orPndGgw11X/2Pf8twiVQVaeqzO
         +JcrLjM3c/2njfoxG/0UPLSbO8/7beiMxbdpxArqSaEeUdbRQkQOFoTq0x3FckRdR4Bb
         XTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970277; x=1717575077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/3xBresTmjspqu22A2IKtdhVbktNBoVmxHYo5+aEYI=;
        b=K2QVvu70vp/iyAmUSqwokAHqMDWWVPAGptXhAS9+FI4YtRnVQZpSL0Hg0Ho5Vhacoy
         e3/zkSrblMH2QEpYO5yLLWT4axj5cxmFXaJYuOVF5rv/6q14RN4+kqH26xZe84PTGth1
         yxTE/pfQ8KW4jWIJf5VjsTX5a3C4p9J99YzMkLRt/NfCDqhqFRICizoIB90+Y7RDtwXs
         3zhL6bmJL6s5l1M7PRz0Qk9dwb4Fnvc2RBPfQCKYqfQq4PkbZIombDsZB3irS52+UYvg
         zc0afwampglpdBk9OfbIV3AUNVqS0yaG98fb8q1olEepfq8mYtvJJ90NBmOx+fThuqqa
         +w1Q==
X-Gm-Message-State: AOJu0Yz9aW9avs3CEH3mDq6L1C4GWdZIGQAz8F9Lwvd2vsEA+I57Gar2
	RfZBj1BbCCuBDOJ1xGbdzEmzqJ9zZQVjDWwtX3vY57VZp69ExHUuENmS3Kcw9iw=
X-Google-Smtp-Source: AGHT+IHglkzxldV0yIKibDMHwUbeD0dDcznsvM+qQSxQ7L+apURurpIMpNtIpC47NURKNZNFlfYH5w==
X-Received: by 2002:a2e:b0f6:0:b0:2e9:8661:927d with SMTP id 38308e7fff4ca-2e9866195a4mr24589601fa.51.1716970277323;
        Wed, 29 May 2024 01:11:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 21/47] net: ravb: Rely on PM domain to enable gptp_clk
Date: Wed, 29 May 2024 11:10:13 +0300
Message-Id: <20240529081039.639010-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16001

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
index 546a32c6d130..09796da2bd57 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2783,7 +2783,6 @@ static int ravb_probe(struct platform_device *pdev)
 			error = PTR_ERR(priv->gptp_clk);
 			goto out_disable_refclk;
 		}
-		clk_prepare_enable(priv->gptp_clk);
 	}
 
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
@@ -2803,13 +2802,13 @@ static int ravb_probe(struct platform_device *pdev)
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
@@ -2829,7 +2828,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2892,8 +2891,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-out_disable_gptp_clk:
-	clk_disable_unprepare(priv->gptp_clk);
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
@@ -2928,7 +2925,6 @@ static int ravb_remove(struct platform_device *pdev)
 
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
-	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
 
 	pm_runtime_put_sync(&pdev->dev);
-- 
2.39.2


