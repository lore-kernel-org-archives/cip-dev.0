Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B45DC0218C
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:30 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.41870.1737546689202168806
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ACFSStB5;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f796586so74257925e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546687; x=1738151487; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwTM5alHxiV99WoSjSGaeY10FKz85c0VVLpWvkRdO+c=;
        b=ACFSStB5qpSqbO2esRfoLeDBvE8GXMrHSxgH5MAg97l/PsD8Q6eNH0e2zO1xGQMaMC
         ID2ilWKOJL8u1W0yHwhWALapxKjAn+BrtIN3qw4dZ2v6IHaM7BcPNy0u6jhvb5U4CsWL
         gSZx/7fLQi4Ag4FzBon7onLL2pUH31pBvYDBKCZ/QYZ8GTVbZ4IWmfEMVLZ7WjW5OAQe
         HcfMINOC/IHeHMnr7D4rS7Xlbzr1Qv1PM5Ci5TWSWkHUFAjEqeo/DyVDici6FIq3Vwg5
         Hnq3AUD6VN5ZrFD34UGu7598Rmbw/znVO5cddUcDaaZiCGvnpzBQ88KvZoKjeLtWeT3q
         sFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546687; x=1738151487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwTM5alHxiV99WoSjSGaeY10FKz85c0VVLpWvkRdO+c=;
        b=n8Hhnqt9RB24M8i7sL6O2KZyL/FRK8K5oZsWXmaXPoHw9wXt4my6aEJwBR1MuL9RUX
         8Lp9+XpYLzcFY/1pDvlZqLYpjnGsxPEQ6umchp4ZBw5dE7AFVmaqWNbsqi6962wiZA7A
         0+5SMNWEvo/dxkqdmuVP1/g2bktshc9jp2a9UPhGn/3dkqJujvjqIYZ2QdNv8EbyKYRD
         T4/mHDMXddOSacGQh/LlqGKitbM/960jPD6m/E3ZxRuSMPVeLRZ2bWSiWPHtJa9140Xl
         BCifOIeIjOmYtLFLYDVlMKh4U1Fvk5qqUbhbWkYbjUY2P51diQL1CpT/VMvCziRA41Bd
         pMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIefPr57ovYuCv/y69Ft6wHWJgVX3tGq4kgwwTnCCF2L8h6W3RIC1y42RnJ62Z9o3cFYKbZJJm@lists.cip-project.org
X-Gm-Message-State: AOJu0YxNrILus+GULdwSx16mErdu1lIR0p/LXvQfvg+sItXrTN2gqZQO
	UuUSu7rNUAu77mgOTbmm1QlFCNKYrjZJ/OeU1oXzZHF9Yh4cUKIRUxr2g0bCBZE=
X-Gm-Gg: ASbGnctdAew84bK3IJe8qUjbCauYaV25ZQytQESjlCYqamJSTdNUQsYWu3T8gphW4B1
	3F6RboWJFZpkV1bh1dP1mfnckHJgaLK5KhMa1HjqHyqZ9ZS/wK2OaBnYYuTPXJBKwKwG+RrBfi/
	pCvwci/7GhQ0dFNIJRmc5zIOg1hKjR3B/pEoPzBneCPXT5z731HDfUK7I2Mq3K9LtjaLdA4+W3P
	PT7w0mg/QV81P247lXfTblG1c72OsM8LwB2BoxfktgGT577UHG/WyAn6pIXV51Q3pRlB05jOR/2
	MBs+2/H0AVk2xgLP9NSuJNs=
X-Google-Smtp-Source: AGHT+IFvGTjB5t6YhqaiNASrv/TyPGTmkW+RqWcSv3LTGooteWpDMdUuziPiFpxWVC8P/BGYd+Qd6Q==
X-Received: by 2002:a05:600c:4ed4:b0:434:f586:7520 with SMTP id 5b1f17b1804b1-438913c5d53mr196441565e9.6.1737546687572;
        Wed, 22 Jan 2025 03:51:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:27 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 04/14] clk: renesas: r9a08g045: Add clock, reset and power domain support for the VBATTB IP
Date: Wed, 22 Jan 2025 13:51:09 +0200
Message-ID: <20250122115120.2885015-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17567

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c8bd9bd6446fa034a1877b553bf118606b37c025 upstream.

The Renesas RZ/G3S SoC has an IP named Battery Backup Function (VBATTB)
that generates the RTC clock. Add clock, reset and power domain support
for it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240614071932.1014067-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: dropped PM domain part as it is not ready yet]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index c3e6da2de197..55e7d42dc472 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -215,6 +215,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("eth1_refclk",		R9A08G045_ETH1_REFCLK, R9A08G045_CLK_HP, 0x57c, 9),
 	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
+	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
 static const struct rzg2l_reset r9a08g045_resets[] = {
@@ -231,6 +232,7 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
+	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
 static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
@@ -238,6 +240,7 @@ static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G045_IA55_PCLK,
 	MOD_CLK_BASE + R9A08G045_IA55_CLK,
 	MOD_CLK_BASE + R9A08G045_DMAC_ACLK,
+	MOD_CLK_BASE + R9A08G045_VBAT_BCLK,
 };
 
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
-- 
2.43.0


