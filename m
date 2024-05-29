Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8425FC27C51
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:57 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web10.8722.1716970494923346994
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=o6HP30KB;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5238b5c07efso2010253e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970493; x=1717575293; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbVgHAAFwBvhTTZT0naG/hJwYyjp6OxNiw9DH3Uruyc=;
        b=o6HP30KBW1pLXEQzAuPLDyiop7P8ILSBfD8FHHmdOis5DTBjv1RL1CkCIPgYSDGPoN
         cKZ91G1j0RklSdHZwda+gO+RQJVpFWQERxkVojgoNyE5LmYpHD6OHJ+toaS40rTQBtWK
         +WyNxXGSaXDguGOK1CIIt0UKtcbX+N9OPBGN7IPH7Lue68Pe+MYyQtZ95zbZ/Zd9qdaf
         JM8y5DrXIcWTZV70Wpl7HfTngjTcaQ68ioHel+YPzfFlm1Sk4tvuZ2qMswVUhMrk4zCB
         ueHiVM/AenTYWJvzGpqyFNpY/lDPPwlAXveySkvAaW9EcKMiwMq3tS+Bx73OEGH40P3N
         2rAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970493; x=1717575293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbVgHAAFwBvhTTZT0naG/hJwYyjp6OxNiw9DH3Uruyc=;
        b=vUhHqs+nJlVoCfsxpTa4fz7bHK8FtAr1+7ZtjsTMoiHD0qDnrcRuWuSz/z69tXQFQ2
         Govq3OBU7GXbOkR0zuAW/nghRG1auBxzJ2ErhmbNROF8t+LQKwqWw6zzgsIibvTfzmSu
         swcYFKUKhhLp43X9u5jlzjcmo5jJuzy2rzxTqhwMI0uQG3qNtd9tIn12jKjt/waDgok9
         96A+MAs/xxGT6n9LXTfe2cRQEBQUgJo2crw0RmuY2llIWtcjeEl3AYuYa+aNMDO56Q9T
         6hxekoIGXXbLPVFoY5pyxkT/LOLpA5lKYmdHWnPYvvZUuVyNYtobzpQK9ZNNN5LpTiIw
         72nA==
X-Gm-Message-State: AOJu0YwF6Av/FsPCWWHpuX1AShwuEH1SEHiGGzaVSG0ZfaXQ5qJkUNDX
	QwTqpFDLfJkqk5bwjZAKAcw9k3g3SHMK5lscMbCn8sW1rSJZgL/zcWwmIA+uiV8=
X-Google-Smtp-Source: AGHT+IHScRtEJLt8yhT2gZTZFA/obSweeCL1CJd/OqFyEC1K2Q3QR+ADgziLcts9yy0MC21cPEMang==
X-Received: by 2002:a05:6512:1388:b0:51a:c8bb:fcf7 with SMTP id 2adb3069b0e04-5296410a55dmr11003915e87.3.1716970493156;
        Wed, 29 May 2024 01:14:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 10/33] net: ravb: Make reset controller support mandatory
Date: Wed, 29 May 2024 11:14:11 +0300
Message-Id: <20240529081434.639519-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16038

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b1768e3dc47792ac5876643604be25bc8ed17cd4 upstream.

On the RZ/G3S SoC the reset controller is mandatory for the IP to work.
The device tree binding documentation for the ravb driver specifies that
the resets are mandatory. Based on this, make the resets mandatory also in
driver for all ravb devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/Kconfig     | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/Kconfig b/drivers/net/ethernet/renesas/Kconfig
index 8008b2f45934..0dd8c5860a54 100644
--- a/drivers/net/ethernet/renesas/Kconfig
+++ b/drivers/net/ethernet/renesas/Kconfig
@@ -37,6 +37,7 @@ config RAVB
 	select MII
 	select MDIO_BITBANG
 	select PHYLIB
+	select RESET_CONTROLLER
 	help
 	  Renesas Ethernet AVB device driver.
 	  This driver supports the following SoCs:
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e8df1eca96aa..c13966e80db7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2665,7 +2665,7 @@ static int ravb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
-- 
2.39.2


