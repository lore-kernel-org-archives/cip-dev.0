Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F153CCFA1B
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:14 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10066.1762416668683752630
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=FP9c9hrI;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4711810948aso4194555e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416667; x=1763021467; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLrKsUKq42gjyo4U+pzTkejs8sL+52pdjk2i6snybIo=;
        b=FP9c9hrIs6xJj/zDFmqRSiqvJg2f1Nn42dqiWCC4z1n9vwKPIhmxynuLwrwA6vxTvr
         ZVNIL8gTi8j9Nq4tpIvbU1TfKlkUfC1wKmS/FLP9OXPj+2fnrxQF6z2ll/hE1swBEgUR
         T2So/li+ETyJMg4jLpwDkGqErp7Hbydx5RUeScKA1/iHjzmBxSayA6VQe8PPAv5VXAqh
         tR+xLb/WTVbOOY1hVVn63VwZjsuAv89wL20moUPhA4uf4YO9JErGKMtlGqV2Qs2QkC6T
         1WgKbaj+YO7lMiZArE/NeHtQpHemapBXka0YW3WItTPONzkeVGxUIfm/4IxnXwKyxON/
         yyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416667; x=1763021467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLrKsUKq42gjyo4U+pzTkejs8sL+52pdjk2i6snybIo=;
        b=G3KEQ98FwOz2Kn+VIcncbxutQu87Q8/6V1V7QzWZl1ivQyoWJ5rMbxnofkvE7pz1fe
         1TgNMr4NdSZDk7OnIiJVVCfARIRr2EqylrFJNuoqGHXexg432KC4YdEbKSG50MLCo9KH
         xATHTHntcO0026kiJNiEo3k0rnzLpFJcpsCajmQC9tfDjnxb+HQ1CSYPozLWLu/Esbk/
         M5NI8kGyy7qWz95bTjW6a3Udex7q3sUrRBYnJomiVHzmao1NIpmFnuXydSgINwZq7wyD
         2oyMn86zY4n1SwQqCz/8Id3lGL5TBJ997P0hSRH83K/T4WV5Ytsew9tC2lNdk53sRYJf
         J++A==
X-Forwarded-Encrypted: i=1; AJvYcCWC7CMbNf9weBQWXQ6JdPetrAG/qoB0PnOavE/arYQl4x7nMbm5pfOd8KGH0SYFB/nOZee5JzxV@lists.cip-project.org
X-Gm-Message-State: AOJu0YytL1iWDx7QYDtj9OLCH2XZyl3S0kPTmttXNPArGxijSGMNEprQ
	EX/PIFJx662XiPQ9BZ6qZPoYtRLonmZktq+X9K8GVt5tUOuWFwzTI95K1pqRG5RQBu+WVUsJ4Tz
	/v0UPIQ0=
X-Gm-Gg: ASbGnctzJz+vAYuz4Zxjf/99Xb8JT83M8DykG29l9sI1d2KD3NXB5FJnElBUTU0DiNz
	BeLupcaj3I+/kO+vMfdkRHHyC0RcWZ6Cq9z9Ca9zaH4ZEFPal2eso8MhZvih1Ntn19gPjODQiIS
	nX501qc2xxGkxDjS9GHKd57O4jznAExJBkKiDBg+x+1GTMqzMHtoU7/YZVVKEzxARtCxP45uVeq
	cS5SHHHizJ7IGxV+/E4O6KqbwSGKhLWOjBprd+ojFWOwRPrekpAEsnZETl1hvUm3j399kATqmF4
	xa0lkIwMC6IlBHPQ0+3DKxvdvjX+FypkMLGhpzLeeKLttdl3JTWn22G/TDepo5eHawWAZzR186G
	PyDeRXICUIC2otKNl6eB87KIKEicYIOedkZnnEp77LuNBESg11/MVuLT320+E89V8Eumr1HVlSs
	tb2EuadFViTy/rovHpCSh+rsCmnVSiQQ==
X-Google-Smtp-Source: AGHT+IHesiP5Vj3+i6ktzhveql9kWPA7ONmT1G+TTQU/ra3dZq6UEehEyAYRaTOl6ava5vXJWOeMFw==
X-Received: by 2002:a05:600c:4e47:b0:477:5a30:1c21 with SMTP id 5b1f17b1804b1-4775ce230d6mr59734505e9.36.1762416667066;
        Thu, 06 Nov 2025 00:11:07 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:06 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 13/23] clk: renesas: rzg2l: Add macro to loop through module clocks
Date: Thu,  6 Nov 2025 10:10:38 +0200
Message-ID: <20251106081048.2574345-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20382

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 3fd4a8bb4b63b886a7a11444f85000ea90d2617f upstream.

Add a macro to iterate over the module clocks array. This will be useful
in the upcoming commits that move MSTOP support into the clock
enable/disable APIs.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250527112403.1254122-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index dd94eca21b19..fa5cfce2e9a1 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1207,6 +1207,13 @@ struct mstp_clock {
 
 #define to_mod_clock(_hw) container_of(_hw, struct mstp_clock, hw)
 
+#define for_each_mod_clock(mod_clock, hw, priv) \
+	for (unsigned int i = 0; (priv) && i < (priv)->num_mod_clks; i++) \
+		if ((priv)->clks[(priv)->num_core_clks + i] == ERR_PTR(-ENOENT)) \
+			continue; \
+		else if (((hw) = __clk_get_hw((priv)->clks[(priv)->num_core_clks + i])) && \
+			 ((mod_clock) = to_mod_clock(hw)))
+
 static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 {
 	struct mstp_clock *clock = to_mod_clock(hw);
@@ -1319,17 +1326,10 @@ static struct mstp_clock
 *rzg2l_mod_clock_get_sibling(struct mstp_clock *clock,
 			     struct rzg2l_cpg_priv *priv)
 {
+	struct mstp_clock *clk;
 	struct clk_hw *hw;
-	unsigned int i;
-
-	for (i = 0; i < priv->num_mod_clks; i++) {
-		struct mstp_clock *clk;
-
-		if (priv->clks[priv->num_core_clks + i] == ERR_PTR(-ENOENT))
-			continue;
 
-		hw = __clk_get_hw(priv->clks[priv->num_core_clks + i]);
-		clk = to_mod_clock(hw);
+	for_each_mod_clock(clk, hw, priv) {
 		if (clock->off == clk->off && clock->bit == clk->bit)
 			return clk;
 	}
-- 
2.43.0


