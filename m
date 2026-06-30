Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63862C43458
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:07 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19080.1782820137205128654
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=NyTYGhCP;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4926f8e02e8so27085175e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820135; x=1783424935; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dS3xPT1Zxrhe1RQOWxc/CUOuQaci+WoyivkI/cIiW7k=;
        b=NyTYGhCPFKzS9OgRaYZanA4zqGKApY1dXvrZ0aSfDKUgP8An80r5P7olnxltNT56db
         6rdVNkzFsMkjJZqpqHpmKAJQdRr58If1mvCkd9OnBsvN5+UIHnGoS5yDjzF4FrmNGkls
         aciNZXxB6Dt3yp7XGwCzJTA7sacEvKbCyByL+cjqgXbbdz1ryya4fy3dcfBv9A3KHrd+
         CubheD5mVfINAvsBc8MbBRShJp2cjS5Nd0OX3SzR6u0QkY8aMkMcWidUPGJ58oRx+f3B
         YlSC6UOwmOoj3+QwKQNCr27Vw11ZfJkkgPNutPojX1/uqI3vyrjPAwXrNAsl3u+ptf9s
         iARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820135; x=1783424935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dS3xPT1Zxrhe1RQOWxc/CUOuQaci+WoyivkI/cIiW7k=;
        b=VN4Qxo9iVUl3R8H0JirZaZIgzjXm+wQ7zF95xKP/8WqnXFBhp9a9o1VOpRK2ZxkKFK
         0QM4rXlgKG752tqYn/f0jrI9zWlmn+1WwStm4tRMNfe8DAcBXLVNSx3ddar5oGfANNGD
         U3JI5yLYfOZvXgn0RIW3AbZlLMXoZnsAC8UKqAd7CiYHT30+TGZ2DvvR4tCNyZJSBsAR
         /hk0c6nEORH8X+CvFIDBfsJJ8QwltSRY0O8w/EQSi0tEXOJU4HlK2PQ9VKrEAkJHXquF
         LgocvrdLtQwY62AO7Rr3aeno2iHw/B7pcTk+wlffqth7yZq+6nuzGdHcF0fSNzFyPJkz
         03Lg==
X-Gm-Message-State: AOJu0YxNd4cqAP82nTBKmUnWphyXD3QVnX2kH0boyAS6xcOAkWl4JXOQ
	RG+3g/i/LGowHjIFkIW37OMTlX+XZuB8a3SzZTZetJ9B4n0d/DXA1Oq8lh/D605a
X-Gm-Gg: AfdE7cmouxZslje7cfvBuWwnHwHAfGgLBzbUTL0mGfsqGQ35fbTDMdeohjHm8RjPhYN
	t/uXolWp769S+S2fu7YPHcbf9GCfgo2e09YlJPZ93+I4o+67N1QK7VAlmP7RswtufXy+DXkcWwL
	MVyMReX9UdZmrWLPZMcE81ukGRKFwaLNm6aunUlvZfyo4CZ1kNK6JXz8Orb+2JeGtfxgVgNhyQT
	wi4LMTZta2x6XNZoancdf981QuNQUHqAUbCmX9178gFNjJa+bX+KTdSsBFf7yQ6UcnveaHRJ8WS
	12JDUN79zpKk+Dzb2488IOQFI/7E7PJy/Jdf5g7/4kDRxZ/+L1NLUcFIF8b7kwsAzdOkqNvALHk
	pHR2Klv8p3XEP9Qdx7GbKynH4viTUvar7uYijHpXh/ggtr4iT7gAzIoyzQ0v8NJ4m6R84f6Dg1d
	li1PeK6qETrVsaKyYyzQ0X82L27K8VX33qr/wxB8XBOnq8vUQ+
X-Received: by 2002:a05:600c:548c:b0:492:5551:19c6 with SMTP id 5b1f17b1804b1-493bda3980fmr4278165e9.7.1782820135319;
        Tue, 30 Jun 2026 04:48:55 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:55 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 25/39] clk: renesas: r9a08g046: Add GPIO clocks/resets
Date: Tue, 30 Jun 2026 12:47:44 +0100
Message-ID: <20260630114813.92739-26-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23349

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit da000c4d5f1de7e83778cc0fb3974d2a9af2933c ]

Add GPIO clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260330132349.149391-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g046-cpg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g046-cpg.c b/drivers/clk/renesas/r9a08g046-cpg.c
index 578a8004feeb..dc4108325d9d 100644
--- a/drivers/clk/renesas/r9a08g046-cpg.c
+++ b/drivers/clk/renesas/r9a08g046-cpg.c
@@ -174,6 +174,7 @@ static const struct cpg_core_clk r9a08g046_core_clks[] __initconst = {
 	DEF_FIXED("ETHRM1", R9A08G046_CLK_ETHRM1, CLK_SEL_ETH1_RM, 1, 1),
 	DEF_FIXED("ETHTX12", R9A08G046_CLK_ETHTX12, CLK_SEL_ETH1_TX, 1, 1),
 	DEF_FIXED("ETHRX12", R9A08G046_CLK_ETHRX12, CLK_SEL_ETH1_RX, 1, 1),
+	DEF_FIXED("OSCCLK", R9A08G046_OSCCLK, CLK_EXTAL, 1, 1),
 };
 
 static const struct rzg2l_mod_clk r9a08g046_mod_clks[] = {
@@ -229,6 +230,8 @@ static const struct rzg2l_mod_clk r9a08g046_mod_clks[] = {
 					MSTOP(BUS_PERI_COM, BIT(3))),
 	DEF_MOD("scif0_clk_pck",	R9A08G046_SCIF0_CLK_PCK, R9A08G046_CLK_P0, 0x584, 0,
 					MSTOP(BUS_MCPU2, BIT(1))),
+	DEF_MOD("gpio_hclk",		R9A08G046_GPIO_HCLK, R9A08G046_OSCCLK, 0x598, 0,
+					MSTOP(BUS_PERI_CPU, BIT(6))),
 };
 
 static const struct rzg2l_reset r9a08g046_resets[] = {
@@ -240,6 +243,9 @@ static const struct rzg2l_reset r9a08g046_resets[] = {
 	DEF_RST(R9A08G046_ETH0_ARESET_N, 0x87c, 0),
 	DEF_RST(R9A08G046_ETH1_ARESET_N, 0x87c, 1),
 	DEF_RST(R9A08G046_SCIF0_RST_SYSTEM_N, 0x884, 0),
+	DEF_RST(R9A08G046_GPIO_RSTN, 0x898, 0),
+	DEF_RST(R9A08G046_GPIO_PORT_RESETN, 0x898, 1),
+	DEF_RST(R9A08G046_GPIO_SPARE_RESETN, 0x898, 2),
 };
 
 static const unsigned int r9a08g046_crit_mod_clks[] __initconst = {
-- 
2.43.0


