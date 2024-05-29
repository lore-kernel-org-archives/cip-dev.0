Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DD9C25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:06 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.8639.1716970259266039354
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:10:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=axpjIn4E;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.175, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso24531591fa.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970257; x=1717575057; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOLHZx555kbJ+Nz+oy4ud3S/v5u8QAeS8Cx1sKq0Hlw=;
        b=axpjIn4E4VPSWo6eYcwYd4WOdmDyTCLSlVJoBuWf3v5V3FrxwsgcOMli9nOqvxz3bu
         jeaVmh6Pm100a2yu/KO03p17rJWFFzhXJ4T9OjSGZtYT13WTf89jS57x2z/hOWaHnhpT
         MOKcRqhZYFZli+5WTAFL9afjGoukE1zSlvSFIokh/fqQm4Ht92uFlJUQ50goPr9I6FFS
         In/95owFLd4dZAjHYGml2c256xkWQgGTre05PC2JQMzfb00/gic9xdmnnc5shYW8LJOf
         OWxJoF3t5y6LJ57yk9cZMJde8QBs/bhn/wofvcmPFVJBqiRJPf8qn3BgonDB3PA6gRmV
         dffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970257; x=1717575057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOLHZx555kbJ+Nz+oy4ud3S/v5u8QAeS8Cx1sKq0Hlw=;
        b=Qnx/wj2hqF679QqoX9WJOk5QwRum40ARAH6XJ2q8L9zsjaCQtui2juGD8MD69TpU9/
         E98di7+OMwl7IuCrBI/33w5kxT8iYh85Y7TU0xHh94F94ASV0qaGiqqYybW6arHEOTvN
         n44uHg/hFW4hL+fWZsmp8xvuOg3XHQzes6CtqtzqJqbbeYt2gLx2oI3xVmjSl00PNK3B
         57uqxh6I73Uw0CcRYqTIXJSCA8qq1sPjQvYRY/yJDongYgWv6M8q28cmOxrjQiSxrQw6
         OltfOPh44WHGqv1gEcp+9o9/8y1JsIQmlItNPn8LdaGRCjbCID6sBS/osM0vTdgs6DG/
         YWhQ==
X-Gm-Message-State: AOJu0YybdwOmg5N7OYKUYaM18LohrMe7J6tR9IEY1FtETdipTHk+Hsqe
	nDUicphkDy0kuSOiCi+xftCRgVejqOwYyGCofDNbrniTuO81bpwyX+s5/GheMAs=
X-Google-Smtp-Source: AGHT+IGQp4kjwwbMdyMLJmU+bgeZS8bmDl6G8O/qottjaiZM82msMmjwujbhw5INAk330Z0wO6OYrg==
X-Received: by 2002:a2e:961a:0:b0:2e5:6957:187a with SMTP id 38308e7fff4ca-2e95b041638mr112052231fa.4.1716970257536;
        Wed, 29 May 2024 01:10:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:56 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 10/47] net: ravb: Check return value of reset_control_deassert()
Date: Wed, 29 May 2024 11:10:02 +0300
Message-Id: <20240529081039.639010-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15990

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d8eb6ea4b302e7ff78535c205510e359ac10a0bd upstream.

reset_control_deassert() could return an error. Some devices cannot work
if reset signal de-assert operation fails. To avoid this check the return
code of reset_control_deassert() in ravb_probe() and take proper action.

Along with it, the free_netdev() call from the error path was moved after
reset_control_assert() on its own label (out_free_netdev) to free
netdev in case reset_control_deassert() fails.

Fixes: 0d13a1a464a0 ("ravb: Add reset support")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c15a4d56e79f..ef7ab9a3ff29 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2666,7 +2666,10 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 
-	reset_control_deassert(rstc);
+	error = reset_control_deassert(rstc);
+	if (error)
+		goto out_free_netdev;
+
 	pm_runtime_enable(&pdev->dev);
 	error = pm_runtime_resume_and_get(&pdev->dev);
 	if (error < 0)
@@ -2895,12 +2898,12 @@ static int ravb_probe(struct platform_device *pdev)
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
-	free_netdev(ndev);
-
 	pm_runtime_put(&pdev->dev);
 out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(rstc);
+out_free_netdev:
+	free_netdev(ndev);
 	return error;
 }
 
-- 
2.39.2


