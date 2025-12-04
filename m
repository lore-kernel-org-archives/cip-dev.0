Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A52CD2447E
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:28 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50788.1764872067592901275
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=a4w52GY1;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so877978f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872066; x=1765476866; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0kQRkGuyh5+jrSNOY06xsBAoBJ/F6kVJEmbK+FzkCQ=;
        b=a4w52GY1WzO+aPoa+vgv3lOBvaVmVyS9g+EvlHPLNdXiw5rOmJq48tbmKSPKl+ilKy
         UAo2eDDXX92RRScMTW0b6E+Zve0K/Hx7AKMu7D2lxQSXR+oT/QD3Bq5suA/Ev0Opw7lD
         ELR7GXEyfjZNTf5KUze1Qp2Sf0OURaD24tpFSIq7QzqbOiF9QfYUfx/vlYh9gD3W3hzG
         i54N9r/FowHlr1KpXSGE69U1TjAF51MSStDixL8lDJ+k6j6ORd2I1YWFdwhwvviJ/Kt+
         bI33f3S2i1Hu1L3Pi5arskT1ZcjUC9g/533361hmEQJb4AFPIxey6XZJfikIXP2h7RZ+
         Fn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872066; x=1765476866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U0kQRkGuyh5+jrSNOY06xsBAoBJ/F6kVJEmbK+FzkCQ=;
        b=h7o9VS7vb3sd0T+uFFuC4cOwbHK3cIzA3FAXZgyx6huUPWHYQO7y7+v+g9rkjU2XOk
         BrYdxXTDOC4cZALODePWWmClZY7d+51PVvrenzbbp2E9FSs6mPJqoO+SMSfIkZT4ZGiU
         QqucvfBKY5XpaAaSFnxRt/e5mVgh7hor0MaKNFWLWka5C7iq2fgqPIDwQDvhYESpMiKN
         OWqO+3IV7Iyqptj22oGwN0q7D+qY2Z4kDlZ8K4JN/wp9dTgJlbnXb1fTjfZSKU68B82n
         oPd7TSkPj58nhQI0dCi54HJcayTL0MO+2DykMCQzT9ElQshpMguZr9QkqHqOdrx7RW60
         fM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm/Cc/dFNhGAeBdWTl/G6h9KusnmmBsgsuRL4Ww40Y0UCOY7GrovbXws/oQdSj+InDMmL+hWo1@lists.cip-project.org
X-Gm-Message-State: AOJu0YxwWfW/1bvXf8C3DlMEBXQvn9fGUWyeE+e4IgJ29YnC+0EU6MhE
	NN1FLQToabIVbQlQtIpat1Ka9ZKIW32PczquFiBJrPfH0+hLqz4T0NGFRuSACcpo2wqYeS8Iism
	rIUhX
X-Gm-Gg: ASbGncsEv5MUEBU/N4x3gkd/nPqlJriUTZDROIQ/h06PaTyvq1lzMi8OsUJGM1t+Ugx
	b41X5aud7mIToKRMiLe7laOvMXaAXkjcUc2Aob54TuT+Hj9Zef1o2sqPoGibgenYbmaP8VNFEiu
	vhiLxGErzPeICGSDyDyM61AdrhQZlnuthFOoZxi8P7umUvtZHVKRwDdh3R+Eo3k95M+BqYQSWAT
	QKttcnyG6xGWvYw2bFlPSa679Z7VnDzZBeHPlUBBG58zATxMG+FwSp+fqr4CYRfHBptxZJvzTlS
	bUZtXa0IjDo7IDReJg9WlTryeZpeQBkvpBr8F5jGOry6ZT+j3TrWhhRngR2Rpmc//vhpDs514LI
	WU+IPHO+HKg/oZxJ5sQSlB4Jn70UaO49hiQKo8xA+qe+uhk2GTxQb+NP0x5eJyUMuaG9tWcl02n
	XSUVwoVwLtpDjtUP4UJ9OWsboPK9hWsFSjvAwBI5lLnfYUJAM+Fkg=
X-Google-Smtp-Source: AGHT+IF2/dGvsV0p6KkmWzPheJ2CxXEg3w1pJHV9UbOoA5NvWIRdd4CAK9Af0bH+0B01lEmMyMfS9w==
X-Received: by 2002:a05:6000:4014:b0:429:bca4:6b44 with SMTP id ffacd0b85a97d-42f797febb3mr3580055f8f.13.1764872065933;
        Thu, 04 Dec 2025 10:14:25 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:25 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 07/18] spi: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:14:04 +0200
Message-ID: <20251204181415.689009-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20854

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
index 3b0513659331..f6041d8fe86c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -407,13 +407,14 @@ static int spi_drv_probe(struct device *dev)
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
 
@@ -427,7 +428,8 @@ static int spi_drv_remove(struct device *dev)
 
 	if (sdrv->remove)
 		ret = sdrv->remove(to_spi_device(dev));
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 
 	return ret;
 }
-- 
2.43.0


