Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A37CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:44 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10075.1762416701032441824
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=iIAmNkji;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477442b1de0so4098625e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416699; x=1763021499; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e+k4yA7xkEaRZlYKnxKbP/oq1sI68nJY9Ll0WwWqw8=;
        b=iIAmNkjiO5HF4rcTunAeJLQjAfFiZ00JCer2jz4rYrGXyNQAfxW/ACme/rH6Q4u1Wo
         2SS1DGpTUNAJc8mWlmWWWN8QWlV4GN51ahci0c1A5CwMuxm6Fs0WvX/7P/GdVqqLB852
         Wmq2SZvDjPkHEx7pmWcFehrTmiDL/jRJ2I1KavCmAsDmL5Pn50YY3ySZphqQ8SJ7SY/k
         nMJXjS6GVxKAAkK+7x4t8QdDeBzRZ2/tnMUstsfeVGqhreNIyOmEJybXkbK+BimTSKmH
         aY/29oUJg3Wfi63szdvd4qOOZkN2Poiam6CIuk/zZvnnSfD9CIYZF4/VMHbIPeBjwsod
         F5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416699; x=1763021499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4e+k4yA7xkEaRZlYKnxKbP/oq1sI68nJY9Ll0WwWqw8=;
        b=t/cblLN27zCHVV2zdJxDIkEhvfjieG3fRc+W3Qbg72O42W2JkGu0t3oqSv2X7Gc4rm
         JaW1uHR0ljmimjv4wsFSiqRff6BfjmXbrfuLdEXcdmk6gSWgJADnOiLgssslhzAD7bha
         +jaQj/gAfwXpoMXnYbnDz7OyRKLbZ/mZRriLpPUwbTPzEw/paodBex+4JsuT3A10o9Y/
         J+6FYJgMn4iunFL0pv9S84dc5Cu6FBpVZjPD50MEXiQOoAfJlojTmKRQJrUtf3xi1bXF
         qGUjUjbsh8sbi8T2VSEMEcnCEcbeLYK8DUBuA3uewn5tCsLc8bzPY2NIM80+aVhXnFTn
         zRPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQBtjfx6zcdLZ1yuCDJPyHeMHcXUtewYj+B/G5Htq8dUv006GwwGDBFK8+d2H+lYF2VN9qlWja@lists.cip-project.org
X-Gm-Message-State: AOJu0Ywt90G60nTMUu/30cLnihAiQCpL6rNTGsXOWwetRy0HwgrZjVUf
	W9957G1+z9g1EwRjfVALOf/wJ7aVIAj7zNKyQUksOOgpWP9FcGv0TI519ouTOtN4jnQ=
X-Gm-Gg: ASbGncupFeE//zCADJkzxkkQtkCrV7ADiebs9eMl6uVvTX6P2YBH103rLK4H/sRr57N
	+yBVB3byZ0YCb1MUqEuTzDYpeu9eADm5aEXXLgycUXFQXHSehqRs4ZZwyNz2AstbrtEnehql+3r
	oC91KmOFhL10/lvoNWxcFQ94NABwWWN9cyJt3AvUddExXD5SQ0qCgYmiMyIHUj2Z/hKv5NhRbrl
	LmZWhVOJbYde3Kn+54imGu+vSj9R3ROO18kxe8+XZBeH7VdTrqH5zwxQknAv4LJIrkZwWaTROt8
	W77ImRB+J3v+NrumftOzFoKNJe1VaNjLJsr5V8UOAg+LQgvyyNWtJTOqKNALf5g5zXj4oCFFd+P
	kG533ZlNW9EVcdssmYCdi7gmKkhFosHHq/7WH3xWzXwwI2TIfQ1wnYRhyQ/c7s61kC5kprF5Knw
	VnENxUrCy4AQ5t3WGFCRvglaRMcsdzsg==
X-Google-Smtp-Source: AGHT+IEKqAxsXJk2ufeJucNpBkaZCa/Tq5uKqPdkRG5rnK5AnifAWjOpsyiP14lB85kGMMY5il9j7A==
X-Received: by 2002:a05:600c:348f:b0:46e:2801:84aa with SMTP id 5b1f17b1804b1-4775cd3bec8mr67350675e9.0.1762416699455;
        Thu, 06 Nov 2025 00:11:39 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:38 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 03/23] PM: domains: Add helper to check for PM domain detach on unbind cleanup
Date: Thu,  6 Nov 2025 10:11:12 +0200
Message-ID: <20251106081132.2574638-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20396

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
index 1a68e0075c14..da8b9af9d798 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -228,3 +228,23 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
 	device_pm_check_callbacks(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_set);
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
index d05b8cd15055..e6f14c3e63b3 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -429,6 +429,7 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
 void dev_pm_domain_detach(struct device *dev, bool power_off);
 int dev_pm_domain_start(struct device *dev);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
+bool dev_pm_domain_allow_detach_on_unbind_cleanup(void);
 #else
 static inline int dev_pm_domain_attach(struct device *dev, u32 flags)
 {
@@ -451,6 +452,10 @@ static inline int dev_pm_domain_start(struct device *dev)
 }
 static inline void dev_pm_domain_set(struct device *dev,
 				     struct dev_pm_domain *pd) {}
+static bool dev_pm_domain_allow_detach_on_unbind_cleanup(void)
+{
+	return false;
+}
 #endif
 
 #endif /* _LINUX_PM_DOMAIN_H */
-- 
2.43.0


