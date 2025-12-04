Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF7AD29F8F
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:48 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50527.1764872145026938008
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JYNGnTVW;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso10330915e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872143; x=1765476943; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5/SmrPCBIcTNTmOhay/F307DEFDs5Zbf3TLxYKOrJ4=;
        b=JYNGnTVWHMDH+mbgZ00PGiT5+/SjZs5B4IlCADa4yrrB/0I/cLQGYVBMSMMvfVrW1e
         FHT4ylSIkQvEIpu2RC830T/RxdV5v8onOi2d4voB4Thpwnw7WAI8v0RN+A/6SApNEBBw
         D+nAzB4iZYSuIHe3cBCgy+bAFw0+oAwOsYdm0dI2oR74LmKf2GOVYq7r9N9FKo9gJniu
         MuhOpfF1ju+KVvILW0ufVkkgm6+5HnciZ0eyghGnO+9pWXIaVD3VgWDsZbh83OqnkTwr
         QdAH3fwxMJOX7rnmZ0g3Ls8ypIZoTyV1S4IayeKIMmkPnwtQpayjTBrrBKzIxa45WDTq
         N7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872143; x=1765476943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R5/SmrPCBIcTNTmOhay/F307DEFDs5Zbf3TLxYKOrJ4=;
        b=IWPAJxxr/PZXzgDgU8VOTJTBgFwsHSmN8brqV9k1q66nxqF4z62tuR1xBSK7VmKuVt
         vjrQ/fmN9KSQ7ZQuZ3OmgOkxxIXSHyyrvov0pYRWUYEGy6hLb5xbPN42I7meiOQIRgkI
         lP0jsKvm0cOrHysrqpfOU3vK2Xe/aKsEtfortob3pCf8QwuB/FuwJDBT+q68KF2zpX7S
         INvBakHHQJl1msH9A1ghPrl8zgKbuzgrwyAojYd4DHY+DBpx3I4wUZbD1wbqY7dQaaVs
         ahT/Yp937ZCtOuPJY5cflGI2BZWTMo/DK/AFPEPYa5xRYsjTwOSpm313JElotrydrWWY
         +0yA==
X-Forwarded-Encrypted: i=1; AJvYcCVN4ccr0R18hJHYyT9wP1Sw2M8BlBJsy8QCY6smUzOLWjlesjIucZy10EP4QIAIozyQPpZ7iD5o@lists.cip-project.org
X-Gm-Message-State: AOJu0YyIX0KJRxpKHLtRSj/MwiJEN0TNceKwUIDh7EFsReNJsVNh6FAb
	MA47wGP4x+CcvuIgSsclcer5YmwB50g7qAVCBxea18S8LKMO9AiTdW731M96WS7N28w=
X-Gm-Gg: ASbGncsSe+B1VBfM2hyRUflFL6StWSUn8kdP7xlY4yCph76z8WePn4Rr/vDPg5DqVSy
	uhEjFsjFBq8n5dusfX5imql2aJAwNFpzJ9Elg+tl67wwOGS9N8qLZhtwgcx37D/1g52/KG5+qZn
	Wk27+XAtcjDHKSXGeHoXepmsSWeRkGxZpLkDvwlXQ511/xHlGR7jMpe2oV75kuqPxWugijFXzxf
	GCX5AEDyDJxjIIQNpOxneDFtzCTNHK5CX++3VyoAAvUeKE5c+2Zd0gvsd5miyxz5eszJUUvUl0Q
	cPHFKdxEmNog8aO78DolbnNgXfxHfxi+suPFnryxxVLD4HjNuImpLvN0YDujbJY+MxYZkasG+Q4
	/x1Y2fGEj5ZOUMc33tuSFbK6VjuHDyMVW2OjYG1gh3+XQO8pzgMoVOBVNUInUm199oMVHzvy56C
	clE3v/3TKT/2qGvMnMCdww8XXRVYLGQhOl4q0h2sgd
X-Google-Smtp-Source: AGHT+IFjeQfZ2eNK+TC6nYkCrFS4Yx6MTWv5aY8u6m59Pc672zo9x0tU8OwHtcL7Y9WkwRi2FeiF9g==
X-Received: by 2002:a05:600c:4ec9:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-4792aef1d2amr68395335e9.14.1764872143329;
        Thu, 04 Dec 2025 10:15:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:42 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 08/19] driver core: auxiliary bus: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:15:19 +0200
Message-ID: <20251204181530.689132-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20874

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
index 31f5a81b5393..b02bbbc8d117 100644
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


