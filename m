Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147C5CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:04 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10002.1762416654722279578
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:10:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=HXxNygyI;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so504872f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416653; x=1763021453; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPv3fK35M8y37UZxRYytJAMqohH/jJ4RwTv8Mtvwen0=;
        b=HXxNygyIfb/qZoQADheA14LiMDA/X58aoDTIPE1UnSDW5H29PVioZEkyMdJ1lNGSoa
         1xJCvVLptXzoWj+gLaO48F9zTDOFnOwdnSWyTbuDlzSg1g9xv17fprlRL8E93ywDL3/2
         TUx9cle9J7/WT6TIkrZ8dGWYVkDL0uusNRHa9ysU6+uPiGv30EMKVs3kOccodwSqR8dL
         QtjV3n5ILYoIu3C0sC6wJAsx00W8gXSxSyN3k861mKsWYsB2R7g8pLf4Q/UUf/KRN7Pa
         hgEXPvaI63oN8KFMl4h29j1A8a/J+QeBAGvCEG8UvxJNVnNhnA3d8kfxDQ/Sbn1+i6Dp
         azmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416653; x=1763021453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPv3fK35M8y37UZxRYytJAMqohH/jJ4RwTv8Mtvwen0=;
        b=XHa/VXYofGDsGw+bzn4Xi50ufQlBlltyRf8dGquYRiliJcEgKffH3f5mm872bTwki0
         KVVPn9yT285i0Ep69GKUEx7jBZ8591Cw68gTyTap4UzjI/UQTjCdblaT7CGz3MvSOdNK
         7I4aGwxJ7zBjgZJzvtyEqMrNIoZQdq8X62mrgvWK0QyHPnCmNACu+CoBR3jxTu0CKjXX
         /7TPRVTa9cuuIopJIEfePx4RcrKAi8hiUvdR5Ne5raAEPlQ6Yz8Rlc78H4/dAOXBJSK+
         q8YbQgHdGgAgH5CzEHDRmbac+tBHItrOL8GjcQRqtf4CAXwsN33TfgCWfFXmgjbHq4Yi
         HsWg==
X-Forwarded-Encrypted: i=1; AJvYcCXOt6bZB6yUZUqgpDSFrjwQOiBXFzk9DrsMsgCQO50bH4UNIOvoLfudEzlG8vh38AWwFGwbK5OS@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy8UjgjnPr8qcrub0uYvbrKgtJLeLa3KMUkkKZSDdE1hhmaAiM9
	VQjhDx8qSiI1CsRhzWBbE7hrzrY/01DvBkc42J3XHXYz30K3U1rRPDhzh2NOTn/2S/s=
X-Gm-Gg: ASbGncvVQAW8OOPyf1lCRYRj6j3M3bAsow6EunGqbEg/GJUZEjYDaWc/V2+Uo8g3gCg
	kbw0cVCyOojiEV10dD5yZGrzai6gyp0I3q0e13W5IQMvGOerY9XtJG8h3OY+CnP0h5cG6B/vWBj
	9EmfFgBRwz7TaWhheZAY2EtB9XBIXgS4pE6tdHZbR4i5B4cxXbXEzOlpWk6odvpvGHxoj21s5BS
	xQZmMTIHZfU2yc9joKHSL3nFZaRCpO5fBxhy4p4lTh83XZevPVeIVryjWad/QXwVdjljRYYG/ul
	Ur7ybfpMVYV2+6bvX2JZlHKC+xCmPYagVxamZ5DxCX7Uh5MMOofq6PqsyvHP7mi5XDPfJmU7z8/
	F+ZsEjHk8gfQEKACGCZC1YxHqRdIlmKT86JkJo784fuXuWSp4XB4aiddQlSXgepMpYzVGgfqHO6
	V5qCKP3NjhLWpRvkAF45cygfUGm+ZCGikZ81H/al0B
X-Google-Smtp-Source: AGHT+IERJvqvo6yv+arrBctpmxbTm7ctakDnyDlzY1XXfEUZPkXHIDxYGA0PPMuz5v2xz1vCog7GhQ==
X-Received: by 2002:a5d:5f50:0:b0:427:719f:de70 with SMTP id ffacd0b85a97d-429e32e48d5mr5395788f8f.14.1762416652748;
        Thu, 06 Nov 2025 00:10:52 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:10:52 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 02/23] PM: domains: Add helper to check for PM domain detach on unbind cleanup
Date: Thu,  6 Nov 2025 10:10:27 +0200
Message-ID: <20251106081048.2574345-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20371

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


