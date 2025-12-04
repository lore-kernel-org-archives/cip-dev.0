Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A959D29FA7
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:19 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50894.1764872175781792958
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lldZN8Pu;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2e445dbbso668965f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872174; x=1765476974; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLrKsUKq42gjyo4U+pzTkejs8sL+52pdjk2i6snybIo=;
        b=lldZN8Pu/0RCVX2/87Hs07XuuL8/knOwjVxzAHH1YOaItyq6fz7sZnQFD1HhlJ7f6x
         db/y98PFcOjmCxU8+nGgUxvoomkPdyo1gBTg+S6qH/gGGrOjJfVaKlE6zVuvJiqQjMjx
         J/uVK3JprczpvU3ucWNS1OyvCgjDMVh1aDXmc/EcNoFFnX+dPPbOcEQJrxdnOHFA1hym
         R3C8k5gL+vWGdIqDpcfAK8J5FGmtxVjmA60/bYv9/5DaM42tt1L/iYsOH799im67crPI
         9rmC22J6UrKZeTX5P+nHSDGZAH8VgG6UR/P63bsWz5plPg8zBtSTj2pJDE1gk8AjJ4dp
         Fk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872174; x=1765476974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLrKsUKq42gjyo4U+pzTkejs8sL+52pdjk2i6snybIo=;
        b=WjwelHSjiMj3Ia/4StDCvOZDUYxLAtw1YXk6xAegtin9mSFEHmm/XVUmGgxreNXqLX
         55MCt3M7e4kf/9q1uhi4zWZkjT+4jRBW8b0vxFo1IwM5qVVbsho6LLTunzU7uyQHsi6h
         DowU9U3cF5SamKPLlvFZAkmiqPfj0kvEzq0UlcQ9etNTre/qClIxggGZmWIsNWemK3B7
         6vWjJChd7zYLYKCi9vxwhJL4vxPZnUOw9pW75qodebyxPGYmQiBkcDtUP5kiVJz9pX4G
         FS++uYIj8AaZhdMdUKHBxLjodorWUH9FM6dpgsJO47mUfvh6C9AVsfJQgjiiuniqcNvy
         Zz7g==
X-Forwarded-Encrypted: i=1; AJvYcCUMfKrgkfhY+EGjVQDXNFyzVgADtOWWjYghzYX50ahFgmhzI5Bz5hSJ1fy9gF+u0Vi3HpwjrwhD@lists.cip-project.org
X-Gm-Message-State: AOJu0YzUTqBYK4ukdJLZi14vsljLdtuTF7/MJX/DQjHbuvT3dKFKoqzQ
	jxwFBStLhl9KIfwUlVvdu1Uqt9X9R0rIv3ATzRzfHwyS/K0107lqdE4sAqkzNPFJVkb8lvKRvf8
	3xGBg
X-Gm-Gg: ASbGncuCa+8Ooj1QrImHxv89VJ0rWfuQ4iuZ1Tn5YRKe5WInJ3uOO5jOSZNfh9ixX/l
	KjerpLAoqoZKdkQGmFkPzGVa4qW4BiN8ceYUNWjg5dpE2CJcBHM67tz/1PBk7V4s613abEK2Zk7
	Fv8P7ZRhNI79AgozT2hdzuCq1EWfBKz9h/+ZZGNCKi0StBYQsSFygAlaoO8nrEH4Z6PIhuOiVL0
	K+8x2oqYE76DCc6tN565NRMRcgLRAGHt3gAMmObX/HtRxRYhoATRbJeqF9yXiaPKvh+sDtRDd79
	vEW7x4LiOYbTzXIXmC4/yvR71i5AfKwzGqXaMS8t/2crZ2jmYe9GMoObbRk9F4CRBTr2A+eD2h4
	dVGBHGsAXhyLdAYpasfEuFC8Pdlx1mh71iR7W2+UIJFeR5n4kA/RA6DDWQ5lS0PQ2nlzOAUkk0J
	25q+SSNca4X/16Blzmphsv93JcK12ufW0HiqtgUz+m
X-Google-Smtp-Source: AGHT+IGlEWe2mMXNV90wnJSflJXz1wRtJ6TV/Afl26aNpLoZ/IdpO9MiQ+rlmXbq9Tih2hiyLctfTw==
X-Received: by 2002:a5d:588d:0:b0:429:c4bb:fbc4 with SMTP id ffacd0b85a97d-42f73185261mr7888091f8f.25.1764872174167;
        Thu, 04 Dec 2025 10:16:14 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:13 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 10/19] clk: renesas: rzg2l: Add macro to loop through module clocks
Date: Thu,  4 Dec 2025 20:15:51 +0200
Message-ID: <20251204181600.689203-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20896

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


