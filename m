Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94562D33A23
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:11 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31294.1768466105859530528
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JDq8jHpi;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so978590a12.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466104; x=1769070904; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw0gL4PDd1QR2Pf19PmOE0Td0QBDX+cFTEunQvaCchA=;
        b=JDq8jHpipMTYbMcRQv76alei0in9njCvXoj1lHBFJPxtrGZNzzIAsaQ9yM33sFixpJ
         WUM4QoPYSlE/5IgHcuk5RAfZRuRDf63FCBH493Hm+Ap+oGdR71QNoXGtMQ4u1SECNLOI
         76vSmasqRXECppb48qzSQeaWLSLjNDBXG+4XNqTQGAMvdui8Yf/zZUHscAkkC3fOpBJQ
         jrs5xsS5NN5N3QSXivrxi1bP+sGewCBFNZ5iy6Ax5oFANXWPkAV1Rdr7vZ2VVzG9kYVH
         rl9bf+TgTw6r1uxxt7XuwV2a9WXYQw21eB/u/g8jTavQjRq1sl4CLCZe75SDjX9O3rSj
         Iz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466104; x=1769070904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xw0gL4PDd1QR2Pf19PmOE0Td0QBDX+cFTEunQvaCchA=;
        b=HcTdCTfcCkjsex4g5kUX2OQF1sU7lfi7ctmEAgL11ZbDo4xwcDXAC3KhRqu1WbeSYY
         EsfsrLgId6EVTT24GldfZPPgWIVulXrQsZTHTxmAX5wMmckBlqpvcK7+o3f7J8+FaN3y
         HLu3wUUoGZMJDPPM/2K9C8rsBwiqhG+P37x8uw9BVIe9Bu8tB5p0CF1f+45u11F7+Z6l
         3H5HLV33Bn5/C48sQKQMzYeuHbQT3PfC9Q/52JEnRg/cXwovfs35i5uQhgFUcrWUhcfv
         M7TKncM+rgjzTiAuR0Mh+WZyvLRZwoh3MDJpWTcjUtYGDh3bkmT7Pi24EqD97BqcDelR
         KSYw==
X-Gm-Message-State: AOJu0Yz8Fc1vHbhcjQsoX08RxpAQrvmJUxB9z/SEk73Wl2LIjRYcZwrB
	p2+05lRsbdYyL8Q4C8NCEFlzG1n7Hb8lvZ8RNSmDj7fU3aj3B2/71j6LS/6O+nY33Fdu59hPMgI
	J5VDq
X-Gm-Gg: AY/fxX4jPS7N6z4mXIg86YNm2KphxyAuAd9BLFp/JE2mxNZ4HnR/plEtpTIK9XoPhY/
	K9VuYfcIEkgMroUUIxJ8lmAzsQbmQLSywUYLViBHWOOaTi1LiMk/AyUb4bxQMG9UQJ1lwSDF3rV
	6WiWEeZGoUr3xG2mZWo8M2Hs70bsgbaNMFKlANPBLkQVhV7VoBEv0rFd6hW6Xb7Wc2EMdzh5oLC
	lIQDP/O6RZvco74STfBCSgrmG5EmGJLwavYDM2iRDUDxXRCoR+H98dlN1EnCOvreUwK6LxI4tIe
	3S4WemINED1P8L39VwrWzXnNUzm8CmS2S7wgFVxxsOUBbpVAo4v7i54JWtJr8reTH+rQmBtBeIQ
	r1OTpohSbo1en4O2LDxMxagMLF/0uBIFHaRw1pdOGdAuv9Oel4doh+n7/PzObvDrxC3xyUaLf51
	hjfvS7G3YLuH57tIBgWWlSt52/qc8tH7J5I+nDtf2ATdB81JkRYaCpffI7uwh1xDgzFQ==
X-Received: by 2002:a17:906:6a14:b0:b80:402e:6e77 with SMTP id a640c23a62f3a-b87612b7004mr512102166b.54.1768466104236;
        Thu, 15 Jan 2026 00:35:04 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:03 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 06/19] mmc: sdio: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:34:38 +0200
Message-ID: <20260115083451.1064048-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21586

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
index 8e7322fd62e0..0142db1bcd74 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -200,7 +200,8 @@ static int sdio_bus_probe(struct device *dev)
 	atomic_dec(&func->card->sdio_funcs_probed);
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_noidle(dev);
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 	return ret;
 }
 
@@ -232,7 +233,8 @@ static void sdio_bus_remove(struct device *dev)
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_sync(dev);
 
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 }
 
 static const struct dev_pm_ops sdio_bus_pm_ops = {
-- 
2.43.0


