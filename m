Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A91C41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:27 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web11.8699.1716970520767565730
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=DTWaUFwn;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.181, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e9684e0288so22497481fa.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970519; x=1717575319; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqzWoSDOULDEsM/8Jro50TsKViK1Pp1ecyRqoNxEOM0=;
        b=DTWaUFwntUPmdlOJnn9jrJ6hN2iEclzG+cFeLdPJWnVsOIj0/5AnRsNQVf4KV7+64Q
         rfjSRfOwxcn7w4n5TlS8CHAATWDCkKmbNjcAXlYT+gqcSA3OVwCZ+mtZGMVXaprWMngD
         9zymygGP+c7amZTGrYXzou+THg73EscvRJ6q1BJ9Vja5Tcm7TUv+/R2MZBqdgk/Fq7Ju
         IRtjdKKQd3ostQt7Tk5pQh/sqsxvSXxhcOacX9VzWewIeR4AEnXUf/KrPNmAQOYPkKru
         gN6a8i297pQ26PVgjhuGqczcNuBQjBA+lXKXNUnKuepvPSM/zcN0BnO4NbeeWD9n6gcE
         LC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970519; x=1717575319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqzWoSDOULDEsM/8Jro50TsKViK1Pp1ecyRqoNxEOM0=;
        b=W8jHoIUJscUXspziel+JZ/O+sarwNo3grnASyBUhgBt/Y3yWC4ipalce3FnDHMqlJ8
         9nX1kcdvnJeTCKBFEOHAjT/1v9EYXhFthmebea9JSZUoQT6ZY28pVK/z6MJemLYY2DEu
         sY9f7PHoQIVCboM3nmuF1ricnQTwqpjt2UYapB2SLOkeUu5PJkni0m//fd3KekzHPNLM
         90h/fagaiwsCYlM9MDYU1X1IwTuSzno8HUMjI8NkcKPRqTRjv9hFtyrzMtRqIvQeHuRD
         dk6PuRQ0eBpV3kDXaxx0LL/wAF6nfn2/hIbH4Xsu+g69v1VpkvwJKsw+L11aK/+kfIu8
         VEaw==
X-Gm-Message-State: AOJu0YynxDXbRSRFkowidpjxUcu8YcXKdkwRgCZLkOhwBfF9qX62mFI3
	QCJeG680d2V47r4VfC+p0DyybX0NSazcg7BLeFo8sLmUt/YccS79C4/mfxu1A14=
X-Google-Smtp-Source: AGHT+IGN9e43QIyvyLviXP4GTM/m1WswahPZqyicqmbi7WUr8wUCHwkgbyMkLuS0nORsfn+iE0HJRw==
X-Received: by 2002:a2e:9c94:0:b0:2e2:a85f:f222 with SMTP id 38308e7fff4ca-2e95b042c1dmr142834061fa.10.1716970518943;
        Wed, 29 May 2024 01:15:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:18 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 26/33] net: ravb: Move the update of ndev->features to ravb_set_features()
Date: Wed, 29 May 2024 11:14:27 +0300
Message-Id: <20240529081434.639519-27-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16054

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7bddccc9911cdff377e16b9a5a386721279b4438 upstream.

Commit c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
introduced support for setting GbEth features. With this the IP-specific
features update functions update the ndev->features individually.

Next commits add runtime PM support for the ravb driver. The runtime PM
implementation will enable/disable the IP clocks on
the ravb_open()/ravb_close() functions. Accessing the IP registers with
clocks disabled blocks the system.

The ravb_set_features() function could be executed when the Ethernet
interface is closed so we need to ensure we don't access IP registers while
the interface is down when runtime PM support will be in place.

For these, move the update of ndev->features to ravb_set_features(). In
this way we update the ndev->features only when the IP-specific features
set function returns success and we can avoid code duplication when
introducing runtime PM registers protection.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 6494f72ff79f..49607ab981ab 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2562,7 +2562,6 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
 			goto done;
 	}
 
-	ndev->features = features;
 done:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -2577,8 +2576,6 @@ static int ravb_set_features_rcar(struct net_device *ndev,
 	if (changed & NETIF_F_RXCSUM)
 		ravb_set_rx_csum(ndev, features & NETIF_F_RXCSUM);
 
-	ndev->features = features;
-
 	return 0;
 }
 
@@ -2587,8 +2584,15 @@ static int ravb_set_features(struct net_device *ndev,
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int ret;
+
+	ret = info->set_feature(ndev, features);
+	if (ret)
+		return ret;
 
-	return info->set_feature(ndev, features);
+	ndev->features = features;
+
+	return 0;
 }
 
 static const struct net_device_ops ravb_netdev_ops = {
-- 
2.39.2


