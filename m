Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B0C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:20 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.18449.1713526753769167064
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Acwdh6Ax;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5194a4da476so2580576e87.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526752; x=1714131552; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2G7UX40s0H4lC768cD+znxJqp5AePrWCRWigta1OC4=;
        b=Acwdh6Ax83zPekYk+K2HuG2tTD/X2/eOwtcNiVAmTViy6QhjlP9HHef6M/LWfkqpaT
         bE1sUbtjv6zIgu9UTA6PY9KM8lnh8Rvjn2v1P8QExeMiG8FCxHcajD5KgN/ThQV/ICDd
         3jdAqasDcD6I+lbGixrvoT9lTsAZify9dNzHCmNamM3HVORilHa5ggbsK0O2A9VRj4Vz
         C+LchW4siD9CE9Pcfwid1nDYgeknEhZjKlJKGoME81vfTAlfSTqKkBBTaSnpWNr2iwCE
         6HNEWGCF2tTysnopCWpVcZjSDYaVWKCTAS/2yGu1db0FT96gFYa3HglrmFPARfWpN70f
         3OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526752; x=1714131552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2G7UX40s0H4lC768cD+znxJqp5AePrWCRWigta1OC4=;
        b=EnicKBCioliRjT6EEiunQxJM0oAr2FgWX2S2UVhQ+4ay/VO6eUrrqDwcQtmLgPAEoy
         R5jbUo405Jgq9mduhBjEQ92jElcx7pJhiViiIHFnwVy4oEkvRvlUBhNYTVqdV/pzWmbl
         aXF+JpEpJoyqu4hmXsP2ISOat+/MxWjhi380OHt8yDx1sRgU+CnWpd/BfB6lKG8cmEct
         KFpLGGydQqb7/BMh1WMsFXo1eJbv82BCpsfdEBI3LT79zCq3asiM80xC7dUHx2+I2LF/
         2i0kBsCu2wAPi8q3T/W+Y8k4p87WBDCd/Yot8VT8+lyZf61pdieuAjOD1nO9AqfCdGgP
         BUBg==
X-Gm-Message-State: AOJu0YwIJq192YxszRTq8cLSqLn+D7XFSw7tyOr0a3sh3FSP7kYhBOP4
	ECMX6xS/K4DOnMFiAg4aLsPnPc0h/7ZYek51T91NWfBtrja0JPLsVNDCu/aGanQ=
X-Google-Smtp-Source: AGHT+IHHqpxxoybllaKeehJFE1WijPoe+hIbsdfJZST8DnFUWXIs3ufPBEgLYeCajbDZvtxR/DtXqA==
X-Received: by 2002:a19:4318:0:b0:516:9fdc:a001 with SMTP id q24-20020a194318000000b005169fdca001mr1548348lfa.11.1713526751906;
        Fri, 19 Apr 2024 04:39:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 19/44] soc: renesas: Use "#ifdef" for single-symbol definition checks
Date: Fri, 19 Apr 2024 14:38:17 +0300
Message-Id: <20240419113842.3675543-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15670

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 2653d5bf1c9d123c0d8b8c1634cf54dacfcfdb52 upstream.

Replace "#if defined(CONFIG_<foo>)" by "#ifdef CONFIG_<foo>" for
brevity.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/6026a3fe36735f0e6a0ecb037bf7c45f42aa3daf.1678705241.git.geert+renesas@glider.be
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 51191d1a6dd1..cbce7aea3236 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -375,20 +375,20 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A779G0
 	{ .compatible = "renesas,r8a779g0",	.data = &soc_rcar_v4h },
 #endif
-#if defined(CONFIG_ARCH_R9A07G043)
+#ifdef CONFIG_ARCH_R9A07G043
 #ifdef CONFIG_RISCV
 	{ .compatible = "renesas,r9a07g043",	.data = &soc_rz_five },
 #else
 	{ .compatible = "renesas,r9a07g043",	.data = &soc_rz_g2ul },
 #endif
 #endif
-#if defined(CONFIG_ARCH_R9A07G044)
+#ifdef CONFIG_ARCH_R9A07G044
 	{ .compatible = "renesas,r9a07g044",	.data = &soc_rz_g2l },
 #endif
-#if defined(CONFIG_ARCH_R9A07G054)
+#ifdef CONFIG_ARCH_R9A07G054
 	{ .compatible = "renesas,r9a07g054",	.data = &soc_rz_v2l },
 #endif
-#if defined(CONFIG_ARCH_R9A09G011)
+#ifdef CONFIG_ARCH_R9A09G011
 	{ .compatible = "renesas,r9a09g011",	.data = &soc_rz_v2m },
 #endif
 #ifdef CONFIG_ARCH_SH73A0
-- 
2.39.2


