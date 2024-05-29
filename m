Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D21C25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:26 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.8579.1716970280285076207
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SQGUp7if;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b4fcbf078so172186e87.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970278; x=1717575078; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIeKQaRtpmgRSoGDGwFwTs+Vs07bTk3synoDo6BLgUI=;
        b=SQGUp7ifCi6Q1T7MTl/EDOXr9BOgvW55DsGcLXnPAVR+eVGcYnKA0Up5ikjcG91FNM
         qxLUC8Q+0+lzpyw+QujHT5vgxudz55QEaM7b72omiCKlxYCYKn+qGM2k+BiN6wVrSk8Q
         NMClP24iCCe5p0zhwlBYaAaC0MKsgBcOhoEUfXg9hn+d8YLuyqsBQ4rdZSJhLmqMMRtp
         PeCyXq/wcBGLj2Q0KTM64zWDCCa2dXPrwXjvjTShJwSPMf4O/TVt752fIoELHQSFiSvT
         4gQvDfrwVGWPFcJxJU1bGYy1b7C8RraALBCsfJboNXrnKHC7a+kWoC8bphA3SrTR3jLK
         oVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970278; x=1717575078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIeKQaRtpmgRSoGDGwFwTs+Vs07bTk3synoDo6BLgUI=;
        b=eJgWye3QHPqud+WYsqmEgUrPSX0HezMK1Abdf+aLZ/b+YJicp82mN6U4muxPG+d0Zh
         AAPPK+pm1QIZdJZtrNsRkQRM4L2Dxy83wKcJcSdFZdZFQ+wb3lXuQVEh6Qturh07cLy7
         5Pfk0DIVDeoyjKO0IKDgZEgqG9TXAtBXGPMPs2tp75WPE3yQupxl7KayomLugVdhvOvX
         diu8og1NTn8czzjEla1VO7VPExwO9ER9KobYt943yqDMNNJ/GsCMgBidYUdr1tOGLluJ
         IaaVAmczoOvj9WbX1jMm8JxlFBvLPNFPXIeI37AfDoe3sTBc2CZ19Cm9Dc+49m6QdP7S
         MJUA==
X-Gm-Message-State: AOJu0YzLv2L2O1j9zcOGb2G6nm0H4tJ+LKX0ZNkVRLl06s6cCJfO2Yh0
	69eEFjOatXTMoBF5LF3fCo41Fvzy89V3AiG63x4Caslazsee6V6zMiIeIhrywPY=
X-Google-Smtp-Source: AGHT+IGemxDqLh49O7fjbNlvFKwJtZsWv4Lf3eKmZpzVRu+ziHl/CZbO/bnPFigMK7Vyp8kGWgybdQ==
X-Received: by 2002:a05:6512:ad4:b0:529:b57a:31ce with SMTP id 2adb3069b0e04-529b57a3277mr5702454e87.29.1716970278611;
        Wed, 29 May 2024 01:11:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:18 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 22/47] net: ravb: Make reset controller support mandatory
Date: Wed, 29 May 2024 11:10:14 +0300
Message-Id: <20240529081039.639010-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16002

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b1768e3dc47792ac5876643604be25bc8ed17cd4 upstream.

On the RZ/G3S SoC the reset controller is mandatory for the IP to work.
The device tree binding documentation for the ravb driver specifies that
the resets are mandatory. Based on this, make the resets mandatory also in
driver for all ravb devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[claudiu.beznea: fixed conflict in Kconfig]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/Kconfig     | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/Kconfig b/drivers/net/ethernet/renesas/Kconfig
index 5a2a4af31812..d1f1e1ee2757 100644
--- a/drivers/net/ethernet/renesas/Kconfig
+++ b/drivers/net/ethernet/renesas/Kconfig
@@ -36,6 +36,7 @@ config RAVB
 	select MII
 	select MDIO_BITBANG
 	select PHYLIB
+	select RESET_CONTROLLER
 	imply PTP_1588_CLOCK
 	help
 	  Renesas Ethernet AVB device driver.
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 09796da2bd57..44cdef3d2b18 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2648,7 +2648,7 @@ static int ravb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
-- 
2.39.2


