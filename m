Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E76E7718B
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:22:55 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.104357.1734524570694238707
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:22:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eSZn5LXj;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e27c75f4so4899889f8f.2
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524569; x=1735129369; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11AoqFUKSWD3zMs2LLxkh6xVkPrdT/9gMNfkIPFCQXU=;
        b=eSZn5LXjwds2SHY4wMcvuo3LcexFC+1e8p3E61y9YAV4Lp2aqID/xOhf//5KEiGBCR
         IDyIHXkuZB58ae5iaMDkmp+OdsK66g9/ALI/jRuevQl2k89VdmSlKM1UU1HScaTabCEV
         ZgwOBj1kQ5UQw0FcKrPfNNP2y4Ni0CfeS+f7icBSVQ6/oblBnaRunip0Buc0JWN//F0g
         O9KgvYy4CuBcKdEBGTLqxshV98jdWU8Gmv8Oqx8AxFt31jdVVQz1C5GAK1Xl90oKfDF/
         y8CADClU3y4AN+zQx1rK0wJJziBRy2jZ2qPyqdb7TgIYFCwKwUjg1zBR4H++e0VHRz1y
         dvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524569; x=1735129369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11AoqFUKSWD3zMs2LLxkh6xVkPrdT/9gMNfkIPFCQXU=;
        b=OAN8E5Z+ZbC/RDlgBKbXQvnyQF+uMbQxAk6JtFvC8LA1vrqlCl45VXNGjNjEylKUTv
         teAVUfbWbXwgBu/Bg6mXkZVzzE69fA7oSM674pLvIu+GGW6FYjBD7uMin1sbsUIwLHJX
         cm/62ghDpCIFbXwrnIClwBMxlGamizlBlw73ADnLBn3WwREaus+pNTZ0uM7dJayBHp04
         n1p1CGAjppIAHj0A4yif3icEGba+1+4Gbr7n3gtSiGspwif6k6JviyuoANhOi/H5UVhl
         FCXLx+pC3AvKWb2WzAwoot2DCKi4IltxPIT2KJOVd4VhzfkM/9i8OfEiDE6A+JXd+V0W
         D+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2zqBk4GwwXOI1hmKvJNVF1GYjpIDauCJnY/ptmI+0OvVEXwvQZpFpvtq0ht5v/6A/nhQsFj3A@lists.cip-project.org
X-Gm-Message-State: AOJu0Ywz/KpY1bYqoZl6nLIbn5n4Hjb3FAt9BZIgUOtQlbr/A2xJtjH8
	gX1cuG59JbKOhci6Wlag4AjAqy0LGpLOfAfus/eqFw+6st477tid67ku8OldI2k=
X-Gm-Gg: ASbGncv4TI/HElcVCzEX6SYKGCcd1Jv8qgpAr8jsCYf6SvqKHWPVJfC7Ydsu2hecc0S
	PPHaP9Kw3Ij6JpNV+ajNkUr3VA/y7DYJtuYtPj0p0Z/ICs8jHyILN571FIXgdInTfRhgb8kF3ca
	avi3a+NdBvRyGywbRY5JSV7NqDCtDXrgGjCi8FsEAEq9HdpUTdVbhScKQ7I5NHWRzbOEeg+gX2s
	uh2YFv3hwejr23yPfh+gPfVSPA3TsxzV/4wCTCUUgXdFPXHF2sA4jsseSFtgvMcGQIxCCC22/ET
	S6PeywgSMfI=
X-Google-Smtp-Source: AGHT+IG9D8nZhX2vOavSsotKZiYwwqMUgdZ4NYVz4rSz4wtlyBtyLhbZ5xDJbxq+BnnFAqobDJQ5XQ==
X-Received: by 2002:a5d:6c63:0:b0:385:eb85:f111 with SMTP id ffacd0b85a97d-388e4d49ff7mr2936724f8f.14.1734524569067;
        Wed, 18 Dec 2024 04:22:49 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b2dsm18790365e9.12.2024.12.18.04.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:22:48 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 1/8] clk: renesas: r9a08g045: Add clock and reset support for watchdog
Date: Wed, 18 Dec 2024 14:22:39 +0200
Message-ID: <20241218122246.2365189-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:22:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17445

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 292d3079abf333540fef06c1533d7c21c6d21390 upstream.

RZ/G3S has a watchdog module accessible by the Cortex-A core. Add clock
and reset support for it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240122111115.2861835-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 2582ba95256e..c3e6da2de197 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -193,6 +193,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("ia55_pclk",		R9A08G045_IA55_PCLK, R9A08G045_CLK_P2, 0x518, 0),
 	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
 	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
+	DEF_MOD("wdt0_pclk",		R9A08G045_WDT0_PCLK, R9A08G045_CLK_P0, 0x548, 0),
+	DEF_MOD("wdt0_clk",		R9A08G045_WDT0_CLK, R9A08G045_OSCCLK, 0x548, 1),
 	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
 	DEF_MOD("sdhi0_imclk2",		R9A08G045_SDHI0_IMCLK2, CLK_SD0_DIV4, 0x554, 1),
 	DEF_MOD("sdhi0_clk_hs",		R9A08G045_SDHI0_CLK_HS, R9A08G045_CLK_SD0, 0x554, 2),
@@ -219,6 +221,7 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A08G045_GIC600_DBG_GICRESET_N, 0x814, 1),
 	DEF_RST(R9A08G045_IA55_RESETN, 0x818, 0),
+	DEF_RST(R9A08G045_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
 	DEF_RST(R9A08G045_SDHI2_IXRST, 0x854, 2),
-- 
2.43.0


