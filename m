Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F5BD33A37
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:21 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31325.1768466176607220331
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lmbmXiRp;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b870cbd1e52so99029266b.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466175; x=1769070975; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOl6WMuD5hPABvqOqMND5wEkoj5bgpUCvjJHx2oK4sc=;
        b=lmbmXiRpSwnmqcz41L5Nh861g+nls6Lf8/YRATlLc+/ibbjX8vmTYyFkN4U9xsGbC0
         vLPPu8EzeQOqNtI8lWDvc1aHYS4SX+05ls13biHoG/vqGQaD1papDavZMbFXdR4rMXLU
         UDx00HUctW3/L7Fw5uQYuQMH0uZLZljoHL1dtK28mBMcgflX2t9LKAvpOiV/Ltu5molF
         RW8anx8LGo/Ntv1nTQqE1VccBVeGDqBKmWpsOU8k1XI4HLO29XltwHSnYgISsAi2gcsd
         rWARR4ghtKqgo1iq+bVEVe7tm0nGmHpQD89DkSw7AGGvbdpcS+z6kfQ13CtkGjOe6hsI
         Cvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466175; x=1769070975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOl6WMuD5hPABvqOqMND5wEkoj5bgpUCvjJHx2oK4sc=;
        b=efLcI6Orgev4CxqDLjnEie2b7j8PuVheuBR2Pxu50d+X2OkUIID9ck1LN4EdCsYHdL
         HEeIdumnYlCcQE851hr+2yH7ifoxamVzpWthNyUJbchc694T+EfZq1zAmN7VJtk6bwx/
         WDyb3dFea5e+VduxS7j4N/dBVVyaKE/1/2/cEfOFPwjbWaHFtZ8DprJbeyWfxDCfMMQu
         2JsojCfe2tJYvKpIAQyVL6h8gL1gnZdWQjtTsfyGN1bLotJ7bFXzGzvr4Y5inzPtPFPh
         hlp7Wxs/SG/KHrYp87bIecl6Cnti8R3BTr87gO3ppZknMISoyIMoH/QD+QeyDcaOEkER
         +wEw==
X-Gm-Message-State: AOJu0YwyCr4cg7Bquez66FAXzi8ESIdSQ2dQe1RrlWNjWLsx8oBQcLQC
	nOTZYaIZ8N5v9wC4wesjc+QZQYPJfBy7yeCA4vg+AfgtDjpOt9Ti1vP6qy9NKQgsCMb4RtyRQqf
	fKZ4N
X-Gm-Gg: AY/fxX501P7FxGxYuQPSL/Fwr5memaofa24lmyXqIGQyktQBNz3TUDPlmQdqE/Jfn/K
	xABsNTYkm2j/NE5a4XRiBl7SYVI9DZs+6GUUaBzVT3ILyTcG14/jJGSfh65POdTHAGWReNFcXxz
	UmmmSu+0ykxqKLf3JPj+68aLtVD4f5ZAA1Iqjl4CrsEVZIsKAWq++EVO95sjprIT/GIudvkx/ES
	Xf2diVDAgasYjqxo4Limk1CS0RlRj6S6m3MoLtHWamQMzK4jiO50vvGxNu95G0nzrEX2CiruoWM
	cRkZgQgqKRdW1v6RNNaGlQe5tN+gy6Vg6D5QWK5qLtI4Nlq+cDvN6KAD5Wd99pWB7sjt0gUr+HL
	prYtTAf2aeS/MRGBaQCGDEWubI2GtQSoZW5l4Y+Jc79KI+sI0Uly+A0V1Q74fbiT5KKJBsK158d
	G2R2U2uVFbLIMVPBMswFWSfrkfaJY6sFJAbZD/1A7hTqbhE8O+1OCuYYDgfBSi40Gwwg==
X-Received: by 2002:a17:907:86a1:b0:b87:35f:fb4 with SMTP id a640c23a62f3a-b8760fe80a3mr488895866b.11.1768466174838;
        Thu, 15 Jan 2026 00:36:14 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:14 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 04/19] driver core: platform: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:35:48 +0200
Message-ID: <20260115083604.1064260-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21604

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit ba2ebd52a22eb7306a2093924920a125ad91215a upstream.

On the Renesas RZ/G3S (and other Renesas SoCs, e.g., RZ/G2{L, LC, UL}),
clocks are managed through PM domains. These PM domains, registered on
behalf of the clock controller driver, are configured with
GENPD_FLAG_PM_CLK. In most of the Renesas drivers used by RZ SoCs, the
clocks are enabled/disabled using runtime PM APIs. The power domains may
also have power_on/power_off support implemented. After the device PM
domain is powered off any CPU accesses to these domains leads to system
aborts.

During probe, devices are attached to the PM domain controlling their
clocks and power. Similarly, during removal, devices are detached from the
PM domain.

The detachment call stack is as follows:

device_driver_detach() ->
  device_release_driver_internal() ->
    __device_release_driver() ->
      device_remove() ->
        platform_remove() ->
          dev_pm_domain_detach()

During driver unbind, after the device is detached from its PM domain,
the device_unbind_cleanup() function is called, which subsequently
invokes devres_release_all(). This function handles devres resource
cleanup.

If runtime PM is enabled in driver probe via devm_pm_runtime_enable(),
the cleanup process triggers the action or reset function for disabling
runtime PM. This function is pm_runtime_disable_action(), which leads
to the following call stack of interest when called:

pm_runtime_disable_action() ->
  pm_runtime_dont_use_autosuspend() ->
    __pm_runtime_use_autosuspend() ->
      update_autosuspend() ->
        rpm_idle()

The rpm_idle() function attempts to resume the device at runtime.
However, at the point it is called, the device is no longer part of a PM
domain (which manages clocks and power states). If the driver implements
its own runtime PM APIs for specific functionalities - such as the
rzg2l_adc driver - while also relying on the power domain subsystem for
power management, rpm_idle() will invoke the driver's runtime PM API.
However, since the device is no longer part of a PM domain at this point,
the PM domain's runtime PM APIs will not be called. This leads to system
aborts on Renesas SoCs.

Another identified case is when a subsystem performs various cleanups
using device_unbind_cleanup(), calling driver-specific APIs in the
process. A known example is the thermal subsystem, which may call driver-
specific APIs to disable the thermal device. The relevant call stack in
this case is:

device_driver_detach() ->
  device_release_driver_internal() ->
    device_unbind_cleanup() ->
      devres_release_all() ->
        devm_thermal_of_zone_release() ->
          thermal_zone_device_disable() ->
            thermal_zone_device_set_mode() ->
              struct thermal_zone_device_ops::change_mode()

At the moment the driver-specific change_mode() API is called, the
device is no longer part of its PM domain. Accessing its registers
without proper power management leads to system aborts.

Drop the call to dev_pm_domain_detach() from the platform bus remove
function and rely on the newly introduced call in device_unbind_cleanup().

This ensures the same effect, but the call now occurs after all
driver-specific devres resources have been freed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://patch.msgid.link/20250703112708.1621607-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/base/platform.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index e10a0ee27ca5..683774c43cfd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1396,13 +1396,14 @@ static int platform_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON |
+					 PD_FLAG_DETACH_POWER_OFF);
 	if (ret)
 		goto out;
 
 	if (drv->probe) {
 		ret = drv->probe(dev);
-		if (ret)
+		if (ret && !dev_pm_domain_allow_detach_on_unbind_cleanup())
 			dev_pm_domain_detach(_dev, true);
 	}
 
@@ -1422,7 +1423,8 @@ static void platform_remove(struct device *_dev)
 
 	if (drv->remove)
 		drv->remove(dev);
-	dev_pm_domain_detach(_dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(_dev, true);
 }
 
 static void platform_shutdown(struct device *_dev)
-- 
2.43.0


