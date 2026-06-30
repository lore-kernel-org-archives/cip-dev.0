Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3112DC44503
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:08 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19436.1782820139994988850
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dMdcdWhm;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493a5392c60so13979855e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820138; x=1783424938; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgT38vqdDRlYF7EXgPJAO2YN5YRDh1PL/izTEOU6Pc0=;
        b=dMdcdWhmtLQEYoC0Ar3bPSL1+1q6hz5YzF7jOmGnW91UDJsRCTXXvMBA/JLyEVnZOu
         sG/Aokap64SeCiXoasbR/WlV5+1AQhXWxl91rzlg7P4jfMLwMqveT+WPJx+qTjhvfYze
         WbQgnVupjp/4LVBjGZ/0YgIY9LwRAv48tRjzXns2bpVnl2WcvJCRANoupsUlEIXpc21L
         j9Gafb8NJ89IGExCUOIvKEk6BwcM8p7x74z4t1AL2GeXgHU294xu/E8ozm3/AxwJGEw5
         dM8gf4G1BamIfjXebtMCrPUl2WYBA4H/RwyfrmOabV9Dvj+YoMz6h9t8TACMPIroPxBd
         wRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820138; x=1783424938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgT38vqdDRlYF7EXgPJAO2YN5YRDh1PL/izTEOU6Pc0=;
        b=ozabUvOzO5KPAuTBnOcYJh755duMxUesMk3vpJMNuZm/AcHaOSO8aYQbfftWWw1wmO
         ZGNsM8ahBaCekl7uc7p6XthycZkli54ybaznwKllq0ToMHWXL9hUWsUbnVF+8ZTTWCEK
         5b3sMxBdTgN5VB7xemNM1vP9asQbyQu4Z0884sE9Q38y68TAMMqXVvptDw2LGOBebvoa
         7CKGcHOimumK50MM6W6x5rQFAakto8WBc7fy6yQ/Tv8Kssdzv9PFisO7vi3qKlErr6pb
         mA96hdh19o4p+nUgxyE8nnYXn4sr/uGZTsdfEiR9aVIEYJA6/5yxxGVrDQEIQREqEea6
         qxDA==
X-Gm-Message-State: AOJu0Yy+7VRmt/m0l6AEP/arAamkoLRM+XPUzshEkA+r7N904n+vtYYu
	ZYDl39PUDd6PSHyAmxgr066eruv4n3b3x6V41PX0jFlyQ/I6BmYSV2QylaTTfMqO
X-Gm-Gg: AfdE7ckLYgWpSvZLDzpvjG0Rm0rbzTv4S7hiqDdF60ykKHy88Je/WHomm/5Uc4W+JnA
	xaBoJLOJKe3R6iFuvDequdd5HDpuuxUwIdqXfl5FPi1e6bJtF5kBaodLgUo6Uf+XgAYpoFHFbJm
	QCZsMICKe2CpConhXi/J7EOCFtOBpQHQDz+DhZH9tTTOMKIU7Rq+YwCUj33AJWab8QN9/09cfdr
	HTm3GIomn6NVKVwx4O64a4yMHdO0n7Egnh0suzo12nMaLjYcIbLB9mwIxGizh1bUCe+OCly/WWD
	fImtv1FXRVYeDrfvNLm6DGXQt9CzoUDkZDjbslKR3FqDsJgOh/BGbiHVUuSm/9E6iUqfCB81DsZ
	3MQLKO3+gb6+2JLnnfaAyBS0Clv2kzEPlZUQ/rl8dm2vvA1d8Y65A74BjQNQor0U3Fk5de9pQ3N
	h2AiUySPR9rNkn6YF/vb0MscXuYWK4tJKoTx2Cviik2QLowNjX
X-Received: by 2002:a05:600c:8114:b0:490:e190:3b50 with SMTP id 5b1f17b1804b1-493b8287298mr47969495e9.9.1782820138090;
        Tue, 30 Jun 2026 04:48:58 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:57 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 28/39] clk: renesas: r9a08g046: Add SCIF{1..5} clocks and resets
Date: Tue, 30 Jun 2026 12:47:47 +0100
Message-ID: <20260630114813.92739-29-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23352

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 6b99bb5e6ebec07815c0ad742862bafa386797ff ]

Add SCIF{1..5} clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260330132349.149391-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g046-cpg.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g046-cpg.c b/drivers/clk/renesas/r9a08g046-cpg.c
index a311e17958d1..962094157cab 100644
--- a/drivers/clk/renesas/r9a08g046-cpg.c
+++ b/drivers/clk/renesas/r9a08g046-cpg.c
@@ -264,6 +264,16 @@ static const struct rzg2l_mod_clk r9a08g046_mod_clks[] = {
 					MSTOP(BUS_PERI_COM, BIT(3))),
 	DEF_MOD("scif0_clk_pck",	R9A08G046_SCIF0_CLK_PCK, R9A08G046_CLK_P0, 0x584, 0,
 					MSTOP(BUS_MCPU2, BIT(1))),
+	DEF_MOD("scif1_clk_pck",	R9A08G046_SCIF1_CLK_PCK, R9A08G046_CLK_P0, 0x584, 1,
+					MSTOP(BUS_MCPU2, BIT(2))),
+	DEF_MOD("scif2_clk_pck",	R9A08G046_SCIF2_CLK_PCK, R9A08G046_CLK_P0, 0x584, 2,
+					MSTOP(BUS_MCPU2, BIT(3))),
+	DEF_MOD("scif3_clk_pck",	R9A08G046_SCIF3_CLK_PCK, R9A08G046_CLK_P0, 0x584, 3,
+					MSTOP(BUS_MCPU2, BIT(4))),
+	DEF_MOD("scif4_clk_pck",	R9A08G046_SCIF4_CLK_PCK, R9A08G046_CLK_P0, 0x584, 4,
+					MSTOP(BUS_MCPU2, BIT(5))),
+	DEF_MOD("scif5_clk_pck",	R9A08G046_SCIF5_CLK_PCK, R9A08G046_CLK_P0, 0x584, 5,
+					MSTOP(BUS_MCPU3, BIT(4))),
 	DEF_MOD("gpio_hclk",		R9A08G046_GPIO_HCLK, R9A08G046_OSCCLK, 0x598, 0,
 					MSTOP(BUS_PERI_CPU, BIT(6))),
 };
@@ -278,6 +288,11 @@ static const struct rzg2l_reset r9a08g046_resets[] = {
 	DEF_RST(R9A08G046_ETH0_ARESET_N, 0x87c, 0),
 	DEF_RST(R9A08G046_ETH1_ARESET_N, 0x87c, 1),
 	DEF_RST(R9A08G046_SCIF0_RST_SYSTEM_N, 0x884, 0),
+	DEF_RST(R9A08G046_SCIF1_RST_SYSTEM_N, 0x884, 1),
+	DEF_RST(R9A08G046_SCIF2_RST_SYSTEM_N, 0x884, 2),
+	DEF_RST(R9A08G046_SCIF3_RST_SYSTEM_N, 0x884, 3),
+	DEF_RST(R9A08G046_SCIF4_RST_SYSTEM_N, 0x884, 4),
+	DEF_RST(R9A08G046_SCIF5_RST_SYSTEM_N, 0x884, 5),
 	DEF_RST(R9A08G046_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G046_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G046_GPIO_SPARE_RESETN, 0x898, 2),
-- 
2.43.0


