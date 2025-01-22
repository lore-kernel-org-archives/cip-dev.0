Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F56C02182
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:50 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.41908.1737546763983940664
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=miittreu;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43618283d48so48739395e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546762; x=1738151562; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwTM5alHxiV99WoSjSGaeY10FKz85c0VVLpWvkRdO+c=;
        b=miittreuBiB8Rbjza+qx4puAM/Nod/2NfU1iVShW8wsQ/kKvAkgkwKicSlZYOBZg3s
         xM3kkG+e/Z3VymKHONC3guEPphfMbXwLVXuxYZwCMAzcBhrV7oksX9cxABjEc4TiuneB
         8w/cZB8Fa1s+f7AiNpLR7maoBjGPLIHFW1cgNLyEEI2w8THkKQiivPCzkCKXFtDwtOOj
         KlmYFuMXLySNciRJiIEUwSdEhTcqcQrNn+NuR2z7Ib58GHKLdgdyleZJ/gTOWDXD8i4n
         bqtZG67q9wmH84Vz7nVAf94FLgz+c6YfBma3LgXEO4/s9btxhMtJcSe20NXx+Erm0hIg
         GZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546762; x=1738151562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwTM5alHxiV99WoSjSGaeY10FKz85c0VVLpWvkRdO+c=;
        b=deXiiqufU6Ooa6rdXED0J19o/haYvXOhHK07B29RSaVL5s9X1oLY/TAyiYXIOyfi7z
         3tSoCieXnpULFdIHFsPW4ZQxOA4n0JMABihPpOAV7KcA3+YdzKXtI7C7igLV/+xBFgL4
         7YJPt7s6ZM7bc1pvBoN3aYh4ZDzbhrh1nPI+He2P0yO+2GMJf/pK4QoBNUoOuKmfSlTE
         HnAZjBaODkPOIWDfg7jjEp4TWV+q5fO/79sThw+7kSKFIORF4BVCy4ZSnrPzDR0LLNqf
         MY2hVRg3AYdI/dDnIFLYQJhGaEJCr/xbSXRpIcdeG7pseBWz4hSorL3CVJ+BCnH354OR
         v1+g==
X-Forwarded-Encrypted: i=1; AJvYcCX2f099lenJ08lD9Wg4bYovJ/LnLXjaVL1U0uVFmUSgg7CjI6jQr2q4ysZz1m8VdemQDWbvJndM@lists.cip-project.org
X-Gm-Message-State: AOJu0YxrlRFI277H+2wbHIjwCPiD2VGlI8Dz+T+pq0JZn/KDGnOjydFq
	0jzpA7IKo/+RiVLNqWDyjD7bodp64SWyJ4yEUIaANAUe2maQwQ9Mzr1kVstkrNk=
X-Gm-Gg: ASbGnctsM09D5O2htcKkb26zuRrkexc9zI5Ugpn1WOiJ2jrkk1iAIw98mvcMtSA+65q
	jhOa4bzH8UU/nUbDmQETEv1IRPt041z5AblcIm7c08/+SUhTeoEFWo275ygDbbyWFtrmdEkYBcY
	GxwwdJeLcPeq5sYS/riNSYGknVguTX/uFOG8/Hh1uzJk/npBmD8UzU9zJZxPYJfN3gXrl569Aoo
	vFTJmpK3AwD+Ch4JeJi/NdJjnAXrcRgItRjCemvP3SuB8g9c00bXmb0dJYxA2uIXUMuvAn1u41E
	zMJ7xHYNd3DGN18q0mQe6Df3eKjlbre1UQ==
X-Google-Smtp-Source: AGHT+IFQw1B3FMTk89EKIQQ4DccLG9ixjUvgmdHYMGwmpLikJnjH1obpxshiykQnsUWh8ljonzHuKg==
X-Received: by 2002:a05:600c:3593:b0:431:55c1:f440 with SMTP id 5b1f17b1804b1-4389144eea8mr232209425e9.30.1737546762472;
        Wed, 22 Jan 2025 03:52:42 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 08/16] clk: renesas: r9a08g045: Add clock, reset and power domain support for the VBATTB IP
Date: Wed, 22 Jan 2025 13:52:22 +0200
Message-ID: <20250122115230.2885344-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:52:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17586

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


