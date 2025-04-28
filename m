Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D45C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 05:01:54 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web10.40929.1745816457967377611
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 22:00:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fl/Equrq;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso741260566b.3
        for <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 22:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745816456; x=1746421256; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aY1TdiANamuB0ssSl0erN4wGWwJMCBvZa7NI6kilg+s=;
        b=fl/Equrqfj9z1UpW1x0eYO0PRfXZA0CU5N87KOU6eN23sl2Qj0sMjR4hUDcABLQFPU
         9cqmBNr9kRC6R4tvM9lXdRZ/yLiaglVvQvvKlh02rfTiQ9LJFDGQZRL/g4P1N054JtIv
         UtUud9q5KyeYh7KudFTZV455jG4oVgxUGh0r9YipI2aSI1NiSzn4EECja4OIV9Hpfn4G
         7McDb3aAULKi4NmIyLCsGoTTtFvyh9CM5E0VCX4S7m9OALxcB1f/a9wosoqDQs3IU3gU
         aDkZzpbnx83WqPJJZsPxaI7MioO1Pi37B8yMy30dLwPzXdhmb0kLXIG6K2bZcbGATNWb
         +Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745816456; x=1746421256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aY1TdiANamuB0ssSl0erN4wGWwJMCBvZa7NI6kilg+s=;
        b=Uzu6A4glT/jhkC3K/ovKzbjOyEzf7koE64tpd30fHJR17u93A/qbxgBDEKGhhdjSi5
         JTgaO7QUECjs4ygA26JRakHmmeVz2czBxvXObsbPOEHQqVz1rQdnL6kiMKwCu1f3eC99
         acDGKpoCdJn2NzJ1Gzbr4nV2Ff/KvbKUXEKK3TbN8bacxezl+T8xW80Wpl8LZIZWzn1v
         AO8ZgWl+Vw0Z1mcSG+Y55zuPlW5ErEz16R/4USp/it8qBn75q0MXBNc+ujOP99i/5NX4
         inTY7PZXi9l2DvhuvN1z1se4RFvDq5jK0p0nyi/TKPBy30XCq9F/c/4fYYWbS1HM6OWu
         iscw==
X-Forwarded-Encrypted: i=1; AJvYcCUzH0dkhMgizFenRYfGpeIVQdYlzndd4RRK6hzzqtqbojTl4uPzXojzP/zls+oyagkxTLGj0Eia@lists.cip-project.org
X-Gm-Message-State: AOJu0YwNQWm9SoMs6WDaaLtg6ZVlE5SUULQFDVxN4+qpHHFmsNSJdFbR
	O5L7eYOoumHUfNr1XHdAEJg87RdA9jjVKcFt+eKcroOpxKfEXJ0Iz8BbcQxIYvNHttYhPQDoKwM
	I
X-Gm-Gg: ASbGncuZBPAU+Qjzm7Rp+PXzdsAq/f+jKTRZJhXpEAuAvxjpBtTQLf7VTzjozIeaPAy
	4M5C3SKCaLoxArJB/1LjCc8aZO3xxQQNWzbg1A48sPiwTBDsCx9Ds6QV5BHYuNPliG59ZjbItew
	f9ONuI5dgZK+HJC/EQKTPpKYSpZE6A8U+xukiH4/dIwuJ3vfXc9n4o5nH3JgKDX5xqrxIoq4+/K
	qAEmTtnpXyWV+0f+MDK6PSRIr4VHUlXGbgOBMG0zLfBDR5groO7oWs+p2wsB9XtQLokCsWd00NJ
	n9t7cg8WzVk3Uqe9nAv4wPN/2ixXCWkiATwyB3IH0+TZ9fQznM+xnDshaONwao2WJ8820jSXCxH
	snPi8eA==
X-Google-Smtp-Source: AGHT+IEj6Ha/Mto489zXGAOY7vsexq0LtzvmpLL688WOKEDLksvmHt7Wro0zRUvIgvFWEMMXMQzWMw==
X-Received: by 2002:a17:907:3e03:b0:ace:3a27:9413 with SMTP id a640c23a62f3a-ace739dd0b1mr826495566b.11.1745816456087;
        Sun, 27 Apr 2025 22:00:56 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7011fc361sm5176645a12.16.2025.04.27.22.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 22:00:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 1/3] clk: renesas: r9a08g045: Add DMA clocks and resets
Date: Mon, 28 Apr 2025 08:00:49 +0300
Message-ID: <20250428050051.3081705-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 05:01:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18670

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 6f5c16b74b8d2eacc98f4e0d1611a129aa6506bd upstream.

Add the missing DMA clock and resets.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240711123405.2966302-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 55e7d42dc472..b22bc5e972a4 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -193,6 +193,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("ia55_pclk",		R9A08G045_IA55_PCLK, R9A08G045_CLK_P2, 0x518, 0),
 	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
 	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
+	DEF_MOD("dmac_pclk",		R9A08G045_DMAC_PCLK, CLK_P3_DIV2, 0x52c, 1),
 	DEF_MOD("wdt0_pclk",		R9A08G045_WDT0_PCLK, R9A08G045_CLK_P0, 0x548, 0),
 	DEF_MOD("wdt0_clk",		R9A08G045_WDT0_CLK, R9A08G045_OSCCLK, 0x548, 1),
 	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
@@ -222,6 +223,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A08G045_GIC600_DBG_GICRESET_N, 0x814, 1),
 	DEF_RST(R9A08G045_IA55_RESETN, 0x818, 0),
+	DEF_RST(R9A08G045_DMAC_ARESETN, 0x82c, 0),
+	DEF_RST(R9A08G045_DMAC_RST_ASYNC, 0x82c, 1),
 	DEF_RST(R9A08G045_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
-- 
2.43.0


