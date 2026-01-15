Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F8ED33A38
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:21 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31323.1768466173396508904
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ipdBFACo;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so913018a12.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466172; x=1769070972; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPv3fK35M8y37UZxRYytJAMqohH/jJ4RwTv8Mtvwen0=;
        b=ipdBFACo9MmU70bhUY5xZD4CvUzNxdi4kXyWsooDe/NQiQuVSA3yVjz0l3DLCmvKXu
         LEYhleYxHzoURo6JPQ+t6mrZ7KWBOVFmo5doOuIBScm0oYsSJZGaY5sDGWMvbNmueOSx
         m3B8XVnjbagcuobBfLNLVhZUAe+2CeKCWqixtenNMbxw4LhcWMRJ0bzVqeR6O73wWn6u
         yJETNb3A8rqtHy8v388NAmMsY7WNOIViD/8oLGVKsbl4G1lJ7kcD+kp3fveJ8k203j19
         0GSd/qzM/K0h60qvU2jv6qgVEJ9WfavK7xb77CwV+MAwQ3JRDSdiYZMDEkX4jZd9+HcD
         xXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466172; x=1769070972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tPv3fK35M8y37UZxRYytJAMqohH/jJ4RwTv8Mtvwen0=;
        b=butKnG519dEFlhMBZur1R1wgxSOWUPyp4eaMRTIxMZPiv4+HddKw2ZZOtYxYJJWgbb
         NFf9d0a3C2jKbvIGaiIkjNS0cpkYfweQ+fOJKHzfEVKbM5ljfvX4Jge9e2OHyDqD8jA7
         bowz4e2c55HFkUIifwLA5YcdDtqDzlnk5BwW1VRhD/tUKuh0Axr2VTZx7GWMGloU18Uv
         05/MTw7nVsXo8ALl7nkb4EskXkgSzukADvteSz//W8k0zKXCRqPisuYCaholxlvOvXyb
         IhV1cBHP69T04r/8ANpQg3UoL38Kfd+ZYEH79UQycN3bRNK/9fBmauituGd7HwtdxljW
         ZA/A==
X-Gm-Message-State: AOJu0YzDgf693JPyHpsALz8IEwLxJzHn3zczSRz81gnI3OZ5DqeO43Kn
	t5KiSP0Jw4VhEQjzdAEKY6DBnl4epw9uFUGiQNuyRwsX8CyFPWRNh0HzK9a9TJ6NyL4=
X-Gm-Gg: AY/fxX5dXyz9QZdg2kosV74bzpMOrhUphoGckc1guHnPcPfgtvTEPwVusnQvr9Px2ku
	q6KsOSkQLH9ytmjCweyquueX79NRu2C7y4bEu9ATk0pKfYxEJPyJRhYFfHWRW6VHZ88GkErcQNP
	RwVjPOvHu50nNXwJpALhCYCNB/jcIi+FKjZBqaD6wm9F57FLdmqvuX00byQ4pacjziHKPP7HpqS
	PWdn6ha5jaV8JzBuExh9vW13vdjUTLuYNZB9F/+6iBV3AvM+mfQ/5nKwev0qugwrtCbf6TYki/X
	R8xdCokARysfVP71e53Z4cjsst3KkAtZxo6hVejdMUFOKwcwN1HhbS458hhlDz8rWrXgHfQ6YJX
	mucwae2u3hLPvI97mAmMH8A2X0PguwW7zFyL8JsbnmjM68oxD6YufnwnJnvewpAhx4odZgmbvbo
	50Gc/usDk8JoEUB59ghwK/Nczii9RP+ArZr+WUhfKEJDJlJ0ecBHfo3lGZ82xDyHWSeA==
X-Received: by 2002:a05:6402:13cd:b0:64d:1f6b:f59c with SMTP id 4fb4d7f45d1cf-653ec47c13amr4997513a12.32.1768466171812;
        Thu, 15 Jan 2026 00:36:11 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:10 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 02/19] PM: domains: Add helper to check for PM domain detach on unbind cleanup
Date: Thu, 15 Jan 2026 10:35:46 +0200
Message-ID: <20260115083604.1064260-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21602

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add helper to check if PM domain detach is allowed in
device_unbind_cleanup(). This is necessary to avoid issues when unbinding
as decribed in commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()").

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/base/power/common.c | 20 ++++++++++++++++++++
 include/linux/pm_domain.h   |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 0581fa25460b..abbbcf85a5b2 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -433,3 +433,23 @@ int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_set_performance_state);
+
+/**
+ * dev_pm_domain_allow_detach_on_unbind_cleanup - Check if PM domain
+ * detach during the unbind cleanup driver remove phase is permitted.
+ *
+ * Returns true if allowed, false otherwise
+ */
+bool dev_pm_domain_allow_detach_on_unbind_cleanup(void)
+{
+	static const char * const pm_detach_allow_list[] = {
+		"renesas,r9a07g043", /* Renesas RZ/{G2UL, Five} */
+		"renesas,r9a07g044", /* Renesas RZ/G2{L, LC} */
+		"renesas,r9a07g054", /* Renesas RZ/V2L */
+		"renesas,r9a08g045", /* Renesas RZ/G3S */
+		NULL
+	};
+
+	return of_machine_compatible_match(pm_detach_allow_list);
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_allow_detach_on_unbind_cleanup);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index be1e09f297dc..4a698f926185 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -503,6 +503,7 @@ void dev_pm_domain_detach_list(struct dev_pm_domain_list *list);
 int dev_pm_domain_start(struct device *dev);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state);
+bool dev_pm_domain_allow_detach_on_unbind_cleanup(void);
 #else
 static inline int dev_pm_domain_attach(struct device *dev, u32 flags)
 {
@@ -545,6 +546,10 @@ static inline int dev_pm_domain_set_performance_state(struct device *dev,
 {
 	return 0;
 }
+static bool dev_pm_domain_allow_detach_on_unbind_cleanup(void)
+{
+	return false;
+}
 #endif
 
 #endif /* _LINUX_PM_DOMAIN_H */
-- 
2.43.0


