Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A1EC25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:27 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.8695.1716970517718256235
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZQHo4o76;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52aea6067c8so406493e87.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970515; x=1717575315; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siI+3C7JjVNiDEtZgZWo3aSKgTkPA0Sj5enLdrVTs9o=;
        b=ZQHo4o76Ap17QX+hBEq34azb2jsr3alhCHsGrTf7+y/YYf/pGhE5eq/kU3fMGTNETs
         m4HXstUbqQ0yld+3ArttkHUIi7ioOWlDgacvAL+HYkNjDDVsNXHhtreuD4HAKMlBpgix
         z5BqxtQrzljc7l0UmqmOmajxcrEbCkUGqtIeB0jj8/xZDEusekGhA5xlgM9yiFpmRhmf
         Z3rOiFEMzYfMjuW8PPkIiXD6RigkraN0YO552wYuDhL59+S0c7ITKFNwqe9w7l3JoxCr
         wFETtKw1YTVp9HYHxcBJE55gnIUWZA7lQRxzeafICvF2h+M1zg4wRL6K4haaTeo5zyeN
         CaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970515; x=1717575315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siI+3C7JjVNiDEtZgZWo3aSKgTkPA0Sj5enLdrVTs9o=;
        b=U5ss8uI+M26WgAdpSXpuZE8zFZR1ORXBNx0veO3PGPEMRNms//i/ENYTFlzQWqPCNn
         4Y3qiFPB+qxd6LSMQ2vP+SaZtL0p/90xK1DXv8SQEN1vY3xBPM/Y0TqESuXyapYAfLuF
         SzYYTCeCGd7aZS8vWVaA4fv1lVRwVVDhzrdumFZxl8sXuT2n8MwyUt2RsIZCBJTTQmW6
         1sDdVp+X/sM8MmFDJYO4GnmgoWtk9UwcjVnXaODMOwixwOBJG4w7oKaIHF6rTyXZ7BIs
         bf0TIXsPvDmJyM+KWXeywJUoqXz34spyI3AIZ26LkQwsVuBEcujCAsePLw/wycSY/6Ac
         mElQ==
X-Gm-Message-State: AOJu0YyoPNO+YW71hsVHcpM/6Q3OfsHcpIlzOnDL+cniwZ/DqCw7YY1B
	FW0GDz8lCwfXNXT9gyLAYFg6UxRIfq4E0C+vHQwuZ2N3on57b3ycZ2Csm0s7tzc=
X-Google-Smtp-Source: AGHT+IFYba7B7EwG1y1hdvYBlgRtP3JeB1MvbB9x5b16B5GxwYlwzFDsD83MtI2N2Tt5p56IyoHSxw==
X-Received: by 2002:a19:6912:0:b0:523:4e50:a980 with SMTP id 2adb3069b0e04-52966bad24emr8800663e87.60.1716970515422;
        Wed, 29 May 2024 01:15:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 24/33] net: ravb: Keep the reverse order of operations in ravb_close()
Date: Wed, 29 May 2024 11:14:25 +0300
Message-Id: <20240529081434.639519-25-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16052

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
index e206b5b21ffd..ea741fcab46c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2341,6 +2341,14 @@ static int ravb_close(struct net_device *ndev)
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
@@ -2359,14 +2367,6 @@ static int ravb_close(struct net_device *ndev)
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


