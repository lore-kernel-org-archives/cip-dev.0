Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B958ED29F93
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:48 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50859.1764872146572852770
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qkf5oIyv;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso16755005e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872145; x=1765476945; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPPMWdngrmyHD4gQjTSMQGE5FpovXitWFOD5rLdt3Gg=;
        b=qkf5oIyvi1Ec5wGyBXuVhqTctFomLCMf4T0llOr8SGvxeZV1/3+GAZSzbjEBXryuB7
         mF2vT/iG5mI8kwasS1IkpY6caBo6Td3aM0NeKgugSpBnCPGKA+l+ijuaF0WlIcJ1M0oI
         3k7rE5KR8h1FOd69mGe/nPT0AqWsmJ4AJodtKvkWsbQXTZbdvulnmrywCQqdgi1v1+sy
         BRvJSl5RtQdN2kimSGdRv0g8snWZ1kBh504J27YGIFuLDk2bL8gfQQNRUv8CoWgjeVu2
         9Ie6dngpzp3mk9CpCKW5j58IyVAhYBOFKJRP8PmgV/YAfosN4apimsWeym6CKttt5bG0
         vBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872145; x=1765476945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPPMWdngrmyHD4gQjTSMQGE5FpovXitWFOD5rLdt3Gg=;
        b=hT0e4+ksgpf1de75o9Tb6GJMn60Py6ykPFYQGIJJjX0lIoi+n9qSPNz7XNvXQVvbeC
         fzEvGoQNERILbOS+Pnf0sep2TAZJCcmQrxSkROUw2ItYIfvOft1HJTx3BtU1/swg83yu
         kB15/7kb9suvfGQIlsFHvG0U8wOjNgSETgi3MoIezVbzbWHrZxMc+NTk/6dckv/Ius7k
         YuO8dbPVJ7gDbHeA5Cyn+O7fg25AieZAgRNpvne2IVupyceX5JjDOTUTCKyZJK6S6dFc
         /6jaI7FrFwUhSuliy3+hpcEBPJLmuH4hWM02ubCV/aVJSUOqJJ55RCqj8eHXttb6FxRA
         E+iA==
X-Forwarded-Encrypted: i=1; AJvYcCVMBHJKjhAu7x7axc9ABDUQKQ25cQJmcOpb0/vdcdzYPY3Z17kJXOFlu9xCmaW/HB/VVUJyWp6E@lists.cip-project.org
X-Gm-Message-State: AOJu0YxgkbMCdNofq3yTDtgIQOGf1WfmQKX9PAmmu/vk+rPap6SK9Y2e
	tvpWuLUUQt1zTlg8qbDXiuYj/aS0vZOc6GL+db0aLfj4U6TZtZ4AhJ7Ip1nh2zMZ03U=
X-Gm-Gg: ASbGncsymn3JbEnrNNTJgox5qIoeZF8n8ntV6UjBdNBCm23mAsQEGBG8eP9Vje1JwN0
	1sCumrPHlF829eC+pkix6x5h8p3uODVOE6zdXpRxVjyJ6cBE3QeI9bCES6YsOWwkTyawjhogjvF
	4BwY5sj5CNr1rQvfsiukJP35Vcl+63QKq5iUV/sz4K3hu8h0DL/iJG/qmazSVDDKRM0IT0bBc8r
	4jwtpXGF/SUo4y9x7PymWUkvHeBzNyyQL8AMkAJCYQFlSEfZRKRK+kZwlHATR2offbTsKNozqC+
	agbWEKgiFFSRrPKE0XDatmdECF3EDFF9k+gBUr9V8we1hUUqA3EUTlxSU6e3SjSc2kwd8I9NhkM
	pGQTskyQC7noNbldviMC34VKROe/HxY0LyTh/SkrpAOe0vex9WCFsS9JNl3em9/wlC4Lz+0vsgN
	znosQtDrvJ62wIxMWW1DeX8A/RMrNOnCZ7Tpkaurwx
X-Google-Smtp-Source: AGHT+IGkC5elypqQHYs4sq/17j8LFJKb2sDvkA4n8+4mI4z1JS2jZKv84yBIAAjjhNrUQpu8SlfLJA==
X-Received: by 2002:a05:600c:1c02:b0:477:abea:9023 with SMTP id 5b1f17b1804b1-4792aeeb5d8mr67103445e9.9.1764872144941;
        Thu, 04 Dec 2025 10:15:44 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:44 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 09/19] i2c: core: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:15:20 +0200
Message-ID: <20251204181530.689132-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20875

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit eddfe53b0d84b02802432bf783ccd53b095dd10a upstream.

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
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/i2c-core-base.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 723dfaa994a0..faed61ec848a 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -569,7 +569,8 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 
 	do_power_on = !i2c_acpi_waive_d0_probe(dev);
-	status = dev_pm_domain_attach(&client->dev, do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0);
+	status = dev_pm_domain_attach(&client->dev, PD_FLAG_DETACH_POWER_OFF |
+				      (do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0));
 	if (status)
 		goto err_clear_wakeup_irq;
 
@@ -608,7 +609,8 @@ static int i2c_device_probe(struct device *dev)
 err_release_driver_resources:
 	devres_release_group(&client->dev, client->devres_group_id);
 err_detach_pm_domain:
-	dev_pm_domain_detach(&client->dev, do_power_on);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(&client->dev, do_power_on);
 err_clear_wakeup_irq:
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
@@ -633,7 +635,8 @@ static void i2c_device_remove(struct device *dev)
 
 	devres_release_group(&client->dev, client->devres_group_id);
 
-	dev_pm_domain_detach(&client->dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(&client->dev, true);
 
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
-- 
2.43.0


