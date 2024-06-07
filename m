Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033E3C27C5F
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:11 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web10.42747.1717769341174338313
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=q2Pcwghq;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6266ffdba8so210553166b.1
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769339; x=1718374139; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0Z0wGNebP5DPlfQfOSdLhCl1ppkwfUAo5GYzgtQ0wA=;
        b=q2PcwghquHY52MeObbhSwU219AjxGhMn+d654v4O7syfuM8GOzpZnf0LptQLpz1lMN
         RaWslEjUhMslzacvOKdsCy1ZNHR8AoWrSHwobDz/dOC/15eIuMBJkbqWbC5t2WkoVIUR
         I6YC+aoJOW/cOlhDhe/e8yUjmq4yqZqKXEm+PjqjZErtoSLktvrq3K6mQfow0ZPVjULL
         la0fRQW0sWVBIN48nkSAmdZN6I6gcN9qUnlvRt1r/KN8Yp8Bqp2M3paJLawNxmy+Lu23
         U4jvQUttJr5bcv4NtumwL/fnVOmziTumSmgJ+ttETajUol8tvG/xnaPFCdfSY1ds/HdF
         NAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769339; x=1718374139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0Z0wGNebP5DPlfQfOSdLhCl1ppkwfUAo5GYzgtQ0wA=;
        b=Vh6e/o2O6YpOSAMygPN3LVezWdQQk3Rob7MQKFav8gsOHJVcN4QRRvMT2e05gfz0jB
         pfmI9EgtxBOvhebjiDqROjtegDiru+4PPXwoDkOlJIHUrIQmBePXe48gLvqEmdsGI91e
         G3dSpACdGUqzhHfpE9CYnL8jv6rUyS6W/15MlyXhcVC95mfa6CJVpdkU/1fk9jxutzg9
         RSwEMLKNUGuQyormK86Ow0v0YCHYJUsc9sRgfphdvMo9XCAzGMSIpEQ/IXqxbbKor0Dj
         5y1zqJYM0VUc7mtQydFvvlz7IwW4GchwR1IUmuETlATEuA4ms1PGwtjwdbtGsBRD2hoQ
         0eug==
X-Gm-Message-State: AOJu0YyaBvdMMBR6dmOLQ53MSDjW/sqf27aQtunLkqlVSgCGXOtIunRp
	bsujheEbsP/XaG3ve0yWX3CMkGMEmVkXrxS/d1R8tXpszHV8/68ZkIr5fKrDSs8=
X-Google-Smtp-Source: AGHT+IGFV/M+/VbAFpE9Seh+x2xEhnYaBG+wcQPMMoYGUrcxEGqBfRnryPnR6aRu1IAkEWrWR6e0bg==
X-Received: by 2002:a17:906:478c:b0:a68:e58b:2c35 with SMTP id a640c23a62f3a-a6cd6660cbemr235237166b.31.1717769339704;
        Fri, 07 Jun 2024 07:08:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:08:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 01/17] clk: renesas: r9a08g045: Add IA55 pclk and its reset
Date: Fri,  7 Jun 2024 17:08:40 +0300
Message-Id: <20240607140856.2497508-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16162

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 755cb955e2e7a2ef65e7a782925585ef1cce53b6 upstream.

An IA55 interrupt controller is available on the RZ/G3S SoC.  Add the
IA55 pclk and its reset.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index a6d3bea968c0..2582ba95256e 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -190,6 +190,7 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 
 static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("gic_gicclk",		R9A08G045_GIC600_GICCLK, R9A08G045_CLK_P1, 0x514, 0),
+	DEF_MOD("ia55_pclk",		R9A08G045_IA55_PCLK, R9A08G045_CLK_P2, 0x518, 0),
 	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
 	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
 	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
@@ -217,6 +218,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A08G045_GIC600_DBG_GICRESET_N, 0x814, 1),
+	DEF_RST(R9A08G045_IA55_RESETN, 0x818, 0),
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
 	DEF_RST(R9A08G045_SDHI2_IXRST, 0x854, 2),
@@ -230,6 +232,7 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 
 static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G045_GIC600_GICCLK,
+	MOD_CLK_BASE + R9A08G045_IA55_PCLK,
 	MOD_CLK_BASE + R9A08G045_IA55_CLK,
 	MOD_CLK_BASE + R9A08G045_DMAC_ACLK,
 };
-- 
2.39.2


