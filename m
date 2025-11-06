Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C36CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:14 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10064.1762416664799893695
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=E1dDJyoO;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c7869704so543551f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416663; x=1763021463; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tpDQFs5RWc86sBGBh287OekzsCI6QEnjPq808cRd9g=;
        b=E1dDJyoO/ki67QtnvrIwHZG8/sY9L6ohHTH4PMMHn3f5DqCn7h/m+h5X7T7LvrxcIP
         x087QVsXSOsQ3CoFP2LBtHdR89rKEG7dL1Xr7R6cWZBbr52nTNT2/nSeWa+4fIPJk0vV
         cxLqsvUU7X55yYkix4JGLWTM1GKSldsJybSp7vXTe7/JKn05LaL/QLzz79nlWrZWqY7r
         7fVGcYZOg81Akc9jAj1HwaT1U7hnfdD21paMSOwj0+BblSqbHtQgMBmEszBPCBjgCOu1
         bD0u8X9nRx1wG0rojrgjgHV8YHTKmBd17WXpPV/4pIhTs4eklRzp4G9Yiq2u/2Pu1bPR
         Yx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416663; x=1763021463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tpDQFs5RWc86sBGBh287OekzsCI6QEnjPq808cRd9g=;
        b=tKdk8qDiGZDgFNYbz1Wv/1mitLfZPRXI5YQqy6L2vsN/3nAOn0eyY62CXlcf1KD4rg
         s6kb1eJwNZjjdrmiNybymkR4RU224BDlLIX9GHO3xIxNr7F8NvTeoLcgVV99kICKNnca
         l52iSc6JDKD0RU0LfdP6TgvDfsJzY1qZKYe1xB+DWWLEBbtzoFUYpFJwMwZ7rZDhfmWc
         XnVprqCEcZquGW/PeP2Z3iF6t3efPrHZwGzrokksqjUg16Sdr/KI9HhpnuduYCfDtI55
         XHqtK4BBQSM3ZWtA4YBzd0zz9SEnUQUvAPFA55Uc/UlBHAcuRxMq6QfUAFLdmpEuOyH/
         iTdA==
X-Forwarded-Encrypted: i=1; AJvYcCVs+1SHV8KHR2oUXqYhDxf+ctJ6niWjqsqEMo0iw55rhqonbh8zW3kEttpbo8H5KDj+x2BIswLs@lists.cip-project.org
X-Gm-Message-State: AOJu0YwSvP5Qk3lbiGLYIevqvPPhR67a9nId85iX6kLwrsvQq6IicZ0y
	Qea8jaNiBUi7InRCiSKjvYARGD/H161eAeiL+/Ro+ZiHAlK52C0m+b30CsumHZL8kq5cyaFBQyw
	b3UthNR0=
X-Gm-Gg: ASbGncsmONv3akGqxTM/mDhQ0M0HkUPAPstw9u1AAKgIdqn+ZuA7MV5H+vIO/6G3q7+
	6sMWOAmQ7JC92Oimbc57040Uwkep5C/AcYu4+SfvmB+kpLCyZ3BGxCrCLgmUnuDIOgyEgIohZgu
	hi8yxFvOb+B/D7NtukiqqC5AbCWVP4usk5baIKx0zOEl4Zd7VOZFH81K5o8ew6y85f2J8/lmv0V
	kI2I1Df4SaeTlHZwT79XrATdR4AbgG1nwYoPpUHMuvD15D4y6VVeZdOIneC1gFglLmL1B50GH9f
	b/5bbl8DqlKDenhGzVt4k0MK8kFUZMFD0jsmaFy/PKdd1TDf1FeWCkaB31AO7TU48X0a/OQ/hQW
	/PBGfy/oOAvC9EohtcM426WBKRnDe4Epbbm3sAcqqsCak9dIkmPbCli3JFv6caiFcAGXjNpZdPX
	96yzw5ywwz8KbE9ry6cfSsZFxf12wtwNHihYJidyDk
X-Google-Smtp-Source: AGHT+IFMY1x8AuRn7jETl1IeDZAmTU8Ch8xDbDY6YANfEvoCGQQXlHk2X0qnsMakBLMs7610oC5T7Q==
X-Received: by 2002:a05:6000:22c8:b0:425:7c3c:82cf with SMTP id ffacd0b85a97d-429e32cb6f8mr5893629f8f.11.1762416663189;
        Thu, 06 Nov 2025 00:11:03 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 10/23] driver core: auxiliary bus: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:10:35 +0200
Message-ID: <20251106081048.2574345-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20379

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit eca710386972f2a72708b0b2a615eb150d218e18 upstream.

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
Link: https://lore.kernel.org/r/20250827100541.926350-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/base/auxiliary.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 5d5b2a9fee0c..f1319ebf8532 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -207,14 +207,15 @@ static int auxiliary_bus_probe(struct device *dev)
 	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (ret) {
 		dev_warn(dev, "Failed to attach to PM Domain : %d\n", ret);
 		return ret;
 	}
 
 	ret = auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));
-	if (ret)
+	if (ret && !dev_pm_domain_allow_detach_on_unbind_cleanup())
 		dev_pm_domain_detach(dev, true);
 
 	return ret;
@@ -227,7 +228,8 @@ static void auxiliary_bus_remove(struct device *dev)
 
 	if (auxdrv->remove)
 		auxdrv->remove(auxdev);
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 }
 
 static void auxiliary_bus_shutdown(struct device *dev)
-- 
2.43.0


