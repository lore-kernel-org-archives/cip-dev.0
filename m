Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5576C369D5
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 05:02:24 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.41030.1745816480859589174
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 22:01:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=h1f+xM+s;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abec8b750ebso730426866b.0
        for <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 22:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745816479; x=1746421279; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aY1TdiANamuB0ssSl0erN4wGWwJMCBvZa7NI6kilg+s=;
        b=h1f+xM+s+K0vZzrFEgjhoiNbIVxeJHVvdjtUB4ZokAJRlQTX1+bXUe9g6g1HdCijRp
         3dUKtWvuyrsmMWA5Ogh4Spl446HiYJQnICEW+V6HSvCWV6ipEesyckMT3zl7fQ6Xs6Jj
         bbKEgkh6QuqbtDYdWO+0ZVkUuc+cbDUUWUXbjkQxYZxiagjJc3BXp7xEinNBqIsgNVIa
         HMbOD+7eM8H9gB8PGyIIf1vzkg/a2VTqknzfocCRA4Zrx8GOJmMwO7K6s9d8rnN43IIH
         EN7QGH344+RJzPxY2v4buL15nskq+AMHg/USvSh+UJEiTGruEJDWicxpt+H19oTaXOah
         +wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745816479; x=1746421279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aY1TdiANamuB0ssSl0erN4wGWwJMCBvZa7NI6kilg+s=;
        b=Sz2Nq7G4RVGzSjyedkhP2JRYsnSDU3SV47XR2TucXYl9sBgJKg3n8cjH3ceF0vSLtr
         blboezYXqQN432msow8668i4uEvztl9u9gRbXqczeehAWcn2VAG2CDvKrzeK6cY1ldpt
         drj+vThqXHPQQlcpWCKo/FR8yyZSnQJZ8+4opwY7NQIaYOhT71O8S3wcT9MlEDiLtDUC
         9Kd1bvAORR+NDHzbNDdx2KTTlYdNaIFkxFbpt0XQqzU/hHZViClruTNdIZ2Nd3+dIbOc
         hr/GS277D6KqnGYTxbUAAo53gmFdd7bbaJW+G5mRTWE3DsVA8Cn+cv+csgbXAk5THsdF
         azKw==
X-Forwarded-Encrypted: i=1; AJvYcCUitY5RDBqIDWgXC2ge00mHopN46w81ZZGpmzYB/7G7SNBLos7XtUML6565934e/oH2J4g0erAX@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz5mHBWbDyQvxT+jaTCdDPExJBfTJTDBrbBBbAQWpCdZC0y1o+W
	wPgpu17fe/dUub0yiKK5g+HLmE41g780gkaergGS3gAiJyddSDlNX+i5f+AhF9A=
X-Gm-Gg: ASbGncsnI73oB/pgVZ30ObADhYXqeHjPHJqaQZZYVK0lG6UL2uFYeCh2TnX1QIxdlwl
	usjaDM2F/JbwOqqUM+XHKfttETxSm0ZyfQCavga+yNj2Uyr+dgbcJaGZgz1Kcu1FSWIZHHtswwH
	GqsvsRo5xZZ3Q2vIFul7dQg6rM7sneyE22xa8isPA3QaTjxXH5dsCwprfsdz53cJMHlRSIQUnDw
	wZ3yttNbyCyQ3yCVasHGEOJbDIyx5dnVwzPwXBLcZ3xcUB0/EImqCMvVNMHzfzembrFU3h9QhWj
	vRkpt+GX7MtAV3qIXDNtr0RrotxeD/1b9bdd/HZutqHIBYy018B043HQyGdhRnWhLehaVuI=
X-Google-Smtp-Source: AGHT+IGFI47IZvjmCT5zsIXO9xWRQ4XHk+XTZxw4vxFGYNPcp4shS2OiigT2YWXUtLw3XHUas0iaGA==
X-Received: by 2002:a17:906:d54f:b0:ac7:16ee:9112 with SMTP id a640c23a62f3a-ace70e801b9mr957101766b.0.1745816479291;
        Sun, 27 Apr 2025 22:01:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41cfe8sm566055866b.17.2025.04.27.22.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 22:01:18 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 1/3] clk: renesas: r9a08g045: Add DMA clocks and resets
Date: Mon, 28 Apr 2025 08:01:14 +0300
Message-ID: <20250428050116.3081804-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428050116.3081804-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250428050116.3081804-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 05:02:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18674

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 6f5c16b74b8d2eacc98f4e0d1611a129aa6506bd upstream.

Add the missing DMA clock and resets.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240711123405.2966302-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 55e7d42dc472..b22bc5e972a4 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -193,6 +193,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("ia55_pclk",		R9A08G045_IA55_PCLK, R9A08G045_CLK_P2, 0x518, 0),
 	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
 	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
+	DEF_MOD("dmac_pclk",		R9A08G045_DMAC_PCLK, CLK_P3_DIV2, 0x52c, 1),
 	DEF_MOD("wdt0_pclk",		R9A08G045_WDT0_PCLK, R9A08G045_CLK_P0, 0x548, 0),
 	DEF_MOD("wdt0_clk",		R9A08G045_WDT0_CLK, R9A08G045_OSCCLK, 0x548, 1),
 	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
@@ -222,6 +223,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A08G045_GIC600_DBG_GICRESET_N, 0x814, 1),
 	DEF_RST(R9A08G045_IA55_RESETN, 0x818, 0),
+	DEF_RST(R9A08G045_DMAC_ARESETN, 0x82c, 0),
+	DEF_RST(R9A08G045_DMAC_RST_ASYNC, 0x82c, 1),
 	DEF_RST(R9A08G045_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
-- 
2.43.0


