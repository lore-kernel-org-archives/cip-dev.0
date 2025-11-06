Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B8DCCFA1D
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:04 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10006.1762416660266249949
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Bkh1TgLq;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso2849945e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416659; x=1763021459; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMidpdh2uG12yYcCjlSAzzvZ5k9pbIGrpg2qXKq9heA=;
        b=Bkh1TgLqq45LL97/CZIHWbANho4RiLt/ISbqn1CKqNbNp6O3xQuol0yzUaBoWDNJ/1
         j+7kMtpW+uAchUp/rK4W0Ov85gXmzJwYdlNlBD/96jbpDZF7IiXtn3YXdjTDj36fcSAI
         w8ihlfzqE5QbBZJGi2QYyH26jXt9XUrixJfOzImmGxmiE4DnoKLCx7A2mNqBvB/04lQl
         ztPayIyUrrusGWVctALDGlc6x5DOueUE8TCTNBcLu+AfQHBH5Ykcx9V8WIC+6MEEu6SB
         h+sxGSnwly8oVQr9AzkQsU4Jwo1IZB8UYrA7awqU70k9D2qowyP28o8MypkFDdlpDl3m
         XG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416659; x=1763021459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMidpdh2uG12yYcCjlSAzzvZ5k9pbIGrpg2qXKq9heA=;
        b=m1zRFPOa3eT+SBFBAr83/qCb5jueOcyMxj3w1jWOmURutJVpVGJ+gApGiXph8LtCPF
         m5aH/1zNUZmYvYC4u9sl7Nz/FdnKGHoelxzilOvev+CX8p2Z9eZJtl6FrB3DODv2rmUR
         a0DZGePoM31XG5SL4JkKawxOtcUsqOgZECL+kSmDlZ7oVwgxCeWaa4tcBI35zXL2L/Pf
         a5FEBhqB+Uh5ljUv8afHNMWi3GWaJrysY/FUgPqPtnZ1u44A+rbcIR8bmbNvEW/MLqJf
         W9dSTmVZ7a2qRv4z0SSeK+JebeIyWxOY8fwomss+OfD086HcINwweR/3emDm4FQ4XPqG
         pgdA==
X-Forwarded-Encrypted: i=1; AJvYcCUKqy7QJeeptf8Sb5QfaDLaAPVSfzac8grEkmAqxY42lLIlQRITQnehUJolVvVG67NCvlklW9z/@lists.cip-project.org
X-Gm-Message-State: AOJu0YwlCFloMVXw1DSTxNl6uUGRxKis0JHlwy/3tKQk0hMmURnhTezS
	4zX3EO6MyVkhotnH0Q2qm+kUZF6EzPQ87NJbL+JUkGfeu1ke+RimRH1rI65J5KMq/2psT0PQvSo
	HlUx4tfI=
X-Gm-Gg: ASbGncuBTVzqxMpYBISffU9SeMj88FNXL4WHtkg3p1/MfcqL0eOhjAiC0ZjxGWWAhuR
	rn69tIvK4FPC4sGMp6BQDWdLLABzHB03xecDwuiKMs1X1xuT3kjxpvwXT8/kv4KyFc7y+g8I9Fd
	Cp+rg7Mqt90L0n8Pe8T6waVlayB/FRU294zF2LWkX+0geTygoQYwFf/Tt9+4/gT/QFSWbZUm0/X
	kMig9JNW9BZSxCKf2gpabpRhfXL8lOhM/eSVfkEhyeFmABx623O/9OdEgUZ35egdRHHEnndxZS4
	YaoP7WVe/Ynj8egSGSUEfDsN9hzv+W16FJ9AQ0jc4jl9sXnNxNwzFRVvVz8TrWwHVo7jjdZuW6O
	jOYgf/CBQ8USO8gykBtZiA8Eb6o6iD2R9dg4J+eqMmVCFamTwhd2kKqn4Uhtvy6qRRsVsjOiJOy
	BYRW6ZrZwOGSWd+3ktXqotprhYxwC3j0ka4KutXZDD
X-Google-Smtp-Source: AGHT+IFvB+A6FFLnpqm/1fmu8r3ktZ87scPlythxVl9i5WEM/y7OGHuatRn9N6fo5CUK6a0KcO7LIw==
X-Received: by 2002:a05:600c:3e87:b0:477:1709:1f32 with SMTP id 5b1f17b1804b1-47766988cddmr7140125e9.26.1762416658651;
        Thu, 06 Nov 2025 00:10:58 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:10:58 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 07/23] rpmsg: core: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:10:32 +0200
Message-ID: <20251106081048.2574345-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20376

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 214ae22e6d4f774f053a8f7d32bd6a9874447b06 upstream.

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20250827101352.927542-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/rpmsg/rpmsg_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 55c5f8833820..b027b0286cbe 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -542,7 +542,8 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
-	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (err)
 		goto out;
 
@@ -601,7 +602,8 @@ static void rpmsg_dev_remove(struct device *dev)
 	if (rpdrv->remove)
 		rpdrv->remove(rpdev);
 
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 
 	if (rpdev->ept)
 		rpmsg_destroy_ept(rpdev->ept);
-- 
2.43.0


