Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDFED33A12
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:51 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31254.1768466027214128326
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SEDwHrlD;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b876b691fbcso133830266b.1
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466025; x=1769070825; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvOHqtsQAPy0ELnmQoy6v/Q9dYoyX5N5EC9OnCC7LoI=;
        b=SEDwHrlDwwZHt21c7dq28RLfo2qiHtiuOcVjSSN5EusXHXjpbXEJQG1EajzWoSzf0k
         AFcetEuCXtEd9CpiM4tPKJWBWJAb1Bh6bfZOWuRp+DXohhvCQsSURRetITUb7opSckF5
         Ypyw0QDA46y/XbKkUOEiGZKheif/G8crqm18WR4/gP7rDE8Qdq+Y2HdG67u4VNGtRXbo
         FUTnooDWhNWzW7d8ifmXkSfGhwZPcBJMkK8Xt7qab+NrikbxDOfSGXxHU1Mfi6H3o+NQ
         eY7RCgW/SzY3WxbAXJY/d0PALSiIVn3kbC/sUS+LalNNCE++hBKfpPuOuw59vfjsS49e
         RsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466025; x=1769070825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xvOHqtsQAPy0ELnmQoy6v/Q9dYoyX5N5EC9OnCC7LoI=;
        b=Z7b+aoHfLRob3U6kxH+UBjHc3xdVeQfJy+7fl8GDPRQU6lGlC3p2uAOj+51RboFrPh
         CJrJSlrtQOlUfdMobIA1sNhFB6IVi66ffr8TUyfzF4aLI+oPrFCTEO5gHcZ+2u7Gtmaj
         HlDfMoqYCkptBbdx/iaYBqjTo/iXofPpZpZixn9HuSsFk5aRKHkyhBhOi4zv/e3TLnSr
         BQ14r+ir3RZXli8JUiaTPU3Q8z9FrKQ1i2v/DKxu8w/XgTSk/06wgqhFx19PSlzd4/eS
         2jE0I2myOcYvglQWtPBxqogLunoWKZkLV/egrRQeOVJ9z6KJfox+sEoP9ZDPUftNkrNK
         l0HQ==
X-Gm-Message-State: AOJu0YxWyMCx93YqnWfaQpsqUTCrq+GoBGyKIFaaBteJA6xwijM5jnMp
	p7GU5J1+kjfolbK7HKhLjDfDepndvWQeng4qdO5mA9WLY1KT5E7aeDPNrudHjmib60o=
X-Gm-Gg: AY/fxX4xtLbmBRS642VDSGbKuYorqHgevv+RaD7GfuJBulF2RvZRBKIILEgib8De01S
	M/g11xFUnZMXqE1vs3IVTzW/Bcxdjv3eatrh7hXIt3MS2JMbzmsX7wyWxrbGG3Sh6QKKmk3VoBQ
	vgKZB6QZQLMHDIeg5cLhhXQqIEBZgHfwWYlE3RXTzcmS+XZRn3tROsnmd1U+MkaEviT7eO7cmyI
	o/+/1jtb/uYPJ5zpq8NlKKOrS2XtxQhMuCUtdWtV9w/nx5WUWwln3/Yb2SwwyPeO9zoeYyGkCpR
	CWDWDBhYDpZan6enWxQafxqx4IuMM7UeyT14HOJzC3GB7wa8MIi9KPBN+MVQOlrf66rLWaXz8Pz
	bg8IU2zYZOcFri1kPqBPZ8kWNVs+OeEUNIKPju5bDtG3Y43FlOefX+xZ5xHejcoyWYBWVJRhC7C
	9TQVDHdLR4VBImY1XQ4b4Bu9fLrdEnxyZxc3VU8Q7zgDOgs0BEji1VvTb3Q80cmPGtVrl0J8Eim
	h/X
X-Received: by 2002:a17:907:3dac:b0:b87:12d2:fa1a with SMTP id a640c23a62f3a-b8760fdab0cmr493065366b.12.1768466025523;
        Thu, 15 Jan 2026 00:33:45 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:45 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 06/18] mmc: sdio: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:33:20 +0200
Message-ID: <20260115083332.1063820-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21567

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


