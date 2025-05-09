Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B43C3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:25 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.10364.1746783321842009415
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XdFxtZ2e;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad212f4030aso162311366b.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783320; x=1747388120; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0FITRV4KFrImRsQnsYl2Q4m3xKEphO0XikOc0jpPRw=;
        b=XdFxtZ2erBpTsqSlSxcPBY+fATL1AjIvmrpClE4HFqDzdve/azGKuVgF6XGyQs0ACT
         QCC59+P4Rou/+w2aKCnk5a00ICMaPYTWrsOu+dkqBYN85meD9RKWOYjjLtiz6nOGKW01
         4qqDuxBU57b+SPCvHcNZ+6J8RvsUeDeC8VlJnoWIXzyEZpBKOavHWzwS7fvoA0mWif8v
         b6BshitW3a8uUZsQErpEG6BkV8iKhcF+Gt4qXX92mtQatur4QYF+nCEE2GjPeqCNxXMw
         I/ARpjlFZcPUSerxKa13CPC1Uhv5BJqoxd030DIrhbuEW+JpiiQAR/cSuxLJBNxigzpj
         57Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783320; x=1747388120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0FITRV4KFrImRsQnsYl2Q4m3xKEphO0XikOc0jpPRw=;
        b=Qncqsm27nnm7Z8YgHEQHmOjsGZUPO1WfUJride2bVwddwHBTYmLKFNaLE0qVRVX4Cw
         OhYBrMxaQ53rFoFqUUIK1duTQRhPKYF/y7CnyRK4t2wxw6ZmZFO8+qrVFdWeBH4mmW2l
         ZwZvDw8LXbtskMcSdFLaL37mnDY8UpjeKMR5bfW4Pvbz5XmwNw0bUnq2SNLQQgnuH/kC
         eHVVYuQsNgRtlNFcsZkSEXtSleBEffQo+CgpWUprerra4+TfR6bt0x0c4a9sifqlG4XM
         2bOSZf6g7dkdTWN6I6aIaYwiKEoAWLhhsTtRkO6iY2iHuU4FCI1qLohQ2ulIU+uhUr/E
         eUeA==
X-Forwarded-Encrypted: i=1; AJvYcCXoIWGzcBxToBCbsFFhcpXRdwpb8qyEHG6NSVDLWr0UFds+FkF+Y4CKokjhJE09untsx9AhZKta@lists.cip-project.org
X-Gm-Message-State: AOJu0Yyep5wBDdx1w24hYaQ33QUDw82FRlIfO6+CD3eWfdXxEyvs+T2d
	i57DdVAujYQViN1xnL1dd0Q965IVn18MgLDd6ESyzeeKqLImkSnz3EwmS4g9nVE=
X-Gm-Gg: ASbGncuvg0eJ8BaEB/TxZnx3uoVT6UOr6E/rwJnFucI/e5tZxBA0cmPIMJ9o+bDpyPH
	uM6eUDodzj2NtUBgDGvshAtSZJeoOz7znrxXSNkstAd9levEZXAmRqGIfzrQpFEpRKx0BhFjg+L
	+OFNON4z9+xMjYQSi+tqhRplIQSmRsGx7gwFRyHsk8QxVlB3eIQMagy5Ivbs/zuFHPAbUSdQmR1
	wbfTkc84iQOi/a7xWxaL/SzOB4wNLHT26yJvKAKx+W3e+RClDede/iXhRtCfRohQh5E/JYp4AYE
	jpN8zH00zxzC1xbEtx5ohO7N+rkW357n2J2JDZ73Xq14Ww55z4BQsjQqPVrh66qAdzIssw==
X-Google-Smtp-Source: AGHT+IEHASErbzQXLk+K3u8TUR5AjpYN4uJbWe8ekUshK/2K+7sel5yRv2PJOBA4rvzwPR2Z1GepRA==
X-Received: by 2002:a17:907:9984:b0:acb:4f46:9d18 with SMTP id a640c23a62f3a-ad218e57dd0mr257127466b.3.1746783320214;
        Fri, 09 May 2025 02:35:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:18 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 25/37] ASoC: renesas: rz-ssi: Enable runtime PM autosuspend support
Date: Fri,  9 May 2025 12:34:30 +0300
Message-ID: <20250509093442.4015145-26-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18877

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
index 64b1c47375e3..507ba55b9b9c 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1149,6 +1149,9 @@ static int rz_ssi_probe(struct platform_device *pdev)
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


