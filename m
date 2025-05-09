Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90768C3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:43 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.10335.1746783158993104510
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=gIKnpw/S;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so3441112a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783157; x=1747387957; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SRxjG4P0L6g8x4FngPDgnl9yyFvB2hGsb1KsO8z1Io=;
        b=gIKnpw/SPB5O2lG5kFcxdptKdrsYIzUGJMwcHfsNhcK9ylm6anfonNqqUbcTdk/h2G
         djNbH7iE0XG7YTSn96TFahh2ilWE8kbItrcm8doDbsGHDVPkmiEGIOiFNGC822b0fNT0
         cGDcSGKkdZNYeZj1Br+7I5RcR91lOFnNW8pOyGroU97igE3SdY10Em30iIbM8JitbjJT
         uoLchHfXivWngA5q21Mn43FQdmsLj+sQAHY+RhFBRpxZWAsNDVLqLOatrsQ4di+LutP8
         cNZwHotyJRYAPhkZh45DYUfCeTNBTGwobSN7yo7u+PiIYhuz5zB2Nf4UmUxqV1w6Kznr
         i3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783157; x=1747387957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SRxjG4P0L6g8x4FngPDgnl9yyFvB2hGsb1KsO8z1Io=;
        b=na5EHiDZnFvL25vVVB8j/+Aykx+LD5oAdbMskrBRzCETpVqeFESA8sp3+BEUO2tA0X
         oWHwV9wdTGfMLLaqNOCD/HOshxlr31+QnKO+/gj/NbcFu8YkF5+CO7gdxCLMAj67zt/Q
         2bnoxjI60b/Im1l2HjRUs4sdcs+mzrvnJ4eFeOj3v3J8XD94xFxC6T1gOCvVXMzr80gf
         q12AOlb+TseRtXM7a7xJQupEunRbqtfeeA17Te7jKxyTwpp2Jxe862EttgqkpmD9KK97
         Z0WCgEm1OEh0yYsiH1zU0dc3SkE4VaTM68RkgggXRL554t28yLPNJkK5ET283NKqs0iB
         pRtw==
X-Forwarded-Encrypted: i=1; AJvYcCUorFgwz+JLsrLYdcmZawdj+EZwuCCYNM23lmnATP2JyWD4FwgWnTIdZc0kpT9UX4q3D6wCrprO@lists.cip-project.org
X-Gm-Message-State: AOJu0YyahhoCiNjrGk6ixt/vx8XHPVIdxv66WXowCWfy4YS2vFKA7Kxm
	EUtuNiVaM5fKPfTQJzvtSB2YofCbNQ+onIkOY7A/u0rtITD1iqc0y3GAZVZEpJU=
X-Gm-Gg: ASbGncuKPFTqZcnKkKqZhjbjNCZsBzMQyX9DRNxrSGJVXe5b4ZM1136hsXD4eyL45jl
	k1nZwBPj7HlfRQE8+7/D97BNTh3ybv1Jmb2jC5NdXOcZUP1/KjW8IMQ6HSmbk7i8z++awDtgStq
	CuVMJ96VC/XDXiv0zpnf+WZpmFVnQo+ASx2XrtixaCydfU41MTPdPJEGT9JhIFbySV/dZ4uYJoh
	mLe1UAWRaJI1wobZyA9wrRn2C0o8HMoH5mVTfOVU40YLRF1l47yG62JnlVcfiTNOSzoKieGeRDY
	62eJ4Bv0nyxTAondbO0mFTcJ7H7zaNLQmekm1dqj9OdxG6nBdosWsypX8Tjbq7JcTyE+uQ==
X-Google-Smtp-Source: AGHT+IEtRhJsSYr91f4gx7FtyESnzjhz43gDH6KXXzO+3W6zQy1dk6JPvti6+ySu7HiNGDkyMbdqsg==
X-Received: by 2002:a05:6402:350d:b0:5fb:206f:784e with SMTP id 4fb4d7f45d1cf-5fca0758c0cmr2024760a12.9.1746783157361;
        Fri, 09 May 2025 02:32:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:36 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 21/29] ASoC: renesas: rz-ssi: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
Date: Fri,  9 May 2025 12:31:55 +0300
Message-ID: <20250509093203.4014750-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18808

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
index bffd41742200..f9f67f20aa75 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1246,7 +1246,7 @@ static int rz_ssi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops rz_ssi_pm_ops = {
 	RUNTIME_PM_OPS(rz_ssi_runtime_suspend, rz_ssi_runtime_resume, NULL)
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver rz_ssi_driver = {
-- 
2.43.0


