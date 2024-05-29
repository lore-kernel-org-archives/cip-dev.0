Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B6AC25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:57 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.8595.1716970307533068527
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=HjboJI4H;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ae38957e8so419012e87.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970306; x=1717575106; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRspZq/JdEPxTwBOFKReBYsJHFQhHEPH8GqLa6asvI0=;
        b=HjboJI4Hp0rXRlFUZo8hnjvM3qvfKYLBXaJfQjuUBFpEg6O1aOQOR5gIUhaSyeEMZP
         nm7H+ZPwxBbo0Zf8je3QK2vzhhGJSMSVeOIkd+Fvo2tNG15JEvV1FjlC8GWSRgHYOO9G
         DFm+exWHOIR0eTZt/RceBXJ84i1tOynWe2I3FjGW3tWKpipMX4jWVpZRTM23TxdOcFqz
         9Di5x2FYFHdEwKzGXSkk5NfJO1AjpxY+HZV86fmuo+inXP69hkMfHORMT5OHDTM5+cx/
         RNcWziJ84vckZuHZEcE9/Pam9zv8lU5IV0VZGiU92at49rFuFQBOSKWFgvPkwGTKRu7i
         CcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970306; x=1717575106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRspZq/JdEPxTwBOFKReBYsJHFQhHEPH8GqLa6asvI0=;
        b=XhXu1/H0pq2DUN1tI6csaaJfVu/YJXXzXMf6n8ffr8+xWWTS4w/emVpnG1FJHpLQnK
         gpqYi9F2Hs0/xbB1835zVFAobyUpEALHZ3ClFdDXki+xBwCc3hIQNemtS4Li7hoSWEqj
         NzdPMOOf1E8rI1urBgIggC+lPDPp9RmqqX5tVeIeDpZljNwLtpdNMppAXI31hqDvzSjE
         Im45TaTcRXNDsk21AU0dnjfsE27k9xfJX5qg3Ot5I6AD0YQXlzErhZ1Ml8A5sq92Wm2C
         BwTGHjIiVBCZ7oEbfRpj8eBPjE3P/efiIeLkvQGgxtK4jhtA5a0oIQKCi+vx1zwl8TUG
         It5A==
X-Gm-Message-State: AOJu0YxY7mpT04rMeQANMYoJ+OAwLt9Khbe5dJU3eZN9BNwrH/TIdQws
	64T8wCxEusJwc3eK5citDjgoyJkET43pul4bCdAwlj9NADVySz1H74HgiKP8oozyUJ6jc0iRQlc
	zSzw=
X-Google-Smtp-Source: AGHT+IEk2DMfEMBMUm4E/miOhSIIl4X7BS1EItNcD3dvw2AlqQNoyZa6ketAdGyVWAfF5O5L9OmViQ==
X-Received: by 2002:a05:6512:544:b0:529:b632:ae4e with SMTP id 2adb3069b0e04-529b632af8bmr3392493e87.2.1716970305684;
        Wed, 29 May 2024 01:11:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 39/47] net: ravb: Do not apply features to hardware if the interface is down
Date: Wed, 29 May 2024 11:10:31 +0300
Message-Id: <20240529081039.639010-40-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16019

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a71a50e391bf00fdc88bb13a867620c59ad744da upstream.

Do not apply features to hardware if the interface is down. In case runtime
PM is enabled, and while the interface is down, the IP will be in reset
mode (as for some platforms disabling the clocks will switch the IP to
reset mode, which will lead to losing register contents) and applying
settings in reset mode is not an option. Instead, cache the features and
apply them in ravb_open() through ravb_emac_init().

To avoid accessing the hardware while the interface is down
pm_runtime_active() check was introduced. Along with it the device runtime
PM usage counter has been incremented to avoid disabling the device clocks
while the check is in progress (if any).

Commit prepares for the addition of runtime PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 2324b2dd59a5..a9046c620808 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2578,9 +2578,18 @@ static int ravb_set_features(struct net_device *ndev,
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = &priv->pdev->dev;
 	int ret;
 
-	ret = info->set_feature(ndev, features);
+	pm_runtime_get_noresume(dev);
+
+	if (pm_runtime_active(dev))
+		ret = info->set_feature(ndev, features);
+	else
+		ret = 0;
+
+	pm_runtime_put_noidle(dev);
+
 	if (ret)
 		return ret;
 
-- 
2.39.2


