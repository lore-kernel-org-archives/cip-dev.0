Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1986BCCFA1A
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:35 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10061.1762416748621169705
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=DCs3d6XN;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429c4c65485so545680f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416747; x=1763021547; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uURFDKOZpoUHR9p2zgKbePjSbXhO8t32enXDvH+p/VM=;
        b=DCs3d6XNx2HuZHV0njpGZbYNzPlamBkSbg4YgX/njHKDQUR/zFPVw46AQdvhZdgnby
         HcVWWEnuHvp0mb09gbm4OU6j3y03UlDaRtuR0ylWqZrzDkC+lIJan/zcN+8mqILqHRuQ
         iSoze+EF6W0UbzpkPckd4CxLWpdp1iLfr1RCvP1dyXwYlUrKQtfqbd2ZMwF0BWA6MpEz
         eSs7TaKo3f+AwGjOpbx0CnrxR/3F4RPLkXjCeuAFnbZdPPpH43lmOG3GRHytUenPB8Sa
         G9KrN89RyyDClAKL/+Hl+krhHEsZRTmtSGigF9xCFhRBE5ZnRq3SGKovfDA9f71eoiCs
         mrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416747; x=1763021547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uURFDKOZpoUHR9p2zgKbePjSbXhO8t32enXDvH+p/VM=;
        b=Yu6ZBb4sxu+nwvjW3LAJT469JGTq9Yn38B2c22+LOCUkbmpaw1Hwd6O33WFcW9JsLu
         wH3yEWU1MB2j2Kqmp1MECo6Dz8MCmgzy/6LueNaLktT65jbYkHmXpIOEjMY/YoHMDkdl
         bkgQ8401TuP3T9md4U/vlBOewqXolFoCV6x9MKvG/wVZjZHC5lgNqDHxX2SE1KUmlde3
         EGQY8Aa+sr0O3ZnqzTM5xyYwAJMAAEqCSJpaMajfI6vY9WtFQrSImbngO3hKpuFB/+rm
         YtoFuvWyfvVFfI3gyvzrNn7d28NWf0jpl/y7eyMOWvIDiHitVvX2m7NnuM1WWrY7ad00
         GHxg==
X-Forwarded-Encrypted: i=1; AJvYcCUrCgajnSN0KILPalVsplTqlcltbAGWcp5YCScRIYjA/wGJgPuzSmU93UbijCzFYTd8KbgbwBtt@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxn3FerWouWfvb87esRM+Ubzrh+y+4OS2Bm7d/E1VozwzqcJuzs
	2J/0Np260DXjJW2txC1OzJ7RrXTTB5Sv/jbk3LIsaypZrgLoPYGRnpl1UrIvJoMQ1tw=
X-Gm-Gg: ASbGncvC2OuSSet6Kfn7t8KIAb7tvWDRSl0oKSfhwWuZ3Int1pB2klCpLqrlWVOZJDN
	HLcTih0w7Lic9uFi1L+VhTBZgYsBL6HPeCR/oEddu7d2fde4lmn01FPGzMg3ObvGTidkcGUuTWg
	uiTojFGcJZ/74JNNPmSKE1scfivZgzcl8+hysOWZy1lN1PSwp5hzfk4WONBtJCKbfo74SJF65L/
	FNfJK7G6QPrM08u0qohfZOmRXaW1qsluSt60xBQK4Y+3ii3N7uRJHrCXTmpzKwmejo/qyL075v7
	s/6BRMFAqNifKIiKgb2fQPwlWbNuCAECj2SNEOw/lX3puKhEXzsEDML8cQIzQVTOWxUplM92Nsv
	ag6+1N8bvSOLI5AYSVNxtAPAG8zdeF39gyV6mCem6g3PwKWilxDNCDNSyy2N6D+odTuPQRBpTjy
	pIqPQ/zxYZGAygkw68jYUsIK8gWCmLRfypi7UG76YQ
X-Google-Smtp-Source: AGHT+IFY+tEtPjv18cfdjm7KK91ZU+N8GFjTlLVblcAQv1++uyQSENejwKnMnx8rsASWIZMFsSUV4Q==
X-Received: by 2002:a05:6000:2c07:b0:429:8bfe:d842 with SMTP id ffacd0b85a97d-429e32c8362mr4784726f8f.4.1762416746975;
        Thu, 06 Nov 2025 00:12:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:26 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 05/22] driver core: platform: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:12:01 +0200
Message-ID: <20251106081218.2574950-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20422

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


