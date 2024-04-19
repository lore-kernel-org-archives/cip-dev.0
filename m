Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97202C41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:20 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.18430.1713526755838216045
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eCX5vHHO;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e4a148aeeso871734a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526754; x=1714131554; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbkmjI83tWV0YSsDWj9iPsSPt6pNqlJH7X1OVPir4Z4=;
        b=eCX5vHHO3MIt3Wi8I9kKQQjXrjApu+p2YlPW75V6rTussYma7x/YGcub2FBrSF/Wv1
         Apit+phI9WYD9EXFWWJVjtGiv3yas77gzL4ErjUFcHDuyO4R2ypQ7KqPGpf74x+r+nhJ
         1k+8rzDmUi8AnDJ3FXnRK455V8XTeZ66gCfxXSlBnwjlOnJto3GRirZSFZpmyCYligQb
         50mqmIlDbLfDOkdTAmytZv/0br4WMjEt/Ytk9yk08z3U1pwgCsXYc2kAcipFeCmzczA9
         KBZHJdCikLXXu5cKAlnVuXGEXFqRFfzbr+RzbWGamWhSZGa449b4CGoR9laTQLwq4Tv9
         CW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526754; x=1714131554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbkmjI83tWV0YSsDWj9iPsSPt6pNqlJH7X1OVPir4Z4=;
        b=urpbjvdcC3uiSZ7LGeRv3Y7DaDrg/sSxBK8tSxaMKZq2Qbji9CvYhfGtJmDbxISMp3
         vdAfaqdqbxYxlwZIAnu6nUpwSb82LVuBzz7gHL5vZm/7Ji8mYbXLJbKu/FYgMjMqAiyW
         viL8j5fDEGEYV1ydle72JAvx5umBHjgkbBQHaijiVlEi2LMA3guGjTe87vpmyWA4NEu1
         XCyUiylMx8OuIQTAA6PuBFvY1w+h9WZQu3befJf1SvAZzGhl2RPsmRX/4DRUKax3h3kw
         JjRmkAsiPqDQ1XBHihLdmqY55zm8+lpXm5xirHbWwG9D3okaBHHnWmN0b+/Fscrb84Go
         ga/Q==
X-Gm-Message-State: AOJu0Yz95QGO2vUijtMdE2cSemk6p8/p5hphx25WKmlRLz6nZEAzXRFz
	8gJwEc0DxJ1x+imqfuTbHATWelJIrmtG/ilH4Hc9redwjPxs3rhg6QCHCw03ZL7XP7BuokePRnS
	l
X-Google-Smtp-Source: AGHT+IH45HbQ6MS8CY4XAmhaS1PWgOe72/UMgJUO4j87HjMRSmp8jhK8uEaW3i5szzk8JbGvadisFw==
X-Received: by 2002:a50:9316:0:b0:56c:d35:1775 with SMTP id m22-20020a509316000000b0056c0d351775mr1743510eda.35.1713526754253;
        Fri, 19 Apr 2024 04:39:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 20/44] soc: renesas: Identify RZ/G3S SoC
Date: Fri, 19 Apr 2024 14:38:18 +0300
Message-Id: <20240419113842.3675543-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15671

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0b9729cdb895a477ba3551cd2102baee2e697cbb upstream.

Add support to identify the RZ/G3S (R9A08G045) SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig       |  6 ++++++
 drivers/soc/renesas/renesas-soc.c | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index c7df47b48546..171be915cdac 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -324,6 +324,12 @@ config ARCH_R9A07G054
 	help
 	  This enables support for the Renesas RZ/V2L SoC variants.
 
+config ARCH_R9A08G045
+	bool "ARM64 Platform support for RZ/G3S"
+	select ARCH_RZG2L
+	help
+	  This enables support for the Renesas RZ/G3S SoC variants.
+
 config ARCH_R9A09G011
 	bool "ARM64 Platform support for RZ/V2M"
 	select PM
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index cbce7aea3236..6689a486557e 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -72,6 +72,10 @@ static const struct renesas_family fam_rzg2ul __initconst __maybe_unused = {
 	.name	= "RZ/G2UL",
 };
 
+static const struct renesas_family fam_rzg3s __initconst __maybe_unused = {
+	.name	= "RZ/G3S",
+};
+
 static const struct renesas_family fam_rzv2l __initconst __maybe_unused = {
 	.name	= "RZ/V2L",
 };
@@ -170,6 +174,11 @@ static const struct renesas_soc soc_rz_g2ul __initconst __maybe_unused = {
 	.id     = 0x8450447,
 };
 
+static const struct renesas_soc soc_rz_g3s __initconst __maybe_unused = {
+	.family = &fam_rzg3s,
+	.id	= 0x85e0447,
+};
+
 static const struct renesas_soc soc_rz_v2l __initconst __maybe_unused = {
 	.family = &fam_rzv2l,
 	.id     = 0x8447447,
@@ -388,6 +397,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R9A07G054
 	{ .compatible = "renesas,r9a07g054",	.data = &soc_rz_v2l },
 #endif
+#ifdef CONFIG_ARCH_R9A08G045
+	{ .compatible = "renesas,r9a08g045",	.data = &soc_rz_g3s },
+#endif
 #ifdef CONFIG_ARCH_R9A09G011
 	{ .compatible = "renesas,r9a09g011",	.data = &soc_rz_v2m },
 #endif
@@ -431,6 +443,7 @@ static const struct of_device_id renesas_ids[] __initconst = {
 	{ .compatible = "renesas,r9a07g043-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a07g044-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a07g054-sysc",	.data = &id_rzg2l },
+	{ .compatible = "renesas,r9a08g045-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a09g011-sys",	.data = &id_rzv2m },
 	{ .compatible = "renesas,prr",			.data = &id_prr },
 	{ /* sentinel */ }
-- 
2.39.2


