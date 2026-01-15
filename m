Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0895BD33A3C
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:32 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31314.1768466182811031915
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=h5F3JnSd;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65378ba2ff7so1088395a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466181; x=1769070981; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR4fLDKYJBnHkJ72md+G+zEENAkuDpPtXwhJJOjPgQ0=;
        b=h5F3JnSdOAY1PzMrkhAFtkD4NdrwA73zcgkvYhrAz/rxt69iescgF5+V3OOr6nII9r
         SL+N5VvlbNKYLKL3pknZiLriJcdeg01V9LIf4uSsTtUVrwODjvN2eVJ6LoN3t600C8ly
         GNK0wS8nogwquXHH0WK8QuD+anjl7TJvUb63pc+8tgEkHKzeh8iRO+dqHo4Nbyf8Xv90
         6vw7G2wRy52XtvmcnNBiv5ft5V+qDrQvR/84qFANiCc7IAb07/Sk4wg1r2hayGneqsMI
         XmcPFvdi6E1gVPsdTsMW+Y18CEfWbxsz2f9srwWPMU/D/hQWJ4ekVbTO1ZPF4q43MM7q
         L8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466181; x=1769070981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IR4fLDKYJBnHkJ72md+G+zEENAkuDpPtXwhJJOjPgQ0=;
        b=qxY1QehwTV+ACL1QAuBuj6p/JDGbs5OYEYLp41BFvo8O8FJ90kSfm/cux+oJvU5ZqV
         LfrIFrnTMNA30dNrY0FWjvQAFnqNHAn1CxI/tWumsi7yESYuWdULrWtqMZ1iQSflWYXf
         nGI78W49W2XgxB/kxtiWkluNDhGMGelQLNU9BfRos/Ze1VQNOf7iDS+GE1Z2gDPEoRQu
         JEFGEMMXQPWLyBtveOg7L62mIydg9moQhQ/NCUJkPVCk0kSoxGfIROehcBF/nlEOqnuC
         Tq6r90iVRPQZzv9nrh2OgeLXmdsy6io7Edju7KkmEw7tEgnDOXklV4BoUVH8yorvEImm
         3fDA==
X-Gm-Message-State: AOJu0YxH73o9l2SdL9G30Lk40bEedV6TEqtn8nrXXY0SDFgEZnhU9zRp
	9sY+igaFGEy/JDwDwPaWUdt8Z5HGk5fIwHa1m41wT1lWkjy1xTe7iqvPcDsxC8id5CIbE2gm2Yb
	q9eLr
X-Gm-Gg: AY/fxX6nkILe8GTR2EP13KqyU4aHFHa/eidCrFzohrdFtTsE2MpJxXq+a5sFP6vUzhH
	G1BcxEPg5Q5VrC4hwsGvrJSKW0L7iMUaSR6EPYnJQotGMx+Eh9w3xWsXQlGlNuJaKTwiCq2Riv1
	YVwPSILLniD+XEyLtocEZjmkIgBMDeLAi/X4BAeFipO0ZTIz86/Yl1ObgP/jGtMku78BVxbXayD
	yctlSTS8+QXzukrt/qEflCxYCtTwV5ERgXWpCRX49aVx+DNre6WWh1OQFb0iFo/Eb729KkBW2X5
	M+RJSKYqq+9fap1ePTyH8sHAqBgGdl8W3LfF5WnRh3xV/Cu0VoZJhUmXPBnfJVpcjkCvM9mqNx/
	NcgcNrfsqPlGE2tPOOWDGe76Oz8KXnDqdxZC2SLbI3KSbJVzlNWIMCdcCse1QVlPUPlyHVtZenw
	DK3wP1NcvIs0UfUysSDqPBpjay58osjjn5DDwH9NWJQVkRxRHX/2GgaxFwyTSIVsoEUg==
X-Received: by 2002:a05:6402:1d53:b0:653:e85b:7729 with SMTP id 4fb4d7f45d1cf-653ec4480d6mr4720271a12.19.1768466181183;
        Thu, 15 Jan 2026 00:36:21 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:20 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 08/19] i2c: core: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:35:52 +0200
Message-ID: <20260115083604.1064260-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21608

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit eddfe53b0d84b02802432bf783ccd53b095dd10a upstream.

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
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/i2c-core-base.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index d70364e6ea6f..4a4756cd09b0 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -572,7 +572,8 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 
 	do_power_on = !i2c_acpi_waive_d0_probe(dev);
-	status = dev_pm_domain_attach(&client->dev, do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0);
+	status = dev_pm_domain_attach(&client->dev, PD_FLAG_DETACH_POWER_OFF |
+				      (do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0));
 	if (status)
 		goto err_clear_wakeup_irq;
 
@@ -604,7 +605,8 @@ static int i2c_device_probe(struct device *dev)
 err_release_driver_resources:
 	devres_release_group(&client->dev, client->devres_group_id);
 err_detach_pm_domain:
-	dev_pm_domain_detach(&client->dev, do_power_on);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(&client->dev, do_power_on);
 err_clear_wakeup_irq:
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
@@ -629,7 +631,8 @@ static void i2c_device_remove(struct device *dev)
 
 	devres_release_group(&client->dev, client->devres_group_id);
 
-	dev_pm_domain_detach(&client->dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(&client->dev, true);
 
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
-- 
2.43.0


