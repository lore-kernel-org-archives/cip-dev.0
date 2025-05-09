Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705C0C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:35 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.10426.1746783327695514128
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=V3wO+Pn6;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so245621566b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783326; x=1747388126; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10AuFG3ngBCbtivxOs+BInG3ViZofcVfKM8nyljn6Tg=;
        b=V3wO+Pn6FXQnLdnxxNatcwiyO9ycSQ2Qh9TBv40YmhPHzPF5FGXV8Kq//klkWeMpPN
         g+6atBJvmxO+SJ9HGFN54aLrXgLPUVjxrEJuVT7sQiZ3GVZI7EF/uUcDtshpdC5t32L0
         vUpK79Yb1Ph02kdYpFEjC2X8T2CRI0o6WxXQASERZJPPsAzud7YwR7V4i6tsFiao7tDW
         +P8Yce27TXzNUr3CoIWEuU+U2TNgCv5PxzxvAJ0FnERVr2CP1CyzFg1Jx74U940tFMNJ
         Ah17yS4+XRFcKyHHhKU6v4vkah3YmYpF3EEjUsZYMS8Stm01StkvMu32+k0U3f73P/MJ
         qdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783326; x=1747388126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10AuFG3ngBCbtivxOs+BInG3ViZofcVfKM8nyljn6Tg=;
        b=lwNd8mswygduloLd6g8kzAlCJq5DZ5b2wdCjfQbPRcegJsmSLzn0PnCE7vLPpr3gPs
         jXHqWmhD4wcM2Y78UisygMGF9iC8n08GB/SFMykvFmKbEpJukuL6PqR4z6DNSFehLrY+
         1cc0/5BF2+Ug3Beh7WhQZKN62dpRXWO13IpJbKs2edTVWIaJ2IPcQK3YdtNN1T4br/hl
         o62u16wv9KSqpbOu14Wiv3yguQ3vjg2wXc6xRqdnTJ/Ieg/6IqBR899bKt103BJY0hcg
         zBBoWx7gzOBvnP9P6nTYs9nbTRjCeL3YmHndGrFl9zKJylsJ0+BSOwiqqX+EuO8o5ylp
         vDTA==
X-Forwarded-Encrypted: i=1; AJvYcCUPmPn2xI1SLLOvNWWgwSUQOjTz/HGIM3EYnA5Hybw6ikKtnytQo9EbI6ywDzR+DHF2TgPsx1qn@lists.cip-project.org
X-Gm-Message-State: AOJu0YxV2b5TBogdvmHx+p5FEfuqGV/FHkNWRkn5WjK9pQVnGtEPIXuh
	p3WB1EXcO1HPyeGolIxpw49XvblOe/Hx/JFvAf7FygJPE/gJ74yd7qv00NFWtMU=
X-Gm-Gg: ASbGncsw7N35+uZp0Q29hZBqCtrufF7DLXdLUf5RR+bhTN09eDhMfE922RkAsRZ9bVx
	2w/hkAu6zX6/ZhFb5R7qtxXKNgcOizF2lq9mbbfd1+l+HveL85W316YcmADdCut3QZrMX7mOaUF
	qbob2GNmF3jCyWCCMbC57cluF4BnTH+VAxQ39zVkM8ovC3diMGGsYaq/NfxG0wX5X6tpyBp0IA6
	kOAW+GSxnTKnp2ELIo3fyvyAAaX1Y3fcJ5dmONW1mCEAKodJwF3LGTGHXwbJH1cHX9cWwYJ/uMm
	iGLNQ4w7pTwYfqE3S9F8vfcybeTPgJ/ggxjhL2AOREtkVKZ5sPNPRee6K8dVE4150/icCg==
X-Google-Smtp-Source: AGHT+IG/m+IltV9sC1C4jWVHDpQMfzpD3iQR1m0qk5tVG9QctklmHUF6O18um5AtqMzOB9uxG/uDqQ==
X-Received: by 2002:a17:907:9453:b0:aca:a3da:80b8 with SMTP id a640c23a62f3a-ad21917d128mr306156866b.55.1746783326122;
        Fri, 09 May 2025 02:35:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 29/37] ASoC: renesas: rz-ssi: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
Date: Fri,  9 May 2025 12:34:34 +0300
Message-ID: <20250509093442.4015145-30-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18881

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c1b0f5183a4488b6b7790f834ce3a786725b3583 upstream.

In the latest kernel versions system crashes were noticed occasionally
during suspend/resume. This occurs because the RZ SSI suspend trigger
(called from snd_soc_suspend()) is executed after rz_ssi_pm_ops->suspend()
and it accesses IP registers. After the rz_ssi_pm_ops->suspend() is
executed the IP clocks are disabled and its reset line is asserted.

Since snd_soc_suspend() is invoked through snd_soc_pm_ops->suspend(),
snd_soc_pm_ops is associated with soc_driver (defined in
sound/soc/soc-core.c), and there is no parent-child relationship between
soc_driver and rz_ssi_driver the power management subsystem does not
enforce a specific suspend/resume order between the RZ SSI platform driver
and soc_driver.

To ensure that the suspend/resume function of rz-ssi is executed after
snd_soc_suspend(), use NOIRQ_SYSTEM_SLEEP_PM_OPS().

Fixes: 1fc778f7c833 ("ASoC: renesas: rz-ssi: Add suspend to RAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20250410141525.4126502-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[claudiu.beznea: use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() as
 NOIRQ_SYSTEM_SLEEP_PM_OPS() is NA in v5.10]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 0f03739f920c..c431e67903f7 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1253,7 +1253,7 @@ static int rz_ssi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops rz_ssi_pm_ops = {
 	SET_RUNTIME_PM_OPS(rz_ssi_runtime_suspend, rz_ssi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver rz_ssi_driver = {
-- 
2.43.0


