Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D20D33A28
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:11 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31297.1768466109337038878
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=n6Zbw7D2;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso904824a12.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466108; x=1769070908; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5/SmrPCBIcTNTmOhay/F307DEFDs5Zbf3TLxYKOrJ4=;
        b=n6Zbw7D2vcF80T7Ft3bIiX2kHa+jaH3bYQDqzAKvKhyNpGP5TB++05zXb8lMnLsx5F
         WAaj6TQmP2TLVNN5Ify1sofikbCLXvspMKlqBj1d46464B/V8tafJl4puA3l3ctcqFcx
         fk39l6rT0FcWkS9jupoK7V4DP6eYtB3Wbm/6WbqtJXvXs4V1VrBknUjrPzbCG0D8gV+m
         fSB7FL58AChFrppOyeRiwxdumckK1smlNXf1VyE/7eiorBE4Pn8btwiX5QoO6Ycx7I9D
         bxbPiHXzhGQ5zVV5GPeHsQAuaNfY5okwb9exvzmCE5yBC1eDMlKarraIsii5Vee0lRlb
         klLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466108; x=1769070908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R5/SmrPCBIcTNTmOhay/F307DEFDs5Zbf3TLxYKOrJ4=;
        b=kb7OeD6GvlueBMuBfbn+j7WcSja/Dvgsx9upUaiTRKKp2C9FbRw3PezyYAKDnozJaq
         hpum8n2geLEN0VOK0QNtHmu9HeDpvrgJOAdLjEtSnvvRnnqtamCyC6um5BOLER/lO4FJ
         +MCC1o1h9oO6laJ33gnG2iTndGtrYk9++IcliHVHICDzYIbekdy8EJiMFi/4ata/1Trt
         IoYs/AutHOB6zFYAS9OaQascaCi4+yVJL5aQNfgKESIRcbg0lJADEggBnwfSjycWahp1
         OMqgbcPjnGANAAT/sUaT/uIaBZg2A945B4UV7Je/+pZmcTCl/ELVpTS42M4NNtSEixxD
         ojXg==
X-Gm-Message-State: AOJu0YzMKF5nhhaGpUJO3y17oNaEDVIXnAPTj+pNEgGkWopeJZlNbCYP
	KW12aTfnlPyR/6upTRrkqwlUbFJOOQr5092TGGtv55yir1/qmeKqDDnnQZXbrn5NgGrob/gqYtU
	kq3kT
X-Gm-Gg: AY/fxX5JGzDen3+WOQIK2Or6NmSBSSHG0SeFX9zKKmfQF+0BeC9aYBjFIE6rNHkz1V8
	QSpC/AKTV7RYtfM3gU4XHkbqTA94Ybb4fx2kbN54Ygj+OOUeUjro9zBlCny10Ps/NiFcGtR8b9S
	mrwRFM/hBGfTnBp84w3bnHwlrXNLCOT2Vpd/FM7NlvC3FLqwa34kbaIYXVxIzHOynD8hX/6TfCX
	/cCgplMBbbR+TKqySeBNGV51m3/RKV7wZQQ3LrB0X/oSmo1tt+RmciHJ4w9duLUXmpaPoUCpVyw
	E+GKCg27JezFQY/ko4qrSonKY+g5yDuxmt6sXVYhUq3CbbIt/m5dGOyUvmuXz7EHR7Qtgf6y1Nq
	ihbZ6RwCNKs8Vj5R2VlhrK1oFaM3uM6tJvsbRsoSenzA0rTF/XdUqWPCEAMIagPHQ0dPXXCqP8/
	8nw1Bp6QxNUSIM1Sik/JDHj5hWNMsmvET3IhD2D4j/Na17qYFKSdrw6jaoZowz/Stu7Q==
X-Received: by 2002:a05:6402:2808:b0:650:8c47:ac5 with SMTP id 4fb4d7f45d1cf-653ee15f8dbmr4345891a12.11.1768466107726;
        Thu, 15 Jan 2026 00:35:07 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:07 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 08/19] driver core: auxiliary bus: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:34:40 +0200
Message-ID: <20260115083451.1064048-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21588

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
index 31f5a81b5393..b02bbbc8d117 100644
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


