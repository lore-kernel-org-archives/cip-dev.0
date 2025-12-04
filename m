Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DDFD29FA1
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:19 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50552.1764872172538422484
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=i2e4S1Pi;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so14764815e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872171; x=1765476971; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tpDQFs5RWc86sBGBh287OekzsCI6QEnjPq808cRd9g=;
        b=i2e4S1Pi0fPuFoetbrgHVR1YWrZVgzINrB0F1FMFVomZ87Ckb2XG8x5ahvDcg8w/od
         wfz9Iot665xIZFq2Yb1w2LuLB+MkqsCcBLC0YuBIxK9JEjdV8iFM+i/Om5aOXSbkh7fc
         SczAfVerLbR5+ZobhYSfEDyI7I4t7j9VQuIUpQvTVLTxwT0sSnSs0jEfhHibnG27+4eK
         mUee6nnpkHI4fyH7nSJzXcXTyxjuMzVnrgHuj/NER0jj4c3TYva6fWFDAIf5/Gvgwcxn
         f6zRTUk8xV/JAhNILPeIBz0R1VVyUuPHo4zCoRUIYsPmBc8So48rDTBrGe09Azr/xV/u
         MZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872171; x=1765476971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3tpDQFs5RWc86sBGBh287OekzsCI6QEnjPq808cRd9g=;
        b=wT4/jn+BJo+wpbTOTaBUF0mZFWwjcWsNu4pt98gV/thKoRSupsJOjKDzjF1ONwj46x
         yxepPIF4yvTHuIgHwi9rQ3AZp54GWtFf8rcbb4vZmbME6Z3OAj6BKcEubTHZi1sB+D+F
         sNQYpMWJUboI6I2IW45FTV0fY/o1j0TbVn6BYkRKGoZwVRaFfun4o4Od2osRl1jkJeYW
         A2v/xOVqk+HaW6OTre/CDxOH8MwWd+x/NnKwkwCl6+a/LvvtLC/O4jxrSx0G3c5lnJhD
         28gLRw6aIuhWsp8NumPE0T8+vdbewPnvsBtvqnu417iolBgok4FYSn/oJ981/YIenvfi
         WRiw==
X-Forwarded-Encrypted: i=1; AJvYcCVf4joQ7JveP+FB8IxQLd+V9uYTAuwItBLdTYAtiq2oEnQb8dn76zZbTPyg60kZKw8nS4+ySVeV@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw2ifdAzvUxhZXBh1mfRKFduArex8azOLGwSctSomEyXvUSxpwo
	JPTS2+IA9mP5wWzBKd6XyIJ2C1S/2p0ROCikf+2Pw1NR2iZYCBmzbzSOUsTvIdOQVUM=
X-Gm-Gg: ASbGnctoTnOzaMXNYDpingctcdESh6+zYA3GGE029Y09TfMoxfEjUvqx9w94J3NCq7q
	Qu//DgFm9VhZKY6xAZ+kxX0YF6sGo3+DJz/etwUbTvYVbyixZGE5Z/n7SvH9YQPCkiiP+gLOdm6
	gntjNESX1qqfESeu1ONZFcdIKIBV8a5pY7JcJ4OFQo1snHd3CO0l4Nn6Srgav7QKqRubpBNDUFq
	iy4D9u6oCMFw+YYql6PqJqcHEhh3Mg2oCTnu6aJ1cwZKkK2PdWJoOWT07N/9kJfrY+L4oODxWkP
	QI83RqGBNUcFLGKNaYbNeZWCcvUt825ZgTHqd2+b6W5qhshlUBbu07jBO7Qfa0xvAkVJueS9BwE
	ZR5x2M14PeLNayhGw0Akp9K1+Ui7YfMR8mgJ487MFl3ncK6LR9xy9zGRg6oDXavWas1dq0cvT3R
	0o6MQAPnz0GzaBvwZed3+kDt/8y/rFVe+uigiotiwcdmwSOUmMCD4=
X-Google-Smtp-Source: AGHT+IGF/hx3w1IlmPaityiKt/PaziTx8X5UTORPw/GtN1f/AlD+SXWZFIFCiMImblCD26uCl7SLeQ==
X-Received: by 2002:a05:600c:1d0d:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-4792af49480mr68194675e9.34.1764872170873;
        Thu, 04 Dec 2025 10:16:10 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:10 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 07/19] driver core: auxiliary bus: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:15:48 +0200
Message-ID: <20251204181600.689203-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20893

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


