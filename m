Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADE2CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:04 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10046.1762416718748907150
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KHoB77PF;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4710683a644so4345765e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416717; x=1763021517; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vjtHCamXnrTfmAG6WUWxPIuR+Ldn6tYmldQMkojAWM=;
        b=KHoB77PF+k0s6y8z11sfE1blBoeBX2iMwjKr9qF76EY/cMjcS+oZSmgznT9NpSMWnn
         a/dXsPbi53qOuDRYJsJANEYZG7h/Rm0+egKDeE4OEa4D32SqF7s6AJq71i3abQ2mA0um
         6NWC2fbbXvlzU+1J+QNBvR1ywKRqDbN6Jcncf9zfnjzVVLFDDldXW4NUBTX+zi1DcWgk
         +hpoVE7f5yrfn7bksTTpRsz1ZxbLjhfBBGBeFMENEo2hlw4ZiecjtoeckbotLBcqTthN
         /RdiWiGMCLYui2NPLDLJuWvGP+Wg0XpuNopgg2achQ/W9WErtRtJzbco9G/Olqd/NPne
         bkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416717; x=1763021517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vjtHCamXnrTfmAG6WUWxPIuR+Ldn6tYmldQMkojAWM=;
        b=GQ3TGZKcEl55aPo4KMn1/8FadbOfTnD3ebq4f+v74Myw63p+IZdjiC/b3GoG3RTM5z
         fxXNqbvP7ohxsquDv8YucYdehgcuLkxB+eyIfF/PWRpQuHgvz8A/Q84Geckgg1MOTroN
         fVH0+6JVakn09NW+wtGTeZLQU2jrMDhKIwwrHtEHnLZr+MrrznsK1QO9A35/Ko7pclzZ
         pbxHninsHHv84sdPUyPe6fLw8mBWV19QiA+Dq44dDrSfWio2tutEgCfOnSLaBsQrcZ6X
         yn3AfV4QCHEeiapxllH9Q+4b61iLB8OO2w4/wBY3nSv4u+vvpjPirQnN/cLhaKKo8k+B
         y98A==
X-Forwarded-Encrypted: i=1; AJvYcCUtJVa+tufzCMiLvf0VYCReW9pFZc7DLDs7aWn6bPIMc/ypg+zis2D3M1Sr6f2XehhM0JZ/B/k9@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy/qN2lkCNPeYY52u9Sp5AoPMCFj8WZk4LulUwGiAp4PeaZOUWv
	X7PT3jVApc17nn0NnyK4qerh+JzJe9PaxhZy8LtCVNJTxNfYwIHumNE9W6mPJevMV1I=
X-Gm-Gg: ASbGnctE+KTNZ69K/GwUnVGqn8hlAkbLma/R6g6b953HhC9zWZwdF+moQ7Xop3ZpGAO
	k1ESMfB+9pghPkXq/fuhsybmzGuUYzQFBQQCUPe+PPKsFGDPVhidCckOxEPZ9dtVXcdqr2+POIU
	GAN3GveeXjYQQpS6rrKX8F6+Qska82aWL31tplNnIz1P7bJkdBZobRLgF86jupHhpU5OUp5IoXn
	wSMlaS4aErlCEj4a+YsS3m9zAdFKL9+VOAjyFOyPL9RSNYawXpug/0y0Wxfh4G1sbm2kE4JvuFZ
	M1GRvkAhPrgoA3s+VV+OgAd832SSfKYfKIF7m6WfBc4c3jtyBAWyGZxF9+PNEJtQ7MtjVeVkODF
	7wSoDnujCCs/Gt/U+hgVBMVLedbXHcJyhvcuEtI19QFGQhHqNQmkrmPFhOJ87GFC8Jo27iOAOit
	AL9KjBAamJVcmMz1YWWKTLNN7PJN4cbwbwHskkkOnI
X-Google-Smtp-Source: AGHT+IH6WgtIPM6k5EqrmGjePHMpbZ7hQv5hdBPWUKwQP+VwhJIRI1FADwurSa0N20YPF3oUvC/hJQ==
X-Received: by 2002:a05:600c:4110:b0:475:de06:dbaf with SMTP id 5b1f17b1804b1-477620b8d09mr12214525e9.17.1762416717094;
        Thu, 06 Nov 2025 00:11:57 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:56 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 16/23] clk: renesas: rzg2l: Add macro to loop through module clocks
Date: Thu,  6 Nov 2025 10:11:25 +0200
Message-ID: <20251106081132.2574638-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20409

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


