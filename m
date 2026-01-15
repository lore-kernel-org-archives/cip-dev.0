Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BDDD33A0E
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:51 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31265.1768466025874590681
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kDVQuWgQ;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b876c0d5318so97566466b.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466024; x=1769070824; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uURFDKOZpoUHR9p2zgKbePjSbXhO8t32enXDvH+p/VM=;
        b=kDVQuWgQnZ/KZyMw8+eKki0HWoaLr4Oj7/2f3xasqyn2qF2biVM1dxqAdtLv3gmsg4
         9zRmPgAN/iQoUBWkVbX7L9z+sYhIJELzv2cMlwaFQKAmeC5Ty0AR2Vz+eiVP+OPwTRHs
         quEop3YvZd3/n33lRy1F1nPDwOQaV0aFrLR2nGReU9SVUOu13weRYYlsJAGpzsPh9c0i
         EK/Aax4nPa8b8IxJucM9U0K3eFUrLdQoZY9U9A6MIRbmEBncm0Hjr4jQkSlbNP/5qpqK
         z8nLNVx2RXj5UV84eYrwZmZgy7QR9LgixOtsQg3AnnDG4KQBXubRSLePJw9g5afm3VH1
         lYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466024; x=1769070824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uURFDKOZpoUHR9p2zgKbePjSbXhO8t32enXDvH+p/VM=;
        b=rRMpwTydK+hGoHr3KuRLussifylROZMzosPNSqviEQ1l8Gjg2am3es8IdntbEo3N+6
         s+/tKwjNg/SNt9sipfgnR5dL4a0FSfduYLoSZElSQDbZchNrh8hnoT8RMO6clifsrDO4
         3vQJOB9MJgJGcK69dl8e3QatuYOIWrUMAsdW16ycCcVsfhJOkSMZJ7FBLczOuMqaXo/d
         8rA+cqbPMT4AGa0USlX3Pq2BZ5jCk+lS/+Yr3oJMOJVVINqv+iIPksJmPbFd5FRlikz/
         6O78m80Ppd2uHJcuhzo4ISq2nduMEo1ezxwU2KnlYWc//+vO6MitnLb+wlruNOnvAv2G
         +VfA==
X-Gm-Message-State: AOJu0YysCMIDl+aOzi4XBUGiIS8yfojDFpqpcYxlEKeAbotY151QDdU3
	HQSuCJFWVNIfhUsDC2WMf7eg/dJSy6cJG4s2l/SH4Eb7e+bX9e7FgjBicNzXJBknsmA=
X-Gm-Gg: AY/fxX7iy8ZEpCliw2oKo51vft38XuWKFT4ppoBZ022D79W8KF2vvYvNVtP7Lm3DzMs
	+WnHA8RFrzMIhgMSGZWkd5kI77+j9zT1a/wpz7aDsb57oubtjP2/jiCmWPiZp3VvOPFn/8hpvlg
	zT7Z21dzq05SsHffYtZXqEBXG2X8baliqF9D/PFtW+o1UbXQF4rGunw8rdIAYQ0QobSViwlrYhO
	JfHU/3fkoW6eqdg3wTKzIFlCSuNynASJLqAB1VSR6a/3d998Qh1Chvda6IGugzm6+oYZgwUzV+0
	Kw2RewnW9YyouAPvAglgSfPVpStuA42G4SlwtFdAFsGlEnzQFqE+KePpC3uMR1gfLWsKHApgrHS
	fkBQ7uruY6rMUG9Ah2ojrqT0A7VaRupLE8f7yVa2ywXRLAdhUYSqhh9BL5FhYN6vrtwH3F7fGod
	aF+s2xCjWD6zzxtmCk3vcmIKeG//UwJjvaQFpklG+p38H4P2aobdtMjRJaWX7rrjiZ/w==
X-Received: by 2002:a17:907:1b07:b0:b83:32b7:21b0 with SMTP id a640c23a62f3a-b8761080312mr463805266b.17.1768466024108;
        Thu, 15 Jan 2026 00:33:44 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:43 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 05/18] driver core: platform: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:33:19 +0200
Message-ID: <20260115083332.1063820-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21566

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
[claudiu.beznea:
 - fixed conflict in platform.c by keeping v5.10 CIP code
 - manually adjust the dev_pm_domain_attach() and dev_pm_domain_detach()
   calls
 - conditionally call dev_pm_domain_detach()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/base/platform.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index cd10408e04d0..7f979754b014 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -753,13 +753,14 @@ static int platform_drv_probe(struct device *_dev)
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
 
@@ -785,7 +786,8 @@ static int platform_drv_remove(struct device *_dev)
 
 	if (drv->remove)
 		ret = drv->remove(dev);
-	dev_pm_domain_detach(_dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(_dev, true);
 
 	return ret;
 }
-- 
2.43.0


