Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB707CF65C8
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:43:45 +0000 (UTC)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16222.1769420619090666352
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 01:43:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Sn1RF6RV;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.67, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so47124925e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 01:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769420617; x=1770025417; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iNZzYwwa2Bs7v3iW6wx0itVhq4qvSPzaGT8Yc20f5Q=;
        b=Sn1RF6RVGHhy9t5bBeC6FXdxMKhqtNgqezpfY80QRt/5W/yLQ6RdcauR2qi9aDZKsu
         3Xk2t+KxYjykBUaI+5v+2zDNdSAwz20cyoBos9W0vcDnFQMBQTzpdf7E3ctUCZbvHZVH
         Q962GALmPD/50sRYc4pu0QVREzUKJSzSAoHBmQ66WYCysdnWhEOZNa5aX1LMvliN9e9d
         ENsqZe86k47RCDZ6noQexgMmmDk3XFL2w41BrW4aPkncHZNK4R4Cr6g/9GThBHONN+Zv
         APzkqAFCWAtKJehqlEQ5tiI3vbjVRWi8eaTAAVQy16gXNrMPwqh++P5/tpa3e91vQJId
         BCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420617; x=1770025417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4iNZzYwwa2Bs7v3iW6wx0itVhq4qvSPzaGT8Yc20f5Q=;
        b=B8JKmGE4qgc6q3TUtrmdCqMow15OE3JbOFAuaC3f00dfT/eS6Pidu6OlRcTFUz/5Tv
         DW9rc5t3Va+c6EBdpNBlfNIbPjYUNZmIIsFzDNrHPG/Zmhy2D9Q3/SuUxrTGgH8zK3Gz
         +ZcJpO1G9Kq7dY2GiC77NOKvD4tdEHUcx6ZASrae0I7eHcHY/pmzRlWWxHmoIWZ/vwfF
         jlISDJJRYdxmTsSiHxzeGX+IjM8dm2lzkih7aKTfnTSI2xNe50Hr4hn/yD9+aeS/4vgU
         8HIGZAmR/bKJkF6P9/oqL9BXw/B/WhsUHsRtXtwGtOLe2gigBqtILRwBc28H1UB+ZRNE
         ybJQ==
X-Gm-Message-State: AOJu0YwxhNu+DBheih9E0RG8SY1Zym7mGK7ZNIF8v3oejqjDfwAedK81
	oK+OLVTkqpb7u35H+lq+anovVG1P8fkJYVtdNcYqGzfsjAYuJyRMGvP5cbpKypz6vo4=
X-Gm-Gg: AZuq6aJiVr1zrIeBbuHAYQcb0mkxMKLPvJIhWG6xi3cHEKSj4w6ItSy/qJeG06XwylE
	X1X8M9FfZosiJ8lBEWuhfwqGheJwJr50WRR3mvGp0A+RaxY76Jn+7iDF2/pqY+IO2aQXZolGWVd
	o0Dkqh+hngcJ+0ZFI1sop9IInhhL2vS/vz5LoBUIO/fax8ZyPK1ydaYnnrE96fPdZDAP24sQ9Zu
	IyKK1kPdPeefccKHlvDksRfJoiosTIiknA0A5DjVcHpamyRsnrXdBuI6vg0DP4lFPH/PK5+rRZv
	Geb8EHYoh65NdS0OB3aqNebQttpvtXHz59h+W5Fw30z3ze8xOSzv4AgKWl9D5BCrIXkAGmstJZL
	sVwQZ6eqQHjiLoUSWaXQYw9z5/TRSNUdTb29HKIbYbEqo6xs4ZDVHlOJ0vRrsQDPGZSnpLLUD2w
	f2aKt9q/0niahIgBbaga+o+rfvCU8GcvNS390YfmGQEZWiPyi3mA==
X-Received: by 2002:a05:600c:1f94:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-4805ccd16d9mr71169305e9.0.1769420617389;
        Mon, 26 Jan 2026 01:43:37 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804daf23f4sm103692495e9.1.2026.01.26.01.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:43:36 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 2/3] mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Mon, 26 Jan 2026 11:43:32 +0200
Message-ID: <20260126094333.2528974-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126094333.2528974-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126094333.2528974-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 09:43:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21714

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 50371ef025a433f782c04dfdd3b59251831a8be3 upstream.

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() require __maybe_unused
or #ifdefs protection against unused function warnings. The usage of
pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows the compiler to
see the functions, thus suppressing the warning. Drop the #ifdefs.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea:
 - in tmio_mmc.h kept the code from v6.1 CIP and dropped CONFIG_PM guard
   around runtime suspend/resume functions]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 +++++------
 drivers/mmc/host/tmio_mmc.h                   |  2 --
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 6044e20ea36a..5fcf137cd877 100644
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
index c7c94caea3d8..f13ef6ee351d 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -225,10 +225,8 @@ static inline void tmio_mmc_kunmap_atomic(struct scatterlist *sg,
 	local_irq_restore(*flags);
 }
 
-#ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev);
 int tmio_mmc_host_runtime_resume(struct device *dev);
-#endif
 
 static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 {
-- 
2.43.0


