Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4C8C3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:04 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.10309.1746783235615162723
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=W368oYHa;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fca2805ca4so1136252a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783234; x=1747388034; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G46JitUFhvKE3KrqEFh/GH+awcEF4oqH0NjMxqpFDSk=;
        b=W368oYHazLD8mw2wgFLpTyXgYIFhSjDfYI8GSEqde67ZynjYEuzWdT1JIWOKs1Rnu/
         R3rV3aLqSLvnO8n/fQahyWxhYiNFGRjS2FoBHrKs8IbYuBx0kf3ukraoBBwsLt0P/dPI
         QNpUKxxfPLTsgSCNotNLzEfIGF0f64HK+9p4X2HiUTqWKJDhT2wEr7PHHlM69c2aKZBb
         WFSeX3izGLjOKSZVWpbr+efCQFg//GejE8mmYQix/eAoRp2EfbKtq11XJyEtrGWxGKtf
         ns0Q1oa+pLRw4utS6dqAOAzlv636Gc574T2p7Biz4ZZPVlh641/BJtebVc0U8MDiARx7
         iQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783234; x=1747388034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G46JitUFhvKE3KrqEFh/GH+awcEF4oqH0NjMxqpFDSk=;
        b=jS29dosa8bpLkSFqa6/yHSduKmrIQ6iCQSXxgvqnjV1c/7KUgpb/YpXF+OV4HdcpD2
         dNujMw1ctLjqd9vJpjzlyU4I3d4dSciPYj51Z5YpsUgXGRh3WAdHeboiyx5RMWGB1Bcp
         u8vdepwX00vfNPpASWMIbwdRND3YhwnoBE9puYt9EHzB0FtUH5u2Lg6aiAwrKdStivZ/
         h79HEsc1kp7jT/4v3WtRv4muy/sozTNvDc6D5TuD4oyyPAqqzpErQWNJ5D8aBp3KgyT0
         z/JCxJkxPU/v67yGiCtFGiEyAQzvYkGbbLS8/RId7tTprEsTfe5IQL/YDd29+rla5gBJ
         UzKA==
X-Forwarded-Encrypted: i=1; AJvYcCWG+5pcRwMCwovscKBGFVxu4rmfLluORNCDOt6efm/ITB6C1zHimp89FSHhwfy/2eHMXv0OX76d@lists.cip-project.org
X-Gm-Message-State: AOJu0YyPUZ76hF/sr4D2n1Zt3Q7pefUqgEYDdwqcmlkwexU29TnVINjR
	u+XVNoi9zfcQsFzS2bRyp2O9tBMI7riNBauB+Ujk/VLwm7u4OqdKzrqIwUn2hyo=
X-Gm-Gg: ASbGncs5ImsntiFOD5ZuBIBJvEsCFmYHRbq1yRnG2Re/glVim41xNTKBQ6gK2Pzwg4U
	zsPA9J/NxbQBf/cExOhYlsBs66CL8ZZaAJDVtXJ8+oPw/83pvVlkDkdSTdLgrnJvCgyBcDt6EsQ
	LnM4FiA4H8iF50RWR/LLWwvPIbMAbcRWGOZx0yo2blVsKdxqydzMl9xB02laReXA48B45UMOp3o
	oTYzjPhLuwwxIgKzVBC4fWl3eWu7ww5DMYBGwrQpW8n4qQXakam9UKIgYTD5UYByr1T5tNInj/2
	mcIxUQ+73v3eSlcIFOusFtq8pyuW6/dzIVeb3H7cOFKnWzfwBbzzmDE+XOUbKudNqeARlA==
X-Google-Smtp-Source: AGHT+IHftQYPjAtDwJDAQzpvt7i79k7Le/LOAX2noc1Pcf8yW8G9KyD2nM9Ce4jzSDdbL+ZzNMa2yg==
X-Received: by 2002:a05:6402:2713:b0:5f7:f55a:e5e1 with SMTP id 4fb4d7f45d1cf-5fca07edec2mr1880066a12.24.1746783233828;
        Fri, 09 May 2025 02:33:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 22/34] ASoC: renesas: rz-ssi: Enable runtime PM autosuspend support
Date: Fri,  9 May 2025 12:33:06 +0300
Message-ID: <20250509093318.4014916-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18839

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
index 52449f406448..7692de807e3e 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1152,6 +1152,9 @@ static int rz_ssi_probe(struct platform_device *pdev)
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


