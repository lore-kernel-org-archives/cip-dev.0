Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C46D33A1A
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:51 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31251.1768466022686928278
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NF/DwQ35;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b870732cce2so107623366b.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466021; x=1769070821; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2UkU7kamRFbcHXefDDWHPuBahwHiSjlaC7SkFBsOvU=;
        b=NF/DwQ35pv3BzEtejAhjmuayNqo2nJaxVko5xijVIjOL+jk1O1Wf60/uNcykPuGQQz
         6uNx9Dc43g/QIyClyZIaVOmrV74M3JXKZMB/zTrJBOLHGUdfR4VWSnfS6BFDWW4rBI4U
         0jsmprJmOFRZST53Dhm1lMYrP37K3W7BLTMpkj2d9IjXqzj0DFirDjJykREB/wlrLKNs
         EIc/MPxDDQeHxkH2EawMzxMRbdkKCixsS9jX88+pG0H3019gvgyvsfVEoGgdReMklRZQ
         QwjGmxF3SNX3TOdDd4AWrEw/U735eMfKrqbso1L0Jh00JO2fvFHfvYQnPrbE0vI29D2A
         M13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466021; x=1769070821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g2UkU7kamRFbcHXefDDWHPuBahwHiSjlaC7SkFBsOvU=;
        b=ibp53ohFmVPOmOOuzh1fDYowW6cQc33KS7I9AOyCV0JCnKmnXQEzGzVjSiOY3MS491
         nrH2kOvlzw7jA2w+OfANsdsG2Gg9oj/aAz25Wj+tNABdAHdTw9lGZ0MfE2+afsPUfPBn
         MA1nagkXks6Gffna/3TJAIwR12IVMDc9+YLT6I0XNZ8vax4ph5tF3jPKg/wHgo3n0cXv
         8xiY0u7QJzr9TKz7M73V4/ZQLPllG6uvsepRxOJm3DlSFu2+3vmHOW56Ti7RLVh7epLa
         wvdih3mlrGthq2AHRB40S1PnZvlmrOr4CDTDkmn/L98bxXiVmdtjzvaLDQZTWYAanufu
         eqqw==
X-Gm-Message-State: AOJu0Yw7bv8a5LHZ5R515dpasdTM7Wf3LHt9CjctE5nNA8z4QTRAqX4n
	IZ2WJ02RXJtXdzMVPt4r/zLOiUteepVBUcKdEisUIicCSeF+zhU9vV9eoPebkDUJetyx0muQCx6
	6oVXh
X-Gm-Gg: AY/fxX700i/x6OA6tdZBydxfLt6rkYn4THHU8zN6Ou99YE4OEdGo7i2Y1QjyvTmGubf
	hEq7aWSuLBTjTykIUeIQ/hwplVPtI455k9V3SNSNaQePdu+ap3hefHQIl0A6tZbsea04/R3tW6P
	oK34W5CfGT+U4Z4JNh+mgZTp+HfKYVhT1UDe06SlISCw44RCVpaqLH4UamEdogTaK6KX/DmFx7E
	8iIyWPe6R3YJVIdXMawufrlahMxfYO714O8rTabKfDMynVd71KwdzaZha9XDhcYflVbazN9PG86
	jtOKWVBmxB4o+l/MZ37FnF/Caxe5a33WNsskzG4Q75nYHb7iOoLI4DiTQBPf75ClOJzKgX2OufP
	uPdU5MvA7pDaHvNkYaBLXVZuIz20w8E/R+W0H+C9q2BrpnjmmftBwWkNyeUX3hoXdrOAEUpC8+J
	8aD2VRq3FG472tLoEylGDpQkUkkdnyMLmt2u6TzwwGIuy3w1JqPtX16yZLtle+K055zr94EKv9N
	nS/
X-Received: by 2002:a17:907:948a:b0:b77:1a42:d5c0 with SMTP id a640c23a62f3a-b8761278c6fmr452526066b.43.1768466021115;
        Thu, 15 Jan 2026 00:33:41 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:40 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 03/18] PM: domains: Add helper to check for PM domain detach on unbind cleanup
Date: Thu, 15 Jan 2026 10:33:17 +0200
Message-ID: <20260115083332.1063820-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21564

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
index de0eee2f0057..593fb5bbeb97 100644
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
index 9c9e4f3d7a73..4022ee6b5e72 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -411,6 +411,7 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
 void dev_pm_domain_detach(struct device *dev, bool power_off);
 int dev_pm_domain_start(struct device *dev);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
+bool dev_pm_domain_allow_detach_on_unbind_cleanup(void);
 #else
 static inline int dev_pm_domain_attach(struct device *dev, u32 flags)
 {
@@ -433,6 +434,10 @@ static inline int dev_pm_domain_start(struct device *dev)
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


