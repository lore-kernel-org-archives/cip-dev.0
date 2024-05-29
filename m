Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C4C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:06 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.8571.1716970263706604245
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=C854Km0D;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5238b7d0494so2206248e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970262; x=1717575062; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo5fKBw87CvhptCwnAJhn1ZB3RBppO2dvL2JdH8m2VM=;
        b=C854Km0DvDv4cdP8x7+Uv72O2Cfv88NvYXJr9eK9LJqOzmls0NN4YLcwbebbYAWaLz
         ZlKSC5Hoo7UGdKQtB9McCvffcIxIivUAHAq7DfbNsdA3jRVdih2mFwbGrhd3skiM1QmL
         LNRDkwNJhAcrrBowYttC/wJvMk/YmU6PZpyKxBnnu7ML6/cstFGrdOT5qdGPQ4EN9CBm
         0060vaUDmLgGYzqOmCi4MSr0hshyip9sYFUQ6iCBh+V7R/U83IThiKvdQvz3M56gYcBV
         fYGfD7OsrlSSq0U6SHGoy+g6RndXuv7hTQq0vM7PZtOPkjcV+zy4FLJ7p3BlmrbLB+6+
         jYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970262; x=1717575062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo5fKBw87CvhptCwnAJhn1ZB3RBppO2dvL2JdH8m2VM=;
        b=oC5l914jHzDteBg9vrFW7E8iZOIYu5hvTiHULHNELaoXXAgFzAWOvylmPh5s+COBHN
         bHsIRK9fH3HEvIsQIHWZ/sGl6WhTf6tIAI8EtrvK9u8G8XdQbpNRkxHboPs16mOrQlam
         dX8pLDfQf09JGebRmv81KsNHbhDcjMSfWXcGn35lHQwZcrBoiqXmgkka3JjREQ2/PtbG
         6zZyB+l6frD1BSGrRaTFTRGlJohAwlqVxpTtVt8GDGCC6HMydhcT0ZH0cZHvWuODdhHm
         ad/8AqQeVpkqrwzcfD9+ZRtdM0gaxYfRCpBfseKDtJSdD3mlK4y1gQVYCYlTPKjYABsE
         x4ag==
X-Gm-Message-State: AOJu0YwLqBViexkUcCGEX2eVZsejtfaT7E0cRGyiiApWX7Dr/Zzeuehh
	+52jDTD9zoBwzKSmj32AY7Dle0wGzHuDBb4TSip07rhc5QFtlgfmmNcz5NcZSmE=
X-Google-Smtp-Source: AGHT+IFx2YcaILCUoapx+QbhZ/EXHJWTOQBID7U1b8Pn4L5exzSHEmDEByQKjQA0srd4stL/pTEOcA==
X-Received: by 2002:a05:6512:794:b0:529:46e:b2a5 with SMTP id 2adb3069b0e04-52964eac45fmr12081289e87.2.1716970261027;
        Wed, 29 May 2024 01:11:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:00 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 12/47] net: ravb: Stop DMA in case of failures on ravb_open()
Date: Wed, 29 May 2024 11:10:04 +0300
Message-Id: <20240529081039.639010-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15992

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit eac16a733427ba0de2449ffc7bd3da32ddb65cb7 upstream.

In case ravb_phy_start() returns with error the settings applied in
ravb_dmac_init() are not reverted (e.g. config mode). For this call
ravb_stop_dma() on failure path of ravb_open().

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 420d6926d33d..17a461ae84ef 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1843,6 +1843,7 @@ static int ravb_open(struct net_device *ndev)
 	/* Stop PTP Clock driver */
 	if (info->gptp)
 		ravb_ptp_stop(ndev);
+	ravb_stop_dma(ndev);
 out_free_irq_mgmta:
 	if (!info->multi_irqs)
 		goto out_free_irq;
-- 
2.39.2


