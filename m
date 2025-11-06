Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A19CCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:45 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10065.1762416755763510632
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SoQ4amkO;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47721743fd0so2674605e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416754; x=1763021554; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isD06OhGbZfVwb3s9/n0YrhqLWxMvwlqAr7xafmkFd8=;
        b=SoQ4amkO+O8bMHy2O2GY9XFgvAdmRyHqy3Vc6zqBQVz4OjLN73acTTropz74IhtyAr
         uSW6De5ZVg0dN56t+cvkXhXazn+Z5xb/loHnKw5aDmUzHvPf2H+0nhPtUPVUweCy4p9V
         2O+QjSb8SSYxS41aAaC6ZVHobywbRttQ637OTtGkVYWRP3+s/S6zsg172aiLq587B43r
         OwWglmDIRAWv0g4Q0OVvLO3QZ6dEtuEp7QvF4DlKngpvynZYHv2oOI+Ldlw2Ye4fe62S
         9HIri1Kx01CznW6GaMegtxSFxszUyHctlK9UHS+uzEHJdsuTUcjaaLZBlMOgz+zcvZom
         rcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416754; x=1763021554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isD06OhGbZfVwb3s9/n0YrhqLWxMvwlqAr7xafmkFd8=;
        b=nNp3XGe/rZ1aZxcjDfo773gOq7hRtmgGcp7uE2WYhWru+6rRPL/xM1YlgG7gmm0waE
         JwfyxLG6/fnfyFIIPo6Afs/myT8Tx1inF34xb3ibJ+E25mb6xd89khDWiIc2tKXyvWjA
         zeFRU2o3hd/eziKpUQl7ulZO9OBp5bW7uCiFzgG0QOL8ljIVCIGJ1ZhuhT5HfaHSVZI7
         XuuChhR6p0wg3uJea9b4U7cbzMfxdSUjFRo9e6NGgBKMvPCzIJIo/slLfqdgPa7oceOg
         YBqe5YGqPQfz3srXVpdsEBko7eSrNZbIF5CLXXjK/wk6WChadZqCaZpiCK7zOaOZHGGX
         IOzg==
X-Forwarded-Encrypted: i=1; AJvYcCVkEi17zWwURkr3+huv+PFd5IyW3w4dFR+ReKJ6V+tkM5Ify57xQMHJI6pXPQhmA96t8t0gDRTK@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw60Lgdlq8N+e2W3S59wwNLeDdrr7k458nwJB1sL0zk1pEpM2Rs
	TIUqRU5Z5kYWAKYanz5Y8IywqC/Po1kSUhXRMKwNesnSR5Oamngm9mCt9SkP6teEv2XisyT4hsL
	rmZR1r+E=
X-Gm-Gg: ASbGncvSgJpSdJx5IXtwL9Yh2E4ZzWfyP1165RNZCkgBy8VSxW8ZXLUuJWmt6lkoAlK
	DPCTKeUwxSQPlN18K3OzjWuVI/doPp2U0Cy9HmRH8U5dBWp3rAgQitNijXTg63JDSrZupkNFb6B
	yGpJmAk9TqGSu6hWaPILG3UgRY+0wdsgc/rwNViSRU3HcWAooGqD+A2z7I2vL1Dk0YQRqnlGZ3b
	8/bt0fdM0usZ61C3COBDBjnfiMcVYX05JO0kJbXgxeQGksPvNBtQzNrsxGOeyGjLYzIz4HajP73
	Z1QcmD0mKLEDUZseDFjr/3O+a/Rqb5SDBGwVo63m5pGeaBs0uehADauP2PEOLGISuCpTMwSCdDQ
	43xjWS6PYVmycmFb+kRK4yXEjnnsMfPu+NCqs9UOt5ifa/uozfyM6cr/Yl+YD2ZYHu7GOwM+OLm
	DphLzWAFgzV65Lmwzsc9eeE1dZgjFqt/zKSTnKpyQL
X-Google-Smtp-Source: AGHT+IF4+wiqZXcudslpWOIB6jJrJD8ibRcveVKzgl0wsBf+/p0WtstMr4EUgcAV2iYiOBt46RxQEQ==
X-Received: by 2002:a05:600c:1386:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-4775cdbd53bmr50574245e9.2.1762416753953;
        Thu, 06 Nov 2025 00:12:33 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:32 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 10/22] serdev: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:12:06 +0200
Message-ID: <20251106081218.2574950-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20427

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e3fa89f3a768a9c61cf1bfe86b939ab5f36a9744 upstream.

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
Link: https://lore.kernel.org/r/20250827101747.928265-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[claudiu.beznea:
 - fixed conflict by keeping v5.10 CIP code
 - drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serdev/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index bf35e03c06cd..5ee0e60b39cc 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -410,12 +410,13 @@ static int serdev_drv_probe(struct device *dev)
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (ret)
 		return ret;
 
 	ret = sdrv->probe(to_serdev_device(dev));
-	if (ret)
+	if (ret && !dev_pm_domain_allow_detach_on_unbind_cleanup())
 		dev_pm_domain_detach(dev, true);
 
 	return ret;
@@ -427,7 +428,8 @@ static int serdev_drv_remove(struct device *dev)
 	if (sdrv->remove)
 		sdrv->remove(to_serdev_device(dev));
 
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 
 	return 0;
 }
-- 
2.43.0


