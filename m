Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAABC25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:10:56 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web11.8566.1716970255417657808
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:10:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TNvXHSt9;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.175, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so17679161fa.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970253; x=1717575053; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPqKikLqckUS0vslC+LtQNcecFHVGqqKyf+de1iE5Ns=;
        b=TNvXHSt9Cc5+uqXfOry4yTLkpoKJfUnFNrWLy2a3Np6JwLBjabAChQRWVR7aatJmgo
         ipY+P2JjMo623HFBPAaJk7ApZhOsIjGoHGLs1QpJDhuAtTKmKupHtTlT2nHNh6WymmZh
         98a3+MtPca2dXdMhFW/FLSkrLGmDAmQE95G5aLcvzPnMK9QWWgTf+6oo9WHytOPa+0kW
         bcY/QxJHS41sj71HBr7fNZ7AoJhGICNk8jzDrCstIckKfhcTQJaSVEsGYCXXQoZbeY0d
         MIpd5+cAzoqR9LEo3c75A07G4vscvLALXadGSg/oN+YQclPxGD+S9T0V/fD6Wm3uxhvZ
         jplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970253; x=1717575053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPqKikLqckUS0vslC+LtQNcecFHVGqqKyf+de1iE5Ns=;
        b=bemALVS/P34gqw+Uw27Awn74quo8U11bb5FLj/FR7ry1dbl6WPz7S74aGiprK06CP1
         zwohoYguhoDNE9DKFZ6LR/SX6Q4X9nz4ig3+zztTjDVy5zpa33PzVVMbyOsY/u2pdkwx
         sEwfbNJayaCbEYaJizNVIraBoV6QeTT41hwhfqtZ4JPNo24fMjRT6G4g58EWaN5lGZqM
         +uK156J0EjzZzcgieUL2I0sTRdJcW+gjJJ2JFkm1JZp4ivBbYwVA14rDINND2/Rzuypj
         xRjomyrNuqagCXzQRDUFz0dNrhWtKOhGOOjQ5C5SE4loQlFNZzFSEhnitwpqKxteSY/J
         bA+Q==
X-Gm-Message-State: AOJu0Yy4QqhWAkiprwYksfmVgcBanqmdokHJpd0BMjOx/7milBIXVYZV
	6heJx26Xqb9uqp0jsSZ4xjEyIA6lZl8Vg4nUksJwfvF9r+AQVq68rjtLSzM7aI4=
X-Google-Smtp-Source: AGHT+IE/O1iGSmFEHPDVx7xjKkOhajYODaZPUGoZlGVyMQQwqDHqZw4RaEgOaQIoBXs9hE4RsqrIag==
X-Received: by 2002:a2e:b385:0:b0:2da:736d:3cf5 with SMTP id 38308e7fff4ca-2e95b24c909mr81808801fa.41.1716970253441;
        Wed, 29 May 2024 01:10:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 08/47] ravb: Fix potential use-after-free in ravb_rx_gbeth()
Date: Wed, 29 May 2024 11:10:00 +0300
Message-Id: <20240529081039.639010-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:10:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15988

From: YueHaibing <yuehaibing@huawei.com>

commit 5a5a3e564de6a8db987410c5c2f4748d50ea82b8 upstream.

The skb is delivered to napi_gro_receive() which may free it, after calling this,
dereferencing skb may trigger use-after-free.

Fixes: 1c59eb678cbd ("ravb: Fillup ravb_rx_gbeth() stub")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20221203092941.10880-1-yuehaibing@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index fd1c5ee676b7..23fb75b9ee0d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -838,7 +838,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
 				stats->rx_packets++;
-				stats->rx_bytes += priv->rx_1st_skb->len;
+				stats->rx_bytes += pkt_len;
 				break;
 			}
 		}
-- 
2.39.2


