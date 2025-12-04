Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6162D29F8F
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:58 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50864.1764872150705991231
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Xeeo0LRZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47796a837c7so10579335e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872149; x=1765476949; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVyO1FDD66Tg3oeWjtopRIrFxgR04NOZHKx4kq7W2YM=;
        b=Xeeo0LRZnzHWdKsHzRhILhQLc8H75k1BxJMeSRDI8Ypsrah/d4maynYNr/D15D5HL0
         IAWJJImA1gIzZrpbDLZ7j0sxPkiq7buiIriE7mcDJYkVzRoRjuxyH3OV4DkpV7bLwfhn
         85WwKf3lXQt8uZyrFjDw+DPUYn/4OEFUn6n44A2OkYXY5ZsU43AVSYyn3z4pWcnreStI
         BZ1mfOIAvOloDr3u0Yo7zyf6ejrpNAuIobWYRMPH+EM1HO5XU11Fn2iCbepySHjqbh0R
         fD00oqkjjo1rbvhFBYAGtJT//tp6fkad1NjZqolxBi4gkrDiSaTWF91YVGWTpOBxVxyq
         sK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872149; x=1765476949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wVyO1FDD66Tg3oeWjtopRIrFxgR04NOZHKx4kq7W2YM=;
        b=V37CMvMrOOT9e5ayfXvNR5g0PwDqlL2LyP27PqZZ5zuK4jxZ588+QX3nrqjiFpE2qh
         KFVAEKEnqCFX/Ld7Ce6H5oRss5CEo6SkLJExvIF5BfVaCUR3JvhXBHbPmq6X1mYwigQ6
         yhvjGqMZ+xoOXofUdzWfEcUSE2mxJhZUq7Lfa2HYBj694Wx3G0m+Cy2mhor4QJ0jrquj
         MVBtrH2ddgdNTMv4CiPy2HQtWDRFKOBIDno+sQiFWus3aiXlx0c+2mc5RVB8Gq87i6JY
         uiwtyJnZ08afhv0AIlPVwFJxPdJ6ZmEulbqyVX74crjgfKlxB8RCybQS89I5/iFcb1lC
         PYsA==
X-Forwarded-Encrypted: i=1; AJvYcCVDhgLVW2qLQUDhgagj8EcARAnXxlZ8DgWcHPD0D5Cpud0nJ53qbl+TP4bTNwseQgKYDU1PtTUx@lists.cip-project.org
X-Gm-Message-State: AOJu0YzKQvpHq4lfboUER3VAkpLYrV+jt4N4B3eX0bfAB1mmfkGzmRMd
	fbwhSi8Uzc9QwzSAg91u34Si+nbFmkcU0H9azHtkidnu97BzjMGQ/MD72LFb+mOTcXPBX/93urM
	rIN4t
X-Gm-Gg: ASbGncuRyb1diFurYemvOjhJk991oWnBISbgK27AGEu/eF2orQuY92qrMGF+LwkSZN5
	Gf5QM3P5XJhEd1JHepttQ8SlOuePdsGSg6PWvSnuRf6icPhoAiBQwiAhNXQwYH6USAPqHVv6M87
	rG7qZ4put9ops1m4Aj6GU1vi0QGWxcT9vEgdDof0Ez6/7JoLeoYQ2DeYZIlk+gKQ4rL0wVA61HE
	ciIoJNKP97UmRH4D8j9qITOXGSCq5sgezqb3cL6Ho9LYOypar3BDsnzckyPfOHTWNUSDkih2v+c
	4RnyUCQkUycjQ2qW67UwGy8Nzg8x2lEw5RPa+vg0SiFSaTu/KBZXl02JuUm4YAYK7tFauf/tt2c
	RJmin/8tOpD8fbDao/JI4aDT6XYQJ2yf6j06Z18wK358Fk2PU815fY7gN1S0kE0mdhyllkFyM7v
	NqMre4XWoScvV5qSrHi01UmCdyRzJnWmP5bR0UCDh3
X-Google-Smtp-Source: AGHT+IEEQvSp8gPAuAK4U/qrLn95l82sx0ok6/DFKpm6TUewQRcZWvqv27uGH2SzmfrREOPyoyaO5w==
X-Received: by 2002:a05:600c:1ca4:b0:477:63dc:be00 with SMTP id 5b1f17b1804b1-4792af404d2mr78221765e9.25.1764872149071;
        Thu, 04 Dec 2025 10:15:49 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:48 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 12/19] clk: renesas: rzg2l: Move pointers after hw member
Date: Thu,  4 Dec 2025 20:15:23 +0200
Message-ID: <20251204181530.689132-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20878

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


