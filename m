Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E087CCFA1F
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:04 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10004.1762416655689152648
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:10:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NsHsjifd;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c19b5de4so577736f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416654; x=1763021454; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3qHi8NH1X041G4M6x0jR2QhEvLGy3ihpAm0uUJAa0Q=;
        b=NsHsjifdgka1EWv2coUnwDN1AlFaml22j5GDvDWM56NOkMOvapIxw1x2TpxS5mPtF0
         RFYTl4nTfBwy6g4mWVejCISoDhdIbK7O2gUKctJfWGi/V4poS1X6bCPzXy499yLU/03P
         mQ6dGUI+vJa27UxQKFcSlditHV+UkuAT/qsrkV8MXD81iMpDvdN7U15wduKC6tawF/01
         bheMoIexzM3vmvXOPlzwbjmRKnWz6QWs/geyB+ShubAckkCXYFOZdUOX9Nyt4lV0q9nx
         /CVc712tBFMfo5bzYbwX0EBoo/LKtGv1FCPydQVxenncbjHR/s02feuU8JbjX4dt55Rf
         6azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416654; x=1763021454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3qHi8NH1X041G4M6x0jR2QhEvLGy3ihpAm0uUJAa0Q=;
        b=Rjqm8XfJ0Z84o+lRbNvJ+tONnJ4zR2Cms1qWDGt4kNiJLBFuc57KdsY0CZNh1f7mMU
         lsoxnHFbptVvHHy+F9KOEJg7EJLv570VAwf0tpir2QmLzipWeIuATNnIZTln9y6U+fui
         snDuBUpJpBVDMdL+G6KoJa638XLi4+rmoyBk1zCW/KO8fxzBpGnj+GIUdHWYujuwRbYi
         fbFlcnHgy9nIqbu8OyXA/qIC6vKSLQ+3s+7AH20gEg6McWfIi4Pn8wxu1ap0XcJ6A8SY
         rph7QsdgyiMRuxTM7+1njhzvmq5ehHxI7lTmbRmrDhB3WKJSazCY4pLuDm0cjsl6OXyj
         khcA==
X-Forwarded-Encrypted: i=1; AJvYcCXo1Chr+ZQcMHZNngn4r1H2s2YNjo/UoBl8ZXtNpP1DBd0M80RK34slD+NNCHlwhCqyhJSty3PE@lists.cip-project.org
X-Gm-Message-State: AOJu0YxM08KmtySCX0relkLg6/bMKG9eAiEzpMI21Tzaiimj8LT2r2Sq
	SFZZWUeD8USQ/yQvIlm+eEfMWAdCT2SKgXdmRkh7HFhJOLPUWu83TG0ZxEKAI0+P6tk=
X-Gm-Gg: ASbGnctscRLo+fGfVB5AWlEcuFQjSVrDpZYRVvPxksO5tvrk//d+TdGrle3qLqA7Vfm
	9uLQqcB5x36REHeLLMpF/TCsVblXir6AmHhKvLoKv5a9LC2QL20toI0R1PQdPC+xwS+XlWF4GTs
	qTnaoRuC/sJy1IcX8FqjdcxmCpL0SyoGsfWmHZQlYj2bZauAZFH3JKFiQA5GrCfJRIcPwUEN4e8
	OgYrPz4NwCu5lr8YYQbEElBLlORhUwSX8HwHGHgbeeP8f/1zmXDkC3BgS65wz1egAL/lAYETxyQ
	FnwWXNpoqDFGlkCuTaYlt4meqYvfGMJbKK/jQYBMbeFKdPw9wr2d46iB7OWJN2cyT3NVYjZ65sG
	a75PXmRJMceR/XIlv18UnoDHdPE9FUWsIKnBOShOHplEHBoXXZe/CXpWeW6bOh0GGujjFhonrtv
	2MnwhLEjH6M+AvpmTq0X6UpwIIKyWrIQ==
X-Google-Smtp-Source: AGHT+IGKTkmLxnRAg38EpOqbpwR4JVzbbxWHFY86py4IyPDb/hS7l5S0FlkQMF84ARSDv+4UGbJL/g==
X-Received: by 2002:a05:6000:210c:b0:427:813:6a52 with SMTP id ffacd0b85a97d-429e3307585mr4142990f8f.41.1762416654013;
        Thu, 06 Nov 2025 00:10:54 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:10:53 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 03/23] PM: domains: Detach on device_unbind_cleanup()
Date: Thu,  6 Nov 2025 10:10:28 +0200
Message-ID: <20251106081048.2574345-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20372

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f99508074e78fea17f06d753d9ef453b174ec98e upstream.

The dev_pm_domain_attach() function is typically used in bus code
alongside dev_pm_domain_detach(), often following patterns like:

static int bus_probe(struct device *_dev)
{
    struct bus_driver *drv = to_bus_driver(dev->driver);
    struct bus_device *dev = to_bus_device(_dev);
    int ret;

    // ...

    ret = dev_pm_domain_attach(_dev, true);
    if (ret)
        return ret;

    if (drv->probe)
        ret = drv->probe(dev);

    // ...
}

static void bus_remove(struct device *_dev)
{
    struct bus_driver *drv = to_bus_driver(dev->driver);
    struct bus_device *dev = to_bus_device(_dev);

    if (drv->remove)
        drv->remove(dev);
    dev_pm_domain_detach(_dev);
}

When the driver's probe function uses devres-managed resources that
depend on the power domain state, those resources are released later
during device_unbind_cleanup().

Releasing devres-managed resources that depend on the power domain state
after detaching the device from its PM domain can cause failures.

For example, if the driver uses devm_pm_runtime_enable() in its probe
function, and the device's clocks are managed by the PM domain, then
during removal the runtime PM is disabled in device_unbind_cleanup()
after the clocks have been removed from the PM domain. It may happen
that the devm_pm_runtime_enable() action causes the device to be runtime-
resumed. If the driver specific runtime PM APIs access registers directly,
this will lead to accessing device registers without clocks being enabled.
Similar issues may occur with other devres actions that access device
registers.

Add detach_power_off member to struct dev_pm_info, to be used
later in device_unbind_cleanup() as the power_off argument for
dev_pm_domain_detach(). This is a preparatory step toward removing
dev_pm_domain_detach() calls from bus remove functions. Since the current
PM domain detach functions (genpd_dev_pm_detach() and acpi_dev_pm_detach())
already set dev->pm_domain = NULL, there should be no issues with bus
drivers that still call dev_pm_domain_detach() in their remove functions.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://patch.msgid.link/20250703112708.1621607-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[claudiu.beznea: conditionally call dev_pm_domain_detach() on
 device_unbind_cleanup()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/base/dd.c           | 3 +++
 drivers/base/power/common.c | 3 +++
 include/linux/pm.h          | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b526e0e0f52d..82d1d9a9d531 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -25,6 +25,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/async.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/slab.h>
@@ -552,6 +553,8 @@ static void device_unbind_cleanup(struct device *dev)
 	dev->dma_range_map = NULL;
 	device_set_driver(dev, NULL);
 	dev_set_drvdata(dev, NULL);
+	if (dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, dev->power.detach_power_off);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index abbbcf85a5b2..ad929eae0de1 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -110,6 +110,9 @@ int dev_pm_domain_attach(struct device *dev, u32 flags)
 	if (!ret)
 		ret = genpd_dev_pm_attach(dev);
 
+	if (dev->pm_domain)
+		dev->power.detach_power_off = !!(flags & PD_FLAG_DETACH_POWER_OFF);
+
 	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 97b0e23363c8..fd4926168a1b 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -721,6 +721,7 @@ struct dev_pm_info {
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
 	struct dev_pm_qos	*qos;
+	bool			detach_power_off:1;	/* Owned by the driver core */
 };
 
 extern int dev_pm_get_subsys_data(struct device *dev);
-- 
2.43.0


