Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB2ED24477
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:28 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50477.1764872065168531404
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=InmD00Ve;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so14748775e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872063; x=1765476863; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uURFDKOZpoUHR9p2zgKbePjSbXhO8t32enXDvH+p/VM=;
        b=InmD00Ve7CHiYiJHsxKU7ST4lvVjFPkYYuwMIDMNps76Xb0VU3SM74BeEJ6kXVBlp+
         Kpuf2g7XSoxhyo/rCuZ7U8I6JtCdztQlKKDGUvix2iTkR/rn7ECs4N4vWlsB23awIZER
         JlfIQI1YyMhRWkoIJWax9YIQvDFimwZ/vtjCWHVfdDoYrUMZzr3Ya1ie+bb7uFo7cirO
         uTbmZcRkqqaVw6lFMxQX+QNcj9In+rCixA1YV/mdd7bXwsz6a3HUljhb6sXuWPFZkYqJ
         YgQLNUNnvsZQy4uh7kQOm7RpSbhmVC8FymmAFAw5K5hnYGoqum3ay5vfC9s4xHhDBL0y
         AYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872063; x=1765476863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uURFDKOZpoUHR9p2zgKbePjSbXhO8t32enXDvH+p/VM=;
        b=E2IDk1aWxmgrob33A3j5BOe76+DNCtf94HQ3NJ1B1WWv94ZFrjqB2m0tBcKuQNb7/W
         Z7tVQ970dI0srI3eOW0MxlVpVKrXtAbywi+MMySvxp+kRK9XFWPepzQ/djO/wifZutTe
         zGtNHN2LwvGD5SXILNRNFXnofl/12uAYmXdhJTUhhKIZ61GpFzSVARJ60CBWKFxVCQK5
         1Yu8qGb22SU78fD0yIjTLd38rLgIFAjXY82jdxbR3z19vLldeW2+piBMHJYuEQZ6EZxk
         9NmpWnNBlmooj1k9McDpAjkyhNgG2QDIbtZgiozMKIYKUPytwXVvnsZhZ6pa544t9poq
         TYSA==
X-Forwarded-Encrypted: i=1; AJvYcCW5Q0u7CjQLCPyKK72cUhweh7/rUbqiktpaR9VLCfuAWEsu7DEs0vx9KZRgeTDpLnYnC8T0EMNL@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw4I7PSHANZ0SOuYJAglIClSJOMywdJowQbin6fvoAcUpw6AYJ0
	Cw+DarfSUJRyNOcA0H4BBIC61r2wvaSGRUyW8C210DjZLHCKu5nuWPYoQabazMybVvMme5+r7pl
	8iVwB
X-Gm-Gg: ASbGncumxsHPqnDwnRRM7YGgS/81ClcPAMLd+L03D3Bc0f+Bhseb6y236Ld2NmFXj3U
	NJGlzXslMIo4Xsb01PlbNVtzEdlo6Byvwfpb85NC+XU9+PaZIXPA5+e5KUgL8pc52hjqbSqQ1V2
	w3KhYsX6J9AByZI9o/r+mfqZqAT3VP2xtpAgb2ImD/7tK5uaLWB3u7Od39RYAMtGtzMmSDd4hSN
	aUA2wTjtnrEhbtFuQ1F6EFrtdUJtwrKn3sAQza4fEgMaosftMheztNScnFSdpMbl4JljZGHy3NA
	FHrgnakLBeUn7ExwbgGNwg+FLJCLMpcMzDtE1a+BvlvGqxGKS0Bzky3pDVOuDAaZDEnUf6T+kw4
	cjlokacL2tTFmlWF1kkPDW+wXwCVzOA0TQCPWTQlkDXV2J8Y4qX9cGz9kBiu8nkLPpmTH9Ihx9O
	WfkY7vAv/B0s5FHJ7knxKRcafD/utCug3F5vSb6Fepl+oE+hzsB+E=
X-Google-Smtp-Source: AGHT+IGLDyCZB4Kb4B8EFt1ZA/LWyXzUvcPIAeEHNOWuUUvOKFzkMb09EsTdFqYYWmJwQ6u3KV6Bwg==
X-Received: by 2002:a05:600c:4f82:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-4792af1b2c3mr71999765e9.20.1764872063426;
        Thu, 04 Dec 2025 10:14:23 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:22 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 05/18] driver core: platform: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:14:02 +0200
Message-ID: <20251204181415.689009-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20852

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


