Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E07C3DA4A
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:25 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.104191.1734524602517616670
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:23:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NrBwXn3g;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a766b475so66613785e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524601; x=1735129401; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00l3AJHksdJYBuQvXFBdiCL8NndypugymPjDcBYEyPE=;
        b=NrBwXn3gq4FPnQrVzGzrncPVSm9MMFBZwX/AYqclOJpcn21vajynrTdbb3fWGn0GjK
         h2+9GzjNDc8Zvsu4WlYiD0q3haY+w2G3R1Ajm9k1A1/Ejougw9m9T0jjTz9CTL6Gz0YV
         mZAUrcot2MJRmFm7CBEvP3YezH3Wlg8QbqstXh+O38aE8TfhnHFegB1FyuN+4lMXiXHJ
         XCYyGa5jtiDR7KcTQ1FwLU3W7oIgm6+Zv6cg1dY1J/E7KroIypu0RwakkXE38H60hnRM
         yRSEeRL7sP3gAMxfd0NxAOLrDW4saIcobdOC/SHTY17C2rSRLGPxSykBjrYvt7BdxBNQ
         9zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524601; x=1735129401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00l3AJHksdJYBuQvXFBdiCL8NndypugymPjDcBYEyPE=;
        b=cdfDXoLVZ1TBroHLPXfEQ7yUaD4i3+H6Qyu7S7UJxFnQz/YcDtP9M9dV7FOB9pIz4E
         K/LCtPxwyceTydPb3AH21FdBxQh9IcFyB8MVN55dL74+hO1cgJJ+RtdmAzsPkTqwB7d7
         idAb5m9MwqAUBHYqvg73FoXy17UCzcSZuUxNPfqmJj76rtLFjs7p13OaL7rX9qQIcNk2
         56+SqiCOw6njoLAbfqo8gENLjri2Pv4hoRSuRUB7hT8gt6CpeDGE5Ap1rV3XZiDzwoc7
         Zp0OfKbcgdp9pKxooJ/RqiAL3CVe4TPcJOPytcSkg0E1bTLh3/x2K6mT66/X0ZbtmtdK
         LJPw==
X-Forwarded-Encrypted: i=1; AJvYcCUURVFSbqTIFyNlo6JMdOrstCSdc8vFcxGZyclgE0uuEf1TwRpsxMKs2g+qBAlM7+h7WrmkywK2@lists.cip-project.org
X-Gm-Message-State: AOJu0YziYEKGHOrxOgjVHHldaPZXa3dvkuGOOcCMcwijQqLkQGlFOYFD
	zMcOPE4r/hQc9xP+DYWCcJIrVDD5OM8TdyC+TANDtNnKrG9qyF6xldWdkFF0BDc=
X-Gm-Gg: ASbGncuUWxhFrKoWqnJMpNWvYPDGWoc1vMFgWTNCUa/ReuGBVHTFq1X25lvnsoU83fJ
	Dlu8MZ7xwApreFp97dDe9L+leZ30bu68TfxF4uwcdf0pi9q+EhdfB/xxWW5OA7R8tKZHUigPXjL
	nr7HPpyfog2Yv/jn1mlFiRC49gst/Db0IFEj/wEOCzRfllIsADI53DLX1Dgit95E7y3CPHVzzcF
	PFwSlgsaKHcseMbyVQosnaS90oyqOwx8mCJ4yun54u0kcII2mB+YVoUdOOtq1gmYL6bZ9o4AyMW
	DN5fgp7d2XY=
X-Google-Smtp-Source: AGHT+IGaus9AHqTq76gAUWeO5okrtKpP5a0kvlR430VjlGn+Hauc+ZDYhBxKwIynl0xyuOxtRH390g==
X-Received: by 2002:a05:600c:524f:b0:434:fddf:5c0a with SMTP id 5b1f17b1804b1-436553452d7mr24084925e9.3.1734524600917;
        Wed, 18 Dec 2024 04:23:20 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm18746445e9.11.2024.12.18.04.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:23:20 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 02/10] watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()
Date: Wed, 18 Dec 2024 14:23:09 +0200
Message-ID: <20241218122317.2365272-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17455

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f0ba0fcdd19943809b1a7f760f77f6673c6aa7f7 upstream.

pm_runtime_get_sync() may return with error. In case it returns with error
dev->power.usage_count needs to be decremented. pm_runtime_resume_and_get()
takes care of this. Thus use it.

Along with it the rzg2l_wdt_set_timeout() function was updated to
propagate the result of rzg2l_wdt_start() to its caller.

Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240531065723.1085423-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index d404953d0e0f..78d904df5f1e 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -123,8 +123,11 @@ static void rzg2l_wdt_init_timeout(struct watchdog_device *wdev)
 static int rzg2l_wdt_start(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	int ret;
 
-	pm_runtime_get_sync(wdev->parent);
+	ret = pm_runtime_resume_and_get(wdev->parent);
+	if (ret)
+		return ret;
 
 	/* Initialize time out */
 	rzg2l_wdt_init_timeout(wdev);
@@ -150,6 +153,8 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 
 static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int timeout)
 {
+	int ret = 0;
+
 	wdev->timeout = timeout;
 
 	/*
@@ -159,10 +164,10 @@ static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int time
 	 */
 	if (watchdog_active(wdev)) {
 		rzg2l_wdt_stop(wdev);
-		rzg2l_wdt_start(wdev);
+		ret = rzg2l_wdt_start(wdev);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int rzg2l_wdt_restart(struct watchdog_device *wdev,
-- 
2.43.0


