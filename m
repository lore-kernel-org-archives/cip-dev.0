Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD0C3ABD4
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:34 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web10.10362.1746783209275683162
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Q6fCZ3gv;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f63ac6ef0fso3833640a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783208; x=1747388008; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Drqm6lyn5i4/POAC0+lXogwftjvjLxvS+LtKkOD6res=;
        b=Q6fCZ3gvNw7aVLibdUto7PtDpl2rPeR7wiMVhQbB+5OILViA16BDicD4lL/hO+YrWG
         utaT8pqZOl3+PQHoO060BdECh3niYmPIu4K4s5SojmZWfBzz2W6K5NuIWgdbpQQNJiwH
         tdzARdl4HYMl4jqltyZ+i5+/OZk7OZWciA9ZDLo2jJ+FZnFTsUoQ6+ZCKyNkp0C3wgns
         xMhkcsTxdb/h6XKO/gkaV1Pyx9FBVQ2aTV9VZLRVvFq8GaWy0A41x3fg3Zldix5emOgE
         J2h3n7XTjou2QkABk82rGUYOxb3YsKKNUMYefSC1+p58lztJxl+NGWdRbzAg6M0g6QtF
         o9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783208; x=1747388008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Drqm6lyn5i4/POAC0+lXogwftjvjLxvS+LtKkOD6res=;
        b=dDaZfFXvLrE/H7/JmNCr5hbYTF2JnRVcv6BLB10Nz2MUBQSJe6W9CnxsJtFErSyfgC
         dsCI11wv0vep1eQdfneH3WoVSQ+4w0F6+Q2ZTLoRdDB/vdBTs3RdvGpnjT5Vm+RGjvJN
         iteRhVMovQIl/r7iQ1FcnYd9y8nzEY4bswaM6rzyoR7vPSTKhZRNRo6LYj72RAWSofie
         gCfX9WfWeS/6Wrw7uFyKsnwsbs28Sj20JXOyTzqjuWI1DmcfasCJ7c75jeJLDTdbQX8D
         SIgwBpGfRjg/FberAT6cGq4tq1hS5HqzCFcCdMiRfXZTY+ktilosbQC7y1pDVSQgdvlg
         oXkA==
X-Forwarded-Encrypted: i=1; AJvYcCX+nhNwROEA6kjd4ngbQbFLPbmY+z1vKCh6uBG1Blv2Ah3jAugwrH8lRnoTPBRxDUgU0+E2LO4j@lists.cip-project.org
X-Gm-Message-State: AOJu0YyFZqF1uGLgYum36EcYeUPxeno/MxTm0Lt9TLsE2R6r1JcfI+CH
	2ZJyAegi5Ea9O6by8oxpgmgxAQzYMKRZak8Ean/bABjCPt2obR0PE5XUyaDD3wE3hn6uVvU65u7
	+
X-Gm-Gg: ASbGncuVAKr3mDtgBZb3JrdAJp5GIinn9ggRt4K0xwg7lIipdi6+S852L7vL4wamUTA
	j0s4YUp/r9eKMgfP+Ya9f0VK41GGJ0H6NFZiJSA0iPSHg+rzQKKW02dfZVZSpXRyrTmJHMT/W1z
	FgVfupWxisnXX97rW5lusfb23AukM24S5754a3afCXtRcEhP7FC4av1EE5EFs/tzCot9uqxOb9K
	ngat2IJvQvrp0Atw0WaMIsPhwpMC0d5iygDDAc/PsApi0iWYFP8O3FkQRZin5//nQihptE2ybL/
	xq4jkY49X7I/tN78WnuEh3R8KVJFKK1NCT6dzPv4eLQi5ujK7AdPaFag+nS1/35We/vAWjjcbWR
	IY1YL
X-Google-Smtp-Source: AGHT+IHq16A86bNBz34YEXwnlE5aVRumAhZLc1AdDHbIpjWB5PD3dzTlMmsnaHnpYcGyTCTsxLUW1Q==
X-Received: by 2002:a50:a6c5:0:b0:5fb:181c:232b with SMTP id 4fb4d7f45d1cf-5fc34b4598cmr5208986a12.6.1746783207731;
        Fri, 09 May 2025 02:33:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 06/34] ASoC: da7213: Add suspend to RAM support
Date: Fri,  9 May 2025 12:32:50 +0300
Message-ID: <20250509093318.4014916-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18823

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 431e040065c814448ffcc2fac493f7dbbfb2e796 upstream.

Add suspend to RAM support. This uses the already available runtime PM
support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241106081826.1211088-25-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 21ce3e3fb9f0..40be8c5093c2 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2223,6 +2223,7 @@ static int __maybe_unused da7213_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops da7213_pm = {
 	SET_RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static const struct i2c_device_id da7213_i2c_id[] = {
-- 
2.43.0


