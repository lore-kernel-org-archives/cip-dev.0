Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0DFCCFA1C
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:54 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10040.1762416710908435036
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=DWPt2g+R;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47754547a38so5044585e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416709; x=1763021509; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuZqzU8YPFuRg+DUvDv8NBjjlzPYY7acEm5kyu3lctE=;
        b=DWPt2g+Rl+Ll+wtUDgTB4+V/NkI+5Uqqj5LBN8ESk7mK9Lrfm/bpJ3yYeQDTxDJK7N
         ufbUmLtzpli29XZdvYvNcE9a874QvtSZSnmuIkBgFDicm927cPX+7edBExwXqy+qWL0p
         n+1/4qalitf4gJRaD+E5UHRaruSBKK1C0OI6hEC7JbrA8dqJ/0ZEgz2aaSBJIg6YNRMe
         CT627tpUQ8XYLOQ0gMT3nHKzzMumNuE7fdXcFwpF2yoasqlF7HZB1VEe8w0m6Uc+w7Eh
         yTemoJ66EuybNVrs4S8+fmJY1zOTOhk7UWpVKfqb9UjEOjx1FNnSS1n+oLhZnNWrWu7A
         xcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416709; x=1763021509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuZqzU8YPFuRg+DUvDv8NBjjlzPYY7acEm5kyu3lctE=;
        b=dGPkbVlLWQTJFujczIkixD++43t2C5mLAFOe0ETRKWGyetUu8Fk47XcQdCkeTt/gD2
         tT6n2cT/873k0X9ifswiNPqb2FiTof6SwPEXKQtFrzb2ABbaUOT+lTSmIc6QBUcb5WTb
         tjzXWikqZWYgAXm90Qr24jkyuWIrh0ZcjfbbCbiwWAEoxx0a+T1KOd+8CWXcTiWZIMES
         zskQXouBSNvdhWGXAW3J8FfzCZrL3Q1U1sePOPOmNOtM5fyLfG+ll2AeNWO5M8t1kMvZ
         BSk/eGXlg3f8nXpQs6bxE4L2GFKjbMkDXK3xR97/6IOLpIiPt7QvZhSvv6B6V/5f9puw
         PxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD0Wgrx0I3b1HYHYT4pPiq0GSfXnU6Ykq6v0kNlnJQwpCz1aOsFMH/XZ+YbpfAkggE6yS5hnL5@lists.cip-project.org
X-Gm-Message-State: AOJu0YyjoRVItGaicE/vJZ/BwPTPR1N9HvP7Gn9H3rqsHZ3gzqMqsWHv
	cJswOKzFkMfQwp+59i6ekNyRVZ8cswhQ463IK08ZiNfS+ez7VYF4sX6BqYhwa31Fq3k=
X-Gm-Gg: ASbGncuef5ndN8BV06dv0QpwogiP9j21xbbmeLJ62wRJFJFw3L1dxWjpyQzBYBXw2qO
	Cu3IZ3PFbJF1wtHcy0q18Cnb82gn+sIk/grYGaN4HtsXtDyFYtLJS5lfAoIa1y+lxDEvk3bGXuy
	FITIkJhO6CMo7e59p+VyW3cDBf1cFO6pjY1J71wdBPrOz71JZCJaIaZue0hpz6UtkvhfnTwuk7Y
	Jy5+0pyZYoJjwVSknIqulrKOMEzNGo0ZMwkXmWWG4qoPhrmFXXAskN0ISwbBu8TMnXpO6r0/lgO
	O1d8dTxVvH/BgGqtOzSGNjeKj3bbHsH70BkHNLzXF6NLDB+N6SxEadc3fBTa22E0E6f8Ck3urFu
	GP+nIn0uf81IrOnj29JMs1IviHpnDQQDfhzNARbpEWfiZdLSfljQhAVfjy7D4m8XeCt2IUbuVnA
	EZMX38UfBlI0IphE1BrgjN32JD/WN9yQ==
X-Google-Smtp-Source: AGHT+IE+0l8fHEuZ427fKK73n30pYHO/xPbx+xkmMrn4jrZrNWIpJCZ5auJ6J8naIF9gY36NL9KYwQ==
X-Received: by 2002:a05:600c:4ec8:b0:477:54cd:200b with SMTP id 5b1f17b1804b1-4775cdcf9b5mr41973135e9.16.1762416709327;
        Thu, 06 Nov 2025 00:11:49 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:48 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 10/23] serdev: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:11:19 +0200
Message-ID: <20251106081132.2574638-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20403

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
index ea2d80990505..0d1675a30ecd 100644
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
@@ -427,7 +428,8 @@ static void serdev_drv_remove(struct device *dev)
 	if (sdrv->remove)
 		sdrv->remove(to_serdev_device(dev));
 
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 }
 
 static struct bus_type serdev_bus_type = {
-- 
2.43.0


