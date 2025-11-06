Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628E0CCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:55 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10115.1762416772302167272
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lAC9WSZO;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c7869704so544948f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416771; x=1763021571; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uomtA41KrflAok6VVFVgZglgCeRAYhTF5C3cR2nkhIQ=;
        b=lAC9WSZORlKR6JA5CtQLgSpLn8dcMcDYozZbvik+jmKiowQZdgscjblJ9TVc8xF8OP
         275FQjS/8Wlylj7FDk1bnx4HhUA3226KcwhJGMN2y77wPRLXLIrWvhmOHjqzqNUo2OIU
         4WJdNsVBIrGdI8GDwkzUBx/DHALryU5s8UxWa4MJ3CtFbQNRWVXObkzSn+C3PXN6B0Ij
         baQSjjYpMCft6bcDwcjqy+IqbXPSkTbiQygZ82ymvsvW2efxqcNHoItfyf+KSwSntbUe
         gSe0FEQv0J0LRFmn0YqEzwe6tRt7q7SaWjAEBuz0LYKDPJVOvGhFje9V8plxXxVi5Ei4
         lXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416771; x=1763021571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uomtA41KrflAok6VVFVgZglgCeRAYhTF5C3cR2nkhIQ=;
        b=tGfG1DBbOIUCjthSgLxRf3VhifvydXCxDiTVfgA6YNpBafZ55fHYWQA3snpYoY5Aty
         FvGoRGdh4JE+fbuu9MJfkel1kEy5o4RhPXeJaXB1nXMxsKrPDzLl0lxHF2LI3kRt/U8y
         HjotvIiQagGgxQpVNzAL6EFRS4VfIjc4YXcHEEdaG4/ar6D17mduiUSKXpPBmGvybqyy
         2bbtlPT+v/0BFbMhpuwGsXtxQFpOhhoDGsYOApR+cnWrHXlvCH0Yihvkv0aj7Io8ts9u
         6TzqKOQ8Yk6sCkWHr+9cK9TobHqeE9O+mVgNykdaPE+OHRrnLyTws/gZM0T4rpmXqN0z
         eC3w==
X-Forwarded-Encrypted: i=1; AJvYcCW6HMJnyyB6m4LCQlJnUEEJ8Y+y7edOXPbrck13AK9QVGPa+ao1xqN7vaJQ4zvfZlxweQhptSL2@lists.cip-project.org
X-Gm-Message-State: AOJu0YyTnaK6Mlciy5VnL6BRRZLirEEfXhTzxs5J97eFspRFgMH7jnv0
	Rz5cPEsR9YrOW7swwMakeE4vyN91v9ld3G5bj6b8snDAoS6vzWBGtYpwTGuTjIPXFpuy97aXJq6
	MB1sG/YE=
X-Gm-Gg: ASbGncu6xPvNORtVGa72KPLuV4K6cqYX2FNe6ZlFVijHQqCHaqOvijaSDWFsipC10NY
	mx80P5S8+9868Nt8aLWeaQwowYAubC9cLBDBQyDxijOEKEPawH6S06QPMNutJXBeKVOsyIVhIrj
	Hj+GxuP3ZNQX10h8w50j4u8exCWYdN6lgnpdRg2L2TxVLfXKPW21fKxwid6wdsEECAcWJ9kaXoD
	Y0jsagfZAHH3sBddSsJ6tP1ZQCa3glGAzq52F7rG/MFO2rDWQd46WjAvGN1zBmJGk0j6jkKhrCM
	Ddze0KBwVy7RpYevXEZgs6GvCUOCs9E1tvqRt1eRt6OohysrCmbqBKq8T8BMEIiO4Gw9nd1NcCw
	w86dlxu4+OCZFwxqF/fah/SmoUW8IgQDtX++QxfzV0VIfUWl0df6V0B0AvilOlZyRdgbhku2QBk
	9A2BpVmN0vu2EgRVwx7I+JSY/xK/wdjA==
X-Google-Smtp-Source: AGHT+IF+l48TtxT0QgQNVYixjuwc6qnJlLSfOPkm0g7yLNrOovHiVldVkX0JHOuOeK6AVK/QJqnLAA==
X-Received: by 2002:a5d:5f52:0:b0:428:4354:aa26 with SMTP id ffacd0b85a97d-429e3309c51mr5433281f8f.47.1762416770677;
        Thu, 06 Nov 2025 00:12:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 22/22] clk: renesas: r9a07g04[34]: Use tabs instead of spaces
Date: Thu,  6 Nov 2025 10:12:18 +0200
Message-ID: <20251106081218.2574950-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20439

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


