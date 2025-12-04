Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DD0D29F86
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:38 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50490.1764872078013964184
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XlFIr3kT;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so8921625e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872076; x=1765476876; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pvJbytWTzeQQgTeew+XJ2afs5Lm454b8s0jaDQoDtQ=;
        b=XlFIr3kTqC8ZH1GbmHT4hVEAJgDkqpalaheC7l7TEWftSIu1PQ5X4uLm4fcef7Jslt
         rNVNqQbfSLYgw6HVOAAI6git1TOS3ffNA8I3+FA3i4pEfcW8+2nhoGBiwr/6KUaiJAW0
         nXlX/OFBVkmFVCZyrQYHGYaOOfEXRnXG1U/dt17M/dNNim6m0dSl4UU5QacMJswq1yd4
         ycY4apeIt7HB0GzHydEQB7rZ8dgOBVumsxrpbK89U419Pk5jpz/MA0N51Hj0MU6dhlDd
         ZaPm3AZozNMuGkVPhMkeWZ517QdBYwgvTblezvvFy5115YPrf53a3/IOEOpVKVb5nEnQ
         vDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872076; x=1765476876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pvJbytWTzeQQgTeew+XJ2afs5Lm454b8s0jaDQoDtQ=;
        b=EIiUC6o0dMf607+Xs3Q+id+OCPbpecKBGm3y7ujeyRglj4k2Zm3lhW8k8IPJucp/rr
         dBxOpITkRRCfzjQpvu+Soy3JW10rEYiom3z7clFBYSKxAOgBYO4us6WFq62qI6Igv2lK
         Ub9x6RnBB5Hkka44+wRLdzIVmtbTa9FRDoDLMmidNW1gqfIoVogfzYnEEHQtNfHlpCwV
         qcePePitOxGDg/3EeuXwA/A6px7JlbHtVG0sBpGDyrz2rTy4iyX1D43YlOR3oC9uinul
         xQUzcGni+5Im2JtitlM90NzzcIwdUOrTQYMKNKrkmh1WwF3MavBcRre7ODRy4qnVQ8yI
         +Q7g==
X-Forwarded-Encrypted: i=1; AJvYcCX0hvJeIInaCjOcX7H539Oa2xvuPy8cV1ra3PZMIB5j2C0DIf0medw2rEtuxg8T0bJ6qkPOWoGY@lists.cip-project.org
X-Gm-Message-State: AOJu0YyU+MS0qIrvbBZR/ljgSaOVQ1BwFPvqcNS252Yx6zN/paFAnCdP
	irwkI+hjxr5jyW4Z2/w7Vs1paHfKB2q6xfbw0JLMVgeBK+/rT8o8XaYYYZ14FOJDpxSMXpM/B7a
	ptkBU
X-Gm-Gg: ASbGncuLJDCPibXN28+2JF1f4r2fsNKcFfZu3h9KkGJvLl5IkaP4uVP3WroG9hRbJC7
	q5TjUA2qo5CimOT+roYr6rRxC7RlAXXDCI/1+2w/3ljLii4OWQXSLvvmW70UIcHdz+mUNAXZNaq
	Y8QqqhR+rNIQqyWY4pKtgCHp9U7dzb3Ddd5QfsI4vcaTQO0+jP6V6xDdCMaNc68L06ahBAGrX5I
	ZKouKLOOItUAxJ0M7LpHqu2lNNlLg9quVto0VLOutQtLDIbxf5cyBG27pVWpEQujjCLIMWw6Ng5
	hdQ3pU0HA51oUKTrFNZHsqz5zkL5o7//eLiTCga4mLrJTKfJ5KdWjTUaNP9PcYDiMCqjUE5Q/43
	PV3MtVq16KzJgKZpIcJzABE5QLilVqmpZ25VNO6YsmpapH6e1CZmetbLjS2+RpBYw1egBMbAO8D
	DjkydmZvgkctgbJpJ4DpaBlfEd3Nwr639eYRXvhHVuED+kSfHIcik=
X-Google-Smtp-Source: AGHT+IFjolxwW+c+Gc97sEh7Bufv5rFLIy0NznUEFxZ4kllZph9BgGFu8Ablx/W1W+J3jzBsWvMAzg==
X-Received: by 2002:a5d:5d85:0:b0:429:b1e4:1f79 with SMTP id ffacd0b85a97d-42f79874eb2mr4295317f8f.58.1764872076401;
        Thu, 04 Dec 2025 10:14:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:35 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 15/18] clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
Date: Thu,  4 Dec 2025 20:14:12 +0200
Message-ID: <20251204181415.689009-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20862

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


