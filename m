Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39E9C25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:36 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.8585.1716970295464943673
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=e7Saxrws;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso2103355e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970293; x=1717575093; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=578LUJHkZC8C7X6/32uN8QTdz7BMeUiw2tgLPtOx1Rg=;
        b=e7SaxrwsKl88DkiuQVjSPBQB3grAJRtJweQr/l2thMQHrL1BsliqZCxAn9EHDUERra
         w5QrjNcAbrbg645XpIh5A6z+6pZ9ff+d7KWGmFPJ4FoBumfssRAQVGDzboYnmX49mpdt
         s4BMI75VIyDjmiv42p5ZfnB+8xMYWlTic9NE2r/1ECqoxOM+ksOSn5y7HSi84CLAlYUc
         rRYGsRmRc+aDx9KeilqwnPnnZAl9J5RrT5pLEzovtOhHckHD6P130SqfByuYuw40b7o2
         WW+xu4n6BcSAFC4YYNF3I/KwmZD53hsdJJG3h+lkIs4yg61wvjTQ4C/2qNllUQ7KG4JS
         vOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970293; x=1717575093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=578LUJHkZC8C7X6/32uN8QTdz7BMeUiw2tgLPtOx1Rg=;
        b=rT3dvegNRUdyPlFZVeOXirweVU9Z4OcxvCgDC/x6MQ4F3raQu8i2ai2QOxaLXOBK6U
         f7akHah23ZNpMfGXN39EwCksPHVu6nyC7v2tmKSMYIREGszo/3zVqLJsicOoFch26yhJ
         HoBRKfq6AGDt4pFjclE/MOTOLp/CzNjGsIfTzlsawOPLoXdoutSayAWdHw+F2sPQGs8Y
         cF8o0u3HOYRm2s1kmIAjxxkKANluGYqdZHZGePqtbi5DwbAxtl3S9uOb9vGaj/4vd+Q8
         AzojwhaL6G+EGcynT0dSlp8uyoX80z4Vl5iRk6b3T7+6f6rSK2mmp07R6SSyE2c54ZXd
         NOVQ==
X-Gm-Message-State: AOJu0Yzzp5bl4acLA65Mwv/E+YxA6rStd6MmWU1gyO/1W5HKWzX/bz7Q
	nVbNKeSRHv03RQ41XdpMjvpt680vpiCd13t49pxOCS8w/5I211FzK5RyUjm1WWs=
X-Google-Smtp-Source: AGHT+IGLOZH2uQXU7yekrIAPAdRVu6ntikZREnzYxoRONlmV/YVqOP+XjdKTMNGAiq124Tr/pIaNdg==
X-Received: by 2002:a05:6512:3d1d:b0:529:a0fd:a257 with SMTP id 2adb3069b0e04-529a0fdb25emr11828201e87.54.1716970292614;
        Wed, 29 May 2024 01:11:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 31/47] net: ravb: Simplify ravb_suspend()
Date: Wed, 29 May 2024 11:10:23 +0300
Message-Id: <20240529081039.639010-32-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16011

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b07bc55cbb1cf88a527d687fccd4a12bac744486 upstream.

As ravb_close() contains now the call to ravb_ptp_stop() for both ccc_gac
and gPTP aware platforms, there is no need to keep the separate call in
ravb_suspend(). Instead, move it to ravb_wol_setup(). In this way the
resulting code is cleaner.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 597c303610ca..2a7ff0037676 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2934,6 +2934,9 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
+	if (priv->info->ccc_gac)
+		ravb_ptp_stop(ndev);
+
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -2966,14 +2969,10 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	netif_device_detach(ndev);
 
 	if (priv->wol_enabled)
-		ret = ravb_wol_setup(ndev);
-	else
-		ret = ravb_close(ndev);
+		return ravb_wol_setup(ndev);
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
-	if (priv->wol_enabled)
+	ret = ravb_close(ndev);
+	if (ret)
 		return ret;
 
 reset_assert:
-- 
2.39.2


