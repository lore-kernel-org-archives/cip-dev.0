Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CCDD29F8C
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:58 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50534.1764872152002909591
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=L1h+mybj;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso17056915e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872150; x=1765476950; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vjtHCamXnrTfmAG6WUWxPIuR+Ldn6tYmldQMkojAWM=;
        b=L1h+mybjYHDncCSne+4afOGTDIZfdndVm2Q0y3hw9qbO+uHYcAMGQEHHVtPjvVzNcn
         y3XWPKFd52qDprIiP7I9mAwUdDFkzzUvfYQylYdxlh+nkdNbtLcpbhHlrYzSC1xI8KPW
         T22AMWfe4QXYCPBQatmCR8xXQnftVHid89fkgp+GQv1S91izGAUxwNVoZ5q7/wp9blpj
         VqmFDHT8cSCWzB8fowWUJNJkPqCKi9EOgO305cHpeARFhw907FsFpL9nc3LRU8UOP4gl
         NpjWlRFEORnTmWOa6908pF8RJY1hmSkLY+TauZVDTKuoWEsM7xuqArlGRniHTzwPSKuT
         LH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872150; x=1765476950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vjtHCamXnrTfmAG6WUWxPIuR+Ldn6tYmldQMkojAWM=;
        b=jTE61O1QujBaXqcOgGr62qkKbyDiznv5xHMuVQbx1Yn2PeHvYZ/cuy0TuVmOTFKnj+
         T3a8b4NsiOtAO5wtBVVg7c+lavi6GM1lMkazAz6TDWxot3YGYcDlReVotN90jhfnzstD
         T4gdq073mSL/0NRvOxATen3rWm5Y0eEbjE74wIL+zZ6wSfjofRm87fBtrPERW6mNtipA
         6/8N6cQ9JrVH9Rf6wIcctgxg3lnNUvcPn5uUDPPHRl66tIrFG/dVoZVOONoTLeMCdg3+
         Xk+InKAT991juvNGFLAgNDnOFttd3+e6/a+RONjDNai72kuykrcYhPEAORf3JFbz/qfY
         6c9g==
X-Forwarded-Encrypted: i=1; AJvYcCWfE+NnRTt/vm+hszaEw9Zfc1YyBPSN973vZlPpr4ECqUavYnGNZY+AcvFG/2qJouZOQ96eVMfH@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx63jUP1GBzxDaGpMzTm4L625WYQpzsgaKdNn56R1BDgq7XTB8c
	Xfsr2HoAJzKkT5Yt1w64HJIt4yypcemeNG7q5sP3BdGL263tNkb9GNdL3wAG8B70VDc=
X-Gm-Gg: ASbGncuFK6oVXbFJdKcZtnIFFjN5yLxh+Gmhb6r+KN5NS+scICla5n+q8IBNFceEoGu
	G9rBkSXGGObZ8IoGZ9wga+UDdJrGBe4ibCbI0+OpIwVdTKbG5D3KwkhW2AMhRNxipBwbCgWAk7f
	Kf5HJcOKShd6ibLSWa+T7v7zGWxbcz6WD5/OdvO9l7KiLJBeuC7SMH4o1+4K4xlTfycxN2ucmfn
	7uQH/vozGenHzQIVi5oqldGdkmkZwAzovf7Y38hQWecDfXH2MmpxQQ1HTcp7Xhp2bVov2mBPWrO
	WHpJZhtFUYTvvWt1h7oIWOPm7MTqo8O4z/9OcS+4AHYaG9wpGJ2zFDRqjxKjuRcaw0lG5bKfOQn
	ZK66sH7lQmhvqSgXIhx8DR67Uhc/BbG7xG9aaG290RA8y6DSp5sG9aMvJVP9Mtt+tI+n1K3nArI
	ULqMNEmWrJPA2r5vu35Z1Y9x89YgObxdZFfBh6kOjt
X-Google-Smtp-Source: AGHT+IGVel8YLpEVj0az+h0gIDT7IBRfCBSzsTYifXRwdzTKTT5b/su/1HobQgZdeoOfSqN6KO8isA==
X-Received: by 2002:a05:600c:46c6:b0:477:7588:c8cc with SMTP id 5b1f17b1804b1-4792eb19ee1mr46750835e9.7.1764872150428;
        Thu, 04 Dec 2025 10:15:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:49 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 13/19] clk: renesas: rzg2l: Add macro to loop through module clocks
Date: Thu,  4 Dec 2025 20:15:24 +0200
Message-ID: <20251204181530.689132-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20879

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
index f8da33fc4246..fcabedf9ce81 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1201,6 +1201,13 @@ struct mstp_clock {
 
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
@@ -1313,17 +1320,10 @@ static struct mstp_clock
 *rzg2l_mod_clock__get_sibling(struct mstp_clock *clock,
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


