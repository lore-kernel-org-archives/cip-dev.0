Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4D6D24476
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:28 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50786.1764872062868798055
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GtqJSSVz;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2b78d45bso624960f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872061; x=1765476861; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2UkU7kamRFbcHXefDDWHPuBahwHiSjlaC7SkFBsOvU=;
        b=GtqJSSVzv95IH3d4OOUSYTtuzj7H4fCkGabE/08UIUVneLJOZ7vncKkAXTDPBHSPxC
         pJEnDReBXNEhQQg5Ltgb4zsH5s9Z6CnxQGjeUoHEKImtHSXX++09o30K2O/9YQr07/E0
         4iBClxM09WEGxHxkPq+lqBPImb8PTsLu2SmZfhNJEj7lH3xA9nkMM6VK6eLGTE7XDmer
         3OR33ms6XDMJ8hhSJoPU0LCdxeHcolxw7JYb4kZ2kRIWneN0FwbfrLUW1pJPjnt1rBZL
         6dTTnSpPv2qhjn6dujEktu61vUHw8wLJNZ2UztkQFMj74EfLSlAz8kz93SUnf9rV6tym
         gZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872061; x=1765476861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g2UkU7kamRFbcHXefDDWHPuBahwHiSjlaC7SkFBsOvU=;
        b=Ri/jWI9c4iVzd0hjebURdC/4xrfOwfsbT4qq207b393uOIkwkEuPEbscC4fW7lPLJo
         vQ8ecbrPet2QODPK8RtcTO3QoK4Cmouw12GPYQHzO76+FYfCP74fwRi6oKkreL22MEp8
         7YD7YBnIwuYzy0NBBMTvOU4h6A2yr/6YIhqhM1Aon6BNXmBT/OysLlMdxVu4h+02FKGf
         L5ArubG8z6Fgm3T0EvCh16ZS4BjhtJWsol/xTJft21R/bItCNiVVrw14YjwfRT2OeOLE
         uCW7htwAHwqEEr4HCW+iFiIT+yHmq9wbNheqptWm1rbtC7qsw0IegUmheU607UxbI5cw
         AfNA==
X-Forwarded-Encrypted: i=1; AJvYcCWqIo6dX0s43ph/HipAnKwhFYiey8qVbXHOLq/+xFANp+VtC8GmeOQ49gr/ci3li+ARu/G9M0Ki@lists.cip-project.org
X-Gm-Message-State: AOJu0YwqN13D36GT+hGOkNoTlRGXe5yvJjll63ECDoT55hBUloRTK8MF
	WdzSpp0fhDBOIVKBTqDfT8Se9sq7w/ULu4H8hOIGyxRSvvZFjlCWrbEXsbEdEpOvKe0=
X-Gm-Gg: ASbGncuwZfmPY0WW975TS9GM9EITtGj3gVR0jQ4bWkpG6vSN48oVQCNCkwn5HjZ9Ynq
	DKtkGgiWyZSfsWEMg0GgIT/XTTlYaVTB0uNu8CiTopbdeQ+rOSUrsgi9FC8Kv3CeRJ3CGtZIBIx
	ZAngu2KaGVHymqIVv/1Nhl+Cu27nuzVrKsiTGI54+d/5VcFSkOd30k9/FBhlNhpOvAVdU2bjJw2
	Nqh4+bmUkJ9BEXmgqi3yKHm5cbauandm3DagMx8PU1+AlLeV91y/zdnUleXBloiojBHnTGiH/Es
	9DKE4Me0pEP+yiT8ZPKnwLgmlOREMUFap8qWxv7ejwDwVR/5HdQz8TIzNb776t0lFhlX+zrjVjf
	hjL9GRWtP2bWYy/USRpwyAs9or/t3ToTyq0XRsg18shNm2Z6ZETlx8GPdFdG9wgk2AjOLYZ0ZbK
	USHKidqkAnAj3lH5aia/AphmRPcvK2slYCVQaj55K4
X-Google-Smtp-Source: AGHT+IHiJEEHHNzItHTB3Qw9UmlYn5In8RiVgUp84t3SV2+C4yhiMHKIRPjGfZ9GL5doBt5BT7ifmg==
X-Received: by 2002:a05:6000:2c0c:b0:429:c774:dbfc with SMTP id ffacd0b85a97d-42f73173f15mr7398651f8f.12.1764872061119;
        Thu, 04 Dec 2025 10:14:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:20 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 03/18] PM: domains: Add helper to check for PM domain detach on unbind cleanup
Date: Thu,  4 Dec 2025 20:14:00 +0200
Message-ID: <20251204181415.689009-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20850

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


