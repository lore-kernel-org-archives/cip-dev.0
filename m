Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923B9D29F87
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:48 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50850.1764872138364406646
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=c3L8bm5v;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso6625955e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872137; x=1765476937; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e+k4yA7xkEaRZlYKnxKbP/oq1sI68nJY9Ll0WwWqw8=;
        b=c3L8bm5vhGjgMrqoRJzQjcl/K8h+KbKR8GAKbLM2mVFivjTSBcCrMFEfqLUaU9T3Ll
         wGu5x35HWfGqZHczphYRdzdSJPiBdO3Xapz2EXjr5uj9EcfumSbAasHBXHSNR6m8qOno
         fj/t8d+rzulS5mC1GXm4EKvY4Eub5ztCMJEODvJKQRsqgnyuzlV7roLbua9s+6eWDaTS
         C6BaQvjNTFk5hNtfbh+G28aEmKTSdkGbAwPJzyucByYszpHWf55lBIuywFWU+cUeePf0
         FtsA0fTObbCDuAxIRGuczqJtDgOM+p33k/5RMfRpDcMV2TlWvHtiRlffmJED5IMIDw+C
         5eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872137; x=1765476937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4e+k4yA7xkEaRZlYKnxKbP/oq1sI68nJY9Ll0WwWqw8=;
        b=cGftkMepTcwKWnKeFarBPbE2H+l02/7891AAz75GL7+oeGpi/Cc3ckdL0g3DYCESO2
         ZwKcMaGOGBZQv/5gqcxRhW10IlBHrikJKldujMrSDeT3kcbM37ladmfMHKr5733j3tWp
         KaY8xAlRroCBCWPxxdy24115E4R+OL7D3tff9ipxXUQOuboRRGGRH34T6874HWjnxcjB
         k2CpxCjOyXLtbtfhYbpkx2VY9l+el0ovj+UqDxV7qzEnA5QrZqKUrsSn3PuMWD11Isf/
         7BXemo1RD5cXtO69Mhbi0uaqRByhcZmHFdyD9DWvYZNAN1yG8c/ipqm940UqOps5YRZ+
         vVaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbLeX0oZTzMpGn8LhcDFLZKXEyGY3TziI5Vy4awuR3DmHmYB66p64J9hQpauVWFCf8ZNOyAxao@lists.cip-project.org
X-Gm-Message-State: AOJu0YzKWjxXjMMh1byVPPfrehqNKaRs+S1Dq5wRTNloA+gR7CSbWIcw
	CZZRY17VVR3nqpXwdqW3v4kKJE8Eyz/Y6BVvl3euiSM8bo5diuiHP+IEPt4RTNHx2EM=
X-Gm-Gg: ASbGncv4rq12q5NROmH0VVVCwDidzTfLvU2jkXKOOZvW4p/cPVap3hKjYSD/1a0XixH
	nbJj1i7moS1PPhyzDtm45/zdIMcn8DtSiomTEHqPLv0EEaxRKRcGNIWkmye1cYpnsLyKuP5WYay
	p9ZdeaWSDCkT6yXFAz2Le9DOBuYPdF+7mnDVxoDA82uArJRe/wQdKs6uuhx+1h+Na4rjBwE86Cc
	zJ0jPuN3t2xjkrj237E23Ax8eKmkRXJokPU1QxZwfHt0WebnCcVdB4MGyITpV6BkOz4oJUxAdKg
	H5y97DmqUQRzV1oa8YHnccW9DC9i5QyexTI3TvE/g+zZQmcH8uHK+8lE3ARjCnM1FscxR4shx/e
	rnLrssg0dqCkaE5GC0/nUVSIDvQDieX5jEaQ03VUDISphfBBx9BFbKLiGoXl1vPkzurdjJCEVY2
	gK93eH/hw+c+iY1P3m4JwmFeCpe2mzzXPaRNN6uAn/
X-Google-Smtp-Source: AGHT+IEPl+XdXKIgbGvTflmSivf371HoRrvkuPWP6a7Fa1gG5OmoIfJFEg7sLcbj9UVf6OggZkfJqg==
X-Received: by 2002:a05:600c:1393:b0:477:3e0b:c0e3 with SMTP id 5b1f17b1804b1-4792af47f6amr66814785e9.32.1764872136788;
        Thu, 04 Dec 2025 10:15:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:36 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 03/19] PM: domains: Add helper to check for PM domain detach on unbind cleanup
Date: Thu,  4 Dec 2025 20:15:14 +0200
Message-ID: <20251204181530.689132-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20869

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


