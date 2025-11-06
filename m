Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439C0CCFA1F
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:35 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10099.1762416746276504631
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mriCAtGv;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so422036f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416745; x=1763021545; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2UkU7kamRFbcHXefDDWHPuBahwHiSjlaC7SkFBsOvU=;
        b=mriCAtGvD2XMBNBLJwhbcm/G57/uBbQefuIlCrWaYs4YrUtWQMC+gyTKLONFxPWfqQ
         CusDQdFxXVznlu1ZY5Z8gFPVzRIAaEwlzCAVNUGh3FqCnq6BhpqsKfuS9b2HJwnP2awY
         1w6IS/ii/WGEYScyla0cH4f+A92l94kxqClNPuCRHY38lLeiJ/8jzWOnSV2esFXYTjZO
         9Wyj8HePF17sVBIYC9U4Is8++9jIATrrjk5TNo1dCcRUOnbPX+gFlNH930fhRgTB8KCC
         2qtD/aeTnTfaHiTP6wmW9L8YTQzSPPnFfA8Z81DW+QUpp6SYjwDK4fnvoABFUX1gl3Iv
         FXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416745; x=1763021545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2UkU7kamRFbcHXefDDWHPuBahwHiSjlaC7SkFBsOvU=;
        b=PusX58uEyw3FcewOThKoU8uLl1qgUEpt/BUZFiPh5u6j7PfsF+SuI9GUcJ9uSz+TlS
         cdNszqZBMGIlwTDeLlW9qYtp+7RQw8HIiWIAGZCzQnvIdyMEt4EVa7k8CEVl7NIRxbDt
         jcm44QxibbeDWB5iDqWNZqMTfNVtz/QFyeff0LQEgbARlaCHxTQgKsNcwkPrha/spaTg
         WHEJKvls1TWWj5nweSAmXEnvaij4xDKRBmdy/Fo9W7mOinXsQc63/4R8Re20LU3fOKxv
         V5lAhjioZfg9HAPDOsda8yXex1/4CVtnebXklgze9UV/aVI/SrzXz8VjE1ae12gaJkjk
         3xMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdOrzwOU3M4j3b54dnaTuMlXdwlpg7C6xl0acjHTNY4iu+/KXsZt2VwQIm4I9kcI+zZHXf3c8p@lists.cip-project.org
X-Gm-Message-State: AOJu0YzKPTWg6TSkT/7tYqX6ssn5ldc0cISFgFZItdDyImHYDYUFA6bl
	Htd0B3WSAZDGYm2eifBikke+X/SdPjWpocjNVKdt06e8O403KHinoyQ08ynDKadTT9k=
X-Gm-Gg: ASbGnctygct8OLPs8rP4jqAd2K5uM6KlXY+TSP4/qIAXlRVlPDuC5ifDRC6kl8/SAUd
	7NVSainjVbM2/pT8vLnKAAWDRJPCBlPGBKI5chk2APL7bfdM6f4XZIuzfc2oG4AfsMSaOO5BVRY
	dpy1tgQU9sEERHSVi9PW2cwvdNFs47BvfQUbbhkPmDv7Af1eL3Sz4kyzGMKLDuJMngW5cgwEGm1
	ScRLFRcWuRQoCYp2ViJWRj/w9UfMGSobJViIEwXuUobn6/jW+XDaoL3OnCtsMvQoBSTGGxYwQSa
	hdw+1CrLXxXwhB0u9LVieepUoZiAM6sQ/9us4U0R6Xr2E599lwR7iuKzrYyja461r2UNv+vHlMo
	H04G6KIle5WNIG13zQP6JB9NeVvImS6Mp2m7AF6Q6rsRIedPa7cKyWANS7um25xj+dD0ye3xtW9
	gZLxrwVpNhJp+I9sJt4VOZFTULVdcpDCquOfE9g742
X-Google-Smtp-Source: AGHT+IH/lTtL6X8f2ycnDNDLhW9HLeFV7CgTfpAQNaLRw6Zd4Epk29u+ngHyBySDLwoTxKy2tijXgA==
X-Received: by 2002:a05:6000:25c2:b0:429:c93b:7f48 with SMTP id ffacd0b85a97d-429e32c82b2mr5588939f8f.5.1762416744651;
        Thu, 06 Nov 2025 00:12:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:23 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 03/22] PM: domains: Add helper to check for PM domain detach on unbind cleanup
Date: Thu,  6 Nov 2025 10:11:59 +0200
Message-ID: <20251106081218.2574950-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20420

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


