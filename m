Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AF3D2447D
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:38 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50791.1764872071046182248
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KpDU5YSK;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42e2ddb8a13so658515f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872069; x=1765476869; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sFjSUORCE2XFdzna5iDN0re0oUcBefSTsRxrXfXBM4=;
        b=KpDU5YSKxyOHg/zIcco5NB/u61TcgPgIzk8bal/aUnun7N3HL44qTQ0ruEeg4P6K+G
         2p5FjUz0bJYH/9v5WJoUCuM6hCxaC5/I3Z19DCmu6jfCyrijX4g9KGzNmPhPM2e1mHyA
         cpxSG3RYySsEQPlCBHdo+4tHs7VTWGGEvV8j6QMSLCpo4pP1CpJkkMSzxK3fFnugeC8L
         DXZfKd1pXq2/e2WvQHDbvg66pK+sWz9ZKS8lni09GupcmEvQezsp/z1k9FIkC5Xpzt6i
         qEk8SDn/tDIW+jZyJc37DtuJTcCNQK4W+AtYZsvoBCz0C5d6ikTWlK8lzTKeGW0i0Rta
         QxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872069; x=1765476869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sFjSUORCE2XFdzna5iDN0re0oUcBefSTsRxrXfXBM4=;
        b=fFZyDWaW1YXJEGPRPdfdy4OPUvrmG3KpLheI8GYR3dRHkq6De3edT1CSPTos6Pjyvr
         DSRJvkETURL5TFTY+pX0oat5kjDDWJ/DYVZ/e8+sIC3t5cl7P4YbgbHSZkXBL27Efjxq
         eJXGYrlgJ8oBkfsbJJBcau3H8iD+ujMryw3boOjDeVpAU12Gc5bG/P8VxjlSNCxy2pLX
         44KnUd6/XXIpJ9kZGeIWmHOt1IFC6g4Zf961PzoiCpcE8Y1yTFdpbwRd2eaU4s0Oqfbr
         nvi5QH27lAvpm+yVm4fMKcj7W/tg+MVGF6icRtAGVkq71l3qKhiqCKxPcnwTOMdnkNG7
         HR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRfLmGWgJGyt2ISYJKw+P8Cdk4mkNUBd7u7a6F8u/BQJv2OLkS3jhsU4JHCk0bDcX9ZYwQY4ie@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx2Wmv5lDrJcrw3H6tc6bKLU+0oFaB6sSbFpz+ncGSO62bQ8KZM
	kRwf4fxL/UHJa/C+ZRqKjdoUvl1pELuEBhT7sVh81oVaRfbuWqiW3xmJuW6D51Q29sxH13t5WMO
	29YVk
X-Gm-Gg: ASbGnctNrOMfJYnB94m0hlPp5rFkzGa0tXo5KHSb9BsJ9AeuYvw5hZxgZObpvVafiuH
	/77UWcjKyqrYeI0HfH5ce57B3E+Reyfa4PUrIKrJn7vjLzxpJAewwgCW/YCDfqoagqgBuyNkRQ7
	vmbgsaZ/0iD/yXiKD2rkIXZhh/dGlx0aOCo0LQTRKiII6FPNHvswvf5k4ACAxUFlWyMxbBP0zZq
	er7pkklEU9xA0aY4ilNHyBby3Js7YDXDItCIJmC0iitv5Fgrwi/r596zqGdMd6+RlZO5K0uS2mt
	wihgeChiVlBDUlQrSChRZsaDTG7BYh05LlvAebcSjQzgAmOzW8bELRk/DGzMtRvnVNSYTfiZzd1
	hFc+wM/ibSWmIrjAOlHMLCj47KJ6srtyXbXkKwcy4pNoLd89ygH/hE2kVAJ1qGTVDjpWZpsqAR6
	wALeJIy+nEO5lQNWcA4Uw5WwDW5YIFeBa48sA2BGSY
X-Google-Smtp-Source: AGHT+IFnq1GDjeSyiqMbMq/k3ZWKkeE18oAni+IbAn9tZrESHtPfaJ5V5mV1pKYFbCb7cMp7fq1mEg==
X-Received: by 2002:a05:6000:2689:b0:42b:3131:5439 with SMTP id ffacd0b85a97d-42f7317db48mr7870852f8f.21.1764872069404;
        Thu, 04 Dec 2025 10:14:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:28 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 10/18] clk: renesas: rzg2l: Postpone updating priv->clks[]
Date: Thu,  4 Dec 2025 20:14:07 +0200
Message-ID: <20251204181415.689009-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20857

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
[claudiu.beznea: fixed conflict by keeping the code from commit
 2f96afdffad4ef74e3c511207058c41c54a2d014]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 379292eb6fb1..a6812257bf1e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1389,9 +1389,6 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 	if (IS_ERR(clk))
 		goto fail;
 
-	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
-	priv->clks[id] = clk;
-
 	if (mod->is_coupled) {
 		struct mstp_clock *sibling;
 
@@ -1403,6 +1400,9 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 		}
 	}
 
+	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
+	priv->clks[id] = clk;
+
 	return;
 
 fail:
-- 
2.43.0


