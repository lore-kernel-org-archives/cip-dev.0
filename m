Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CE7D33A2A
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:11 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31281.1768466104278932784
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BnmDG/q0;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65378ba2ff7so1086375a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466103; x=1769070903; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXrWbS5Of2bHY61qwgBAT9LLHEIz13TiDK0masPFwy4=;
        b=BnmDG/q08kbXp5tVLGwk7vaceeQRGQhqSyhiCCFvF/K9g4LwbY0nfEE1jkqqidkHvi
         qxkNVmi0lDofSoFFpbjRqv97H5IbFelhvYiLaO6mcksQiNEb8Bfzn7KgnbpQKmV14oeP
         0Q9v9EhwKIUgFnWuQC/oBV/r7gkztFYWeJzWgZzDzDIDHe/GSFFnHhJoZZJOgrsKljV0
         stp0F+d1sqQhzotsWshSGbpDKT3Bxp8ND75VAoMyaae5rntqI0RFUU+A1zlakxBBZbuP
         03k6JhstMai6oDHTnpE02sFckuM0ARSmLY8w4zd2wk8TlhXVnOh7YtcRqAnjhRbpRVVF
         aWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466103; x=1769070903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SXrWbS5Of2bHY61qwgBAT9LLHEIz13TiDK0masPFwy4=;
        b=Btpi6JrYWmaqt8pkc0J0j4GA2GWn/zrK05oTxa+DuRl+YKk5o01jk2mkpyMQFKun3i
         ijRHUAH4pFff7LBN3rvrvaKOqfeEF4I4jTEG+uOECaexSONG1xntSIiVk67OMWKcdK66
         pJRjVZYG+zjDNLGDfJKCU1upRR5X5ZKuo9zB0rOn+SobhvkOKuF9rYfgtDpbl6JSnj+6
         ldM3/FUybHkbYX6g96GzvV4IKqWMVVy3IDgn0JafePpvuoBQAKXZYauNJu6rsgSqajpD
         eYhrS73NB7LnwVNbtYR6/zojarjk2MF21PfXeaHt8v6cw8ZucZfb9m+Och0DbYseujE2
         Ufdw==
X-Gm-Message-State: AOJu0Yx0MBOulKRHTrLiSz+WeClL/whrn9qrMrDEEF/3gbtVn6xpvD5P
	MLk/6J6a5klP0DuD8iOXW6oI382oYvj8Kn+L7KtpxZup5HKgbtyeXSU4kkwn6F91PldhkU0YNUl
	iiTHq
X-Gm-Gg: AY/fxX6T5LkE5o4mM2d3ooqK2RPnGg9oNutj6aF+0u2d0xQdote6ynru7XiRt8z8eya
	PM1rSbfXNrX/GGdOlGH4DjJuHlOhe1LX0MaV8CT0+GiBcxa/YlYa8q8TDgZhjdglXtKlt85W/MA
	CSmer/U0uzbPnHCnfRtim3ON3O99AQI/lBTjjhge5DbMfGmmN0Z2jc93vmXTXQZ+qFFYAYBJfaf
	3/7/Cb35JfHd/N7lpkz7Epd7imZhe+/vFVT+RjxaJS2zmc/n9k6LRRxMT0yxTJplUUiCdlHwW2a
	bsGOz2ym3im4IKdYUeYwST2JYsxhxhJENHn3BQh7XhW8Lggtuf4uqKlrNtN5QBBOPK3vLGk5YuC
	ETfzdFXih1EX7kiZogg/aqp7sbJtDNrTQSB8ICBrCHldD3z7dDkrc0o+MYEB0jSJZIck1XI7nAl
	FT9RO6nzaIMPUNhHONPx3oLif0a0TVOrLCSgidDpF/0BV0vvBG2FEhwr/a71a64zoI5g==
X-Received: by 2002:a05:6402:1d53:b0:653:e85b:7729 with SMTP id 4fb4d7f45d1cf-653ec4480d6mr4717630a12.19.1768466102688;
        Thu, 15 Jan 2026 00:35:02 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 05/19] driver core: platform: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:34:37 +0200
Message-ID: <20260115083451.1064048-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21585

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


