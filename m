Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D1FD29FAA
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:29 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50900.1764872184071378634
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ovkI+qw9;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so879347f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872182; x=1765476982; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBXNsfD4B2DO3Bx7Ss2SQ+1DELG6ogi6mtqqqH8JvT4=;
        b=ovkI+qw965ciYWGtVuI0c+afFjMRGyRUqwSMO3JvAtFPsilssTwam1CKHn1tseZvFA
         lxUpzHvXi40/RPc99WQfpIty4Cyx0NDJ9m36D5YvA+9lXWQgokwhtJDYjpEQf8HCFPV2
         z0KCK9KF41RHdTlFmJgtz08ETjbGdKzSzXtyup+Js8gDESvuV4MnODfJvO4qfTPQUUkJ
         W26BFE8VF2/iilZMuX0HTroVWFWktOLezYAAzhNJW6ylEec3k8Br+UYKWwAkeat6N9R8
         ngl5tEC3Bo9hgkuOkPiuUNybZMielOR6b0FPVXHY71UA+65urU61i5O46gAIUH8zLptL
         l3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872182; x=1765476982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBXNsfD4B2DO3Bx7Ss2SQ+1DELG6ogi6mtqqqH8JvT4=;
        b=BIWNdGnp9Rkz0J6pNkcKVb1eGnAfZ/J2vjbmZ06YwA4bJLX6OzNizKm5JwzNR2cV8h
         AAbqorOroZZcudg0rQ3QMo+zKmIZ+v22ofKnzg0x9NU+XAF4b3KwMDZT6WyY3HDK3Niq
         zQdhGA/iD8laLQ1YxyTyXO3vUqqu3I/detHz7R06vrLsqN1rw6WFVGc//F1cED2BOA/x
         g8aEuf04DaF/vsxP1CF0hY69pJc8Ei3yu1MQbdOVyHx0CvVGKO5jY6FdF5JgeiH8BIxP
         0kl6PRb5cXoxf0DDap/4fZQhwpfWn/yboF7BuUu7sfXtJQdFz0AqxGfz2U2ron+pooJ2
         NiTg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ER9HBCoxHG7Q5WclmB8csKkHuvFl2x2YAwAAJnJPPV9PDH5LAmJxO6XL6XdbNaGCw85FoL+1@lists.cip-project.org
X-Gm-Message-State: AOJu0YypMF7IuYsX0jZbO8lJFQ+XqKhpM013FAGOYBOVVf72Lb8CHxMr
	TpQzr1MYl3JnH1D4lyXxwvPAVZEtbnX8cao/JVOO5kDEWB17E4N+CAPy3jCBWplBoDk=
X-Gm-Gg: ASbGncvPcLP8UWbO+F0/zoV+18O5jJfG3c3dbG+MKTO+ftzRAHJz6eTSGecFUoiNKbW
	VGzmaHpJTlVrpLhTvPmeUErpbl6Zg0W5uELQZsX709rQy0OiHtuYi7njNyOrRjPaTpw8f0UTeia
	TBFBk7r0sGKUlrQEbP4o4IfjFLA+UMXVJkwQHm83VYuqXy07IDo2uZBNoGR86IQ70zTlfOTo8Fn
	zybLRJNDlMNjmw92rhUBMEA34GuH6ff6evjhzyjzw5IPKnsNpSzUeJ/SfDtoboLfcaCSpyGaSRJ
	1KJbL7E13DI7mcVt23a37gv0tzVvxiMvVhNyxtnKVdklkxF87/ov5XXXJ42ApaCwPEclqn2Wblp
	wHPUh0r37avH/em71cY6UeZbnaH9+H6BO0Gk/Y2JCqHutnn0gNVsG4JhYMeEc28BIQzmH/DN+zr
	Nl2jHaQmbOpbjHWjPfcn5wvpNTR1KkFBPoMBkKhYRH
X-Google-Smtp-Source: AGHT+IF9k/B+gC8jiw6QpEv1k/W1B/u6POoinyWQggUMCLxFpXHR5f6/FP/RY27r4QiDpgEc9x0iRA==
X-Received: by 2002:a5d:64e3:0:b0:429:f0a4:22e with SMTP id ffacd0b85a97d-42f7985ca00mr4124345f8f.54.1764872182427;
        Thu, 04 Dec 2025 10:16:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:21 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 16/19] clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
Date: Thu,  4 Dec 2025 20:15:57 +0200
Message-ID: <20251204181600.689203-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20902

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0ab2d84f94dae48c3e7605cdc99dbb4e7c7b206a upstream.

If MSTOP is not added for both clocks in a coupled pair, and the clocks
are not disabled in the reverse order of their enable sequence, the MSTOP
may remain enabled when disabling the clocks.

This happens because rzg2l_mod_clock_endisable() executes for coupled
clocks only when a single clock from the pair is enabled. If one clock has
no MSTOP defined, it can result in the MSTOP configuration being left
active when the clocks are disabled out of order (i.e., not in the reverse
order of enabling).

Fixes: c49695952746 ("clk: renesas: r9a08g045: Drop power domain instantiation")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250704134328.3614317-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 6f0bdf9b6e4b..c1365385d61a 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -255,11 +255,13 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_PERI_COM, BIT(4))),
 	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0,
 					MSTOP(BUS_PERI_COM, BIT(2))),
-	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0, 0),
+	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0,
+					MSTOP(BUS_PERI_COM, BIT(2))),
 	DEF_MOD("eth0_refclk",		R9A08G045_ETH0_REFCLK, R9A08G045_CLK_HP, 0x57c, 8, 0),
 	DEF_COUPLED("eth1_axi",		R9A08G045_ETH1_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 1,
 					MSTOP(BUS_PERI_COM, BIT(3))),
-	DEF_COUPLED("eth1_chi",		R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1, 0),
+	DEF_COUPLED("eth1_chi",		R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1,
+					MSTOP(BUS_PERI_COM, BIT(3))),
 	DEF_MOD("eth1_refclk",		R9A08G045_ETH1_REFCLK, R9A08G045_CLK_HP, 0x57c, 9, 0),
 	DEF_MOD("i2c0_pclk",		R9A08G045_I2C0_PCLK, R9A08G045_CLK_P0, 0x580, 0,
 					MSTOP(BUS_MCPU2, BIT(10))),
-- 
2.43.0


