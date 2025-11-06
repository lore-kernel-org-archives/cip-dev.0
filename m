Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8405CCFA1A
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:54 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10038.1762416709597017319
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qR11fo+M;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775638d819so3024165e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416708; x=1763021508; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Krf66jMztnwYPZcHM+BcZOKR7z936klUX6/I0TL+jhk=;
        b=qR11fo+MJm2TDvAwnOB7pHhKkB/CuIMNqM8lHMfe1S7Fzz4KpoXCwzMucDbAp8Cnok
         4Uz6fwWl+ZqxuMxWKHHZmPjfJ4xE4eB8OdceZFNLxegJYyGvc1Athhp9Pt0BtB2Fr0Uu
         s+qRWYM8YFfRWXZAgdpbPzvwuGw+mdOEQp1Er3RPWBMIa/JVE+F8NxhsTwSiRbvn191Y
         3u8BDp6ChgxU6u+3i0anODTXymmYNdoNmM5LtlYfJjdQ7FEgWtHyqb46Uf8jrraqFOgE
         lfpbJ39hJDtCbx/F2W/JxW8uJpyUxvNF2aHKNsOvqnsfbA/yJL2SPaf++GzpvrT4bMLe
         NEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416708; x=1763021508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Krf66jMztnwYPZcHM+BcZOKR7z936klUX6/I0TL+jhk=;
        b=BocmB97SpkpvukrTixszMe971p4HcNqlQM0Ag/HONZPRRkXL0LLZDADPCYnen8Eksj
         ycUSPRkJR78i1OE5eZDusmQ5lAo74flUj4MBwQt1p6u8NOkO2DDBRaSuUz7B83drsW0j
         /va1/OK8wPVdd8gJfiRmWWUlrBjhZlu44dz245Dn/FuXUl1IilIOauqCRvxybegtNJIm
         Fif58f+3aHZZDBYUPyQng4FuPDiAF6+i9lLZGcALBRMr/IZPck5Nw/8rjIoHEPWyhZsj
         f0oPap7RCw8JegGck9WL4EjCjPT//Nz2cPu+6wUbSsSmuCDZwHXHofrNSNWoRFh8hUUp
         /joQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIbbVsH41lU1phkUgPmqN7phk3iN1yJrio4OiWdaqvkPO/6GwPj4lO5FTPr8QiJtkm+qQRgwQs@lists.cip-project.org
X-Gm-Message-State: AOJu0YzYlyaT0qzoRTGeWIfxmdH/q9EOwKxZwipu7tqAl+hU0HjxrlOU
	o5zNpb6/JX6A4azJ/7eeee5qasip4pC82ZmLOcEaqSDRSPqx3H9ain1E2e3rdWKb2NOLP4VwRHj
	755zUcUU=
X-Gm-Gg: ASbGnctj5UJFDwTZwICu/st1J2k3kdDw/ufl15ZItDlIu6X/7fZF7aE3roRuejeGOMt
	UM2MfhWzJqYy4aqUIndscr2DTrftZA3qom1aSndYel7JA4ospbmyhMUruA2RBxAp5qDttDU/In5
	lPNG1nehMaH+IgmrgVrutg3gjMb4f3PX7YXgvB67klJHz3UA+Hr4MOCfrK8BDJsesGv7531BwJy
	6xTAmAQ3QAZx+sfTg2AEgTFffq3a8y07Ta+KPoSeR+mpK5e/p0X6TdsmZG3L+YSgTo5W8imTbq1
	gdKbDP77WtdN2FI6C3xLHscL5SsXzLkTLsNE6QRmr2Kse7akFyVIenbQozV2Pkq7ssKS6wDL4V4
	TEZse7Z3TjxEpKYUJejZmaLNhLBECvpITAER5gOCgy+6HELlYzVxcN49wIJnFl07TEBAplx9Q1G
	eLvRUibsm3Z6ztm12EeOeWYfw4hzjk+D7r6pMVgVT1TSBEoCQEdpY=
X-Google-Smtp-Source: AGHT+IE04MHql+T7thshVfAjXe5o9rLUyJLjbSQWa8WP0RnE3T5F3mxoMOQ/9hW7C5wduqOIJ2VgJA==
X-Received: by 2002:a05:600c:8b13:b0:46f:b42e:e367 with SMTP id 5b1f17b1804b1-4775ce3568amr55063675e9.41.1762416708001;
        Thu, 06 Nov 2025 00:11:48 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:47 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 09/23] soundwire: bus: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:11:18 +0200
Message-ID: <20251106081132.2574638-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20402

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 969bf687c12cd9f64ed9368f0c7429445de7c10b upstream.

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
Link: https://lore.kernel.org/r/20250827101506.927787-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea:
 - fixed conflict by keeping v6.1 CIP code
 - drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soundwire/bus_type.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index c68f859db063..516e83bf757f 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -112,7 +112,8 @@ static int sdw_drv_probe(struct device *dev)
 			name = drv->driver.name;
 
 		dev_err(dev, "Probe of %s failed: %d\n", name, ret);
-		dev_pm_domain_detach(dev, false);
+		if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+			dev_pm_domain_detach(dev, false);
 		return ret;
 	}
 
@@ -172,7 +173,8 @@ static int sdw_drv_remove(struct device *dev)
 	if (drv->remove)
 		ret = drv->remove(slave);
 
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 
 	return ret;
 }
-- 
2.43.0


