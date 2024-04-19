Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6A0C071DB
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:28 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.15271.1713514706463093491
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=c6xfFG8f;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so2167583a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514705; x=1714119505; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2u77/UNyhFBmoWyr1vZ7Mi5m07t/tZTJIfrMiV2dew=;
        b=c6xfFG8f6B4kspz+Qh2nbGc+IL3TAoqj+Uv1NURG3QE6r7XF8hPrUnRJ498Bxf8drT
         fBRuCzVGOxV1XitrgkZDFZGlmllQUIbg+VZbQGLCwjKQ65P/WIEZnr2TeUorcxxiDjBK
         8gFlmdmyoiAmhTSIcGYkCKKBt2aoRiGlfqzLdh6AZJXpBgqKYuoBUYfU2QNDCB1L5xnR
         1BjJUjAwfTUnbjoO/ABlb5iTg96ll3iH4Ia71Y6NIf0eJ2kRMU0PsbMmTQeI40q/495t
         xQlcC5pLI1QuwVnXFb+kxK8icVrN5CO6LszU2y5b1yVoS+Fy/eYrvIHUuPAzd71UQCLI
         jRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514705; x=1714119505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2u77/UNyhFBmoWyr1vZ7Mi5m07t/tZTJIfrMiV2dew=;
        b=pTN1I0G8LhEfowzbEAOAGbYAewxRWfSIsLt7wEyDwlPFarKMOZqaRAK0trIs8tLGj4
         GwPot5FP77X67LwKA98bcmP4trI2cNOY09p2RVTZyphoPrGJXTgFi5Fx7gi3lucVwN4f
         h6fdnzan9vQtI9cSn/b29XmcTAAxBxWxt8PY2YLE94JYAnzarl4IhsdPIN7XA6oJ718C
         VFxb6Xiw0R1O8r3wpVnEBTeeskETqWKqLMRGf4yhohGh2x5RPPAaJy+ll6TOg5eC4O8k
         8rFyU8ZfUY9jJw3tFv2mHyA6HvM4ukiTTVNMYsSPwul1nsP9Xk/7I4uzLsHcmlPIQVz3
         wcoA==
X-Gm-Message-State: AOJu0Yz4gBupJaKT2IUnES/q05n4tDCziRwPjI36MZ8JPL210STEwyw2
	zjYe2nlHgxkKPpEKLRMmvs1lCVq7mFv7VwDI6WlKhxcDH4X9Vv8enFqcoLq0pGc=
X-Google-Smtp-Source: AGHT+IGwuD2hfGAI5Ery4nrdoVHeMKed+7wKbydjLcBfhxTcafJMPiz9GKkcTlOprsGeYqv0elYepw==
X-Received: by 2002:a17:907:94ca:b0:a55:8a04:d729 with SMTP id dn10-20020a17090794ca00b00a558a04d729mr751754ejc.72.1713514704925;
        Fri, 19 Apr 2024 01:18:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 27/53] soc: renesas: Use "#ifdef" for single-symbol definition checks
Date: Fri, 19 Apr 2024 11:17:16 +0300
Message-Id: <20240419081742.3496709-28-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15614

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 2653d5bf1c9d123c0d8b8c1634cf54dacfcfdb52 upstream.

Replace "#if defined(CONFIG_<foo>)" by "#ifdef CONFIG_<foo>" for
brevity.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/6026a3fe36735f0e6a0ecb037bf7c45f42aa3daf.1678705241.git.geert+renesas@glider.be
[claudiu.beznea: adapt to v5.10]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 92584f5ab967..ba3dcdf8ddac 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -343,20 +343,20 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A779A0
 	{ .compatible = "renesas,r8a779a0",	.data = &soc_rcar_v3u },
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


