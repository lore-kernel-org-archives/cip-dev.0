Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438AACCFA1B
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:45 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10071.1762416762596686835
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EKd64/EF;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c7e438a8so622084f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416761; x=1763021561; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUb9wuCd4vsWsqDyRiYE+XL0tDOmL/+v5YeHHd752kc=;
        b=EKd64/EF58Hy9lUDBW17FAeDgeFOgdpmJmrRQKz+5k2zI9lVxbHRluX7s534+gz7X6
         LgN+E2kk3YwL6lQGXXQMkWQdNkfnmMqVaNngvV8mzm+bOKmrWxkAJNfAuSFXLD1phArf
         KYGaci7P0Wgt/mLWKL3TnbUyk4rrmC9HTyFsXqmorDrabUYQWK/DPzwfHOXmL90qrXrr
         o5ah+MG8kgL3NbBmyL4G8/4oZ6c8Y+YbXB2MxkVsx3uLvlPkyI8Pv/UP+qywvsppEgMh
         eWtBJq3cl/s0+eABXo2jcQyF0iul1/gWyZtVE44XrhN6J6d7K0xF0nBvbIYVgf7xyfD7
         TnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416761; x=1763021561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUb9wuCd4vsWsqDyRiYE+XL0tDOmL/+v5YeHHd752kc=;
        b=QEnUkLcuxbjdUi+MA2RAa5Pbflw5I2ltHNpcsQoX/Kp1tRIayozFL2ePhhoU/v7RZq
         8viG5jZfLi/dOzaZSSCeY2HmpSjX1qDsPDo55sRW/GRdam5hmP+xCny8gqwAo6Di41Na
         bMS7EI+vdeOO3Ws0XQ7kSSncAcv18p3gWbdpSS4TCrzdJHsQJayM9ZrDospiX/0OTzgf
         C3nmyrvbkHNAzmd3rsTPyeAfoQjNUdB3bsKT8xZ2LIBapjtajWrHX3w2gijPxYPB9XmU
         0vsbmsbba9ETkakpJ0f1SZuHtad2AuWcrrBPP1ktq9J7ulctSR2k5wzs7xhM/I7RHRv6
         Xcsg==
X-Forwarded-Encrypted: i=1; AJvYcCXk+jlgeynZcSYZLuJ2AH2I/5uBfC4tWqPYK19rC5tPxD0dYb0w6htySWqmYPAbqxjb0RBCs73/@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxp7K3AxovKGWqF/h7LTZjxPiT0mZ5dBWMhjlzbgR+5hBYQ+pvh
	7jmiHcZLa/lbOKbM3h51j+IKVibeiDwBJruSEqOV8EyzNFd0V7ZXwFd7KYc1+eSYa9o=
X-Gm-Gg: ASbGncvcsuEqXkfsAvyEP4SgkAYgaFQemSihAD6vlbbUoYqWE9Wt5rUwhzgX526sakD
	ZGKqel8UfJCjc8iXtd26/HQcUyShAjMXrWCtpJxIAS9CNaouNLWiQ3khngw0XgB47lkrYKbNwY3
	Bf6nI0Df69+cq1A52fWVRGpKpG8r+6jcKG55lwXMzvrXWENsw5JpiEOTHF2f4cA97kQIdHahTaP
	glDOFXefXyHqHg/jsE7i+PSwuO4s3f+6quWkxn28Cm5QR4JpAesS/sdUkaBVdi81zjqPmsSnpXt
	eUzK54ipJiU3bFJsa0TUFrgALkaDj0OpHoq2m1YjCGzxENXiLa8U1hmmjWy4wK9k8gHa0Iz7LlG
	9uxrh8V6vBDilmTg7NdHMl//Sz8NpB5SCCxoL4RoH3lZgtPIBUVUrHN9WY8VZ1fpm3meK+pZRpc
	dkOTgN7/UtquO1nP1s3wgK45A1GWci6A==
X-Google-Smtp-Source: AGHT+IGRP1RmEsvO96ZHUMYTl5v+dAsT9hQMMiP5CN7IAM4loUsgNdeCm2WTBOb+4qSosxamRyyzvg==
X-Received: by 2002:a05:6000:258a:b0:429:ccea:f6e5 with SMTP id ffacd0b85a97d-429e32e9203mr6122213f8f.19.1762416760912;
        Thu, 06 Nov 2025 00:12:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:40 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 15/22] clk: renesas: rzg2l: Add macro to loop through module clocks
Date: Thu,  6 Nov 2025 10:12:11 +0200
Message-ID: <20251106081218.2574950-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20432

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 3fd4a8bb4b63b886a7a11444f85000ea90d2617f upstream.

Add a macro to iterate over the module clocks array. This will be useful
in the upcoming commits that move MSTOP support into the clock
enable/disable APIs.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250527112403.1254122-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: add the it parameter to for_each_mod_clock() to avoid
 compilation errors]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index fa6f9c9f4f5b..25cdf60eb789 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1200,6 +1200,13 @@ struct mstp_clock {
 
 #define to_mod_clock(_hw) container_of(_hw, struct mstp_clock, hw)
 
+#define for_each_mod_clock(it, mod_clock, hw, priv) \
+	for (it = 0; (priv) && it < (priv)->num_mod_clks; it++) \
+		if ((priv)->clks[(priv)->num_core_clks + it] == ERR_PTR(-ENOENT)) \
+			continue; \
+		else if (((hw) = __clk_get_hw((priv)->clks[(priv)->num_core_clks + it])) && \
+			 ((mod_clock) = to_mod_clock(hw)))
+
 static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 {
 	struct mstp_clock *clock = to_mod_clock(hw);
@@ -1312,17 +1319,11 @@ static struct mstp_clock
 *rzg2l_mod_clock__get_sibling(struct mstp_clock *clock,
 			      struct rzg2l_cpg_priv *priv)
 {
+	struct mstp_clock *clk;
 	struct clk_hw *hw;
 	unsigned int i;
 
-	for (i = 0; i < priv->num_mod_clks; i++) {
-		struct mstp_clock *clk;
-
-		if (priv->clks[priv->num_core_clks + i] == ERR_PTR(-ENOENT))
-			continue;
-
-		hw = __clk_get_hw(priv->clks[priv->num_core_clks + i]);
-		clk = to_mod_clock(hw);
+	for_each_mod_clock(i, clk, hw, priv) {
 		if (clock->off == clk->off && clock->bit == clk->bit)
 			return clk;
 	}
-- 
2.43.0


