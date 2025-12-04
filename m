Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A9DD29F89
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:48 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50855.1764872140906931676
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MMCSliyc;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so10315755e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872139; x=1765476939; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXrWbS5Of2bHY61qwgBAT9LLHEIz13TiDK0masPFwy4=;
        b=MMCSliycPkbfPUf97ib3PlmoCXWafmo/ZDC1nwUj4Uq6VSWX7ED/Y0XNgLDYn6PyHV
         JWVQk0KzKs7jIKmm6trXzZu/HN9grxrhCty3iTy4Txr8yzQ/GSmFpeKXgl0bKrLDgMoy
         Yfl7K6t1FJNjxk+1laa3Vx/qKYn1UcugAPIOimzGXAeRl+AoYAzuBOdi+GyJKVkH+DHG
         xHcujMq6NgFeQnh9nfDQ2DUBvwTqbQXDUwCgYIZ5maf8kJ3oGGXasrh8Wsx+dkbuYNGI
         mEs5k3mLkgXNzPA6xExBfT10H9+Dgs2lnK/D+Pwd2/XY1aHWTaC/KPAVw0jIROqWgDLY
         hi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872139; x=1765476939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SXrWbS5Of2bHY61qwgBAT9LLHEIz13TiDK0masPFwy4=;
        b=JdcJZawT48PKrLeeW9I614UZ4AX3yNeGioNunU4GzlQ2kuIiZ0FH+Q9e+aNff55dqD
         MDs1JNbkSM1Pbk17g5KvM7pWMnji/r0TUrO4o1f/b7XGqvPWQkjqNipitf2gUsAQcFXQ
         XvI+P95xFYnG310gVima+5Td/K6li5cC2VfBcLr+Vjb6gBi+oS2S528ZVarHvFgW3tv6
         jN+1ZgURP2sVNzUBcQlz0NWKTwbkYC5MEUAGyToXNBhjfrC83BqjvtqIfCdMUv0xqH8r
         FJZbqbnjzu5VbKhU9/u+UjSkbuXm6HJM7x04N5livXgwbw/qgfgWNMOnLZ2U8HwJhbMz
         5WtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQBoyoifWPKJN9ltUMu3TPDfQrm8QjVgFLoxi4L2XD9EQ66HsDBJewbYUG8c4RS7XU7kkGds4p@lists.cip-project.org
X-Gm-Message-State: AOJu0YwRNwTXicrjaGcfesA1S8Zr3NlzeeDIdsQ9BPmGzwKNZrzDMOYa
	xWvmygwBCD6ebvfajo+yqEMLIXbea/vDkbtqjq5lxrGZg786Rm27SBfFw4EJs7V3vjs=
X-Gm-Gg: ASbGncvQovFhlFPIP6c28x1b/OU4/6Bjj+QNeQFtCydOuqKIdpFXB3NWiy6uklKAd+/
	w+xw/hGt5C0wERY8AE26x3NdbIzC1++rZEWZV/c3QmRWcCbEwjxrP/RudiD09feL9o4LrbJ+0JK
	4QYJn7HZf78CQiqR7b4xORs3b67rQtdzbZeBJ++lLPoyTRBfusBWL6fORB3f+6GeV2MsOU+q3Bk
	ETDFOFdMnXr2E3KsGSu7i3f59aAZjSHqvc8TQr9EdjwDjhErHI5r6rMlIeUmJAcKD/eh68CPnJL
	5ortLCsQZvZPrJwvhUvLtdr84t5zf87npD0sikN1JCy8aL2hLa9D9vmXTofvI21UqoLQUf2DH4S
	B8WVOzW8SEfgedwi+eY8vbVqywOt+HOWAw89/zpEoOOjNLOH6R51KIjY7wCs1OX/ZUxTJpKf8E9
	S1CJBMl7LQ8S3SRHXIdaRZhhG14DneQjz+7xgyKf/T6iwK2eRzqg0=
X-Google-Smtp-Source: AGHT+IEZWn6sXRJ2C/Y9uXgGx/NhogUaSa6nRZHKaIkRdhb/jR63buU1N1FUM+Q08z3HHGd4Hkr+gg==
X-Received: by 2002:a05:600c:4584:b0:475:dd89:abc with SMTP id 5b1f17b1804b1-4792f25b843mr39269775e9.11.1764872139218;
        Thu, 04 Dec 2025 10:15:39 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:38 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 05/19] driver core: platform: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:15:16 +0200
Message-ID: <20251204181530.689132-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20871

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
[claudiu.beznea: fixed conflict in platform_remove() by:
 - keeping ->remove_new() section
 - conditionally call dev_pm_domain_detach()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/base/platform.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 14fde28de3f8..62e8ff1ece97 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1392,13 +1392,14 @@ static int platform_probe(struct device *_dev)
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
 
@@ -1424,7 +1425,8 @@ static void platform_remove(struct device *_dev)
 		if (ret)
 			dev_warn(_dev, "remove callback returned a non-zero value. This will be ignored.\n");
 	}
-	dev_pm_domain_detach(_dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(_dev, true);
 }
 
 static void platform_shutdown(struct device *_dev)
-- 
2.43.0


