Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2C0C25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:17 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.8734.1716970509348774565
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=gI+ayvit;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-420180b58c5so15393605e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970508; x=1717575308; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiGmDi2O1kzDZjfcPodLCQuiLORqmvBrJA+edxzDO1c=;
        b=gI+ayvitX0TdqShHdlqMDAiIuDgfJ6/EKB2KkLNxDdoS72zIlUSVHzuL+YIKFHavOd
         1sTVzyx3s+SljiCbhKNTP1+DiTMtwLr7x7+33E10aXmHi/zHTt/lKZB47/LsuRyBMYah
         nC86LVOdQ3cRpTMDmMThl179yw04SOBY/H2E9Jl+hcH61zCqpRC8ziN1AZvvabAP70j2
         b9D093YXsOfDbSo0EsZWstn0sS2jvsO6aQzPYri62SqjrEa9dj/v34kOzyhffdFysRaF
         DE/glVQHmNyr4pZQ9B8C1PGXs1GDgPmI6whnqloxgkbqanBetgwvShME285hxoA3Rejj
         qt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970508; x=1717575308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiGmDi2O1kzDZjfcPodLCQuiLORqmvBrJA+edxzDO1c=;
        b=PY/jZpRWT04gLpiJxrNt/Rsl1z6xiswtNnkCEWiiqPKNe/bP5YSnmjjubcNgeZv2Ru
         yTRv846wKn+71fblbNQ0HCiGnE5LpRBe7219aLL2rbvqMl0bUwJiFl3FAGwDE0UsDyeu
         ZiRX14yHaK3YjKoj+tqowZn7DmDkUDCHbYDQq7XU/205kdpSXGiRpyrIFAqJzDtsT4rS
         POLuwg7Hs7id0MSrMbmfAXw4mx8oDaHRg2eP97HpfdW0NuBB7s8z9WTbbgo1l/eiVisy
         v4MwvPRT4bCwJD93+gF1rIsSEd2jeo058wjKMCOSHCZTThwdgUit5dRnHgAHL+PQPzDE
         EZSw==
X-Gm-Message-State: AOJu0YxAgiPoWMUlBVb//MJLBtrY2I4CtRxaPzEITkwgDZVwnEOKuSFF
	+sjuOv8I1+lnaSLawKwe26EQZ0hxw41LvrjCc6qKFmzYacMvIO0z7A5OKp+xJHY=
X-Google-Smtp-Source: AGHT+IHM+VtY0A+bmOFh8r1vYjhvM4Fh8lpI8Pb8RN39dFFf53lI/2TEm1CF0IfxGRM0TAtD98sjUA==
X-Received: by 2002:a05:600c:511d:b0:41b:143b:5c2d with SMTP id 5b1f17b1804b1-421089f303emr100392765e9.28.1716970507877;
        Wed, 29 May 2024 01:15:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 19/33] net: ravb: Simplify ravb_suspend()
Date: Wed, 29 May 2024 11:14:20 +0300
Message-Id: <20240529081434.639519-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16047

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
index a76cc7aec5df..38b6807428c8 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2951,6 +2951,9 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
+	if (priv->info->ccc_gac)
+		ravb_ptp_stop(ndev);
+
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -2983,14 +2986,10 @@ static int __maybe_unused ravb_suspend(struct device *dev)
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


