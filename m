Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC56C27C6E
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:20 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web11.42955.1717769236121512251
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZRIM64aq;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so2738777a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769234; x=1718374034; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0Z0wGNebP5DPlfQfOSdLhCl1ppkwfUAo5GYzgtQ0wA=;
        b=ZRIM64aqHc+keWiQ2mqAN0nVKBFu1m1c1OVsjE9mct4y6kYmdGOZY1EiHDWDpRU4Ao
         rDHDmJ6I+wD+U7e3LKOoQ+Hri5kprdYigfunvSH4iMFP4jWhN1LCIlx3XAy4sRHExi9N
         GMUW9tlltE/hScZjrD8aBpMkpW4RJkS9Y2Yn43OLAbUIZJh3Q9NdrpUTpaPGLxOA+MBR
         8GV1poSkNgogkFcUsdm0/Y5ZnaQZZZQUMUlpALkswIqZqeQcdaCOkVfofzYv/GoVBjqX
         sixaCbn5wrvICu9lhdtJwqMwPYr/4+ioM5RkvyJZi3soxF8t1bRumHA9Z9zBUmWEbgMw
         XqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769234; x=1718374034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0Z0wGNebP5DPlfQfOSdLhCl1ppkwfUAo5GYzgtQ0wA=;
        b=Bl9gZ/yR0JBurbG4Cs5goGUEALYojjfZvJ4tZZgw7N5kBIfsFDJ7d5yHK0OjclzUr9
         yoMXQOgSSXk8TexHGjjO/OhEHwx+tjPwGYm7W/2AtjakCn3eh7HUWe3MbT+NAIvnuxqs
         s2Lkyq92KHx5rx79gjmqimZVCXbO9pj3eLoQTSnBroUlO4PtPv33MnXQlXfaMYy3Ewna
         mRCg4zFvT0jMHPNVXfKn5H/ij8FibO3FTQa22wnTZ2LR9kqSa0WFfCHKlo569KYMYDm0
         fI7RToB6c0+k7S7nNkxKnhvfNCCdwmO1wdmUu8xR4p6QZGEFr5fXT3yU+XHiPAvK8Nmm
         Z6Tw==
X-Gm-Message-State: AOJu0YwaPGof70BJJSp/fLhxcJQstWOKgTCbSUq5HM1lRn2Yy17A7Hpw
	8CSHMQu5mWIvne6QUyxjL6SRJAqB4LcfjEIC37izSr5QfDgjTf4JHMNZtmYJYYg=
X-Google-Smtp-Source: AGHT+IHeZ2UPWPTFSrByiK0oa4VWbGd37CRQuQ86OBfZYTp6kwgd1mMw29j1k/34KkjXXXwxfdZsOw==
X-Received: by 2002:a50:8750:0:b0:57a:24a7:2756 with SMTP id 4fb4d7f45d1cf-57c50980934mr1519281a12.33.1717769234441;
        Fri, 07 Jun 2024 07:07:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 01/19] clk: renesas: r9a08g045: Add IA55 pclk and its reset
Date: Fri,  7 Jun 2024 17:06:53 +0300
Message-Id: <20240607140711.2497286-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16142

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


