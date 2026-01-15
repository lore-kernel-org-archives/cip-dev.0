Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F152ED33A3C
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:21 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31329.1768466179447397219
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ELpj3Fej;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso850888a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466178; x=1769070978; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVq91KWNFTNbXoD+ksXzxIHQB6mSL5DlFXOK3kG3OWE=;
        b=ELpj3Fej67UbtSOeatqrSldT0md2K5GXjAD7N0PwF5wKo53NWjtiZF/gD+xGAr3iWe
         TJl9jfEGOAleaee9ktzUw71efQ7xcq9+sV1XnCdqfasNGlRqKRzulBS/TY8loIdvrDRJ
         DzNXVR5n7AMNyCUuDQfAzXpgmbZ1K+DCTWZNsgp0EFzz5sz6Ytp+t3GHfbBWMQVW1cVI
         9+C30LT3WaqAtbncgxLoTB+D+rVVBDw2raP5fBCQvJBNzmuctDgDyO4qXeMPk8Nx05xU
         HL0gjnPmooUNy2w7sERaefz1XX8z6SzxdsVT2R17x0FGjqUzL1AAXaiPkI60uVFac2Mm
         xpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466178; x=1769070978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UVq91KWNFTNbXoD+ksXzxIHQB6mSL5DlFXOK3kG3OWE=;
        b=n/Q+xAimUBYZZYBzR9cu04cxqXXCH2w212ALVg9XuAP6XPtlGpjmDQa/Cb9p/pSqhB
         JSJ1EbZeyuzhUVcVMMupGRf9692hG3h0QlNfTps49bVl9OEWwpbNabu/Hs1EhbRWfatx
         L/7+gkxlbtRlnPxagA+upbtoW7Y41YcWC7CHUtdxO9rjuwPnAMhzYwGAuuxoMPtU51c2
         XZo3XCCUNVhOZXxZ0Qkd+BPmkl1YbK33V5MlQVWW/OPTNGP4sIF1BTwxEroszdeArHu5
         m8nPPmWfuhPemHB8gu3g1dpu4tuyEybOO/ztgThMUG9nY2r5Ma8Pu3dybIoYe47VZRgy
         VEMg==
X-Gm-Message-State: AOJu0YxQaTZa2FCWTRSAhEChKT5RC4LGVcuF1I1F0YtfvUkvFdFN1lth
	SONpfsctvs2plydLrtLKYoPLRY2HSmB348ZpuJuaPpJ8oGdwet3jq3bz03aA4B3rx/Q=
X-Gm-Gg: AY/fxX4BlAkigqq+qadxw8lhoW3AivN1U6jCfN6KXGc4GlFi8BRf08COvlh2kDTYDVQ
	WLh+mnoqsgQfLSSFHY7DbFxzfacEoD+dNS+1ihVsGXppY4ybEukUm81fhfsIPS+9UYLUiLxv2Ko
	Kon9ZzSRBDStBL97BrXY+gRZpAnSmgKQO3XHiaOyj5RDi5Uhf/QAMhm1H2/iROzzNMO+DH9N3zZ
	6WqAdYqMRK23NmkQ9UUJSxmpwyUi3U1QS2mL0JrpGvEEBCzL29N9FPCUwSva6sIic2yB3kc669N
	pyW1vPNH+VPsRU9aZnLx7np8C33bsaxx++N+4afK7iFXxVmqsxbuE+UrNQGq5xlqN1D22zJqu2W
	t/OA5EEClpJtx1XMnwFOKuYhKBe7RBqvFxyGq7K+xQ9AwZeZE7NyiJ3ykOFCkpZnwTb9zGXol7H
	INL4Reu8zHyhqwqMjRSCqUO+2CR1o4zsujGBK0neJ0883bZjJM48uhYubeFrUhp34R5w==
X-Received: by 2002:a17:907:7f8d:b0:b83:95ca:589b with SMTP id a640c23a62f3a-b8760fea594mr502470066b.10.1768466177819;
        Thu, 15 Jan 2026 00:36:17 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:17 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 06/19] spi: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:35:50 +0200
Message-ID: <20260115083604.1064260-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21606

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c42e36a488c7e01f833fc9f4814f735b66b2d494 upstream.

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Message-ID: <20250827101612.928008-1-claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/spi/spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e5f3372d86be..2e931ccc4c97 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -434,13 +434,14 @@ static int spi_probe(struct device *dev)
 			spi->irq = 0;
 	}
 
-	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (ret)
 		return ret;
 
 	if (sdrv->probe) {
 		ret = sdrv->probe(spi);
-		if (ret)
+		if (ret && !dev_pm_domain_allow_detach_on_unbind_cleanup())
 			dev_pm_domain_detach(dev, true);
 	}
 
@@ -454,7 +455,8 @@ static void spi_remove(struct device *dev)
 	if (sdrv->remove)
 		sdrv->remove(to_spi_device(dev));
 
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 }
 
 static void spi_shutdown(struct device *dev)
-- 
2.43.0


