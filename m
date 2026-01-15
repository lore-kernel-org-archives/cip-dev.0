Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9366D33A2C
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:21 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31285.1768466116378229146
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KwlfDMxj;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso965317a12.1
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466115; x=1769070915; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP2cdBAS/3Vbt+Vseasn2OwFDQv+JZBkK+2mtmf+OhU=;
        b=KwlfDMxjFEA02Wc0ty/QPeNH6JT6D9EopQb99hj3dXCENhNgootve6sv2SrOU4z/tz
         r0JgQl1ybzZskbiJioFxHigAdipK9a3mcTJb5lXatbXiu3C92vTLn8Cl458hSRQSdVs3
         8gxiBzh7BFEIKcjlswCTrMBnRFnYRk3ff7GBaYpQmuM8i0Xi1ENwJfiGIlIwE/cbjMo0
         bLyPJcX9PPWmrbI9NjSCmEKkciMRn5Q9DfIMunBphcION0bEMJCRUKFCNQ6sp4Gs/HHj
         2VixbmZQ7Fj8W5X7brnsb5TYrx30SsaFdJumZhNU5vCAaBu2ooCQgBDbqp62UAT0K2C6
         CVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466115; x=1769070915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oP2cdBAS/3Vbt+Vseasn2OwFDQv+JZBkK+2mtmf+OhU=;
        b=MiHHbk+Tq2ETUwr1+QY8KnV9MM9Qq76LtOUuJfhE5EDVpftd5NkIK/epUEg/iYKkm4
         NUmiYhSBJEmFRXr+Six4FL7/AI1EZcajoEkttBAWQYeTSRfViGUzpYDIfaofbpXKHLrh
         rkIsh0BVYV3qTHtXJrPKk3W2JnJXYhC/LoN8RP+n7PuU57JBLCulGbT/C5Jrw4dAg9Jg
         93C9wuon0A/vosFAfV4FN1RAGyJfyawffFgnrryOezhS5HX48MQlYGTv74xbmK0Xhmpz
         iPoQ8dUwV7vfUFWdkLahrIzjJMTMqEg/95xTUkXgER/5nOCW8avheoRj5EGU7PowLGBf
         jvqA==
X-Gm-Message-State: AOJu0YxLOkiviP+h/aYQ8wtfT22dmEyZyiJOLV5dpdDSI7eNSGHeVKWK
	gFjmQ5YwOU2Qrh/idzOeXLxnbN79uNQETAnro9c4HnYE0QE2Rp3ZzxF0WbxaejQ00Oc=
X-Gm-Gg: AY/fxX4nBgEBKmHhWJKd771+vVvZ13qUVjtYUgm5jlkiXLmR+hfkPnm7yfFZteT35B3
	lNwHQIUf5J51aibcGhV946kwqoESY60FsSBaju3jnFT6dEiRFKOt2H4Gh1H9HZ8VRey1hLWh/mz
	ad9w/RI5SMDlVTqrXRAy8lInZMmGQwWQ7+BOwrnPp083wJdgjS3iGrMy8DNcxrUvTflYUYTtaAq
	OrQt3zxpvgvOivDaaM0HgI/XUu61/jsiasJn4CDB8U38pjVsnROVbBv/dfkX4+nyvLlLy2+34Fr
	hx/7mqNzKo9u4PCKjHOSjonRzz9eDOmFI1ChUgvm4zHGVgRSIbmhIWQqAaZ3yooUCZFg3ji4IqV
	nUoV1B7M4Wn19KFBg4y7qoihGiZqTi9xaTmRBIEnp+dzdUaFFcZt7lbZUT2wfXZUyWxhqUwZnl5
	vFOoRyG2by2Aul9m3tEDpaxvQ+t42SRyg0wZHcO+ioQDH00UL3goww5nnhjPxupLdLpQ==
X-Received: by 2002:a05:6402:40c8:b0:64b:9fa4:ade1 with SMTP id 4fb4d7f45d1cf-653ec128fd5mr4494427a12.14.1768466114715;
        Thu, 15 Jan 2026 00:35:14 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:14 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 12/19] clk: renesas: rzg2l: Move pointers after hw member
Date: Thu, 15 Jan 2026 10:34:44 +0200
Message-ID: <20260115083451.1064048-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21592

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
index 49eb2c7867e5..0fdd4b0aa5ce 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1195,19 +1195,19 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
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


