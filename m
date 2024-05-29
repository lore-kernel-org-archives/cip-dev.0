Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8BEC25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:16 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.8644.1716970274489228161
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Ygt+0/Tc;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42120fc8d1dso12651865e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970273; x=1717575073; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObUMt87zR5wNoXAOudqiZOvZcx8Oy7K4WW+L5RX9pUA=;
        b=Ygt+0/Tc0usfYHS1QcKFHPLAZCiGI9Fgr36AZKkAUYNXnEmt2u0anulNuGTPq6Sjhk
         lpfdg2f1BE4E8ys8bY86yFI0FckzXt5dJB2qamYDW9iaRAAk286gUPhG/4Fgq0ZCcxTn
         hPB16Sbq8QszfzmHVxKGtRzImM4YmLkWtreW795Y/QznrcEr6q5oiRu2wjEUsdceHfbr
         8ysCUFWhf5XiURfI8gwKh71z3j7SdrGpA9EF1b2T1EkKNVSkVOLfuSXtgljFTRa9Xdym
         fOeUnE9E6cEMmOIcza2CSvJgNum4H+WzJTcYALqRB3VfyGqq642iP9mOKTlg43YtdBT+
         f2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970273; x=1717575073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObUMt87zR5wNoXAOudqiZOvZcx8Oy7K4WW+L5RX9pUA=;
        b=fPFLD7s0J0yD9W8Nj/DYKRqLhi5HnEhYWwNJ99BD6GR9uLhzsHOZzPDz8HoQSuOo/3
         EvqOrnkjS1kJtMWwXyNt5v9qy9CpqpHaNS7xthOuyNirLdCnysjcmWCuOI0xmrvJ4ikl
         ASc94NgxWLbDLYiaFbZM5RZnu0JfN2JkAoE4nx/nwrqFWMXFOuXsIf0MiLTipOjPE0kp
         cIzeb3mY/sPj3EGmt7deV7NJrlKSldGsVOhVRnaMVkjQfTHvmuStH5A4wDXzjjHTP+4V
         zm0z2kRNfOOKSluS8RcwOV+Ozajul1FqN/luYFoQuhSDdDUz8vTV13C5jT2ELFA8j5aw
         qvlQ==
X-Gm-Message-State: AOJu0Yxon9AuAnvPylHTEdutHTgr+TFLQdFG9dKPPf1RgonKpAursS8B
	nv+st9mDhVxsJk3sDbxho/KmVwIbI0FC3DDAVix881FYCwO92WD5gjBArSlRBHE=
X-Google-Smtp-Source: AGHT+IEnDzVZYXNAbrPDMRBTvZl8c2gqNlB4BNYjqI4j0z2vI6YQtskEUFnveo8kKvZPCyMft0KqhA==
X-Received: by 2002:a05:600c:45d4:b0:41c:ab7:fa0f with SMTP id 5b1f17b1804b1-42108aba51fmr113675795e9.34.1716970272967;
        Wed, 29 May 2024 01:11:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 18/47] ravb: Use GFP_KERNEL instead of GFP_ATOMIC when possible
Date: Wed, 29 May 2024 11:10:10 +0300
Message-Id: <20240529081039.639010-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15998

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 91398a960edf50d27206d808182e3357f9f5c668 upstream.

'max_rx_len' can be up to GBETH_RX_BUFF_MAX (i.e. 8192) (see
'gbeth_hw_info').
The default value of 'num_rx_ring' can be BE_RX_RING_SIZE (i.e. 1024).

So this loop can allocate 8 Mo of memory.

Previous memory allocations in this function already use GFP_KERNEL, so
use __netdev_alloc_skb() and an explicit GFP_KERNEL instead of a
implicit GFP_ATOMIC.

This gives more opportunities of successful allocation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0c803f697825..ed19026e0976 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -482,7 +482,7 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 		goto error;
 
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		skb = netdev_alloc_skb(ndev, info->max_rx_len);
+		skb = __netdev_alloc_skb(ndev, info->max_rx_len, GFP_KERNEL);
 		if (!skb)
 			goto error;
 		ravb_set_buffer_align(skb);
-- 
2.39.2


