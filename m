Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B57D29F9D
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:18 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50549.1764872168750483896
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BE3dVCfJ;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2b80ab25so668362f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872167; x=1765476967; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOl6WMuD5hPABvqOqMND5wEkoj5bgpUCvjJHx2oK4sc=;
        b=BE3dVCfJYaQd9j4Ch09UtVHtgQJa9ZWTYaS9zD7ZxTF32TT1snWfWgHt0WLZ+kcAhH
         OagIpm+fgoNkWaHiBSdJ9NTEDMqMkeUYT670MlLxxpPMsAqyyMydieJ7ADZ13hPLT+6+
         PTe6KxdU/jtuEHI39+vwg04w8ez4kSeaNQrD8decEg0lPP47EDDyv59yzZaHhXuYFHvJ
         VxFjWDMN8z2HV7UhaFS69vKkxn0TkscvWFqfa2ImeMb+k8ArlgrgD22lJcHyq7u84t4b
         mSEpWsTu9f23IvuAt+0mprXhZYWu6BcAzHmwVZqzRGg4oTKHHnvrvQ0Wju7+j1US5F7h
         rwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872167; x=1765476967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOl6WMuD5hPABvqOqMND5wEkoj5bgpUCvjJHx2oK4sc=;
        b=SAnbFXe0XwoEaKc/volIrS9MmNlHIMnOsWRFRztwBOW98tpwLryHBtK467go4EF6y0
         VftA0tewp0mrvvGrWvq5XyZFHxynHBFY2cq/hJk8jyf1RiDQcVwCwfh2BFOWbtNp304W
         s5svV6tmNL+jJrbBUfyjN5UXlBnK3uPQosTOf7A/6mzsWznNF06FMz/CyayRhp2qQP03
         ESVycRJk2I6Dacff+CHJssJCaiDhznVJj95kI2xmH1PQ/K5+C9PG7hj8vGcedRHJ3wrx
         oDDA73c/IOE2I/xQmeC6VT/rlcEnM8VUIBPeqUsqlrAgxKpxOrPl8ueJYAHKm34lY+88
         YVLw==
X-Forwarded-Encrypted: i=1; AJvYcCX7+qgN4xNdhyOoS52YRWGiftAYY5FwOOovPhegt0Sr75+p9KmkMYlTOFjapJAqYAMgPK4GeGv+@lists.cip-project.org
X-Gm-Message-State: AOJu0YzjANVBbv7UHCNABkIMI7HO9SBxKg7SrSLPuRMfIZ5VInS4fDiq
	rFcOme4xIiV76AccrvHgdmO+bFKpOwGAHGKKp1tLFj1+bxj3kKE2jFxu6Mr6QjAG+jc=
X-Gm-Gg: ASbGncvNkKonstmAzPYVy/hP+LhMwASjbfypcGEI6bAwXap27TEavxrxQzFU8BysYrc
	4rlUygfuAYXeAO27WsAlTNXUL4TXBzP0EptZe3p2H0xNGjvrUpsOL6UwEKrBIyrIWjdAouGjnnt
	Xcuz44GOvLgptGaJkCrPId9StT+eko3WS/2uRHCYJ03wWOq2Bc3sFvAQeg8INUsAWgeo8xOoyBW
	SBC7oHFhN5Cat/3eLPZ9RhsskniY7HFlkSyt5k8GVZCMjoHq9KIaph+PdoPsuNMDcBYoiBGgxLP
	/dCxr7Oe/QGQpZgMIa3/gUCNaWYmrdFD2t7fgGN4YVBweIeTsIFtxbvLFNY5j3P0OC2ZATWbkbz
	jHtAkIq/uAexrUhMDCnSFUzr5Z1agmjuveloCMo+YsUL5uOiLsU9JWTWQxjMIXFcs95v5LWtwM6
	6lRjkjyzuI1ntX0A8vuiaPhvCT8I3MBDQrGZmSwNGr
X-Google-Smtp-Source: AGHT+IGw26CbX6iDWAC7FO05VdEMCoKuEsn+5DK6uFYlVeCQQgXnZDj+AzJcLUv06BUXh8bgLRUjzw==
X-Received: by 2002:a05:6000:402c:b0:42b:4139:5788 with SMTP id ffacd0b85a97d-42f7317401bmr7773864f8f.6.1764872167005;
        Thu, 04 Dec 2025 10:16:07 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:06 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 04/19] driver core: platform: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:15:45 +0200
Message-ID: <20251204181600.689203-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20890

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


