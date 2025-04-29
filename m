Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFCBC3ABAB
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:37 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web10.20294.1745934453206946412
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=cEWYp8CW;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so10495450a12.3
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934451; x=1746539251; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Aooz71updk3uskflDW3rkicD9BjwvZEZWvnjEoP1n4=;
        b=cEWYp8CWjAqFPeE05RJZQeJgDA9oYEZSb5TRwIr1qxAxsm7qZ/wnc5A0myOlLNdl9A
         1Fymdoc70z//ee+sMYUlcsoul0t1uuirexpQiaNTzQaTIpRo9r8ELz0S9lZbRX2+bK/d
         LEdFe/2SvskJJxqATgddlndEUx0WGuWKsyFOJgeObo71ylqlj603H9O1z8nrEvNLe4xB
         wXmwwmlBNtwZlMkOiVVhCac0hjMgT+xa8d26MBcCCAyntXocVD6NNib58WlRJ0+zqqtt
         VWJUTwLavKrtkpGCVhaTnKA4Lh+GQVZOtlMwO1BLzqQmwjWB0antfBl4yTuzc9Ae0wCF
         cxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934451; x=1746539251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Aooz71updk3uskflDW3rkicD9BjwvZEZWvnjEoP1n4=;
        b=hbt8nGqhaz4UUug8u+qWIgOvxhnxPuDOP6i6IHADoMKFkYiwfjJu29p4/C+5QuUU2o
         9whdPff28VB/qTEA+LcsDwHGTTDyhGiulPW4v7ibcMQQGehIuKTu2f7fdbpvxOz3HEM2
         Eq2yYLxtV9kh5HodjFjqPWZd8B9fuDk91hCvwxEu3mnWBGiXiyBQYGtXXBDK/Fc+3N5+
         kXA1klZQ/Yn/LPVnQPQyIUroSHsUoUkfQ0OCJOmkv6fWvRVovXOnvH3AvLNvSBz5FnpE
         bAvrK2IM96WpniL5LC/2yFETi2SBDHrHdZBB0JRzryig6lQ84D1MsQ95Q7sU0lj0ZYiH
         p0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWta4YlzGpFZiTIb3l9hpLWKP8PbY5tUESXxO7rOgqiZo2FbeiYAWU65WtRHOsIg9I+3D2eYEb/@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzu6b6U5OziLAEaYGUNVpCX7hD9a5VR1wKb3npy2YWowIvp5IN4
	6z7D+VYzKSs7ES1BULKEULlyeteCoK0/+KzekCnOBpcTrwssfscYCZftP1KgDJw=
X-Gm-Gg: ASbGncscxR3MTa+O27bGo4AUnhCt+qRywCH+pIcxpPvqMKxZ29MdQu0YRwyLg5Q1qxM
	NPr5HZszhK8XeQrt0etAVzdEu3FGhYtIHB2nfuzDIECrRvfGrjkO1J+q5XJygpYc4QcvLH/HiuG
	YGoGOGELEGfO2nOtxPX7BzmLC3B18gakU+wSds0PTbBcCBcOGPKJIIpgvMd9zzc/fK8aWkaEpxh
	DtvqMGDHP8IXj8UY0LQCYtO9bGYd4gimQuWYuamp9/i5x/EpZ5NSicS09YRjxeVe8WKxGi6sqVh
	1LCtBpba83H2AvNUpnnmHCROgeYERtuV5JGDoBF8tg+g+lYg7d12e4aYmdr4i2yh5XHAc0w=
X-Google-Smtp-Source: AGHT+IFEMBgBUw2EVpRr7DIirJbKIggVrJVyGpVXTRj5NR3jDT8iRPuuWE9trcjSmedsBoQ+tZLI5g==
X-Received: by 2002:a17:907:60d0:b0:acb:6ec0:12ec with SMTP id a640c23a62f3a-acec4ce14a0mr380597366b.35.1745934451232;
        Tue, 29 Apr 2025 06:47:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 01/21] i2c: riic: Use platform_get_irq() to get the interrupt
Date: Tue, 29 Apr 2025 16:47:07 +0300
Message-ID: <20250429134727.2429662-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18714

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8ab1ff9b1ec819bf431cf6c370ba3d9f8c8a108b upstream.

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index b4365edc7e24..45ea33e1538c 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -434,12 +434,12 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(riic_irqs); i++) {
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, riic_irqs[i].res_num);
-		if (!res)
-			return -ENODEV;
+		ret = platform_get_irq(pdev, riic_irqs[i].res_num);
+		if (ret < 0)
+			return ret;
 
-		ret = devm_request_irq(&pdev->dev, res->start, riic_irqs[i].isr,
-					0, riic_irqs[i].name, riic);
+		ret = devm_request_irq(&pdev->dev, ret, riic_irqs[i].isr,
+				       0, riic_irqs[i].name, riic);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request irq %s\n", riic_irqs[i].name);
 			return ret;
-- 
2.43.0


