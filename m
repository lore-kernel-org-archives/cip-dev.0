Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0161DC25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:28 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.8736.1716970521772927696
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=k3Wu34Zm;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42120fc8cbfso11580935e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970520; x=1717575320; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSj9oYMXBLVUiXIDHIb/ZIKKGc+KUGEEzQtbT3H6vk4=;
        b=k3Wu34ZmbkV8jLHfBfGF9xSqudvvy9FLieVTq/dp9ab3PceoiLT6VvERbMVbxb2RkW
         7loBrKM9hQyA0A7KW0ycHt2TALCq60Q16C+ZKR8c1jXScaIJ7BFDyrqeetjHOG1+vgBv
         BzUTgxcKTr8MjsVGT9I0XUbG4djecIWL1KeKRVjlK75NqMNXHlkcz2qzlxUHGkXI4zNd
         m1YQ9KZdB4ewEyB4J+b6iFDPtEtwRe8fICMeUAuFiuFmuuRusE8Te3Xjuzz32CxeF1tm
         oNP9v9Pxe0M9BT29VI+Moe8aMgDau9sSFEQyBCtS5I2BYzR4L8sGFnWhkIwU3YpqLtzX
         BXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970520; x=1717575320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSj9oYMXBLVUiXIDHIb/ZIKKGc+KUGEEzQtbT3H6vk4=;
        b=vwtCLCeLhB1mXITv6CjXlYDvNWHDKNURCA1f6ZIpidgAlyhjMISl9zB+P08exAJmQE
         XAukz6zH/gDbhLdsGMYrTzMQjhz9TfQyCzFvAFY8gpck2GkJIGJB9FoDgpuBJoDPFkPN
         N1OCRG+kkCDn8v9ZSQAouyHlIGfVsVBu41Bxhbe+r+EnFm7L+uXzmuNgmb63B+WB/ljv
         4uRkBqWimZbqVOlje9xxgUWRCUAIslkOQIRkkk+a1ZXQZcOgEeN78I+sOmWt/59NRAXW
         UfJVzKQCM9xU7or05OXjWWqCioVNuv1RSYSCEaB/cy58U1rmt8tn6Cgcc5DlV6Jt0HJ0
         o23A==
X-Gm-Message-State: AOJu0YxKIvPxVQbijaXu6efBuCoH8TSJqDInCV9LTeCrwH1v3fXY0qxf
	xuPLMvVb3o8yz1ikwlnzmq2DWaiuhOEKNiyr0WawZxgrohk8BTYBDCKbLgQ6Ozw=
X-Google-Smtp-Source: AGHT+IFCBgI8VbNV0TOsiG1tnWI165e/LutZDX4QsGTQh1ks3lHDlUAY7hcoutbkgUTM4Ok7mxWQjQ==
X-Received: by 2002:a05:600c:6b1a:b0:418:ed23:a9f0 with SMTP id 5b1f17b1804b1-421089dc44cmr111110385e9.18.1716970520332;
        Wed, 29 May 2024 01:15:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:19 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 27/33] net: ravb: Do not apply features to hardware if the interface is down
Date: Wed, 29 May 2024 11:14:28 +0300
Message-Id: <20240529081434.639519-28-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16055

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
index 49607ab981ab..a9adf5f67d8b 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2584,9 +2584,18 @@ static int ravb_set_features(struct net_device *ndev,
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


