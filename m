Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F365C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:10 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.18420.1713526742731942508
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=K/qxM4EF;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so2480195a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526741; x=1714131541; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2AdxgEaiwmkPsUIrm4YNxqGj7QuZwVINKjTX1zNVMw=;
        b=K/qxM4EFaTj9ArUK7/vfksuTF3ZpTqhzEWHggqTudrmtKqvfUVTihy//Dnd4kiFpnW
         BLy9MiMoURRVHLet0viO799Z9i+7Vi/XCXfqYMD/L0cPm1+wPr9ZyABpElhZ4PBwKyKX
         dt9PdvhCVWoREuE3tn+IN7vYsR/aX1pqRSG7T07n5tb5BQRTWoKGrXYAO+m5QhvGTcAZ
         xVlP4bksyayETz6kqUykhoD/ZrcZsOzOf+oOt7fR6ll6gjWz0kvqv9vZUHuUgRdHoajB
         NZMyTuTZ/ECtH5/LkzAXETgTu3yIKIyiwYDxWiFSzZImxQXt3ntAObXc2Gad/MFitMqH
         hPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526741; x=1714131541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2AdxgEaiwmkPsUIrm4YNxqGj7QuZwVINKjTX1zNVMw=;
        b=MoTtT4wFGe1KaM6VtWWwrMQf2AtpOV//xILgDQPh+C1j/s2nU4gof1zCKHm4CRsXSK
         k1JMoE2XJWpEgpFxT2PPeP/lFO3uP4djQpehueVQo8M/hSwflfV6oS5Ktp8KUORK9GIj
         zle8n3PkPaEd7lG8ViOSNorlo8rOBKKs9naYLPXWlNHDwS69P29rKu6x/jTmtd/NvMWk
         dumug57XrZfg7OpOV2FmH/FDjYe6BpM/ppy0D9K2FtzO07BWiQ/8bOB0jHWmYwWcI2Rv
         5gv9Qm8Uv+arM7IMc9MemUavdlUcJ5CaXxOTjPWMQ4S7KWEBNLylh0oGtJyub5+Xg5qU
         DjyQ==
X-Gm-Message-State: AOJu0YzQ1lrIiaPK9KFghjLYt2XmQCuCCqp84J9WOXZjY0Zfw8CtgPGK
	Z+++MFMivO6PRVtwH2m7gJErDVwpzeNS39w1UBIocW9BG7vktYMDUKlUJZ9Q6Gw=
X-Google-Smtp-Source: AGHT+IG5ax+sOw2tLQUKuZvzxYxoyEI9+MWyj0QwgEUGksyCNyPlf2jBiIbpyafy8SBjeOml7AjlIQ==
X-Received: by 2002:a50:d751:0:b0:56e:2c34:cfec with SMTP id i17-20020a50d751000000b0056e2c34cfecmr1361174edj.7.1713526741120;
        Fri, 19 Apr 2024 04:39:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:00 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 12/44] clk: renesas: rzg2l: Remove CPG_SDHI_DSEL from generic header
Date: Fri, 19 Apr 2024 14:38:10 +0300
Message-Id: <20240419113842.3675543-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15663

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 3e8008fcf6b7f7c65ad2718c18fb79f37007f1a5 upstream.

Remove CPG_SDHI_DSEL and its bits from the generic header as RZ/G3S has
different offset registers and bits for this, thus avoid mixing them.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-10-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 7 +++++++
 drivers/clk/renesas/r9a07g044-cpg.c | 7 +++++++
 drivers/clk/renesas/rzg2l-cpg.h     | 4 ----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 1a7a6d60aca4..e0ae25644e1a 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -14,6 +14,13 @@
 
 #include "rzg2l-cpg.h"
 
+/* Specific registers. */
+#define CPG_PL2SDHI_DSEL	(0x218)
+
+/* Clock select configuration. */
+#define SEL_SDHI0		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 0, 2)
+#define SEL_SDHI1		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 4, 2)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G043_CLK_P0_DIV2,
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index f5550fccb029..c1c94c58983a 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -15,6 +15,13 @@
 
 #include "rzg2l-cpg.h"
 
+/* Specific registers. */
+#define CPG_PL2SDHI_DSEL	(0x218)
+
+/* Clock select configuration. */
+#define SEL_SDHI0		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 0, 2)
+#define SEL_SDHI1		SEL_PLL_PACK(CPG_PL2SDHI_DSEL, 4, 2)
+
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A07G054_CLK_DRP_A,
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 20da0c620b90..f5382333d327 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -19,7 +19,6 @@
 #define CPG_PL2_DDIV		(0x204)
 #define CPG_PL3A_DDIV		(0x208)
 #define CPG_PL6_DDIV		(0x210)
-#define CPG_PL2SDHI_DSEL	(0x218)
 #define CPG_CLKSTATUS		(0x280)
 #define CPG_PL3_SSEL		(0x408)
 #define CPG_PL6_SSEL		(0x414)
@@ -69,9 +68,6 @@
 #define SEL_PLL6_2	SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
 #define SEL_GPU2	SEL_PLL_PACK(CPG_PL6_SSEL, 12, 1)
 
-#define SEL_SDHI0	DDIV_PACK(CPG_PL2SDHI_DSEL, 0, 2)
-#define SEL_SDHI1	DDIV_PACK(CPG_PL2SDHI_DSEL, 4, 2)
-
 #define EXTAL_FREQ_IN_MEGA_HZ	(24)
 
 /**
-- 
2.39.2


