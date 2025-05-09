Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D20FC3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:33 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.10262.1746783152228942973
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Ygf5BbVP;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad221e3e5a2so61565566b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783150; x=1747387950; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5DVwJVxI5yO4EGrPQ8OZTlmd4Mg4eBSJB1w5NGY8ZY=;
        b=Ygf5BbVPxJcxQz4nRyId+sH/nWNCo9qXcCX+MPyT3qQpXrlS7S02aqvhgcTk1HxDns
         3mQA8bABc95Jc00VctgmdP2W6JaNi+B9d+FI7lh7kUcX7I9EN2QPKqh9HZ6JEhNg0ExT
         oC1E86B8dXcfeL+SaWyVm3Vz+KB9hTIRoB5Yve7kos7jLmBe8baQ8YxajfoZyMXLlyQY
         EElABlf1LYd8CmUUQ2/+VvIM1AvsebTFjIGvIsUZuMqGqSDou3W0QdoT0TrnA2OygUEb
         QpMis4QZ2nuBGqHUYbXnJ00PRs1JuKwCGYnEibK1Y0X2i79B25k+848sLTHawJcfY4eA
         1x+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783151; x=1747387951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5DVwJVxI5yO4EGrPQ8OZTlmd4Mg4eBSJB1w5NGY8ZY=;
        b=q3fYPUVb9uszZzaZnyUd5PYmX5731fTq6acbrXLOTCd8HCK1cZN5gEGZuDVwaDoCwu
         oQ4pVrePNiVfOcB3wZSyXmYPwGGCp7cPSDF+dCmcBejILYbjK8zLZtPCuhn71SJwctK6
         Z3gaQMcIy/sREwQYFeT4AQACrsiC+GsZ6nHSgFEKEmEN8rgUn3WFqyZOVGXt+eQd9OpM
         hln9R7t1crMGjtnd+rfvJsZq/2XbvZruRBmaRhvpPFR5uAAa8gBdddIneHMF3uPvUjqI
         DASta35akdxx3HrJRG9zyWAFO4c0SpEBs6cpuXyj3ccRLTOUUA8TJ7z6WE4OflRxKT0N
         mkLw==
X-Forwarded-Encrypted: i=1; AJvYcCXBtGxxbaeO2aoHogGCrKEfS1vf9kUMnIs349nl72IfhtFj3X3d69MU3sjkr4n0aq9LPYiHrCDh@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx4CtmFwepHygt1WC5Ep+p+74r4jKcSJzb+k3Rk8Fr2XjtE070u
	gEXTbx0JTZasU/w0DS/Wduk4XhOT7yPpA6TauXUDP/xNGTvY2xNlzSwDgJbTq6M=
X-Gm-Gg: ASbGncvM8o9BOcUH1BtNvOwL6AmcT3wdLiWcg4RUBvr6eRfADcguxX7NaS5DxUQdyjG
	FLPKxX6lfsRAdhhn4ifh1skv/jopf5oLKzLDdpbcMjcmRzJMKtAUPxcG/rsFu9vaul/0DW1yTqL
	Ac6D5AOTFPUYkOlwEuaHVJBCQCzWBJ+3ts5E5XAhK898ivH+bEDvRcWMlKuGSYvoWqrgnFj53Q1
	2KbJ8Cbtxn5zqFTM0WaQmC9L56yYI6YKwTVxkE1vvs76lXJmdnCZyifs+2FTTKZmB+6Z/2YAgtk
	aUE96eLPiie/QeJYZ7owaXBSIgacDPVRFnK34tYl/isXP9gWUItE6qpynq3MCL5oLHz5RA==
X-Google-Smtp-Source: AGHT+IFRL2eZNzvj+3qVgkp/9uC3dcWVO5KND7N4v4d81WABA9EWHGB6IH0tZMVVhgN0/1KK0SXfWw==
X-Received: by 2002:a17:906:8e0f:b0:ace:6f8e:e857 with SMTP id a640c23a62f3a-ad21880d6a9mr239198166b.0.1746783150617;
        Fri, 09 May 2025 02:32:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:29 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 17/29] ASoC: renesas: rz-ssi: Enable runtime PM autosuspend support
Date: Fri,  9 May 2025 12:31:51 +0300
Message-ID: <20250509093203.4014750-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18804

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cf3a79e4f826fc680fd7bfef7c427e2cc6023bc3 upstream.

Enable runtime PM autosuspend support. The chosen autosuspend delay is
zero for immediate autosuspend. In case there are users that need a
different autosuspend delay, it can be adjusted through sysfs.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-15-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 868b734eba65..fa32a5bd0d7b 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1144,6 +1144,9 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	}
 
 	reset_control_deassert(ssi->rstc);
+	/* Default 0 for power saving. Can be overridden via sysfs. */
+	pm_runtime_set_autosuspend_delay(dev, 0);
+	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable runtime PM!\n");
-- 
2.43.0


