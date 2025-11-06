Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA1BCCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:44 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10076.1762416703578674747
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=glSfzmqS;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47758595eecso3227335e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416702; x=1763021502; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXrWbS5Of2bHY61qwgBAT9LLHEIz13TiDK0masPFwy4=;
        b=glSfzmqSyUd8EqqfMPdI6a/NaezE9Zt/r9GER9bGjOipvTqkEUQtvdiNTcnGkh6W7V
         Ca5YBHKOo8owj1N+tfQrbIdT9Hx6qTSYLj2odJuoYfDFReNGKjeNP7h6r0EBCB69dgtz
         mw7aXzcgLJgSxtTVeyam5vAx711UyxiT/ltWmO5wFGT++iYFB8we8c/ZpL+S1/LYP/6w
         agoW/Gq79PlCWSWTAMBSeXgiqH1lCdnX7xtzbDw1nEFvUHECwg6FNwgJGjh+u4o2Lm3r
         CtHifmo0VDS+dC5N+40yeWzr06o6G1GzlBv/dprToV7g0jKBAzo45LMOBIXcdYXMzEsn
         FIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416702; x=1763021502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXrWbS5Of2bHY61qwgBAT9LLHEIz13TiDK0masPFwy4=;
        b=wBWWWSEpIl5kGrtwWCOHeJYfxVnwykjz69LM0upGxQTQ6m1vIasD93xtEnkiZ1B98A
         ZF8vwwl3JFXUVfC6J6kqrNRFe4Id/PQ2/ayDbydtbWNIdsleWoXvGAwHXbEnxkrW2Tdm
         28DGWN3RO1iLVoCfGbHkKabL4RblsCbT1NCDfJucewuvqd9Jqbih+qVJP39bH5N9gxgO
         D4piePgRZLXX/IKhvMa/c2bxpS2af3caZlcRtCiMcncJoOvfzr6re5ZnledN8Z0SuHso
         chIoNrqjFqQnT0nNEo/MYGJUdHzp3/cHKhg51vMhTT0PGO3XGdiTQLEQUeqPQoRSr7K8
         ISgA==
X-Forwarded-Encrypted: i=1; AJvYcCUMbWVZ7XrT4Mlpn5FP1WF5EIDoiTSmyZ4pBUZkvMnrXUVqDVhsly3/HFwPXnupjClTaBe3gK1P@lists.cip-project.org
X-Gm-Message-State: AOJu0YwyjAj6Jt0v9eZs1RQuthEf4EffUd2SAy7I73n7SrLa2A4RfieD
	Y6onZ3YXBVt3VOSEx1bZo6D35d1OV6CIjfz6J0WaFEdRuNRpZZ03o4ptKlM4BWML1EQFq/7RenS
	3m0xhNFU=
X-Gm-Gg: ASbGncsM7dZP9QPYfXZBOHBRPDCEYzvBMKnTYWfutU3X3ysFiUgwHHrRWE6T+8QFulX
	Cb9fwpgHbQ/qjxSa1Xc2yKO7wHx7QhofPkWr7yttA5yox1Gb/mfc0e/iU3ZvRxHKk+RFZ/GtYjB
	jkrdXo+07mxKET9hkFwqAe5SzBXlQ8kXtAqn3wHqKNxpoVNt43zXKR3tLTfDhOtsPF67cCWXa1X
	OlNIBqtuVnstLhY7/F1IA9j7tf/ZaLHg86w7D+ADlBzwlogenkXrqHeZGxbyJuYjF+FWG7hiWdq
	lv42QgRk1P491IRLTLkGq32KjbHxE/ZlP3jr2En2dfYCbGUzaHb+YXe1IvxvfKouX1nmfrhNSXi
	qs2yS/SYc1EmLcqgCliBVy1+D0I22CMZkbl10YwTPQwR3r2h4ld4FLb41CJZ/wzs06mHXcxPZ3Z
	AoLopHC96lbppPP4nXyzgMpqRH032DQfpf7pRiOjqC
X-Google-Smtp-Source: AGHT+IH8YHPBwQcdiE1rTDGQvm/pJeG+A3rbjFY89mvrmBvAuFkdLekc48OhA4DOl5rZWYqZg9fIPA==
X-Received: by 2002:a05:600c:348f:b0:476:a25f:6a4d with SMTP id 5b1f17b1804b1-4775cd9c069mr49221015e9.1.1762416701888;
        Thu, 06 Nov 2025 00:11:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 05/23] driver core: platform: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:11:14 +0200
Message-ID: <20251106081132.2574638-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20398

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


