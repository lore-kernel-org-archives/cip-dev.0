Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C316C3ABAC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:37 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.20335.1745934455276935008
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bFVbGNj0;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac339f53df9so1160893566b.1
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934454; x=1746539254; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yamUPL1mYnb0zkVwBYojz97fLGYy2NeuXvu2g9jYV7c=;
        b=bFVbGNj0nRdNYlZZ1VrRS6g+lkDndkTvhv/2oZ0CbLNbAjLyhky6uyIipS8csOcRek
         VlT9F1RDryFI6KB9kfctuJ8q8VvvbMGGggXx/Hw+AGFVK51MCYVbMTuEa1ZAA+xioJGA
         Nlw6oodYAGc1FgQBcHxMIv2GZJa0ZtAwqT6tecIkjswApPzdCHGzrazkI78fPhqkHbTI
         yFMkYffVd8cb0+Xc+mehzEfr1jy7WsMORXrsiYis7zd01RuBVj0L05EkBTVauzCiFqc3
         tIWux51DxJ07y6bwPQFrguix890ani1524yDuEHoEF7aNuc/cSJO/lBSDjLLVF+87Mmw
         FjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934454; x=1746539254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yamUPL1mYnb0zkVwBYojz97fLGYy2NeuXvu2g9jYV7c=;
        b=rBEdUPPZP4vmDVNWBywU6DqhL9p9FsvJhn78aBLHAwbpzjaituEc+cjh41XPILJ/hm
         CmoQiqIKezPXIUAWdUlBQOM5ciphB3mYlbhQA0t3is/8i6+yaeFG0tTu7GX7LmPxUTpd
         HTtu3zEq2ggf18iXRFEiqho4ktUjJrr9k2ryT8Pkbq7vBKgqwwZ8c7I3eIwW7mkzMXzg
         BQA4bqVKL0SNMtVt9Bb6GgNdpzAjbtqyYNG6djStzgmJxGWXNKIKJkHjdVlaECTEHTUg
         +5MCCd0pmSW1hV5+t9MsbdVykMptw9Ki7ATLpEvNCjwsK7eiWnfKdQl0QBf0JYqDxAAr
         wRhw==
X-Forwarded-Encrypted: i=1; AJvYcCVLpbtr5mGgRMTj44v41/tIyGWIT00KDP8z+9DtkC3Tlc/bs7IAtQVa3cVY3kbq9/SlsLAmFjeA@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw7VkpWQUANSg+GgY1YUrMgA1bUJ93S4c1uIGd+oR22U0PxEGK4
	20yNXg3iKAd8G/f8kYvMG8Mik+Nn88uJon02q8+iEZKSJvQu8JeHYD9k5a4NzjDXUeASyxzx6ld
	D
X-Gm-Gg: ASbGncvLmkP2pIkWMYFQZSNaKAtn33+DZStcZpkPHLvI4c0UzLjcVSBZh52ahzbMu7u
	enGwIyBAT8BLG1xb/bFW10MmITwTmNpjQstIJa2olSYwQ4nflMMsW7VF5F8JDkZ0KX5r1hMVxXp
	hIC13WnIfUSbeoWZ3R8zwjNgpmzzp7KIwTTHzGS/Ug1JgjTe//oSCLwW++QL3J5oqqKlaSmSIq2
	cNlqoN3JyraXGlOz5wDgGOZwo/9hTLRdn9MODyRmUlt7xesRsCjrPP2BGEb8TUeU5ib5tBpj90G
	JrwnhqPacer87kxStxmu97ZreTExdi1Zm0T8LkQI7c0+/Csx5odCpktbYHImhi8VBzP/bIA=
X-Google-Smtp-Source: AGHT+IHTd7Q/HZKsvFKh6hldJRP21JQp56BDPcwxwBlArakoKYpnuc/dZzSSloiwLuEfop/qMO8+AA==
X-Received: by 2002:a17:907:97c4:b0:ab7:1012:3ccb with SMTP id a640c23a62f3a-ace848f77e1mr1253283166b.14.1745934453695;
        Tue, 29 Apr 2025 06:47:33 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 02/21] i2c: move drivers from strlcpy to strscpy
Date: Tue, 29 Apr 2025 16:47:08 +0300
Message-ID: <20250429134727.2429662-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18715

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit ea1558ce149d286eaf2c0800a93b7efa2adda094 upstream.

Follow the advice of the below link and prefer 'strscpy'. Conversion is
easy because no driver used the return value and has been done with a
simple sed invocation.

Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
[claudiu.beznea: kept only the i2c-riic driver]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 45ea33e1538c..efa1655da7d6 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -448,7 +448,7 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 	adap = &riic->adapter;
 	i2c_set_adapdata(adap, riic);
-	strlcpy(adap->name, "Renesas RIIC adapter", sizeof(adap->name));
+	strscpy(adap->name, "Renesas RIIC adapter", sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->algo = &riic_algo;
 	adap->dev.parent = &pdev->dev;
-- 
2.43.0


