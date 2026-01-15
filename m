Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058ADD33A3E
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:22 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31331.1768466181264816798
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=n5ST+i4U;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so897021a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466180; x=1769070980; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tpDQFs5RWc86sBGBh287OekzsCI6QEnjPq808cRd9g=;
        b=n5ST+i4UNGoD8RrHmgFMDxu77Sx7YE/AG+hTlqdB1jWpNpyJJ3PPZXeHXJxHb5D4H7
         7qt06pkQ+u5LiJldruliPV9PTAb4dFpNzlLxlXPVjvcUC3J/yCqIBb4kIp5IMwoiKw1u
         YFrO6U90vNbIX0BH8UON4J8yfPsQXuKwPO9UiHVTV0CO8jXpDdOUCPBIaGbIg6T2T1fp
         VWhI7Lm/frZyUxSH4qWzeGesvAsUo+K08fJbCZf4KwMpCqeM69bCCMvL7Dc3zs2btRM5
         157amngcb6Ccd1Wf85lruMyAR+IIaI+p7YVlJjy20GtAe7dirIj+LD7wuTcdectxtw0n
         8arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466180; x=1769070980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3tpDQFs5RWc86sBGBh287OekzsCI6QEnjPq808cRd9g=;
        b=bUmg7ZpxbS8z8MiKX3908kMqOZ3KICNvGYWk9D4KXL3g/6/D7DJXL56GCNWaFBbaGN
         18gzLFPlj76s4gRm/zTzHiL07PyhQ5qUyC6OJ5+Iu0m8zhs6fzG8eKBKNXazxaFBJ0ET
         4cXkIu1neU63f5Q81Fo42uuB/Qey2BOetkRyBnxUbVwSQwdOm9/ryraFGKAWM7OHSW8m
         K1XEPMbWfSxOmC0od2n9j8Un4AYaS+8KAAeblpHMYxiM/DQtnjT2+sfVNYAzlPvFgiLk
         vtiiGwvpM/gBX/kLBfCG6KPooHLLBC66fDkWdX8sWq6ZiKup3C1rhQBX6t9xZjx9L6mB
         Ibfw==
X-Gm-Message-State: AOJu0YynF+nPi6bgwEAWm6RfxXDUH9Dxs9iwZlssYMycm9lxJ+U+h+Rs
	5q4mfXiw50/7aeJ8OMkQl/uPquiCjI4yMMo1mBjSlh6im/oqXMZy6h+vvfirrMNpGYt6nvC2jIT
	5epu9
X-Gm-Gg: AY/fxX4aE0OqZYI7t3rXxd5xsTrD65IcVVJ4LttgWvWm6znpXY2+G8YEs20Oirq4KSd
	wYkgCN/3/+MEodMGO2pVORVDlMbSkxaKgWHwYYsHta83m5bvcWzXM35jWEAdbnPrk8DOSAh7PfF
	URZdWyR5yM2cNMND0ztPwQgPalIHo6AXMLCaosII5g26DMrL8ejdGHb3eiY4LXlRwlZpbJHm833
	46444jGHYGxlntwzlyYrgN95c0tZeY+xAG+rOAx2pdfziIaYBrdHW+EE6wYoSNVeXTjcl3Q2MqD
	kZlJi1Olscp44z+I4KdEDo0tDUyXLYtQrAU3ohoK/62Q4J/ANjrWq4hHJhVqAuVInZ+LkobRCAz
	JfFiA3glgPhQydDjfzEifhWyzrLAc2tO3C/cEcp8tfFI76yB5jDqfeV6pxn/n6yk9kPVmdBYQ+i
	/9d5GQ65Y7Z/O1KMJ+gZX6nkEQwIfu55Vfx/oAv2PHve7N5l0A3YADB8TN1tk/7IZn+w==
X-Received: by 2002:a05:6402:5186:b0:64b:993f:ce05 with SMTP id 4fb4d7f45d1cf-653ec45af8dmr3775387a12.24.1768466179639;
        Thu, 15 Jan 2026 00:36:19 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:19 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 07/19] driver core: auxiliary bus: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:35:51 +0200
Message-ID: <20260115083604.1064260-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21607

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit eca710386972f2a72708b0b2a615eb150d218e18 upstream.

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
Link: https://lore.kernel.org/r/20250827100541.926350-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/base/auxiliary.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 5d5b2a9fee0c..f1319ebf8532 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -207,14 +207,15 @@ static int auxiliary_bus_probe(struct device *dev)
 	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (ret) {
 		dev_warn(dev, "Failed to attach to PM Domain : %d\n", ret);
 		return ret;
 	}
 
 	ret = auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));
-	if (ret)
+	if (ret && !dev_pm_domain_allow_detach_on_unbind_cleanup())
 		dev_pm_domain_detach(dev, true);
 
 	return ret;
@@ -227,7 +228,8 @@ static void auxiliary_bus_remove(struct device *dev)
 
 	if (auxdrv->remove)
 		auxdrv->remove(auxdev);
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 }
 
 static void auxiliary_bus_shutdown(struct device *dev)
-- 
2.43.0


