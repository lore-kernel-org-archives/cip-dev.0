Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F68CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:04 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10045.1762416717407310559
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=df9D1zTQ;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so8052985e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416716; x=1763021516; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVyO1FDD66Tg3oeWjtopRIrFxgR04NOZHKx4kq7W2YM=;
        b=df9D1zTQJ1bdNB9NAGsHFYR2PuT+03DnJy972nvfXPjShK11A8tABWeSgMeKIwa8Oh
         E/gJKVyr/ivYx7ek3rBxup7nIXyhixSlk1+nqMYerp1BO+hxfmac85sfFZV6640cLBGu
         0mfsie23igN3d6rp80t/DGKA3Bnn2H0oJBiDINVgxhynSV+KjWuMvI9q4dldstDiyahv
         5UsFQCn6F+RMiWkEFHJVddXCLm64napHiiVNZS8iQlHgV/PlBQGytuSdPaapMSYxIq9K
         KwBg3HYUG9SLb60QhyHOvV2b3kj5rbOoS5BxlqxyaIP8C5rAJkemMdo6Uk82SmsxG2XB
         SAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416716; x=1763021516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVyO1FDD66Tg3oeWjtopRIrFxgR04NOZHKx4kq7W2YM=;
        b=cP0HZS6MkvuVoYsQ6+DQaHPKyBTbmjt21TEyfMcybi/TCFnppIDXABPMloptNsqImO
         +HeGLHb/PGCS28H8TTLHl3OACp7QBujLnpiOjihAlJk0/qMEbUbUWXmOZpYUUTfW5IRE
         S1BzFduNpibayztGRu8e8NH/Uq5EmUTBp391vqchbrRCp1AAFOYuzeIWwF+ph+XhX/8b
         bBhvC0aWVSQG6wO6AZbWskBq5ZwTdrhaHl8LhT5FnRs+do8I1EFy0tank/BhNPgDJYcE
         zo/Y1yHvnGmCj8VrKVccQI+XyAh6jDYlt+Uw/kEAKPVNwTUKNSVvJtfyQrP3EzNZkSYs
         XfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe2tkE3kxNxCYoP0uF5rmm5j9HuBWlAf/9iNR8OloR2S0kFNWJMYMxDjmPytnSLoD3vSfL0MM9@lists.cip-project.org
X-Gm-Message-State: AOJu0YwAN9ga2cd0S3HZ68qQZ8B3qDadSnODEL6FTX0kYsdYS0q01SJM
	jMXTGNnR5nZM9qgU+HYD+GSKHPK/kBthjv8Nwz9SL1kjZXwtlNw+BiAcu+iq8f0g6/c=
X-Gm-Gg: ASbGncuxi594TAl1RzizbjFy/Lj53V9p3CbEnp713l0as4ka7znDyM+ZEUFXWctzv5r
	hZxi3mPdQOI0gZxtOezqoDRyXNki1ptPLcegAOBvfHmantc/COTJrXiGfttGRs8oJZ8BdmmPHK/
	OCJzY43oJ+tjhYLQztMpUKNI9KdnPZUQhIJYDZnZme5DpZTTI50PbCGlNoDSWZ5tVhLf721t5zD
	uVg1bTYfTlSwprXAcLxHt+o+eWeyGiNt49qKdCCJ6ruvL3FDRj43lNsvnTMtAAhU4SJ5oqVeTnM
	+wrv1ordnMkc++XZjqOJJHr3h8CSMzi5Y/0je9HM8zrhtzoxegncfXydA8bTm2E0oUSwrVpIFLd
	dbzMv39l+33Oi9+E0Ig0kWlXphySIPoDdHhrRt1aLNNYloim65x0/xVDhvUVQ91zzPPKOUd6WNY
	nAyoSN7VOE/3Q8CCg63HMAPTxehuc2g4Z/kGT7a/V5
X-Google-Smtp-Source: AGHT+IF3NVx/thC8FjIPrYhg2/K1dOJQdownu3Khe+iAD+2muuLaTd5+nKMLu7O/xrCbeg5zu2NOnw==
X-Received: by 2002:a05:600c:4584:b0:477:bf1:8c82 with SMTP id 5b1f17b1804b1-47762081a37mr20783105e9.15.1762416715782;
        Thu, 06 Nov 2025 00:11:55 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:55 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 15/23] clk: renesas: rzg2l: Move pointers after hw member
Date: Thu,  6 Nov 2025 10:11:24 +0200
Message-ID: <20251106081132.2574638-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20408

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
index 96535174407a..f8da33fc4246 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1184,19 +1184,19 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
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


