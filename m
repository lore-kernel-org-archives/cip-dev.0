Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF4EC0650F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:18 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.15303.1713514695904212531
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RsnS7Dm9;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.169, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2da01cb187cso30327891fa.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514694; x=1714119494; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2AdxgEaiwmkPsUIrm4YNxqGj7QuZwVINKjTX1zNVMw=;
        b=RsnS7Dm9fCRecG4uh+fQbBfsIiO484hey6XCokAiNq5NhtMQpYdmn7tfGGuQmWrAsJ
         xjzV7YcHIZUU06YLj0hflrvsAranCp7zw2oQxS5sMHHBl5STRfamDVHJfjX45ezKmUu2
         0ZQ5k7ZTgiihBhb8DuKmiLhrbRovLmhtF/elfLph1dHQXYZpOI7nkphQbfenDA7OPT7m
         qheBPll4Pg/vaUVJ3IvxpNHDS5yjscJGSZuLg5JME9LvQLFFHJRDy6o2MYWSU7nHHk47
         4uauveQfJEtRV+vO0io8X51Oc4Dk3SQwFEIqbkjiBSySiRndE0g7nvB7TtALkYaiOhJo
         QaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514694; x=1714119494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2AdxgEaiwmkPsUIrm4YNxqGj7QuZwVINKjTX1zNVMw=;
        b=p5UNDUXIkcFO+U1aSTLtVVeapagLRM5kAEfW4EatTLzXex+kS1G8aeO4LPOVgfIxwi
         mmiPQg4qrMCJ4Mnv4m5c0Hc8RIE5dzlqcfBwUgzii4Kdzng6ySCiknqD/Z02bo7vvJmH
         UvSI9RE27k88OFtbHVhakhfXdppXj+GzEZwtSfp9QAbzLzXK8NzaWVUdJQcyBZhUdSQb
         wMhuyjJVgadT3lwxpynlQEwjUjrCMlrQ/eL50cCuFZowjBzPqjlD//yB2Gl9SKZ/CjO6
         /KBwCfVeLw+rmCNNl7pp9q3cSMR3hcuKbMb/dGksnfmx0VTFSLQXaj0KuYw5pNe/S+Pw
         g8PA==
X-Gm-Message-State: AOJu0YzWQ2f8op0h6KfTQO5Vv80XKrCs60nxRpTHyglAtbDnvhryJbg8
	eiDhZBzcCuuIW9Vqolg/Wssn+01ZASpuSlc8mMo5lR+dxr4RhUhrtLxkvR28UNc=
X-Google-Smtp-Source: AGHT+IGxXhyEQZ1hjtERAtYg3JMGLt4v0FnuklgW5qo+ORYRY5qx/U18JWRGWRmfezJfT1IxXerekg==
X-Received: by 2002:a2e:9c0e:0:b0:2d8:5fe6:820d with SMTP id s14-20020a2e9c0e000000b002d85fe6820dmr978390lji.11.1713514693979;
        Fri, 19 Apr 2024 01:18:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 19/53] clk: renesas: rzg2l: Remove CPG_SDHI_DSEL from generic header
Date: Fri, 19 Apr 2024 11:17:08 +0300
Message-Id: <20240419081742.3496709-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15606

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


