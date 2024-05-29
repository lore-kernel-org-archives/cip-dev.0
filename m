Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C4BC41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:57 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.8663.1716970310138043340
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CRY1A7zj;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-420180b58c5so15372315e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970308; x=1717575108; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CwGr6rnBIE2IFHlR+9EPUlW4SlprjFgG9VZqkhi/7w=;
        b=CRY1A7zj7xJSsq+lsMwOH2WHQ+cbzWqshWEz1NSzQSjDH37fNOUG9KlOnUULbdrqLF
         mlTkrO2QEa5eiBnWaGF5QcUiD+d/oqVOkcTJKZ4kDDm41dmRBZuGrFHFNFCbTPfIMBeS
         EpmO06V9//gzYb0/67Th0Xb0KVrfWpuuYuSJ5FabjqMktrKJy09eOJFnYUkAbAr+oEoD
         e3AZBES3RQ0QBiC29FWDmhjDOW+wBbG+PwVng7zklTvUUQydJKCWKVZSCrG/n6lie16z
         npfawylBAPXw2p/W+HoqpMC9XQm5AmK337eoyQX1PkdXph4i57EgrRiQ2fp0GK7V78xA
         9XtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970308; x=1717575108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CwGr6rnBIE2IFHlR+9EPUlW4SlprjFgG9VZqkhi/7w=;
        b=mUEoXgnqDUELZU2O0kx9GcB5N3uYXawY6vFFRyYK38e+1WJmprffXkMAYKtXgFtLff
         /O9xCsDI9sMwpeN8WUBk55M+ypSiVTW7QqY3zkEojwZSWzxXXvmacBSAzyM4hl4Pu9gQ
         YfNkkWJI0oFcJT8QIdQ2OLYoC6AadP273EVoqUB//gREP5Zqor5+Q/A41Wqcn2a+cXwI
         PUUo9LBuALnKsdbR4RfQw9kCHzAjXKotkTwYpP7mpDYXKkEgnchqw/lGzGKjnlT24Vdg
         khCAZEIGyGxnMdzmiHEfsXaW8jHgGQkVSEixT7SghC0u7TGw8/kkmu7MXOH4g1LAMAeL
         gvCQ==
X-Gm-Message-State: AOJu0Yz79W30pF16svcYDtramQYcifZqiUddHK0iA9ZKCTTCPj3PUnCv
	4ThoEDwl9nx4zy5XoDjLHgGV+dOVoU+37k4rz/I2bG3yTnopaBLS+2W+jgXJI/I=
X-Google-Smtp-Source: AGHT+IFEjCEF2ynlYQE3YiedInL7/nZeBEUyP8bwuMjdx9eHHbNvpy+VVqJ6CnLAjk9lxgeJwHrSRw==
X-Received: by 2002:a05:600c:4506:b0:421:205f:52de with SMTP id 5b1f17b1804b1-421205f543bmr31658585e9.26.1716970308629;
        Wed, 29 May 2024 01:11:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 41/47] net: ravb: Fix GbEth jumbo packet RX checksum handling
Date: Wed, 29 May 2024 11:10:33 +0300
Message-Id: <20240529081039.639010-42-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16021

From: Paul Barker <paul.barker.ct@bp.renesas.com>

commit c7c449502b51c5b5de79f97a42be750b28f6ecee upstream.

Sending a 7kB ping packet to the RZ/G2L in v6.9-rc2 causes the following
backtrace:

	WARNING: CPU: 0 PID: 0 at include/linux/skbuff.h:3127 skb_trim+0x30/0x38
	Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
	pc : skb_trim+0x30/0x38
	lr : ravb_rx_csum_gbeth+0x40/0x90
	Call trace:
	 skb_trim+0x30/0x38
	 ravb_rx_gbeth+0x56c/0x5cc
	 ravb_poll+0xa0/0x204
	 __napi_poll+0x38/0x17c

This is caused by ravb_rx_gbeth() calling ravb_rx_csum_gbeth() with the
wrong skb for a packet which spans multiple descriptors. To fix this,
use the correct skb.

Fixes: c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a64a8ea84c57..fb0fc86a2239 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -889,7 +889,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				priv->rx_1st_skb->protocol =
 					eth_type_trans(priv->rx_1st_skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
-					ravb_rx_csum_gbeth(skb);
+					ravb_rx_csum_gbeth(priv->rx_1st_skb);
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
 				rx_packets++;
-- 
2.39.2


