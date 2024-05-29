Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34E5C25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:05 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web10.8636.1716970257464464662
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:10:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kTucsQpZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-529682e013dso2087924e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970256; x=1717575056; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHwaqK8FDbrUJOjMh40D051saX2MZgSoYnTbNQAYvkk=;
        b=kTucsQpZ8vC6oV6YziDNiSYFMYkCLEq9+hVmSncczRIsmQXOLyRSl7/t8THDUnRCFm
         JzrVSW1yQk5dHfRoDDpTHwb7AOGbU+8Z0A/IlU+s4Uy7f9S61nd6rpobHaljsjjBvpF+
         1Kn0XMvPCr4C7A0t6cInw9fbCMCo0gT4C2ZF/mZTWkGe26TCkRrkwi0s1Nclhj2ei8YM
         PFHYhT/ef+Aq1wzdtynWGP4bDOVYprGGSdH9HJsITfkPgxno4L+uDCM7On544vCkSDRH
         l1SwMemE+7BQPL6+pepmLtbNk32rcVxbmspr4J6c/Egb+cFP9JUiHvEF1Hoz5v2dHBMw
         /oPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970256; x=1717575056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHwaqK8FDbrUJOjMh40D051saX2MZgSoYnTbNQAYvkk=;
        b=KEIBtVNXEqV12/0nz+Q726oTfSA2QE9Obo7FPQpm6DuZaGny9z6lf7q8sajBQgy5v/
         jt0jfBtdvY1dE5jUYI4SM4Xbvud/MPzyDEx8zPxDBzwyYlCAxeY3zsi59uA/t8bCjqF9
         fDAaxU1k7XWpnELXKPoMnXBI/xbNg8AGm1Ykfl64tTJBCNTxOjMwMxYP4gt2CEMWEdgB
         g1DQdy0Nc8SCnEIOF8ffeZEFrKcbHXC1vmwag5XLbBZjqB47cgDTtWO2r3Yjxbv3ZGGm
         cbojhcMR4e5+sMPy9ebupA1zCikSj66nMpSadF/x7jJ4S/LLWkDUV8mNo12vYodw3fEu
         MB9Q==
X-Gm-Message-State: AOJu0YwlDyeQ9437UL4DgTL8d2bcdwOyzUO2k1kqiwGYY0mIFtNbpU2J
	E0eiLrQUmCn2EYXr26AEpAT0+qxKVqp6SRILzK35x/3Fer+bWntCuyJeUf3KN7I=
X-Google-Smtp-Source: AGHT+IGUQfqe8sx4jqWwk63f7ASn1lJGX+KTDnq07Sz4Lr/2/Wnzx4Z/+Wq+9XXnUmTLl1a3pbtSMg==
X-Received: by 2002:ac2:58f7:0:b0:515:d038:5548 with SMTP id 2adb3069b0e04-529650a4281mr8135561e87.31.1716970255684;
        Wed, 29 May 2024 01:10:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:54 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 09/47] net: ravb: Fix lack of register setting after system resumed for Gen3
Date: Wed, 29 May 2024 11:10:01 +0300
Message-Id: <20240529081039.639010-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15989

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit c2b6cdee1d13ffbb24baca3c9b8a572d6b541e4e upstream.

After system entered Suspend to RAM, registers setting of this
hardware is reset because the SoC will be turned off. On R-Car Gen3
(info->ccc_gac), ravb_ptp_init() is called in ravb_probe() only. So,
after system resumed, it lacks of the initial settings for ptp. So,
add ravb_ptp_{init,stop}() into ravb_{resume,suspend}().

Fixes: f5d7837f96e5 ("ravb: ptp: Add CONFIG mode support")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 23fb75b9ee0d..c15a4d56e79f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2994,6 +2994,9 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	else
 		ret = ravb_close(ndev);
 
+	if (priv->info->ccc_gac)
+		ravb_ptp_stop(ndev);
+
 	return ret;
 }
 
@@ -3032,6 +3035,9 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	/* Restore descriptor base address table */
 	ravb_write(ndev, priv->desc_bat_dma, DBAT);
 
+	if (priv->info->ccc_gac)
+		ravb_ptp_init(ndev, priv->pdev);
+
 	if (netif_running(ndev)) {
 		if (priv->wol_enabled) {
 			ret = ravb_wol_restore(ndev);
-- 
2.39.2


