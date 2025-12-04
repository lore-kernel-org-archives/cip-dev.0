Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CEED29F91
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:58 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50871.1764872155814853100
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Wsied7Gg;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so10317435e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872154; x=1765476954; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pvJbytWTzeQQgTeew+XJ2afs5Lm454b8s0jaDQoDtQ=;
        b=Wsied7Gg0SpEY3VZWJtGe1bBzELYWyhWqA5rlunGSvYtOfD5q4isw7Vwgs5gINCuvG
         XR9LTeQRdj2l0U2SRRSTNn8K0gMc6KzCiLCnCw6ZlDFteEcu/0q1LexMJsjeDWV4sNip
         vEDJAYHxl25SGiNb+OcCCI9Zjh9qLoVx3Cq4Ot0sZQTb5M4lyflSUDTpd/8Lu6XTlAM0
         +QGq1t9Bhgbcd2UX3/qZXOZ43Lr4WPuMQzJ9tx+n1SP+RuxWmxeD1fDsXJhhWnpoDm5O
         hlISwcoNVmpIjwIYmIjDnRH6tBRFXIlUbzURk+/HDdAsmdrBxtT+NSq4HaHQKtJaOwCj
         A+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872154; x=1765476954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pvJbytWTzeQQgTeew+XJ2afs5Lm454b8s0jaDQoDtQ=;
        b=a6lB+lapoL5hDORScDW8Y+qGWUVPdXQMzKEOl92FYke+7mbcEcTBXCK7vaBoNCNMIB
         s69UC+r6irmZDcCQikU+sLzPVJbz7HHKgFyPQH52dEV3FVn3lAgAQ1CcTqGCt9vDt21e
         9CElYLrdMXtTH+0x4KUr7jbupHEgW/y4HTAEtYrNLvyHNLLQpTtGfeN+isgR3a0tsEP2
         Yfwl1/5OhKStBerRcxU0cXYhHLRrVGPUvbWnHI9MwiXXnCdKju3rRIf1DARxqYJG/WGE
         58hTS9zT0LM6hn/ZDMA4LGJw5qBRagVbF6eHshD93mZhupFm12Vg3Xd6W6vC5JAcPrBY
         d36g==
X-Forwarded-Encrypted: i=1; AJvYcCUeW3QYEFel52CqWhV8Ko4G/g5dB1E084KS1zqkPIvfInlDvwHBgse1ziGhtR9n7PMno6KdkmSX@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy2PlqE5RF4RKfpfOsvrv/1xHNuzJuVeXdsnxEcqRvX+gqInv5u
	dI99fJo+I/OWKu9UT+OL4l2edMItw1TDt6ok0LQuiw+mFqHGFp0rsj+UsYCqDt+dEMc=
X-Gm-Gg: ASbGnctLuDkzjvc4t3xYMewPcbo5oCZju/vAyXP6lGNimi3djTxeMBVCT1IojxwPx0w
	x6vKMQ+eaXOteYG4eWVCNySoXbEjjbaE4FAw8A70L6bMkCOkgm43YJ3vCfCb97FwbhdozpsMfnO
	m70Igo1CGCDmt8fIxdaaG8fqHB748347eReiHWFtGnrtBUyBLP5WEwJfoxlyyl4o98iGOcf9uzm
	wP+rpf1maZOAN9vs7OsKxryJrk2uzlwYPEltVthuvlkXnh5EgDTuAPUR7uXFEq9xdRbeRCfT1nr
	e2fx3IyO5d0YIdy+5agfsnx3u9bRe5a6B8+gUK4pre7di6dMuQlxpd/fz1fn1ptJPh+du3xIGSi
	FB+uAzzkg8WVoaw3bN5XXAYy1FjW+DJMCodmxrUqwsfaSXZbfdLYpm5CygcKA8/r5EXMZlXrafV
	NFgpmT0hs/wWHGwflOjqPJXSkFwoA+1oKviq46SSnr
X-Google-Smtp-Source: AGHT+IHJl9bLF6IqYf9EQwg1WBfmR1Im7yZFb/C7hrLFFbH4qZWLadCHDXZylteRHhm80oRBqY0jFw==
X-Received: by 2002:a05:600c:a45:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-4792f244111mr34166005e9.6.1764872154167;
        Thu, 04 Dec 2025 10:15:54 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:53 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 16/19] clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
Date: Thu,  4 Dec 2025 20:15:27 +0200
Message-ID: <20251204181530.689132-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20882

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


