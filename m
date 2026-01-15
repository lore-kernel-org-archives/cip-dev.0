Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91998D33A22
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:01 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31290.1768466101003098892
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Umys45N4;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso853286a12.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466099; x=1769070899; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e+k4yA7xkEaRZlYKnxKbP/oq1sI68nJY9Ll0WwWqw8=;
        b=Umys45N4BGH1IpDRQ+Ida+M8HlLDG1u5JsJCBFLqf/61kCdJ2GyNZ8vgXWQRKBIP0L
         mQmveLf2k0XUEJD/YWU/YIXK9ran2aul4pil9roOpXZO1P4Kilz/fxVWTj/0ZwGN1zO0
         mW5bAxZiWn8yMquucJ1mTxEXV2JzXeURd+dXIB9wdFgqdzZ4YM4rTSE4q743xkpJx5rP
         e4AZ2gwscrXaD/DF/Co0NXVJoMOfjsCPgDo2WQwyZ1a8OxdpFvbN6dyKf2e39N2VFvxp
         GBEbY2tM6FYXSwffsemCuIRxIyDyDy210ED1gUZIzHDzGtwNjqWhFOa52bQ30N+cNb0y
         0Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466099; x=1769070899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4e+k4yA7xkEaRZlYKnxKbP/oq1sI68nJY9Ll0WwWqw8=;
        b=B5pi/JraJTzaB1JgbwacEbppu4J/Rbzfaiti53l9+bVULEjBQAQ7UP/uIgZdxAV+UY
         xMfF5c/DMoAE2aRe0WrGYWgBoLOYsX/Qxz9TT6SQp/NQgiQcX+lw2v8B6ZB54dXFzkAw
         JDiJZwqvLaLLFz5ggMzEfn0Cr9wACbYNkM34L2r78hPI65mSG5vKPERapodNv68yoMMU
         duB6JAIxEwRsi2vwOL8rkr3R4isVjuUgcmV8v8fL3RLK6VSKr2t0GHOoCMh3cdSYmP1y
         PYQuKiPzu7dA13xomKw+RriEwEKvJHUbDX3GdRjK0VJJISIIGPO633en03GscVRhhXej
         N1OQ==
X-Gm-Message-State: AOJu0YyMgh7gO8yMKMLgoKwmuXjyitZuNIH+OG9EGvBUDtCBsixe7/Dk
	ZmCm/TVCKasDZlEwOSh9hV8l8a2Weg58jWx35kjXgnxnMMeb/bktNaRs5FHHdsQguWg=
X-Gm-Gg: AY/fxX5v0mxuKuL+jfQCBubMmjAk8Lcm8JgAS+XApOf0A7jG1fLGd+pu8tSJdj7kGaj
	WOQa9GzBKZH/h6p7qh2RFY7g/VVIeidlZCNw0dx32b/JTpy5/H+RVS1Z08G6O8Folwx4ZtrNtTX
	fBG1SXGvpoOmgEz9c42tUmXY95jOsLcMG7W6zEOUDddSxM39btTU5esP8MqOhZ0FrS1T6ckOP0D
	yma/szYuEGgDVaLs4M6ljkS4noEBWR8skrFcQ8ikOPvp6oPgXZkRzdFDUH7KhalA4eb9A+XQFZT
	mr8Y1+QTWUnCHvp9GpnA9LGP1vJ2sPuGd6yiSeAm+8uGsC0O0Cqndv7iRD6mMDiuLPb2Z3pcX7U
	zUlzmmSMv+Cxup2htGMxgPggYw/2mWwdtsmpEMorGSFskernd/GGtEZFQLObrgLKXNTXc+68eUU
	nFoP+FixudYCGp3uLEZnpKnCjT/faGpssdgMJPnEoL2alGXIwlJFJOUFtMJjp8Z5YqIA==
X-Received: by 2002:a05:6402:278a:b0:64b:5f4e:9e6d with SMTP id 4fb4d7f45d1cf-653ec443355mr4168578a12.18.1768466099364;
        Thu, 15 Jan 2026 00:34:59 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:34:58 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 03/19] PM: domains: Add helper to check for PM domain detach on unbind cleanup
Date: Thu, 15 Jan 2026 10:34:35 +0200
Message-ID: <20260115083451.1064048-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21583

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


