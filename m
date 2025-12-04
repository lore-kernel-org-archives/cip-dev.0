Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A97D29F98
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:08 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50884.1764872166413234234
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lPT4QNY4;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso6628055e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872165; x=1765476965; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPv3fK35M8y37UZxRYytJAMqohH/jJ4RwTv8Mtvwen0=;
        b=lPT4QNY4x5GF9BJg9sEb3YBObTR7w1pfhYenp32HVLyGCXLAKDud0HExJAVBEkgDFR
         HJQwx6xx6/iC7UpMFWBIvj/fsm2WHIGqTNZGwJfAAYUE8uN6Hj2o20tAXXTTnj44B2e4
         xgjzl7CFaPGUJBAD5ZIXCArYQeG+B0XDIUeZOzpjkFezpC+vLVNWhBGoI+yNEZNluf3E
         CBq2HiZqU8yX3QrlKDANDFiJCZAjXroLbduhqOak4zdpMuTp/kaY69XXxd5waZCNToJy
         YWkXsklVbZrqCl7p/E2KBr8FqTgxwYuESmednKdFYfXiNBlT2ajl+0Mxc93+MdHk8frI
         44Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872165; x=1765476965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tPv3fK35M8y37UZxRYytJAMqohH/jJ4RwTv8Mtvwen0=;
        b=uqH8xrMODjrRCpXSEszlipBFR56P8N1u5kYzPkenVfORo8wUBfWeYcC4NVNHsSLmZ5
         4xWUYQZJV4uS391MyrFXn3wUdBrMWJYnQ7aZog8HFJ/VhMG5+9FSriEZi/JuA0T3WZjA
         K8rYf20YfekMAi6J2/cqcGPqny3oZ6Ed1jYm8g+MAkKmEgvpWy85Z2U6twnR+JslP8CF
         R879KOnOMgog9dIAPmLzv0jTN0EGj3C2A4tmPsnqQVlHiMRjv+0+UlDCxD3rvTOZ9em8
         Iv/+CQQQIfbNkRLEkPwiEgm3pdUD/HpsQKVn0aQfJi3E7C5IjO50YPU/igw4pKOu7VhI
         43dg==
X-Forwarded-Encrypted: i=1; AJvYcCU3hs1HWZL3/VUemtqGO40sIycrhc/cKgb5JATZfiDlCvzcySBs2x6ItwOydHe747BdwaH104wP@lists.cip-project.org
X-Gm-Message-State: AOJu0YzRQjn6CEfJE3nTfMW7z3K1slXawo2AIoNfYKd0Mj/y3HNUY19N
	jU35k0YaR1dSj/koQ40xsODADF+FGtOx57SCZ0m447w1zwSjMl18LTXd029gIGTaM/Y=
X-Gm-Gg: ASbGncvxfzli8fcZZqxghurMEjqttJ/Q9AgAR+ryZpwTQXHK1+Y//CPWfTtJwbC/uPA
	Z6OHQPb/5+K4go6zPjsX1ubBw+qbEYdedv9vpGs1XZTJ5CU6mrR7YOM+PYdJpnD9GsXZnONFOlC
	FxwccuPRPi5SWGe83pIVxLFm1XIX1Vctuo0W2BagAVHhD7TUC3t54JxhtHrVU0FxsIBYimgGInV
	+EbfuDYV1Pv+6dgwqulRW2k/ERvn8Dk74E+MtE+cqIOZpwSfAEHD43JWYRGzH5Cgo4mEnC4DhgV
	WP5IRufYui5Bulo8ojg7GmvADvzvkvhF3MOrff/0xAxYSy3+rtfU1MbeGkW0X6FiQbR/l0YMmfo
	tAljFzWGaFiASZ1pkdg+NyNdFNT8Dm6wUX33iunX+Lt6y9P3S+zx/xopb6k4Yy5+sl2hnaHyoXB
	TeOnzpbssgBeMLjP2FVXCBCAdYxDGTpWLn0E9cv2u+
X-Google-Smtp-Source: AGHT+IEEAdiKSfBwXPv322PI0XYkkzd61Kkg1ns2l6syT5XhCuBtpM7OtUj13u67IZpfzp2x82unmA==
X-Received: by 2002:a05:600c:1f94:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-4792aeea42bmr67686895e9.8.1764872164804;
        Thu, 04 Dec 2025 10:16:04 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:04 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 02/19] PM: domains: Add helper to check for PM domain detach on unbind cleanup
Date: Thu,  4 Dec 2025 20:15:43 +0200
Message-ID: <20251204181600.689203-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20888

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


