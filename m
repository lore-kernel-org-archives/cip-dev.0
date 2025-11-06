Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9FCCCFA1D
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:54 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10078.1762416707140880386
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=N1yR7khI;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710683a644so4344675e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416705; x=1763021505; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4dSLvwo5PgzCDG9xnKtEpej6Tbvv9H8X+Ler8IGSd0=;
        b=N1yR7khIR/wfMvX4WfDg2o7hQJu0hi0U2pMiq+5VGs21YLhDANOWhnN9YvB+bM8c5o
         fPXHeF6zmTB1EV2u4aKXbFZ5DGdkQ9z68zYY5b0uM9VAW0Qjdej0l4dxwDhRhLaSaCaO
         9O7Jaq5aTbs/7xMFWULNpUDzrt77cwdEAd2ertEB4dx1lrgdwBE1980TVe0AddDVop2g
         EuPRG+/EIGFLNU833T6w8vYoKlPNzR5ZSHILTj31zwclBUJo/7wYRzx7WGh6gWBVU6kj
         IzEB0YtBDX7yZgaLBihVyJbNe2YmcHIKma7k1EEU0JzN6iKuScgw4DD/RlzFJhDSePKx
         jCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416705; x=1763021505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4dSLvwo5PgzCDG9xnKtEpej6Tbvv9H8X+Ler8IGSd0=;
        b=HeX+dIcN6Sh87MMBER4vwgTeaXohIiq/yeYcOU0HIPcuz2WlhQHUiNobLGJQOB0J44
         kiU/GLjOG7HRw+WGAiRrIiSdBDUvApx8kM0qQj6sdj/ATQaYKBves8DJsLyIftzAtGgF
         qjSykpeZc+yJUoJfbsOEh+QmRT3gG5hB9pe1yZfIorAl4rRSCmgsYyr+s3kTiuwiwoAS
         FFAotNaXO3ayw+JnXmAvbJsmCzOcDje5L0JilSP6UQMIGO47676x9rLs+WxCo4PAQYIj
         9T4PNbxI0WXzxFu0PCEXDeVJP3D1RPUmdJeNhWJFFUIA/3AYLbQz6LWWC148yOkBVfPI
         /1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWq5iqm6ViPl3fWtNQhji700Q8LXPMjSszRmNkTTBEw/hr+GGvwWlIpTrpDPf5Q/01qDTEBl1GD@lists.cip-project.org
X-Gm-Message-State: AOJu0YwNi2xaLqtGyYMv2fh3DkyLMFwy937Z56XIm7sZF3xINmj9EaSo
	NnpTzi5iwue5Lz0Lohx2ptTXztys+jZxxdr8V1JMlHAex1Mz0qVdLrgfQbXw4kleqzxm6dFDRMO
	INHzMKcY=
X-Gm-Gg: ASbGncuTV224DTMW60Zrqrp9Wa0LjJU2SDtScbCKZrM3KX18xE/GdR8NU18dDJma6ZI
	Zb/SSvWwG6F4x3HooBFRjWb/r+R55QH9OnsuDMWvEsM3XS/uaatCoQ+h/8yGM1tNPL39mHCiAgv
	F+N7SoDxf5AYPSEEaQOKJqRiBkpqOCPTWQrDoZC7RpU3yMtra1pUlgJy97GVwzosYcPjpV9Bq40
	Xk7VcyrIJ0laleTf9wSoxczk2THxQYdINJST6riOfKQIAlWled0Szdaad5lrrzQsCbhe/RmR7Vt
	wQc8d9CGDIqqzQZMLHjoupBtrkcVDEent4cg1OZwS0nIUZbtNUt7kiBU6L6peYmQhE8SeF5CGGM
	LuWqW8mkKukV3VCeBP3uta+bhDrkUptNYgLp42bC1ILVtJeLWUJVghn4Pid1WXZ6BYCjhoflFaX
	xwF5Fa3mRGi5gk1f7+nsm3iLbbXtmpJg==
X-Google-Smtp-Source: AGHT+IEYv3eDuRlEndvLWxnDIELMlLelTZmgv3UuQaDhwVYoMD+CZVt3DcW6slSafddMNl5uBRlFDA==
X-Received: by 2002:a05:600c:34c1:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47762073135mr21205635e9.13.1762416705530;
        Thu, 06 Nov 2025 00:11:45 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:44 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 07/23] spi: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:11:16 +0200
Message-ID: <20251106081132.2574638-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20400

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
index feadf94b8893..b8e9d04ff27d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -435,13 +435,14 @@ static int spi_probe(struct device *dev)
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
 
@@ -455,7 +456,8 @@ static void spi_remove(struct device *dev)
 	if (sdrv->remove)
 		sdrv->remove(to_spi_device(dev));
 
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 }
 
 static void spi_shutdown(struct device *dev)
-- 
2.43.0


