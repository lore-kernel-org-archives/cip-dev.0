Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B250CCCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:54 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10083.1762416712045190460
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Jh84uC5/;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47118259fd8so4373995e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416710; x=1763021510; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5/SmrPCBIcTNTmOhay/F307DEFDs5Zbf3TLxYKOrJ4=;
        b=Jh84uC5/nFtXRQ+eGuXMeqyc/aEm4ebPqejVAsKpBR94UzmiaaTy+bnKd3uhknYw+T
         YCTyrSiYmWTKG4mMsvxUDw9lpOuTRRCHkc59HXFPLUjGiYaYOcPW6sEX6E6nxX0Tb8A6
         7UTmQ1RiPdy0HWUA5EHMjZtvYzkC7buN4nWLWvtGr/xxxWCi+4FNzwy9+sMZ2BVVN631
         dG7o6DTwihpJfIm7Xx/jCFk9AJ/ysjUi3EPztnHm0P6ceECkr7IR9fy5XZqQpTvSysun
         Cc0Vbnr7WDtPFZTzdetfBtrcU1uLk1mLN28y6Zn2pdE2BgMlUj2zUc+oZmBvBrqj1VLZ
         4miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416710; x=1763021510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5/SmrPCBIcTNTmOhay/F307DEFDs5Zbf3TLxYKOrJ4=;
        b=NHp6qiE5tcmgwYPIdTPtmeVBiw6ja/5xvQT//uny/qQHBvWAfnkNvw8kN+Or4IqMn/
         XbLRu9Vi63KsDGirHoS1od+v8deI6vncsjHkdE/7wg8TjK9GT6WGU04L5dX5VdrYI+mg
         cWBSStLyaip+ejx9v3nZgdcvjL1nagUcJ1rvorSUS4elTjVVgr5iNJN+oNXGr5QZkjm3
         SJIlWbNIl38kczVNrQUnLYMT0U6jyPXeaNkJtq7vTNwcOD+biEhhSz26JILxL1RtJ0Vh
         K4ORQ2gvXQ3tJKscZsQQ1Dgwycw4jIVgxZcIALmq8Y3NTZdAHLKH9owKM6mJUz0Ozy8t
         puFA==
X-Forwarded-Encrypted: i=1; AJvYcCWObrof4LzbnJc2ZB218QOp+M/7g6CDhZa0MDKAf+g9wG61YIsJk1QAc9U1U0hg+VoFBDxFJX/d@lists.cip-project.org
X-Gm-Message-State: AOJu0YxUDeT8VYccOj1Riv+yX0fhCSUMI5IXzdpb4ydgt4OW6OhQqVdy
	jbe7gSzD3hJsPKSATFd53ARQ/zhcxmTBWEAuGJBnxSVvixANHhUOENaSrAdkcclyXBcVYFNXi7r
	ONaOwZ1Y=
X-Gm-Gg: ASbGncuHXMTMOTLpl/GQFScwaXU5snlRB2evdPeoRTi2lkWikskQ6r+614J/G2YhPYA
	fRbVToqylQk9cwJseu4r9s2YccFtbrmTlv3RfoP1u9qgvXQoI4e527leXve7maWJzyNNu5uZiIm
	o12SQYdxPMjyg/8LXJXS/ZFKCE+IIw9RMw6mMujf4NN9SPXa7purF4+Z1yP5eK8rdxbTJCo9ISF
	BjlUERRyROikDBgrAf8MaoTK2tPYgoR/9Xt8smhc9wENymQxmFAkCL4ZIm3/N3oBVyo9M28J/yl
	ffSg7GNPi/8N1hxVipIHNxEfQ8v6E14IVooCcHqC2dglMoGh8F7WIDNXvKa0+ll8rVxm9vKJsHc
	G1Zp1x4bzyMr0Nq8vm52V37RGTkoisFiat/h3VSi4q5zz77/R9DSSdhI1dwfFPEaVPmT6N497hq
	N423zX1CffOqFBNSp9YBFKLIbfwYAAxAqw/WIFa+f49o/1VkZnPuw=
X-Google-Smtp-Source: AGHT+IFiZP5JHNrL/ele1M0lbAz3aa83br1YvkQfD6g/4YiTTI5SVbgt4hnnY7QZg8/LLLH0Eqm/qQ==
X-Received: by 2002:a05:600c:5488:b0:475:dac3:69a2 with SMTP id 5b1f17b1804b1-4775ce164c5mr50855185e9.27.1762416710455;
        Thu, 06 Nov 2025 00:11:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:49 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 11/23] driver core: auxiliary bus: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:11:20 +0200
Message-ID: <20251106081132.2574638-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20404

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


