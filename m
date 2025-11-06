Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27467CCFA1C
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:35 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10062.1762416750570060141
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=VfejHrzU;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c48e05aeso430637f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416749; x=1763021549; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvOHqtsQAPy0ELnmQoy6v/Q9dYoyX5N5EC9OnCC7LoI=;
        b=VfejHrzUidnWXR6OnOVCAtrsD9e5n7HnwcwYlNx9w038cVux8jxogIZ4aRFhFdnr5j
         UTXUEy1Gqh3pxFU1wkT595Ucsj47P5I4jY2moARu9RNiHTns+QzJL8MHNxHN4803hex6
         /AIC4iZfixCaIiGAP68wTuweWi0hzytqYE0DDQFAh4mbibIaurPfhuTqVcYD3piuSv2r
         X0nKT4wH1XM5sn4D8kX0szD2PFH1pD+qn1HaOHPLev/RTxVg6XNMK2239QniULdOGDlw
         AYRRlhYm8Y5pE8JG22A7qBiiCfV8FnIrucNmmzGsqVMBkDN0bT1t6bhP4l3qHDD4Tr44
         08hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416749; x=1763021549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xvOHqtsQAPy0ELnmQoy6v/Q9dYoyX5N5EC9OnCC7LoI=;
        b=mq9LAf6h51+SIfdbSRbeqaiAaVJlCKfhBDiGN8XavqBtMYYnD/D5VknJqQLkt2//Rk
         XY1N9os/s5LGbzrhmG2pVZTPzTV5nq38Dtho+V7eWDf6FGe0igR7ktMfAvvZ52BigVhP
         b5nFujl/96PAFabXVIUn3GVL9ELBQ66wZSgCAHg79PNi+LCfQUfX2AAidB8Q5Iz7K5rp
         Y7JQqOd9s/AVNcw8hxrMOKWpmeD2H188FBugxkDHQKjCOQx0zOwk1eWtDKswmsOkJVYz
         UoVVtO3Lc5TpI3tb2cR0wsZDAskcYol8o8QHbslMNF+40ejvNngBZUeJ8oVcqMo4wQnJ
         GdIA==
X-Forwarded-Encrypted: i=1; AJvYcCUB2GFFEzZwaD1sV6uDBT8qpUBoQMfNH+827mq5RH95PxToRv32K6d+XutMz7YWMMlsExbPqoIy@lists.cip-project.org
X-Gm-Message-State: AOJu0YzB4gZYo9Xcu9sUQIXVZSuKZU4SdQIEfel5StmvRjgvOyLjKsLi
	7sJnNXYsDQig8DVUIMFgwakCENNypD/HW73Q3EApwEhKocLr9sTR+3yZrcNty13wM1w=
X-Gm-Gg: ASbGncubO4KIeS/XWVuoNHDIrBm21dQAg9VI5/HXypU2uWfbt/Qt3Bqonsn/80pqT0B
	sUAcaPF5C+InC3hegdYUF+0kE/dM8RRESFg5PiaZfsR65EcZhylBjnacO/7ArL3nD3MsWsTQ2cb
	/GctIYZmAdtzEc/xX2hKjDtCxQ1YNBy6k2EcmyLD2dZzVPs1ouiA10MWkt1eQw95Ktnp+D5M/sN
	TJRfMcwRGI1czfBBojlft03X2yLqH6+46rxbwakaQwQe2S6FHVSRbV5SXU/9ebhU2wOFXCZm34p
	593KYJWWPoy4VNLX8aL0iZXhDUUwOmwg3P9ofMqtBUgEtTlvqsfCzY9xy4meEz/ZPOhp8kGnOdO
	ViRXDEWJ42yyA80sa9T6XyGIO1bW6pXJTO4pe0WbIXTFLlF+dEmka3N4jgnyDdrWq7djDd1uiFN
	H6vLEGG77hpQdEv9Ta01nZOStgHuqtr6I/MMGUP0Lg
X-Google-Smtp-Source: AGHT+IFUQJnNV9yZAs+2/wRqCJ6jaWD6vw8UmC7qDl710MvezX0WWMLqIobR1L+O3sTV0cmpcUjaXw==
X-Received: by 2002:a05:6000:200b:b0:425:6fb5:2add with SMTP id ffacd0b85a97d-429eb19ebe3mr2133553f8f.19.1762416748864;
        Thu, 06 Nov 2025 00:12:28 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:27 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 06/22] mmc: sdio: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:12:02 +0200
Message-ID: <20251106081218.2574950-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20423

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c2ef7a03f5c8f0a612a8beff666483b725adf8fc upstream.

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
Link: https://lore.kernel.org/r/20250827101236.927313-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/core/sdio_bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index c90dabb5ab06..cfb1d2b5b21b 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -199,7 +199,8 @@ static int sdio_bus_probe(struct device *dev)
 	atomic_dec(&func->card->sdio_funcs_probed);
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_noidle(dev);
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 	return ret;
 }
 
@@ -231,7 +232,8 @@ static int sdio_bus_remove(struct device *dev)
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_sync(dev);
 
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 
 	return 0;
 }
-- 
2.43.0


