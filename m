Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C658CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:34 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10021.1762416685137510508
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=D6FeNyBW;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so8050635e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416683; x=1763021483; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/UneUPWkf3tkIbCTIx6lmUz17X0EqMQCJU4eY0VnvA=;
        b=D6FeNyBWKt6j2ZbyqR5sWm53vKoLJx62Q2wo6KIutNeOXlnOAhMjY6K3MeNay2hvrv
         fUSuua+ClzgbPmMSzoMHiTTkzozfHKr4Hn9xpJDS72xhNyws5iijYoN9OBTqwsRr2AZf
         M7Blar1hHa6ABxrkN2bDtyat4nf2/YFX5C5o9/ZsO8k6uaslzaDvsONnK7LptklfcMcX
         0WHq8Dv3hvk/6/bMr09byt3FYEnJ6YvHQF0UfKj5seRm3xqEtQFQux3ikHXCz7aAJXJC
         FBcwTjtjX2ohEqROQ3UIz3nWTYkKJfAm03q3MTQl5sb5b85DHrZudRmO8kyrHhgP3X7r
         2PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416683; x=1763021483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/UneUPWkf3tkIbCTIx6lmUz17X0EqMQCJU4eY0VnvA=;
        b=uJNuPhj+ZvEL1rIQDJdl2m/Z7r31Z//TI+IXP65qyEW9bYqr53f7z+65VjUTZBPkl5
         MCMXn17IT/gbokeP2xZw5naDBBotsbL1WvDz95W7rGf3s3fC2s3LiGv5M6+178HLggEn
         nyf3K2Zw5wOoH3yOKm4UQbaVAtWPKHt1L6ZXRX8DbL50wWLk7/L2oHPKUWG0vLVoRf9w
         yXfQBU1LREdYMLiNbYP2NDhyFsN8OWDaTEdPCXopKs6/FoofNMDv8KFbemgaFtqMOaaD
         uQyzj17/oTVAZwIjBLdpaI6frsuqQCS6fnuGb8S4hP/NkeX6+rsFWVFtd57D1pmJgrOm
         PezA==
X-Forwarded-Encrypted: i=1; AJvYcCVyIkbXWGruW8Vzorl7sEcnMyCPVK9oTlhCnv8ZV+k4ezL9QiF+YefSPOOZwEswtLfBhlS3E1oa@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz5pYxE7r/ZboK4m58wFQuBn5nz/BoD7+isscNzFQkqPfxK/CSr
	2/2ZrVhcqo3LcfYzjRBndzCuVW/DOaJ9s+hMOQYgTXQPd6Re80qeemtpaL6gPxjHay4=
X-Gm-Gg: ASbGncsVBIhWs2QNGM51p0l6GSpHjJIadGtAU7jnVf9/onTcpwvlMngstFfN648yIDP
	ufICZKyABSuM90GfajCIsVrEU6kgVk0DJw0lrhOwVoXcdP2ixd8UadKUPq3txAjTI+smCzR2+qv
	2HBalkl7xuaXR7FXO2bzeWgDV2slIkAOdnyYCyk5OxIGbETccruyrCdjmcja6JuFWekUdDWfj4C
	DlAnSvlRxm8QO+j01YBmtbOv8mOF40ZojQiyM2iDYSc6ohbhTZmJ41aFoby5IEVFp5DYqXdvMh5
	vEjBblEcDdQpervrQ0qV4tN3lM+dxWlOJ/nnXBX1y3ldMvPihVFyzt3nBNVCKnPOLhH4Sy3xlUJ
	/B3O+eLfdj36tg5HTTZBq6CNuUNZzVCC+lFCeq3/CWXolIequqaCQuZnWXWUgGD7JFGedP+3vfv
	KmiRl1RDtzA2QL7l9vscjye6TV7h0dOp45IHGyLZBK
X-Google-Smtp-Source: AGHT+IFx/k7mfsBXrIohbBAgL3DznFCvQ9h3VEWB+mWaMLO8tuDQ2/gWKGdJ9sBPCFnkeLkNnRRQPw==
X-Received: by 2002:a05:600c:3e16:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-477620a59f0mr16988635e9.16.1762416682248;
        Thu, 06 Nov 2025 00:11:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:21 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 23/23] clk: renesas: r9a07g04[34]: Use tabs instead of spaces
Date: Thu,  6 Nov 2025 10:10:48 +0200
Message-ID: <20251106081048.2574345-24-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20392

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
index fdbc0635a869..0dd264877b9a 100644
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


