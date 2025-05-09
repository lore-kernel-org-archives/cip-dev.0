Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6107AC3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:44 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.10370.1746783214387713961
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=j5Sb2W0W;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fbee322ddaso3666069a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783213; x=1747388013; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EymOFNuGE9smR5/OfxXVJAXxYlQyylW5h2/9vR231wM=;
        b=j5Sb2W0Wl+WqjfWfiQsP03jpLMddcg4W3hb5PpzaCwokRlsx9kSG+umblcYpehMzxO
         h0WImDY2yYJPIUcVzBEOMgRB1EG96OP0xyRrxETNo5X44FNiJDjAyv8mvBbdHuhA/0w/
         ZODqtSCvNHd37xoSkQXM0gJxNX3BSPnTzX/M6T3RnkfJNmnPhWcTDBQdLJWRtZtcCFW2
         1HapxUryA0EQ2jGxWdz6TlNEUmNpFFKtRpYGPOppLPNeO4C+LW+iY1sOLARqwjMKpeK8
         G2dpGnhc9RKj9/JMHJicNRS7yyTQ3ofpezPMbfi5aRO+nlHyrSEg+SztxkvCYRd/F/bo
         zpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783213; x=1747388013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EymOFNuGE9smR5/OfxXVJAXxYlQyylW5h2/9vR231wM=;
        b=cH6eX0hUxwBXfF3sRr7LrTfLebKr3IpP7xrPsG+5pPMwJ0DrjxaCplu8yM9YKPgLSb
         FHmZbXSEuiiDF+wfLSBQqIn/rw8UmmsLnBdApEfI4Rbeo0Q6C0BkF1AYMwnfQraJMopv
         qPAGOm3tfjsytgdgBttVKUpxprSXI61xEbe/SQLN2nbeGFUvZFZ8MjOsGm1PQFtwM0cP
         SlOTDHZ0IlpA1VXpHq/nxG6MBi3uft7nEsNTEuKn3sLCQg9Lw10CEVqlsvBEV7VVYmeW
         xxrsZhrTpZt9x6n4ikwT0TW0Uhohf09TBJ6bowbpLvfBwDbf/UkGsM42LCWIkzMcajTS
         9mZg==
X-Forwarded-Encrypted: i=1; AJvYcCUyxtGqvWaIXG0xUMbpdOdR/CLw5zJK2mpltDU/Dudbz2TLDmcndPJq/6b1eebq3cxD/T3M/Yo+@lists.cip-project.org
X-Gm-Message-State: AOJu0YwDFxPbNyi2Wx3q42HLpGKzEd/ixgZq9JB34+mezc8lJ+Q4KYpL
	yaEVEJUo3dg94H0EFGQmGCQ0u6PS5IOGUQ1JIg/fA+puMopeTUnEID3TFb7xq0Y=
X-Gm-Gg: ASbGncvgahJQ3pspBFkSOkGJzRsNtZrcgUHFLfW1K+mgFuAag8WX7wO37TSCNmea7vE
	zpOJkupZxaRUoJC8V7DCAt/uXh+iqFUg2zg25mEgSec7QhxEM97JtgjmwaRwc9ENKF15rAuBSdQ
	jGC2RcuHte1qcROEdrfW9D4YXIeNPK4mT7ZWtZBETvpphPOJ1GjgA5WoNvOh/ykX4OFUtUr0tJq
	4AyYqAP0je1TgUGygtn42jyUsi8UWRFeCQ5AkKb3B7OmEL1IrYGtDDf887wGUgq90kERe+VuDRW
	yuEk8+aVSHsiwcgB9HL+PQQl7b4NUoPXA/zQMEOaiHe1PZ0ZyuhsjgPYonKWt/X8WUR3fXU+J2O
	gXnxI
X-Google-Smtp-Source: AGHT+IHhU5M0Nwrxp0/c7qqpLavhR9VksW9aHmDuz+i5ORVfy4PRkSFD8j0OpM9vCxgxfPcHJoyyeg==
X-Received: by 2002:a05:6402:2813:b0:5fb:fb49:9cff with SMTP id 4fb4d7f45d1cf-5fca073143dmr2283406a12.7.1746783212822;
        Fri, 09 May 2025 02:33:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 10/34] clk: renesas: r9a08g045: Add clocks, resets and power domains support for SSI
Date: Fri,  9 May 2025 12:32:54 +0300
Message-ID: <20250509093318.4014916-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18827

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 97088b3a8e71ed87fbb25a34b222d869033d73df upstream.

Add SSI clocks, resets and power domains support for the SSI blocks
available on the Renesas RZ/G3S SoC.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241113133540.2005850-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by:
 - dropping USB clocks and resets
 - dropping the power domain instantiation]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index c14b34bfdb05..d01a784cbb10 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -208,6 +208,14 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("sdhi2_imclk2",		R9A08G045_SDHI2_IMCLK2, CLK_SD2_DIV4, 0x554, 9),
 	DEF_MOD("sdhi2_clk_hs",		R9A08G045_SDHI2_CLK_HS, R9A08G045_CLK_SD2, 0x554, 10),
 	DEF_MOD("sdhi2_aclk",		R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11),
+	DEF_MOD("ssi0_pclk2",		R9A08G045_SSI0_PCLK2, R9A08G045_CLK_P0, 0x570, 0),
+	DEF_MOD("ssi0_sfr",		R9A08G045_SSI0_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 1),
+	DEF_MOD("ssi1_pclk2",		R9A08G045_SSI1_PCLK2, R9A08G045_CLK_P0, 0x570, 2),
+	DEF_MOD("ssi1_sfr",		R9A08G045_SSI1_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 3),
+	DEF_MOD("ssi2_pclk2",		R9A08G045_SSI2_PCLK2, R9A08G045_CLK_P0, 0x570, 4),
+	DEF_MOD("ssi2_sfr",		R9A08G045_SSI2_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 5),
+	DEF_MOD("ssi3_pclk2",		R9A08G045_SSI3_PCLK2, R9A08G045_CLK_P0, 0x570, 6),
+	DEF_MOD("ssi3_sfr",		R9A08G045_SSI3_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 7),
 	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0),
 	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0),
 	DEF_MOD("eth0_refclk",		R9A08G045_ETH0_REFCLK, R9A08G045_CLK_HP, 0x57c, 8),
@@ -233,6 +241,10 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
 	DEF_RST(R9A08G045_SDHI2_IXRST, 0x854, 2),
+	DEF_RST(R9A08G045_SSI0_RST_M2_REG, 0x870, 0),
+	DEF_RST(R9A08G045_SSI1_RST_M2_REG, 0x870, 1),
+	DEF_RST(R9A08G045_SSI2_RST_M2_REG, 0x870, 2),
+	DEF_RST(R9A08G045_SSI3_RST_M2_REG, 0x870, 3),
 	DEF_RST(R9A08G045_ETH0_RST_HW_N, 0x87c, 0),
 	DEF_RST(R9A08G045_ETH1_RST_HW_N, 0x87c, 1),
 	DEF_RST(R9A08G045_I2C0_MRST, 0x880, 0),
-- 
2.43.0


