Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0364C27C50
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:46 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web11.8592.1716970302815373612
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EEac30ag;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.172, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e73359b979so17360461fa.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970301; x=1717575101; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFAe2MLhQCuMCslije1rdWN64i8If7VU7gRb/W8PmfA=;
        b=EEac30agWVqukWEHk3SxFvBN4BhDqGmB9I6XavcMxMSjFgy9j65lAhQto9ZSTjz6Hf
         6qG7CLkZfHHn3PB4F3liWjrWmHrbn01Qd9+R3YnVPGnfQ9k4YHNyZU5QqqZ/jBZ3PybI
         biZBM8ZqqkTrOnTwrLmhdQbYkK69hTHq8QSL5gRmLpSYafuAITe/tnhmDVCYKlDVt2cw
         yNoEiJl5mLqVOIulgpoVAasQgtakR5vpY1dLdItjyAzfaAucsHbTvZJ3RH1NB1ABPTQf
         1tksrciIXD9jsD+fCeigoUDvPuL5GqMdF190nA+9YcOehJjTKUhIkmCTBlokSAS/GMih
         irQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970301; x=1717575101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFAe2MLhQCuMCslije1rdWN64i8If7VU7gRb/W8PmfA=;
        b=U2Cpt2QkVK+DchjMZ13c6ZM9AMKmKO5u9LW1+7JzJ/xJxByngUn+lW2yZJqwwpam9L
         FIiAr7UYE5SV0nU4pRSrS8a/K3hAFEYdg6HKBmHDb+7nuFq0fcx4ILpvlYdDJ0o7OJ8M
         FLDaBykegZEWlS84okGJ2QLWnGtR0rkTYXBCZuAkeoOhJGtUZah5j/C0DJY7xIROM5dM
         BjVIYvi0x3hLz6tPtwzu/O/rpMABlGck+9pmuCVpi14HP/8SSMP+hLXhw2BvoG4PxBpU
         6hH+TdkGVX0YtyZVHB5sOt9umdk6NBq4MR/XncV92Z7RnjeM3Ibd4hrDmN7nw3ZqNpwf
         UDDg==
X-Gm-Message-State: AOJu0Yzy78UTlRWqthaTcUR9OS/fJkCpyAq8a+eiy+KDUSyZB8JUvMdA
	ScLd9eHfXqm2wXft79E9VuvOoxNmgtVdr3A2GcKhcvuaysWovzIS2wvybeZ2lJY=
X-Google-Smtp-Source: AGHT+IEzN6EEZYFAlbnu3q+j7c3WvGQm4bSZOqTV9lQnsfDPj3WzwTNBLuMWWh4EHzdHFvlxpQU4NA==
X-Received: by 2002:a2e:a9ac:0:b0:2e9:5b89:dc6a with SMTP id 38308e7fff4ca-2e95b89de87mr106095321fa.39.1716970301022;
        Wed, 29 May 2024 01:11:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 36/47] net: ravb: Keep the reverse order of operations in ravb_close()
Date: Wed, 29 May 2024 11:10:28 +0300
Message-Id: <20240529081039.639010-37-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16016

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a5f149a97d09cc9340d8fb4e22a3074a7bc1e02d upstream.

Keep the reverse order of operations in ravb_close() when compared with
ravb_open(). This is the recommended configuration sequence.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index d9c6a4d048c8..83b08ff417f6 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2331,6 +2331,14 @@ static int ravb_close(struct net_device *ndev)
 	ravb_write(ndev, 0, RIC2);
 	ravb_write(ndev, 0, TIC);
 
+	/* PHY disconnect */
+	if (ndev->phydev) {
+		phy_stop(ndev->phydev);
+		phy_disconnect(ndev->phydev);
+		if (of_phy_is_fixed_link(np))
+			of_phy_deregister_fixed_link(np);
+	}
+
 	/* Stop PTP Clock driver */
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
@@ -2349,14 +2357,6 @@ static int ravb_close(struct net_device *ndev)
 		}
 	}
 
-	/* PHY disconnect */
-	if (ndev->phydev) {
-		phy_stop(ndev->phydev);
-		phy_disconnect(ndev->phydev);
-		if (of_phy_is_fixed_link(np))
-			of_phy_deregister_fixed_link(np);
-	}
-
 	cancel_work_sync(&priv->work);
 
 	if (info->nc_queues)
-- 
2.39.2


