Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2203DD3901A
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:32 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31332.1768466184227329248
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Rm9qijoJ;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64ba9a00b5aso867015a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466183; x=1769070983; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud1VAdSqjBRjK3xQjU5W/iMYBVfbXxCj6cPXUWJ1ldk=;
        b=Rm9qijoJLKvtz2HARZBqlwEEQinEQUm0ATGTS6h6sjEVFmTVbBJE5nBWqKimh9Bdmx
         YcsV88ptirDoiq1MpAqyzVjVmF20EtC1UlwgGGrjFCVTPasyrc+y6XpgndW4OfjhoHGp
         q5H6Vpok7XXp4Cb1Bea84BDF9kUPx7C394AZofU7e1x9qcOzLpea2aRQ5A1cZLWxMe8o
         NDNkJdBtMTI4UNR0OXTSgKRvZGDfAgJusl8UHQX+BzB9CMguh3lmeSNBviJutfj7Prp7
         mm7FodNeyN69Zmv/YbClbqgWLNykxStzzYG7ZrgFDmS+pcM4GFQfcOUcmoFs+Zu8iw+p
         cKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466183; x=1769070983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ud1VAdSqjBRjK3xQjU5W/iMYBVfbXxCj6cPXUWJ1ldk=;
        b=g81XL4awNGBI4RvmKoCsxmjjc589NeYQzTvNteoUDmB6cs3gJQzrtpc2QgnaX6GCi/
         AZfTHXWD7xU+W77DZIKvHNJdjk+fhImDie1VajXH6t3Y6iiNoWq3UqATTtFGacnpWvjk
         uk44kwGMHrSE86/TmITFK4Z7LW+adC/YkbNn1l0qGlnTJFnKen1fVu0Y3+1RaJVuy9yw
         6Hr6przqQjFmShgI07TC8n63oPhMcU26JVZWgN+NGXK6OAPODjN9D9dAD8SgeBXjfgH4
         Fn49QlYP+xLISBnMkKG6HDbeP9T9advAtof5Spnj+/SMki8ywoPiBg1cm0XzJar8vFp8
         jakg==
X-Gm-Message-State: AOJu0Yyq6OBygp7spSLYc24o26nCef8s3oD+8VK+p8bM7TXL2Cxv0miA
	dDRzsD3U3NHeN+8TDhJajVhboScAx3oezIo5gcnVMOuXza1FBvFgbqRdM5vOQj6CRxE=
X-Gm-Gg: AY/fxX7QOPmqopy34q/H/Arr6fa9Q4JjsDO4wiuBgticcA8chdEeCTxukcV9d4WH63B
	ofnTnGSbudJvOwXFN4bf4sBaWm381ssNsuzsOaBfyex7awpbg9KwLXzZajHkrqJRoUccQ1FvBFb
	FK/tGn6d2NcK7NavWMtYrMs2vkHLLJ0mvwV46pDGqAubMlC7Ke2t4kDAfgmlrr8UVS0rxWdzDP8
	glauhQrqmji+xYNZZ/m6yf4jDzjefD4T/xFgTOOHtecZ1W+dQTk897NLrNcf8xiCs9O4tF3QAdK
	cC8Abwg5Ujc3v38+MDyU/TrRcBJGlcWyFmXbBRNBqZBsy9MNYlHti8dQ1EtUxD//OxByzWLCiMk
	NJHCPO+ceFA+AyOZYdCQXETROQhsKHz7+cVVjUR+wmQ1EFc1oNXMxjqH34oBJZTpThLifWytffA
	lpWowDeTjdcU/1MRZvcLUGVg4A6SJHPfSP+of0acB16kfQH6e0PZ2yjXJiRFWG1TfwIg==
X-Received: by 2002:a05:6402:3506:b0:643:e2d:1d6c with SMTP id 4fb4d7f45d1cf-653ec0fadd2mr4361491a12.4.1768466182595;
        Thu, 15 Jan 2026 00:36:22 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:22 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 09/19] clk: renesas: rzg2l: Move pointers after hw member
Date: Thu, 15 Jan 2026 10:35:53 +0200
Message-ID: <20260115083604.1064260-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21609

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a68ea80f85bbf7b69f69ef9e17e3e1be14d948c8 upstream.

Reorder the pointer members in struct mstp_clock so they appear immediately
after the hw member. This helps avoid potential padding and eliminates the
need for any calculations in the to_mod_clock() macro. As struct clk_hw
currently contains only pointers, placing it first also avoids padding.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250514090415.4098534-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index e4f2d974f38a..dd94eca21b19 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1190,19 +1190,19 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
  * struct mstp_clock - MSTP gating clock
  *
  * @hw: handle between common and hardware-specific interfaces
+ * @priv: CPG/MSTP private data
+ * @sibling: pointer to the other coupled clock
  * @off: register offset
  * @bit: ON/MON bit
  * @enabled: soft state of the clock, if it is coupled with another clock
- * @priv: CPG/MSTP private data
- * @sibling: pointer to the other coupled clock
  */
 struct mstp_clock {
 	struct clk_hw hw;
+	struct rzg2l_cpg_priv *priv;
+	struct mstp_clock *sibling;
 	u16 off;
 	u8 bit;
 	bool enabled;
-	struct rzg2l_cpg_priv *priv;
-	struct mstp_clock *sibling;
 };
 
 #define to_mod_clock(_hw) container_of(_hw, struct mstp_clock, hw)
-- 
2.43.0


