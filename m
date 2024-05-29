Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4360DC41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:57 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.8723.1716970496505057792
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Z8UX9Gt6;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421087b6f3fso15330115e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970495; x=1717575295; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOHOI8uLHUWl/mqKZ9EzFcKZ2y1mL2kj/tIOPWlIieg=;
        b=Z8UX9Gt6NFLP27ffDYogtp3HfC9J2XfQJw1yMiDYKnQ8hDe+hmaGsdcEZCY+BDXYJp
         bYKIIM+PiB01T5ZEGvoABsacQ+HUX9pO2Bp8v6a85h9gIE+P3D+LHpZ8F6pns7PJxOER
         /wGG9oY99yYO1BUThiwp/g7j66ljiT3D9SBgadizVT1w63ISf4LHDIkxdvJ2P+gjgg/Z
         HEgukhXytP2Xtu03Q3lR7BTSVEYzKeKevSg/t1+7winGdKOIIDekxeJiDxIhn1uxZWqY
         39vJw2I5ckBsGe2DeIe1PgylCvs5uF3jdpBfltHNtBaB6bfCZT+y93QIfNfK0/+EQ4VX
         317w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970495; x=1717575295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOHOI8uLHUWl/mqKZ9EzFcKZ2y1mL2kj/tIOPWlIieg=;
        b=gA7YxXSZrCl8MvTivSi4/yzB1P02k22CuF3EI6iNXqxFXE8bNzCfyyoSplMXU2cRCP
         nzS5gGdI3vKg9eMyET6qRn0EbpQ6JiPPFM2aorXltzWdpBsS6B3Dhwp57fNxQ+HgE7WR
         zz/z150aLz0A1fNVhShYZhAwwzvtdN0dzLibdpX1VoowE1k7c7Ot1iCXkXLHSz08Js8I
         xv480aKtf+JW7rwRzFn0lLlvOtyl2zPRK25fg/10uvvraMW/spUpCnkwV8EHLMuLTM0g
         79xrx9SBgYoIQAUcQL13czOIrqz572Ld2Hji0ZJXxhlcsxGyTWyUUmRZIoIsgwtzPakZ
         uNAg==
X-Gm-Message-State: AOJu0YyBqPzb6lwCwQwaBtXRXx31ERhc0j3npt7+Ds3nRJ9tkaLS9oM2
	GtpWX7KKrqQcL3TiNYdm0O5hpliodfl6J5Q2s1HLltGADdPEhD36+QCYtT0MrnE=
X-Google-Smtp-Source: AGHT+IFRxlng+R+YyfYDDXoIgs5fdjlkXzwJ9CWjiBfdZ2HdJxLkRNk1Bi9Et4hdfqeIsi4bt2WLrg==
X-Received: by 2002:a05:600c:581a:b0:41f:f957:96ac with SMTP id 5b1f17b1804b1-421089d9dc3mr117855965e9.13.1716970494994;
        Wed, 29 May 2024 01:14:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:54 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 11/33] net: ravb: Assert/de-assert reset on suspend/resume
Date: Wed, 29 May 2024 11:14:12 +0300
Message-Id: <20240529081434.639519-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16039

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
index c13966e80db7..13ccb0d65603 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3000,7 +3000,7 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	int ret;
 
 	if (!netif_running(ndev))
-		return 0;
+		goto reset_assert;
 
 	netif_device_detach(ndev);
 
@@ -3012,7 +3012,11 @@ static int __maybe_unused ravb_suspend(struct device *dev)
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
@@ -3020,7 +3024,11 @@ static int __maybe_unused ravb_resume(struct device *dev)
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


