Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8282BC3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:04 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.10385.1746783240235577132
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=FnuGuaaE;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad1f6aa2f84so411553766b.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783239; x=1747388039; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wM+gqOrpmoDllBYAW/sAOv0pHg6iyxSWxea5Bssa8gc=;
        b=FnuGuaaEegfd+Q4ft3KW8XRsJb9Wu1zSHXPYBEx8ilY0zY51DFoM/DYbhJYBR9TmJl
         GuledcCyn7jIoqPGJ7R2Qwv5FQRGLQYfOQCmTj22LDvWBy3IuWZCMhOw6gUSrPHuBZHJ
         qzkHtebgu2vC20no1FOMcH5Tb8Z48EoXkkXLaHULhWV6XAGOZnZxgr9N7XfBNo7CX+iu
         Vkr6I36t7EEHpzfR+fvpYSgfCj7OXJAnBvyQt8Djr0b74pqxwDj/gfZsYF19svo52i3w
         USi0+LWDFZar8Lhtz/MLLN8Mx5USWPmHJ/t0S7HZr/vboJQPcbuNiQZOjuoplpx9o55H
         3twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783239; x=1747388039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wM+gqOrpmoDllBYAW/sAOv0pHg6iyxSWxea5Bssa8gc=;
        b=BDeZAmsUeX+e0Ums+3ROro7oIdLRdCDiKPUY914PzoHwaFNzreIDKNIct9yU+/hG/r
         MwQ7L3YBNFju7uIGXsVeAtSUoSBjhbVyvZKZtEijxmxyB0ny8xUqBMGXHjKrgpi9kM9x
         zFAfz7fnwpIuiiTjhk6ZLIP9TxFijMOqUaVGcockz0U3cyHSrG2+h/vKOk4QfBXsVXZa
         eXFWAE9ly3oRuyOplcMHhLcE9q46r4hyhZqf+UWaY+p1EAUJ1ouCVJC+rtq+cbdT40Nr
         ySQw57xhRe2bVJBcShdH4nUTrWISfuoudw5zq05TxO0SqGJtXNzaHgRsWwlmsfyyI1nR
         027w==
X-Forwarded-Encrypted: i=1; AJvYcCXODCzGDfPAM1tX912FSXbo05VE9LQE3gjMVul5uTUCBMXFvLojROtxksB7xFYDkAA7NERie+oU@lists.cip-project.org
X-Gm-Message-State: AOJu0YzdAAbQfQuSyqDJNRlX3ZNNt+QaHDRWZdojb/u3cIu5FR6E31ut
	5iYgJWfi+W6gRSQ9Cz3u4IVl+hC17NkCPkQCSzJ4SC6YyNxweUnqshIvWfjJ615kS3ZH2vvJ0G0
	a
X-Gm-Gg: ASbGnctciNCvqQQe/J4qrFURYrkqbZX1ApDwHq3UoSBFxaZ5xtnbvHA/gMtH/jbmaIN
	mvhhMnL6p4d1uHP4mHrjhcEiyk5Wfbd9a/2a4Df9eHxZpAHmpVnqT9HSx5rwRqbPug9ClHHh+Am
	VxqocfouFyhiEnHBk8wtOLuGrwJrTQvaa+bVey6oniopf5GtAd0gDBPlUhMraoeVfVs6BDx+Ufi
	459/F+dlvOHmETN0BUkvml6HZ29/sML1lHqZhjJ7ckHXmT1SEOiKj1ACjlE/0VB9DHctmCpZOAC
	DYSaFcbpSdn5e6kxB+U7ExqQVFrqh0WUo2HY2WyS5/85PZEkPEIqxCp9qbDtzwikVQ4fjg==
X-Google-Smtp-Source: AGHT+IFmqbTc/sYwp0Hs8wyUq8snJL3ne3KUC+phV2YAducHQHR/NotrF3SrZgLNcFRW6bHbHXn/ZA==
X-Received: by 2002:a17:907:934a:b0:acb:a7cc:4102 with SMTP id a640c23a62f3a-ad1fc8d005fmr587757566b.4.1746783238562;
        Fri, 09 May 2025 02:33:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:57 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 26/34] ASoC: renesas: rz-ssi: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
Date: Fri,  9 May 2025 12:33:10 +0300
Message-ID: <20250509093318.4014916-27-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18843

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index c5e0dd1c78b2..56aeb867135f 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1256,7 +1256,7 @@ static int rz_ssi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops rz_ssi_pm_ops = {
 	RUNTIME_PM_OPS(rz_ssi_runtime_suspend, rz_ssi_runtime_resume, NULL)
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver rz_ssi_driver = {
-- 
2.43.0


