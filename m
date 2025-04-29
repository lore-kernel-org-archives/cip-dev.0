Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73863C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:37 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.20336.1745934456624159367
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XD4ucarG;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac34257295dso1024234866b.2
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934455; x=1746539255; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA9R1ldJtQHSHc6sx5NCXw/2aHm97A7KonFj+C4dW98=;
        b=XD4ucarGiZ+IfSKxiefR9yAYGlkmS50E1U9O+6E+rl9TLnrXbn2X/s6SUBAKMjRyaO
         3633oagkSSbH1eprat0yqzC1HwLaV9aqyT8ySY631tCd5q07fI4YwHFcy0ayphapg95H
         EYMq5/DlHUzwxnUWLjwLgpfYAHvvDSPIOnIo4P0wa8R/8UXmGVcyGCZLWhIWTnJh2O0u
         Dw6giftJGyxcVqgPFtNo1dsKsb452sifjwbPqfU5qLX31wNO/w6XvqU8zf0Lg7UbRskm
         TaVPiM86u6MK6wa29RA0LlWol4RuuNITLlcZgUGEOZsGGFNzl/WW2QbRuichcuJIqNF2
         YBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934455; x=1746539255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA9R1ldJtQHSHc6sx5NCXw/2aHm97A7KonFj+C4dW98=;
        b=dyEUM8seWF/G8jTuXdmdztwpfQpwwMFJ/svjKbxiT4EXFBGyxnaHtMrXgBwJE/OIMC
         F50EdFhs+jeYao5Y022ngaNGzALLU1Fg/+2pXPSm0grOpSrev76s31MmiDiqvH0voJOL
         wgTF5ZswQjC245Sq1AKpLKPcqeKwO0nzsrxx955kmtcWGD8gLlN73aMnt2SKAW2DTlwP
         XFawugu3tk39REa4EWcvcJ2XJ5/+CyVX0ptFSOPEPcLcBsyEozGvhojL2FySHXtmrGSG
         mQ2HNDYRyduYaCIelBMOc2Squ9jdZMK4OpHXuBi6K2Fn+OD49eEe52JPksl7BkeLQ2Zs
         vjAg==
X-Forwarded-Encrypted: i=1; AJvYcCW8GVbbRzT+rEcHk8zz4U5LaLJc6WXw1K06Xu2qQ6mTpGp1sfSmyU1VuAflJH5U2ODyshNBtIiL@lists.cip-project.org
X-Gm-Message-State: AOJu0YznlCv7S51MMK9t77fY1YT39VPDO51pldQAQPbdOiCq1xmcRf4H
	hOciLG9pybuNTS2C11GIJnapNwvn2RyrHnqpKXO8vQK1a8+ECnz1c5bM9oQf0RgFIV8JPrpCt1b
	+
X-Gm-Gg: ASbGncvt+dTrZfBseqPWQ87zS3mcV9R6DofF8xrKz8nVzKwE9mUPo/eql1B5dYyW6CN
	8nYPNKnCeRUA0fJNyp2Ib3vE8n/Dhe57NG5klHQWQTgbq3Cn55c9dQuVx9sNBlvQ/sPODyalSOU
	fbJ/wVVCgHfea22ZSmeZy0QafdGDfVqHj1yz+/FISBaQ8953aJjaSud/j5ZzV2x4i8MX/2AfbO8
	TP4ZfonAnGtVHzQgGjONLF45xKjVpKZSBW/WY5zQYLiYJ7xmgwIFmWjuKsdLWLzWsUjTW2KnJ5o
	NhaZem7Sw2DBtg/IkeQ5+vDPDLNUX4gIvv5bKDBw1p8TMC1NN5PKbclEnnoxjezscfnf6vc=
X-Google-Smtp-Source: AGHT+IGB9+CgwY2FjXgKuX8s91rOEqwhJZ4Q09HBmUYiVn+PSVVdowoeT78S3zslw3F3VaOgyDgDZw==
X-Received: by 2002:a17:907:72cf:b0:ac7:2f8b:6844 with SMTP id a640c23a62f3a-acec4e05972mr369204266b.23.1745934454920;
        Tue, 29 Apr 2025 06:47:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 03/21] i2c: riic: Use devm_platform_ioremap_resource()
Date: Tue, 29 Apr 2025 16:47:09 +0300
Message-ID: <20250429134727.2429662-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18716

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit e05e47088ef12ce69b5c40605e95d01c11807a22 upstream.

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index efa1655da7d6..6f8ce656183c 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -400,7 +400,6 @@ static int riic_i2c_probe(struct platform_device *pdev)
 {
 	struct riic_dev *riic;
 	struct i2c_adapter *adap;
-	struct resource *res;
 	struct i2c_timings i2c_t;
 	struct reset_control *rstc;
 	int i, ret;
@@ -409,8 +408,7 @@ static int riic_i2c_probe(struct platform_device *pdev)
 	if (!riic)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	riic->base = devm_ioremap_resource(&pdev->dev, res);
+	riic->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(riic->base))
 		return PTR_ERR(riic->base);
 
-- 
2.43.0


