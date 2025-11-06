Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034CCCFA1D
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:05 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10090.1762416723486584203
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kQ2q8DB0;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471b80b994bso6217955e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416722; x=1763021522; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pvJbytWTzeQQgTeew+XJ2afs5Lm454b8s0jaDQoDtQ=;
        b=kQ2q8DB0n2tTI3hbOxRfksWi85tIGBJyRfAcZXoXrdoe3gbEN59X9UNUJgdvpS+f4H
         Q47bC+An5VtZ3/hZNu5Qg/dIAp3aSiCcl8EmgVTL2uc4YFTvHBTUTXGfJ7idm9ZptUqS
         d69k6xOeJgIZbjlZzXOyJETmny/liQShhgYjM3xsSHq5Np7x7TH7Ft09Hr0K+VeYE2rn
         xwu/659PCXDI3MXQTczAsPuDyqUvVKhrZHWeSm5DNJs9uvfdCZGcSRGp8chLV75ipuuQ
         2ZB/pjL0eS5rbNBMa4OWPv6B6JPGhtrrvE00Jyb1FP3dLL4/tm6BVzO/ID5N4Xuj2b4P
         7mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416722; x=1763021522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pvJbytWTzeQQgTeew+XJ2afs5Lm454b8s0jaDQoDtQ=;
        b=iFQ46Xjr8nX66wFMct6YDbI6xlxCfHn5EHKTZA+rk6BLsYC7YU93sDLGsUgbInNsfm
         Cnt5QNyOMCbBVQNRuhV3FHJNFQigH3beiAIqWYiqorOzPZUH2UDCO+Xtslc6+opchav0
         942pYRJ4ksmuqY5jm97q4pv5Yke5aMNer0kKyW8G64PIVH0OXGZDzkyQ2adG0S7nZy+4
         22gv6wn0Eas5wZxAa2lXS1jIFfBqnxopk+FobA4XKMgbISg3gKZ517UiUQlOuNvXrfCC
         qkCMoZrLkZbUhtRxK68BmBLAHrhoPkUsdUeHT056Z8I+fHnRsMhS/vn9vDTr3DhuCmbS
         FmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9NO6N+xPuiJW1lQuLjCSRzCR/KAyTbwemcBxg487TkyszmPJfTVNDtE3gWkDjm9H7nD2hY7VP@lists.cip-project.org
X-Gm-Message-State: AOJu0YzoDexF2+vWwKjQ7ECq+utuzpWjrzImCvbFT7iXQF1B+PEguSQ9
	2uB6xzakzNZEGvBDKXDoDWQLE8iD4l0FkyOGjIAZmLgt4WU9gDF9FNapb9DUcZn0Kwc=
X-Gm-Gg: ASbGnctwnewWBbkNiJffBWSBdzLvB3mm8j08xObKOafhSA1wIUkhhuazJ7xggSj3MTU
	kHSR/9NkHl1GN80UvRYQtqGYFRT4l+f/+R2s3HEsQAnVTjR9M3Jcl8ycrXXwiGIeOU89Hjn0XV0
	VDkQw5iXC53XBYAI0jXuYykKnhoFM7SZWNiIn7UHjWLx8TAge6D9gmAH2UYcg8HWEW4vmCsM9tW
	dkPNqEnuAUdGrfiznGBo0QcDIeg3mJj3iggOPY5KeNpy2OdTSj7MS6JCFwBsVPzHBrZmrHmtgzQ
	G9j7enYnhA/VTW0tr85cCZfW/lmZdq6KCgVgDB0BZjiTONTMmokW1085QymkGl0BAs5A6qtPpER
	BrR6tgdDoxy+nuBb7TGBrLxHjXq01aNLpxKtmH+v36dyNuCdihycqLV4V6uR8/KoMTIMFFdHTLL
	4Qh1dlLJf/WBo1ZBBa8HKXsqsjFirOfv0DQtThvfLw
X-Google-Smtp-Source: AGHT+IFfzLRohpXu47d5NFLy2AVutrjrJqQ9s6NBiU6JGlkLRGPGW9sOjFfkdwuJm+8Oiupf4a/tsQ==
X-Received: by 2002:a05:600c:4748:b0:477:6363:d3f0 with SMTP id 5b1f17b1804b1-4776363d4f6mr12914435e9.3.1762416721857;
        Thu, 06 Nov 2025 00:12:01 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:00 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 19/23] clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
Date: Thu,  6 Nov 2025 10:11:28 +0200
Message-ID: <20251106081132.2574638-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20412

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
index f5f0ddca4b8b..6d7295c36d5a 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -246,11 +246,13 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_MCPU1, BIT(13))),
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


