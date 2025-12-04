Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE01D29F99
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:18 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50888.1764872170223595173
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=WyYokaIn;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47790b080e4so8153215e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872169; x=1765476969; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XQfUImmoDcKzmFn5jPmXsh4tD/k2Dmqe+1MBSg5Zeg=;
        b=WyYokaIndOmriVoeL0DNheVe6b6gu9a/OTp9KFKE/WPKzPDGmzDZ+v5xifenLnw5+M
         +DXQgLfmy++UDMdV9qpKGOkSwpmnGI/9qpBDQ9YCBPE18QguNg49qqjJkfEnHXLHkWEr
         U2wx26JesAboj//wyEYcSj9TXa6V+4e8P3grhf5XH0ZA6dcPwhvvun2yvLO0fBuoUaL2
         PUgijCYcL8N3V6aNqeUYrvpdELvTaXIIPRLNOzGZTZFjmxIr41H1TjZzbBovHxUSSM2l
         AVshsbzg8J0va4x3RwA/CN14by9ljqwV1LfgLEXFY/NS4jgbnwkGA6wXZ6cqLuq8ws/y
         xVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872169; x=1765476969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/XQfUImmoDcKzmFn5jPmXsh4tD/k2Dmqe+1MBSg5Zeg=;
        b=N9fFmC8uZ17sOdM9ErJwed7Hnh3RLT+935J4QeoVqpiJxqyfU3ge7/5nHdQKEzDsgt
         +QJMY94LTkNsuQlISie4zYW6aSURfxokSHnciwI15d36tWL8EOJgYIVx404FNOYLefyQ
         WVX6fqMNjESa/+7jxvuR6OKfv2NMR2XecwkWzB/fcbcwZFpQbpR1fewMahZRU21F1vaU
         AT7bH42AdBqWTud434+7l/U3sMhaemXP0Qxvybo6ookXC0LOdjJ8RHsDB9dr/NiQlVek
         oo0jKFqtiJdLa2NSPXO+nXQLQk79cut8FQUcpU2VpIfSF2klczHzDOTZ1PgBxV1QNJhv
         zHCw==
X-Forwarded-Encrypted: i=1; AJvYcCXiUx7ui+vFwBr644TT04nIwalLV0bcHysBcLRCH8NBDOZ29UgSTqlP6Gv8yG1e0UMDt90yQmlt@lists.cip-project.org
X-Gm-Message-State: AOJu0YxinquI+ieYErVbweGR3s2t+LLBqWy+9YepTRfb4evaK+2CY/4M
	hrn1TSdk/xIE/0LrMlaGJ++bofWYLrkPUtyksfWuqYc6oa/68Lo4m25FkruA0Swt21Q=
X-Gm-Gg: ASbGncvQavc9xK/18O3vy5AKh3xbiTD6AXkh7HpK/TJOKf8IaNSxCJMrVw4hdFZ7ZJY
	trXwM43AY/i/bZdhAmRneTqUGeSrdoVnBoOaa0Ys23TgBdMcppHoXieqCinw6I/SMjlll4ykOdp
	DJryqghWNh3+nOsXqxPVDRpkOUZYPbYFT+Ym/Ub+atDU99XQFUpsUSruXFXyVLI7HWU2SZML/yV
	YK28X2JKIY6VYtKAtpX+M0ELXKPZ3PRCFqqmCFBBLFksPJfQyO5Bd3cO6BIoGKV9P343QStsKiD
	zlm/08jl1xP+9bKAEPh80No2BzqY1kprMBmzzBQJ1OS13Az2629jn5HC4TUraZpm+SL7RL0fisd
	FIEX+B3BpjDc69ytQUmXJ/dKDXMl9SwhKSYUl8pM9kKKsInQJEUtyfE31n4Ttto3jbgUeZoH9wT
	CrrJj6XqiuLoqfNPyFP7fegDRmoWzW3/cl/mbmCegR
X-Google-Smtp-Source: AGHT+IFUMT7O+0AhaMEXD7cjOsvdxqcvpvx+KhxZPCvwihjWmGIQrOJd3Gq6N1u9iibbITSgPOCG9A==
X-Received: by 2002:a05:600c:1c9a:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-4792aed9fdfmr80276395e9.2.1764872168461;
        Thu, 04 Dec 2025 10:16:08 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:07 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 05/19] mmc: sdio: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:15:46 +0200
Message-ID: <20251204181600.689203-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20891

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c2ef7a03f5c8f0a612a8beff666483b725adf8fc upstream.

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
Link: https://lore.kernel.org/r/20250827101236.927313-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/core/sdio_bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 656601754966..07704ad86131 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -200,7 +200,8 @@ static int sdio_bus_probe(struct device *dev)
 	atomic_dec(&func->card->sdio_funcs_probed);
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_noidle(dev);
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 	return ret;
 }
 
@@ -232,7 +233,8 @@ static void sdio_bus_remove(struct device *dev)
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_sync(dev);
 
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 }
 
 static const struct dev_pm_ops sdio_bus_pm_ops = {
-- 
2.43.0


