Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478DCC07C79
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:28 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.15273.1713514707583403875
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ITVvoYY9;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4715991c32so186186266b.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514706; x=1714119506; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGe8OhrNd5ExkofOMiSpKCzmNy8+dJX0t3+6P2ZkxLk=;
        b=ITVvoYY91bYm+zwenxHgEIK5/Ccf/sHdwN42EMB+GruMLofT3vl0qTJFEYVt01KB0u
         qtfHAW21vuTgeRmtwxq4WKDI44kuD/mvbiswkgTMTzyf8IYDlKZdsnbHqDgCVPm36V2e
         DzHbH7zOJMNGFwRTY5OlM6AZ/icpB7zK0Og6rPEMRYswl/oUr0OwYeb9NGzzvU6/590j
         cuJHK5KZryrl7Z2wydJS/97EFlstCOKbh8j0zsmM3TO2xn/pUvxdtBGmr8j5/6q0pc9C
         IzVpKgy91YUaVlwE3/rr3tnd0aaF9p64eK98Sq6HMMiLCOlQ1ktJuqqDFEoezacb/sXG
         kwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514706; x=1714119506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGe8OhrNd5ExkofOMiSpKCzmNy8+dJX0t3+6P2ZkxLk=;
        b=SXdisyJ9sFcZbqXqQm4Fs50pFM4olighkK3eoS3jAsF1bj+1LNq8m4VVlvNsGR5gmX
         XgWXSZLMa6liGgdGTPYFYrJcLlJUVbTuhgK5QcYggaiq4d3aH0tpLNTO7uJVXcS81ZCn
         x39pInm59mAUdzB3d2w4nmcCE9S+D5/mpOU/x7IvbK3OSaBsjbkFc0kBNqBYrTqC2SeU
         eChjAEV38k98HAAXO4mveRMm3YGefTVjK678wCP4vcC8zlfzMo8t/pQHljWNoSVIn389
         E6ch/s2GJvWC943dw72HoJpAIzNhXtcbzMKz9sO8ARVujeCzr1AHep7qYfyaNjI+ngY3
         RkyA==
X-Gm-Message-State: AOJu0YzqqUtmVRvwGYxGNNsDqFiD3Ef3KfXvbnRLn2DbfIQxnD8somrD
	drP3SwgZq8MO9eb6UYdRx0hk1OYNsIobtjY3Bja4X16jcH6WKKc3jWqQn2wCj/c=
X-Google-Smtp-Source: AGHT+IGSbkk+7KNdX8YNNJdyNcBQqSG5Bzcaz+1Z/JtsYyK6VYkHkdkeBcbI8v+0EGYAtilTCxzy/A==
X-Received: by 2002:a17:906:7708:b0:a51:969e:ba0 with SMTP id q8-20020a170906770800b00a51969e0ba0mr829204ejm.44.1713514706086;
        Fri, 19 Apr 2024 01:18:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 28/53] soc: renesas: Identify RZ/G3S SoC
Date: Fri, 19 Apr 2024 11:17:17 +0300
Message-Id: <20240419081742.3496709-29-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15615

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
index 6256fd3b6efd..f9aed9eb9f43 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -303,6 +303,12 @@ config ARCH_R9A07G054
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
index ba3dcdf8ddac..854020afd1ab 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -68,6 +68,10 @@ static const struct renesas_family fam_rzg2ul __initconst __maybe_unused = {
 	.name	= "RZ/G2UL",
 };
 
+static const struct renesas_family fam_rzg3s __initconst __maybe_unused = {
+	.name	= "RZ/G3S",
+};
+
 static const struct renesas_family fam_rzv2l __initconst __maybe_unused = {
 	.name	= "RZ/V2L",
 };
@@ -166,6 +170,11 @@ static const struct renesas_soc soc_rz_g2ul __initconst __maybe_unused = {
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
@@ -356,6 +365,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R9A07G054
 	{ .compatible = "renesas,r9a07g054",	.data = &soc_rz_v2l },
 #endif
+#ifdef CONFIG_ARCH_R9A08G045
+	{ .compatible = "renesas,r9a08g045",	.data = &soc_rz_g3s },
+#endif
 #ifdef CONFIG_ARCH_R9A09G011
 	{ .compatible = "renesas,r9a09g011",	.data = &soc_rz_v2m },
 #endif
@@ -399,6 +411,7 @@ static const struct of_device_id renesas_ids[] __initconst = {
 	{ .compatible = "renesas,r9a07g043-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a07g044-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a07g054-sysc",	.data = &id_rzg2l },
+	{ .compatible = "renesas,r9a08g045-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a09g011-sys",	.data = &id_rzv2m },
 	{ .compatible = "renesas,prr",			.data = &id_prr },
 	{ /* sentinel */ }
-- 
2.39.2


