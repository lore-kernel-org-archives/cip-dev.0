Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167D3CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:04 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10062.1762416663315682385
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Tc/hbuT/;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429bf011e6cso631652f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416662; x=1763021462; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mEEUDvPN02LAVTQ7c50VMmoh2trsGYFvPVCobXrXyo=;
        b=Tc/hbuT/P8n8tRl5Sgot45S1k72D36iHf3Wg+HaBC0LtWU390jFl++dFRQn9zMm8o3
         hvoABNgkc0i5hkOTDFfsOUq4Z3zRYOZnUhACHV2Yi0zGqAbqa7k24YMjSV0dx7iEGLaG
         zXoNQIgc9bRzoQgbMyqgaqjXi5G8N2OAHk51e2Dmmo5CJwFCHseNFQtO/WUmqNTyvhEe
         f7npF/Fm6G7IZJigvAfFixTiBGBmGvcsLPBAEpgjq08qsHRx4XNWn6FHBo2X+5lUDS2c
         KyfdfKUliNX5Fy9j6VsLdZ4h5VFkgxfAzMfxC0GFTzI6G06/872/fvm4r2TIogVsfpWr
         5dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416662; x=1763021462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mEEUDvPN02LAVTQ7c50VMmoh2trsGYFvPVCobXrXyo=;
        b=F3QoBLKLufQY/BPabB665ArI2X6I+OYrFCiy01cKSQXE5lvjn2c/WMCPoDx6txc4Er
         zjn2C6u3dyf7b87JXKTwKLTLGL6FPjYkrDICtU+TJmVtFuF6LrGeCbMur8PkwdtKueFu
         TODPdXcKZkUeG/Xme/GgB/XAdUXHppOEGkVe6DdP5pylXkQJUS68d8KcYns1ultTbOvE
         Q/qq1WizHReGHRzF/T1+bmCcBSlaHCoTNwpAz/KW5L32NCBI4hSYhOTCBmxK1utvCBki
         4Da7jhq4TZEAIj+FIqV1L4pWk/2U3+oZNlFu51+kL2AGTK328lYQmj8PFUIngXCKJBTi
         xYyg==
X-Forwarded-Encrypted: i=1; AJvYcCXhWg8hgfFNHKgCA9U2/hPsRFz/VG/LD7xJqSZ14UMpgjkaffFZ3yyAiDtI6ycKJMdCNFue7rBK@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz4M+vUvvaCJlPK1zdDCBPcxhesmw1MikHqSi90CLnOP5rEjvbQ
	gYHEOobLLfLnTP1uS/vfIj83d21YkRZ+/GokHx1cMKyCKWQRH5+cQ+bZ6JYWrJfL8Ig=
X-Gm-Gg: ASbGncs3QZvVqMZjilWfOCnFV+cSnRSI/6u/zXlSZWD9U+Izp0r1J7Z/goHuBgAfiP0
	kdu8wCc+49RSh6yLx/bM8BeD92i3OHxHp6WsNotbjrvPl6CT0M06+58UIuKwI9dyseTEwxduLs3
	VFsezRuM308T1qEarphGM888UkZrSRSRoLocW4VEIhMgVU1eKAttRu1EkJ2Ju7SLhsJ+mW+Rieb
	xixO25WdWZYQZrszlr2TTFW5lQ4TqIoyfiB9u2/Z0NM5TRK6mQf0XoRTtlQSSYcK69uzXRK0BsU
	v1e+uQi0i5jUDD7gwYArq/AhXwGTLwucFk68NnkztDJ3utgswlGIcW2/PvdRrLL3ftLDQf481Zf
	w6UL5IVuaKWDFzytNguAJtjUm1svUkDPmyH4NnuEv+0a6a7U844buePCqE6IEcUY7uxGT3KlXdP
	gz5RLGrjqirtwlUlg6v3AKxly6j+x0mA==
X-Google-Smtp-Source: AGHT+IEbJISOiZw0DReGdA8N5SnI5r0olq5iVt5ERNbDOQs7FE+41+1lOmD9FZXmjxqlSmpRJuDKwg==
X-Received: by 2002:a05:6000:220e:b0:3e9:b7a5:5dc9 with SMTP id ffacd0b85a97d-429e32e481cmr4889067f8f.23.1762416661693;
        Thu, 06 Nov 2025 00:11:01 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:00 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 09/23] serdev: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:10:34 +0200
Message-ID: <20251106081048.2574345-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20378

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
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serdev/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index bdf58b4bce73..8ebe491a91fd 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -411,12 +411,13 @@ static int serdev_drv_probe(struct device *dev)
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
@@ -428,7 +429,8 @@ static void serdev_drv_remove(struct device *dev)
 	if (sdrv->remove)
 		sdrv->remove(to_serdev_device(dev));
 
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 }
 
 static const struct bus_type serdev_bus_type = {
-- 
2.43.0


