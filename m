Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA70CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:15 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10053.1762416729186264766
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=QeaYVEaT;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429bf011e6cso632811f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416727; x=1763021527; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uomtA41KrflAok6VVFVgZglgCeRAYhTF5C3cR2nkhIQ=;
        b=QeaYVEaTmvpsGBpvpDXy+YJInubgKwwclzfCFISGbf3JikygmvtUt9MBxqJH98jQXf
         PM5jg4mr9vKoCmSOgYUyM3omNdkZBuL2sGHl2svT2PYrJtb/am+odh6TR+FhgdQHn6wb
         J3kFou5f5iMKjEmPtRQHoiw3nx1E7/upFwForya9xAEGfZgeSjWNWoPM5i0MX0WKl5dY
         G4Fzp6AewEFjPPA8tjjw+In8hOUwdUWFGA63IbY6oagpSUDmLw/t4GZzTWtmXMUD09Wh
         wxVyXn10Dzvl0m3FY9ucf18msiQgaqcXyZw4emtMKBlqP7v3UZGCtGscdcGstIwdj01d
         yGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416727; x=1763021527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uomtA41KrflAok6VVFVgZglgCeRAYhTF5C3cR2nkhIQ=;
        b=jPW8ybwNG9+jLtdgn9cucobCAkVoeTmQMKvOQ21LbMFNsNY3iH928kV4z/d3JXTSHo
         ihLxVYoT2Jd5Kril5hDhMIA1Pa6lS19S8IGDs/HBI7RktGF6CV+5TORxcgBH5C+N3pSR
         8Vyq1HyhskLE/CmZOC8CPXSUoRtnWdJVId/9dqxcoUhGlJ07hVNGfSeZeyG4RpJblS04
         ODDhCABGsr4vjxBpH8dpOtmA3MbnDcjrLp20wr5uXHehEBY0/oD8l/dsT8AOH5fFUgW3
         Eik5nrkdu8bBHTOScxBtoqb4+jtQbYjOSDavVcMyEzAHIlBE+g8N5jWXlWFxrlc6vbCE
         M5zw==
X-Forwarded-Encrypted: i=1; AJvYcCUZl1cJFHrlDthTlI2+5eVPotKMbZ9NHKV+GVE3ul61wW0TzHE5C8mQz7yzakbeJ8fdfNuH4qd+@lists.cip-project.org
X-Gm-Message-State: AOJu0Yyi/oT3ZzKU/lgCVaQkuy/O7Khak2vBqxQEKhTTE2cGlkXgdgcv
	enZkxppXxRvSdbAtmRAmGtaU0qY65wxPX8DGbqYaJN4O0oJ/BTwK691h/+cNcodx5wI=
X-Gm-Gg: ASbGncuTROBQgUIQ9vEyvrrJncoSZ7S2ZYLBo2ZByCOQx4U58YXG3ha76leQgGDAanr
	cUPl9eoeRVy+3QSTUagNQt5QhZKpm9eiQ+o2FxmC3yG9dKhXsrsN2V+tZ8HVAJtsSfqjQG/owqA
	Hux/SVcaCHcWWNwHbPIuayThQW8FSt3NnmNirMf5V+yTbES/sqgJwfNd3nskUXxwdG96s57wRB1
	eXKMyC0YRYCJiLBCuI75LpTt3CGQ0Pnt2VfJNE7n8kxeUOubI1tNPu6RSn/XKkoUrwRJMbJVPAA
	Vit+uW6ldfzZgsBSmuw8gNtaxgcRtW/XZ4Go56moL0NT9gRaIELtivzYLOJr23E/EPWTafBk7XO
	wF+HB/1j1YuDLJu518gAT7jRIg+WaJJQtdGb0oDJTTz6iXpwwjzvnp+uO6Qltn7cR6bTcY/4ht0
	zfIfZjkwg9Bal8IjNnQSPa2J4L/71ZDg==
X-Google-Smtp-Source: AGHT+IFF7S6NBO+yz+GmuI0plLj0oGaNI9OiDyjtgYC15nvM/ckqx0HnfJPrcNymTk2d9xHuvTJ7ug==
X-Received: by 2002:a05:6000:210c:b0:429:8d0f:ebf with SMTP id ffacd0b85a97d-429e3309a80mr3731372f8f.42.1762416727585;
        Thu, 06 Nov 2025 00:12:07 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:06 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 23/23] clk: renesas: r9a07g04[34]: Use tabs instead of spaces
Date: Thu,  6 Nov 2025 10:11:32 +0200
Message-ID: <20251106081132.2574638-24-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20416

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 8933612860fd0087a0e27dfca01106a98ccc334a upstream.

Use tabs instead of spaces in the CRU clock descriptions to match the
formatting used in the rest of the clock definitions.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250806092129.621194-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 8 ++++----
 drivers/clk/renesas/r9a07g044-cpg.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index f050f8565916..33e9a1223c72 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -213,13 +213,13 @@ static const struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 	DEF_MOD("sdhi1_aclk",	R9A07G043_SDHI1_ACLK, R9A07G043_CLK_P1,
 				0x554, 7, MSTOP(BUS_PERI_COM, BIT(1))),
 #ifdef CONFIG_ARM64
-	DEF_MOD("cru_sysclk",   R9A07G043_CRU_SYSCLK, CLK_M2_DIV2,
+	DEF_MOD("cru_sysclk",	R9A07G043_CRU_SYSCLK, CLK_M2_DIV2,
 				0x564, 0, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-	DEF_MOD("cru_vclk",     R9A07G043_CRU_VCLK, R9A07G043_CLK_M2,
+	DEF_MOD("cru_vclk",	R9A07G043_CRU_VCLK, R9A07G043_CLK_M2,
 				0x564, 1, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-	DEF_MOD("cru_pclk",     R9A07G043_CRU_PCLK, R9A07G043_CLK_ZT,
+	DEF_MOD("cru_pclk",	R9A07G043_CRU_PCLK, R9A07G043_CLK_ZT,
 				0x564, 2, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-	DEF_MOD("cru_aclk",     R9A07G043_CRU_ACLK, R9A07G043_CLK_M0,
+	DEF_MOD("cru_aclk",	R9A07G043_CRU_ACLK, R9A07G043_CLK_M0,
 				0x564, 3, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 	DEF_COUPLED("lcdc_clk_a", R9A07G043_LCDC_CLK_A, R9A07G043_CLK_M0,
 				0x56c, 0, MSTOP(BUS_PERI_VIDEO, GENMASK(8, 7))),
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 5028b4ffdf5f..ae85c8ffb745 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -303,13 +303,13 @@ static const struct {
 					0x558, 1, 0),
 		DEF_MOD("gpu_ace_clk",	R9A07G044_GPU_ACE_CLK, R9A07G044_CLK_P1,
 					0x558, 2, 0),
-		DEF_MOD("cru_sysclk",   R9A07G044_CRU_SYSCLK, CLK_M2_DIV2,
+		DEF_MOD("cru_sysclk",	R9A07G044_CRU_SYSCLK, CLK_M2_DIV2,
 					0x564, 0, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-		DEF_MOD("cru_vclk",     R9A07G044_CRU_VCLK, R9A07G044_CLK_M2,
+		DEF_MOD("cru_vclk",	R9A07G044_CRU_VCLK, R9A07G044_CLK_M2,
 					0x564, 1, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-		DEF_MOD("cru_pclk",     R9A07G044_CRU_PCLK, R9A07G044_CLK_ZT,
+		DEF_MOD("cru_pclk",	R9A07G044_CRU_PCLK, R9A07G044_CLK_ZT,
 					0x564, 2, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-		DEF_MOD("cru_aclk",     R9A07G044_CRU_ACLK, R9A07G044_CLK_M0,
+		DEF_MOD("cru_aclk",	R9A07G044_CRU_ACLK, R9A07G044_CLK_M0,
 					0x564, 3, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 		DEF_MOD("dsi_pll_clk",	R9A07G044_MIPI_DSI_PLLCLK, R9A07G044_CLK_M1,
 					0x568, 0, MSTOP(BUS_PERI_VIDEO, GENMASK(6, 5))),
-- 
2.43.0


