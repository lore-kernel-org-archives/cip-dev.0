Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D2ECF65C7
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:44:15 +0000 (UTC)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16238.1769420654447491436
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 01:44:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Se13HaoG;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.67, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4327555464cso2852204f8f.1
        for <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 01:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769420653; x=1770025453; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2Kr/s2Yatk42zAwU5SGVe09DI6TUQYpj4+nesDY7uQ=;
        b=Se13HaoGqt/xO/XQQkXTklUDLfxdqhTZIYqcYVEGhLtPSeaV38EVskr0AeoHrDOj+b
         9MoL38GGjbJ0gj9PtspTq/gWDjO4EZIM+I7ZvyG4lQihtGV2EzvolW7zWhhHASCvm33Y
         GsG0vPOab9xKmO3SutUP6aYW9Y1WfhbamsZCrjfnpJ996sBOdKGs3X+WpNoxo2Xa6QHN
         qjEjKXj+wcMQNDrGdLBYRpBeywlp/rbi2cCRfqDk2Xm9M+rYTeP8kI4bYGZ0dYtGLuDB
         YTykhm+iKR8tBlXc2Hu7yOmpt3M4u/U4/fLxAL+oVUWNbxgCTG32p8gy1pc24KjWseZe
         LAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420653; x=1770025453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P2Kr/s2Yatk42zAwU5SGVe09DI6TUQYpj4+nesDY7uQ=;
        b=W4Zes4cKPt2zT3Iy78aj07odb8VSh3n+/SKj2vwNLYXECOShsElo85DEAJwiTrMV1c
         yx2gBo5d4gIs+7/eS6PtdYvBnjJRQEAJYT44cSm/8eAhtHgcJH/p4ZganaHTdroFIjGc
         nU2ULMGDWTh1q1/hx+5Gq0BHPLMMoJYfO/wgfr51Buod0SvIyQXHoVFRG8jwlCqLDcIr
         3tR1yuqmrVC6pvl74FGokOiDNIgbJn34JquQhnh/agv5AmLQcycHiFAcwtT8z+uXty5n
         PKg/7UDywRsDLtc91ak87H7PvdnoD44cLrpHCMt9j+k9MiyauqOpB9MEEAm9d85721J1
         mA8Q==
X-Gm-Message-State: AOJu0Yw7Xy+1hzkn97H44WrPHVoyDJM5jdtHwRuRA4ELBLdZ1rBEv4eX
	geaS2NTKyiLOc1omu33VMrbfNhO9F0ZoSI4nRKecWgc4J77j+MOUHjh1Cgx93Fnl8Yi80blGdJR
	j+Amkb0Q=
X-Gm-Gg: AZuq6aImlRWmKx5yKiH4vUWIBDlcdYqg8azvcq7uV4W2cuG/iPDuh9o+dMixa0sq1F7
	HOrJwawcde56U31WiYKB1oThWbkEiMZ9Rq7DMe/VgHK+5Qsq4+Ui1nK1AFkSw+GZoE1M6uRS2xo
	O1P1wCzLlC5DqH3muORjLUANJ0yv0tWTVLDNVAUu0t6B4sO7wsOL/2XtJ+hr/ExGinLpfWB6sfu
	oZSGShQNFseBCm2z72s/WcoiqHPLoIiluFbnXXD/wYrDg20b448ua7bv+DEDb4Sw6zGUhqQdLO7
	/4OpTQtAdxnv51qU4TJDd1UouZJZAPL6p0/rJk3KNjO0R28+LdM7b2dTXJ3VetRi04DKy2P9Jbw
	PbqxmCJ8W0wlgubSUS4R1uXs1bH9NPztgAZDxyWUKFfn3UwOe01qHalK+kdHvs5wEv1L2XQgz4w
	qdxuS42DMnQN9croSKji/3DYghFFIpRyGF+P7wOQ8=
X-Received: by 2002:a05:6000:2c05:b0:42b:4247:b077 with SMTP id ffacd0b85a97d-435ca1ada09mr6479821f8f.41.1769420652758;
        Mon, 26 Jan 2026 01:44:12 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745c5sm29675520f8f.32.2026.01.26.01.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:44:12 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 2/3] mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Mon, 26 Jan 2026 11:44:08 +0200
Message-ID: <20260126094409.2529052-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126094409.2529052-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126094409.2529052-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 09:44:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21718

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 50371ef025a433f782c04dfdd3b59251831a8be3 upstream.

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() require __maybe_unused
or #ifdefs protection against unused function warnings. The usage of
pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows the compiler to
see the functions, thus suppressing the warning. Drop the #ifdefs.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 +++++------
 drivers/mmc/host/tmio_mmc.h                   |  2 --
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 5652979e09ed..ec475d427421 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -599,18 +599,17 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
-			   tmio_mmc_host_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
+		       tmio_mmc_host_runtime_resume,
+		       NULL)
 };
 
 static struct platform_driver renesas_internal_dmac_sdhi_driver = {
 	.driver		= {
 		.name	= "renesas_sdhi_internal_dmac",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &renesas_sdhi_internal_dmac_dev_pm_ops,
+		.pm	= pm_ptr(&renesas_sdhi_internal_dmac_dev_pm_ops),
 		.of_match_table = renesas_sdhi_internal_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_internal_dmac_probe,
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index a7263eb10450..572078c9f2d4 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -209,10 +209,8 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
 
-#ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev);
 int tmio_mmc_host_runtime_resume(struct device *dev);
-#endif
 
 static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 {
-- 
2.43.0


