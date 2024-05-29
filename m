Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E389C25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:26 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.8648.1716970281699473405
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=A52zUcsV;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so16611855e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970280; x=1717575080; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LzsHXa4OakELPHllrwwEvUfLcOdKyJ/XyOT1ZLf7Tw=;
        b=A52zUcsVKFekwizSvDjcLQ+9lIFpMckq1NZok2K7Cs72znigQMeTBJTxRpsMAlJeZP
         1hUrToGrTbTPPPHSbximhplJ5g/iVBdOeOktkv3SSEi0T1v1L613rzBGSD9IkZHmvcwD
         ZEgzq0nfegohDuxJtsWLkvYcuTJP7QZuvCHnryVEYxk//1W5X00r1sansYvVWQEX+FBs
         re1GcST+ObyE2kGgF1ZrB1t8p3j6bhjGtf6bUAwiisJLA/Cfiaq1+1VlT4jcjB32cKOE
         aSixpaToaKzquuCx1IfVMjFc5bzV0fnNqM92Y0Uy+VTrzfEGS5941fG0X8FT4hOgSeKi
         d92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970280; x=1717575080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LzsHXa4OakELPHllrwwEvUfLcOdKyJ/XyOT1ZLf7Tw=;
        b=aUcM0hSJ5THWdKXI+STbb4uWCHS51Mw/6W9Gzxg3vm75OYsJiCNZiM+aj5W0fZaxMx
         w/VlN2liJegwChOdZecCxxhdljoPBKC0Jt4ROP64r3zu3W6OYikLIufFUituH/UucGSH
         zDrcRXHBsJMsoc9GLkd+m7GUy06BrYa4teKym0mro61iyg4/BRfF7/aWKU4b3R6XqF3I
         kLLaigMN3a2PDZcsqN3DGBsYFws7FvXrMU4EwBWlxeRyXCDGXohM2/+SNvJlPpa0GQgF
         WDNrnDfAB/f4YUNvQeTSZfi3pUza8W7c23yYA7gEyvdoFT1QbDGJVLSHW4tUHjPl3Qe/
         Z2IQ==
X-Gm-Message-State: AOJu0Yyhs5DCWT4cSCG5istim/iAJG0N0oNivEalg5S1YKkTyNy5uJ7Q
	9qpZWEi+yGuCz2/RdTYL/HuL5EZO8sgBTRUQTEqHPgJzgCrznECNKnzBD5cwa96IJgNDOTpqU90
	DXAI=
X-Google-Smtp-Source: AGHT+IECCb283izpKI2eYd6xMEZPgHN7GbCDUAq4Ne2atpGzUWcyMLonQgwlLa7QYTlWNW9Qx9NXuA==
X-Received: by 2002:a05:600c:5121:b0:41e:3272:6476 with SMTP id 5b1f17b1804b1-42108a5929dmr117720755e9.10.1716970280236;
        Wed, 29 May 2024 01:11:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:19 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 23/47] net: ravb: Assert/de-assert reset on suspend/resume
Date: Wed, 29 May 2024 11:10:15 +0300
Message-Id: <20240529081039.639010-24-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16003

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c5c0714e29508fd748ee5df09ae242476bf2e451 upstream.

RZ/G3S can go to deep sleep states where power to most of the SoC parts is
off. When resuming from such a state, the Ethernet controller needs to be
reinitialized. De-asserting the reset signal for it should also be done.
Thus, add reset assert/de-assert on suspend/resume functions.

On the resume function, the de-assert was not reverted in case of failures
to give the user a chance to restore the interface (e.g., bringing down/up
the interface) in case suspend/resume failed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 44cdef3d2b18..5e7b5857d347 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2983,7 +2983,7 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	int ret;
 
 	if (!netif_running(ndev))
-		return 0;
+		goto reset_assert;
 
 	netif_device_detach(ndev);
 
@@ -2995,7 +2995,11 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	if (priv->info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
-	return ret;
+	if (priv->wol_enabled)
+		return ret;
+
+reset_assert:
+	return reset_control_assert(priv->rstc);
 }
 
 static int __maybe_unused ravb_resume(struct device *dev)
@@ -3003,7 +3007,11 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	int ret = 0;
+	int ret;
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
 
 	/* If WoL is enabled set reset mode to rearm the WoL logic */
 	if (priv->wol_enabled) {
-- 
2.39.2


