Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C9D33A29
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:21 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31301.1768466114975730793
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JGId6Z32;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8714a52072so114146366b.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466113; x=1769070913; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHedw59vWW2fCkZxYw3DrMVqC4naZoF8R6gOsbvanvY=;
        b=JGId6Z32Zbtz1o0S23Wwe9jaMec4B+3ad7Jh5Lbc5WxWupHO7r9QZozEQNz9Nyyrq4
         Fzfdnot7Xz2HM8G686o6AU7Qzyh1cD8IBQYECyCLngRdjualqBJgYRdm3/KeN22UZIqs
         1d+9iUw64+T9MGL4rQURJKDDbcj+YwK++z6rzHA6p3DA5fvldA0Rs91rE5Xae+4YYaNN
         fTVPV082Xk5y7W7ufeklcxAYyx8oknij0IEZ1zHl/jkjzjPWoHWX5ErP7I7N67BJrCyY
         NyMIjcX0CtTHxoYU6g0m4v9JakOzNLO051s88CTBFN0R2QJ6S0ZfTrEKnO1q6wQzW/M+
         xgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466113; x=1769070913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHedw59vWW2fCkZxYw3DrMVqC4naZoF8R6gOsbvanvY=;
        b=cZ+GwRILX5tRP17GJrRjEjAM2ohSWt5dpTcaAOkNj1Zocq/Mlj/JlAYDpuFBMcJsFw
         WJTQJY8nKP2/GTPApGD3a43cayV3T+7a4Js6sE8jacpUBsVpQka1p51rNtimDP3febUT
         0uFiewRPdBKp1nWQWkaBVdFI7+2t1YZK3IA187uoHjoigh+1JQJw1dr45ksbeGLvr5LN
         bekdyu0STJ6Jp7HgV2DO+hvMRXQPirbZB79SNUCwjQf5kMiMQiFfwAVni0EiUpbysmx9
         PcaNMyf3lZ/kRtHJYvd3IUD4L15jlfO95qsyj2DmYVGxIyXBwqJqbNu8lPRoH/Y799ht
         F3UA==
X-Gm-Message-State: AOJu0YztGySg1bpUFMCXvurUZ0ZFOPs1NJoRjt5T+28D6+OUe9X4xnKi
	xZ6Z1oSHMiV91mYf5PDzlgNin5kQSqLuJ27Yj0VIZ4jyG06XkIlOq6BWVcJb+KTaHFld+bZG9Vn
	Ndu91
X-Gm-Gg: AY/fxX7i6pDrq5SskOnaNDztew1oNtMriXTpLK+CmAqwbVH8VDZqH6agZhjnqS2sErb
	TIZfDiJZNX0f0r7JpGSR5r2u2Y4/WlPf9hCFbas06ykixzuMlDSCM3RDx7NFVTravtR0SCE2wyV
	DvXruQNSmC9zg53K1nOH9oR4maEC+fWOHd7VHEIQOiRiyBy/JCl08+P/5aLuOlKSilXrp0cpuag
	kwYvGUI/ark+Zg2RwdkVgX/hLrE2UM2JeAsYT2nuQHLcsjThg7P3IZvtqpEcvKDGNIbAaK3eB1U
	grhtFFfoq305IlC1Kg4bDXv6YjwMobmHJ0VOv24hm8ruxbdpFfx0Qz8V8Z3rdp7ovdPwVgW0mDj
	SEyzvi95W9xrbg4nk0JsQNDnu+wIww3z4HPyJVzJmgdakXT+yvZeoA4ZCqTLc7abQMWfZkTaNR3
	WGH5+9dsr2bGPAqJqhl9+7GbvyA8vANOhnH4XfGIxJ7YWJUQ1QGxHiss3Cn98/24lPYQ==
X-Received: by 2002:a17:907:9689:b0:b73:7fc8:a9c9 with SMTP id a640c23a62f3a-b876106f8e1mr453607166b.29.1768466113362;
        Thu, 15 Jan 2026 00:35:13 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:12 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 11/19] clk: renesas: rzg2l: Postpone updating priv->clks[]
Date: Thu, 15 Jan 2026 10:34:43 +0200
Message-ID: <20260115083451.1064048-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21591

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2f96afdffad4ef74e3c511207058c41c54a2d014 upstream.

Since the sibling data is filled after the priv->clks[] array entry is
populated, the first clock that is probed and has a sibling will
temporarily behave as its own sibling until its actual sibling is
populated. To avoid any issues, postpone updating priv->clks[] until after
the sibling is populated.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514090415.4098534-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by keeping code from v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 0f7f876b352a..49eb2c7867e5 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1401,9 +1401,6 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 	if (IS_ERR(clk))
 		goto fail;
 
-	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
-	priv->clks[id] = clk;
-
 	if (mod->is_coupled) {
 		struct mstp_clock *sibling;
 
@@ -1415,6 +1412,9 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 		}
 	}
 
+	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
+	priv->clks[id] = clk;
+
 	return;
 
 fail:
-- 
2.43.0


