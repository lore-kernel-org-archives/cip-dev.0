Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0DC04FFE
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:00 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web10.18433.1713526733955425391
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:38:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MnCGu/Yi;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so2446138a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526732; x=1714131532; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj437jskGkSLGzlrRwaD8VVZiwYXk8zUEwBscyRDn4o=;
        b=MnCGu/Yi8XKZ69RFJ0sbcUBTkmu+At/bVpMeXGgZEiE8AajmM/qHSViqyhiKq+gHiI
         jkFfBZo1CQ6/BVkoOzON5ovIyyUcWWFmYB/Ha52ox+x2prXp+aFzNBO7wV2r+ZWW1GRB
         SLUjPQgVX3SeBKhJ7IlXBLphVsEu11RE9bQ2A3j8ngOcVP6i6nYBpBCY9u2UDo24LU0h
         BqEdJQ0fM20/fP2jnJkr6ytYuJ3V1vDfbsypjgusHFPVgSU1Zxd/ReyobtqlxJfsFesq
         3lVjCZsRUu9mW1lCr1kTOWIfUIqGhOGVVdSFVz73IprCfYOjcLzttB0QMIT2R0mYp6Rx
         4a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526732; x=1714131532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fj437jskGkSLGzlrRwaD8VVZiwYXk8zUEwBscyRDn4o=;
        b=Px1xroFYYnM2RIBKeZ0I9UuCcX86aca8HM1YJ+5/6QBdoi7O5lvTLuPG28rzId92OP
         hZdDa8fZcaudjiedbzW9+zwRI7lKHMy6d+W7Ehb0qmoLSeHdthDbfaOGAwwp99h6ZA1r
         a+2yTrgVYWLS8p6xiIkGhEpoknSlzng3Gi0BALpxQ3ROOZYGZyq3Cl3b/HWvfk6BIkOg
         anpUcOgl6RTStKkjFEV02DBFVaB8MeFEtzo7Eqg6kX3oAhog71lc3BusBDEhRBUphcAZ
         YuqSfQ02jDMrmhP32bpXjSpn2lF+sWLlTrp+BLuBf6oRomZv9YFJFtFOscY+tTR9O9bv
         cwKQ==
X-Gm-Message-State: AOJu0Yz0FdhVBE/zB3NwjWItzZM3h7oA1vNxHml5qAEOY44JmGCwcBNK
	/ugTIsry1YHOPuPKmxNDQ/RrUax3RZxnqlEAeaY0xy9O3Dme8h7KGjIntN3cCjM=
X-Google-Smtp-Source: AGHT+IH6Jcot6TWt7470Jp1LH+RMC3CTJFVqE6NAMABpWLMtzwnhXlFORjGspXnpt0/oUgLj2fXQlA==
X-Received: by 2002:a50:f698:0:b0:568:cdf3:5cb2 with SMTP id d24-20020a50f698000000b00568cdf35cb2mr1838622edn.30.1713526732429;
        Fri, 19 Apr 2024 04:38:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:51 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 05/44] clk: renesas: rzg2l: Use u32 for flag and mux_flags
Date: Fri, 19 Apr 2024 14:38:03 +0300
Message-Id: <20240419113842.3675543-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15656

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 897a3e34d6e73d2386715d5c44c57992f2c0eada upstream.

flag and mux_flags are intended to keep bit masks.  Use u32 type for it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-15-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 91e9c2569f80..097fd8f61680 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -92,8 +92,8 @@ struct cpg_core_clk {
 	unsigned int conf;
 	const struct clk_div_table *dtable;
 	const char * const *parent_names;
-	int flag;
-	int mux_flags;
+	u32 flag;
+	u32 mux_flags;
 	int num_parents;
 };
 
-- 
2.39.2


