Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BF3D2447E
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:38 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50485.1764872072307327471
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LzL2yEQt;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso10235735e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872071; x=1765476871; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDwIf690mBDD3ESyYhSAiPClEx3RAxlnO+oLPXQ4tjM=;
        b=LzL2yEQtFYADN0CwatyjO5ZZL+U3L2I80dpQWDFu5EkFdgBt9MvBqkMBv3rAzyd/Kh
         7OhxIfEk2yJXH7g/0YIYSGkZXWaY8oZWcCr+7a4+Ree1X1xvBaRQFneNetBAqkIL02rh
         TCIv3wdkehWDIhnSoYrm1ycW8RfvDXLj6Vf4bhG7oLzjB+nDTzCdjhEWb8K+6EJIEJmz
         wEu4RG1AoHXIHUlX9eKSH+Fog6GfoCN6S/KrO6AViVV0YfJZxvFr/Ll4fkgQEkjR0i7M
         /n5M08jFrLhJsJeJFl9kBYU8gyihM4qwiDu/vWqAvRcmklOA0mdNGqVQkErs9U5+c0Jm
         jI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872071; x=1765476871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDwIf690mBDD3ESyYhSAiPClEx3RAxlnO+oLPXQ4tjM=;
        b=pMFWey0V5AFP6khVrzPiqbHrKbM84nGwD2ekajjGOEd2yXc6uNfVljrAbN741fmZS7
         8vg6K5JSPfOj3xcQhjhYu/OXUK2okoMAVOP+5Kwynbz/JnGt5VzgXq2odvGEIzeOBnd8
         XYJJFqD63WeOOtnji9cC2NQstpJGXXIfLoaL5BJXx4V3Fe+IU3Rj/SxI+kZ8j5ODH9OR
         hF09Z8jRjTq9VUCYd6F1efJv3HQDE3HQ7KT9HiFedzbIgh5nnGR0ZbFJM2qGsyZW7p6+
         44Yvt3DDmTzkBmg/1+0GmMuSrViI0elwkfIAyYVM7dMbKNmp+MK3ZAftBjCr9JLqw0ja
         fsKw==
X-Forwarded-Encrypted: i=1; AJvYcCUAzz3OtWxwlN3v3lBTbygwzA1M9AVBLhKACU4StounV2oT+3NKbxYlLbWR1ciVEzsLa/nZKrQT@lists.cip-project.org
X-Gm-Message-State: AOJu0YzU7sy0GT3ZIRZYppDBoTI9Oa+xvndKCojYlJjSnhIoLekvK1VD
	OPjA2JYTX1W3YJY/6KtrqBADZd1SZpfxvuPzFMXEKPrHx9wKJyBx7hx0lfMzfKQs2r4=
X-Gm-Gg: ASbGnctOiXNcUYn/Cc972i04j8Lmzuw6sfJ+96bI30CgAG4hGVRiManS1HXeROEXM/r
	cVnwRhzLkJi1GMDQbpPZDFhQpeWz1mGbfWtADDHgvPRw9VPx1Y65lXnz1JFh4yocGEKnbxBgzQn
	2DDgmS0//fN+399FEBfI+gNTtjmwRvOOyhyokfTnaiSKWyRnyEuBlka1J4Xp98v0rBEZOflMJ8i
	9Esszj7exSe7pOOey21IVgqCW2DmiM5OI+fo1sxzgz7y04BVBviIJDcpJqPUyj3QifN7kaZs9ZK
	YPuqo+lV3QGxP5WXjAbo/2nTnMYFbQgy3nQinPM0VzvzD4b6J6GYHf3KctEZBBD6jS9nBGSkqla
	EcuR4XwSKLsvosr8RIvqIpCYZ3Ey2X70O4NxKa++7o74xBZVUf2YrYXI0tOOrCqVNr4rZ7vSa+p
	HAGbaGYel2mOveLUcnIhL+rNUy1vilOaMjsVmWNQr6
X-Google-Smtp-Source: AGHT+IFxX99j49SArKTC/oSlQ4iaJ4rrJukHpJN/oG257b43tiri7BjNeMRAphruS1UThuMGSb4fnw==
X-Received: by 2002:a05:6000:4203:b0:429:8d0f:e92 with SMTP id ffacd0b85a97d-42f7317453fmr7669666f8f.6.1764872070723;
        Thu, 04 Dec 2025 10:14:30 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 11/18] clk: renesas: rzg2l: Move pointers after hw member
Date: Thu,  4 Dec 2025 20:14:08 +0200
Message-ID: <20251204181415.689009-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20858

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
index a6812257bf1e..fa6f9c9f4f5b 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1183,19 +1183,19 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
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


