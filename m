Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A27DCCFA1B
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:04 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10056.1762416656764602747
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:10:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=raLBoJ3U;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c7e438a8so620601f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416655; x=1763021455; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOl6WMuD5hPABvqOqMND5wEkoj5bgpUCvjJHx2oK4sc=;
        b=raLBoJ3Uw93B/7rwehgGpzrfFWaaSyufbK4q34vCCWJ4yXX/FvPdiRds4bhFZ2gRdV
         BTG7da12cx+/+/5w4QpZPvOw7RtV82PMI0JRWEKHghTVVWdc9rbzPkjBQS7K+MI/hmrl
         d82ezbUB4nASLfFzbFA8yVslIjXGqPT6qyzOWy7UIIm1JCibM4Vw9syLJbAm88ttOCVp
         NJLpns1y32FPQ7JNOdfe/wBlzZ9G/l6gDX1s01ESE6kEAgHOQBlITp3pyEyCxnyZRVL0
         559UIoyUJq0AzvJq2r5KbKhC5KRMvC9slc9Jv7kloz+k1tzF3kRE31rwrSRL0RRBGyFF
         DF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416655; x=1763021455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOl6WMuD5hPABvqOqMND5wEkoj5bgpUCvjJHx2oK4sc=;
        b=W6ScbWwHzfTwUaUEzsojB7CDjN7VeIHcbU4e3HqjW6AvRO6s9D1oYvM1YyhCVTu/Al
         lRQzYQbvjInQ7A2YnDO2jvXOXYMFelm714L0XeA4UyIIgTasqL02g/p9G6z/eggNsoBA
         z4IVZYXeYW9OdruRSzisq50lttvIVxTqW4+aO2lgNr41plrbNnQvT0dEqmmY7z2/w3JN
         fmOMdb1blqe+hQTO/qwOLSy8JnZwddF8pl60pVbVjFsLA8Vrhj2zj73yVwBRJ0FI65V2
         c/L7tlNc19FL9M2PI5171kpHP5vxgEgIAerTeRLg7MQcqlxTCl1vIozoeuVKfuhBlTwe
         EX+w==
X-Forwarded-Encrypted: i=1; AJvYcCXTLxgCVdMNqNOSrslhAmYHq5Cac5uHCgzL5EK8E50JofN1p8KHkr2m37GZIqIeISFlatU5qtO5@lists.cip-project.org
X-Gm-Message-State: AOJu0YyZZ37pRyGQae9XRkM45/72NyB1Trfou7p2Miw4J3rRlcxizD93
	xkXtMs++E3aCgZtahQL86K4vppaYBELh66WDd4MkjT5Dp6fYl6GZJyf6JuvisIU5IRM=
X-Gm-Gg: ASbGncuoBgL4eAOsFLo5FX3pM59aM1SPIkZajVqmjGd9UNWaYHOc6EDms9Tjb6govqp
	orVDW8nifcC5ecBbCUcBaqa93eYGzpo5iw4f4Tc/zGsrkO2J68P0Ok+R+ogxfZ6PX10OqICvGQU
	BkgTWRNHLhPI6prX6rJEpH3yxU3G5ePfequJaEN5BmxU1aSkogOgKHlYsj0F9yzT/b1BVVD9KS0
	xx3zm2AVPBzmdIJ1gKa5fXetrs+lmHlz0TUiVqrfRxUe6uqAKU5xi0xK1YTFbXBF8KHTUhe7s8C
	skrk3HGNLEFGCEB7fScG+ZK4g6tof4alih2HQKT5VXx+Wh5+lV2xQ1uKsuQ32rDrrNSGNFJ3D7T
	uDmpD0HLD5EVYsxXxv9js04YL3rM6IbF8Su8l4bu897IkEiaTrjKBxN3bamYJWnbcGRukTp6OYa
	tZ1U1EDjZgCewub/ybuV86nOR+j0UzgA==
X-Google-Smtp-Source: AGHT+IGaFqEeZRocGjTxBrOMFpg1Fw8CEFTFuQ9+8nvVai178YhFsfnRCbV2fbK4k2GGYlH7ipdd2g==
X-Received: by 2002:a05:6000:22c4:b0:427:7f0:95f0 with SMTP id ffacd0b85a97d-429e33079c5mr4735507f8f.37.1762416655137;
        Thu, 06 Nov 2025 00:10:55 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:10:54 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 04/23] driver core: platform: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:10:29 +0200
Message-ID: <20251106081048.2574345-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20373

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


