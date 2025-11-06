Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E9DCCFA1D
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:35 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10103.1762416752731383137
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MhJA9tlq;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso422493f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416751; x=1763021551; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofIxhqp1B/Qnz4R5cvmJRPTV+0M6ZaaljarO3/knCSU=;
        b=MhJA9tlqmtvvxR/R257iK7IiQeHpW22Onyv40abDq3QojpHYD2JSaHrqgEZfQDtomQ
         P1LqiMnux81cRTMIENf2ukfnn99/nW5e7iJdFJ46aatOkMUD6H4h8BdNHEYcqlMCdqOt
         6ibMEDl8YoJJfGe+gRaaTWSmRmb3DmqQFsif/3X932XW6XCbHSdBp83VhGfTxt9X/UnH
         0sYnMJoyFAOA3yW1fU3Von9G/5RUF5F8p2szX+FvsV4GdIz/Se+s+mordEXY+VP9paqa
         uWMA0x72eBnvtifBhxjl9XP7Prd6LX61JG3FQwwq/r/frbfSgM6mnEad3bEmZtoKosCR
         AX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416751; x=1763021551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ofIxhqp1B/Qnz4R5cvmJRPTV+0M6ZaaljarO3/knCSU=;
        b=YhzMhlyw+3rzVjvYM2dncPn0YQGtcc6da2+gzQks04QkFVgSss+JFDVRuX+uNOVr73
         tjeA8r/p9VxUyTLNlh0KUvXnlf0vPwfG98oWgBlrn21M3eKLCDX7OZsqtygw66hMN7Dq
         a3tV2Dr97bs3Y/vIwmZMRiD8KCZ4Z3NBrCXnMm3H7apo00ZkSoCMug7Qq+Fgz7aSYUoB
         TcTP95XWsmWRgDQV2S8svCSqkETXLgw/zcYCuQpzhos9/yOqHxRl/LwuuERYLsJWkdQT
         oX/ytD9XiYnDUBnomsjoyVfilXMRutw4gmpV7sUAKmIpEx2Us+Zes9odY0Kur3Ply1jP
         Wq8w==
X-Forwarded-Encrypted: i=1; AJvYcCW5pA2CmBjHOOz3oNi+68+aAT7qFWPi9Qha31LtigrEfXZ4mF4wAfkmkdrw/Xw1wdc50Sur1puO@lists.cip-project.org
X-Gm-Message-State: AOJu0YxAM9hKuNO6Ozcq4AazgseQoZtUk9Fdws/xmwoMl9GK35JxF0k1
	VYGAyFjrwgiPcTW98iWCq8KaGRQoKVJiBmZamhvgaew46bOjNQ1Js/qLKI5zMREgfEw04s0XFbT
	t0ZX8z40=
X-Gm-Gg: ASbGncs8cJ2Q/c4esZAsrgJr7pAixxFnMkoAT5V4UjSaJF4brJ8oAmfGwOWosnth1ch
	SDckripdnSN0uSvUe3nf1nyDCm0wsSdmFHsVDU9SvHE4EZmsdlGf2AFuijHat6VolYFsrHE15+M
	jQwrRyR157UZmWOf94H2SU5JtFcNfCAgGt+Z0Nl/AZgMtUOslXNAW38yAFOtxWGodJ3ucc1NYpJ
	MAVePXl/vxcMn7be3wjm3qeUH5W5HIpyM1ODncUTxlNthN0fuJOg4xE6SEvjMOSePpQQNMVTqBW
	hCyV1ovjtbfHa7zcVQHiGqaIwK5K2DxK0qu3SsMvQnU201qhTZvNbSEWrzBTgMi7G2XDlHTSX5F
	EYhiAuitItJ3gzJmaQ8JTWxGWz4NKV2qFvVXIvjyEv1DB+D5DDDZIP9CQxMYsXPKyL3X9+X+m6i
	7XLkOQwnRMZ1d1ER3fnIzPbhhiqBGc6A==
X-Google-Smtp-Source: AGHT+IFf9Po3OY+GO4PXY6Gzf61i9TpLSW9sw9SmMQKyofV0x6v8yjIdsfBpQfZr+gx+kuEpn0kBAw==
X-Received: by 2002:a05:6000:1887:b0:429:c972:3515 with SMTP id ffacd0b85a97d-429eb13b6fdmr1827765f8f.8.1762416751162;
        Thu, 06 Nov 2025 00:12:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 08/22] rpmsg: core: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:12:04 +0200
Message-ID: <20251106081218.2574950-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20425

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 214ae22e6d4f774f053a8f7d32bd6a9874447b06 upstream.

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
Link: https://lore.kernel.org/r/20250827101352.927542-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/rpmsg/rpmsg_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 58db61f4d613..4e62ae4fad2d 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -451,7 +451,8 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
-	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (err)
 		goto out;
 
@@ -509,7 +510,8 @@ static int rpmsg_dev_remove(struct device *dev)
 	if (rpdrv->remove)
 		rpdrv->remove(rpdev);
 
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 
 	if (rpdev->ept)
 		rpmsg_destroy_ept(rpdev->ept);
-- 
2.43.0


