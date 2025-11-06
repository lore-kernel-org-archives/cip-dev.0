Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE05CCFA1C
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:45 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10070.1762416761365218016
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=PbWxYF1Y;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so5325265e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416760; x=1763021560; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDwIf690mBDD3ESyYhSAiPClEx3RAxlnO+oLPXQ4tjM=;
        b=PbWxYF1YE3nbjL1DR28zHhGWpTzvAVwJRA5Ggk1G40OzZVCv+R3JnPCn2z63YighjQ
         2SQ2/YNJe9e4OMlsjj3dC3M+Yt+2Xa6UgCh+3oTH1v/mzrl0SLrFc1k9vOoITwrh3cXA
         B59bRSBd7fyTdAXK9JSuNQIxxru+PP6v7YwgsEofaBYQ6U/dcgpTf3r4Uh6ZHz28rLks
         QMjYQNlCK9rWgBR4fbsuZlyNabAcG05D0d5h1+GGJGlTTBea9CTx1fRBehBMrgkLdktl
         APcgc+TbjssfC5Z3azALSX0S9Xhk98gSJZjh1CKsgZEzbnYCKB1d6HxM0hpWJ0UB/aAI
         kbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416760; x=1763021560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDwIf690mBDD3ESyYhSAiPClEx3RAxlnO+oLPXQ4tjM=;
        b=gtK/Vy2iGXiXQaV1wP5qJkmLCmOWkLdIIV61CaxaopkF6gJeYXuwdK0wzjuh9ZOLlD
         vS05AClGmiBOA4809keX9kr76KMEk5cZIQ4VrjP7Ezc83p1yN/rpGbreuHnt4u7fEH7L
         WW+fecmREBA9OrHdZbtqEyOQQ08UrUtSLjAj0W4W69tnp+vjhwI0R2p26DjWplO6o+kA
         SqWC4ho/2x4fMeSWSOPGIT19JqlSGUzL3/7g6gN1uHv45fN0ZYMOSOVif7JHAbp3YjFZ
         Q0lOd9InKZHhfbyaiiR23wKKvSmvSVhYX0XNnrb70iZrkRHYbNixVzAMjACvsu3fjk9X
         eo+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXi0sZe/VRv5+U2dBNl031tFSOBuziKv/TSNGDyaQ8YRwp0gh80e3k5oeTrK50N0oYZntLScM83@lists.cip-project.org
X-Gm-Message-State: AOJu0YwIm7q6dX0EeNX7u7I0iY1W3R31vr85qibNRSVzMBJ2xDrYouvt
	DQBMr1qLLLo/+LyjOpzqWG9tPUZHaoVyLUtfi2tz04P9Zr4BZ1GMJ1KLZXGo++3/iiU=
X-Gm-Gg: ASbGncsBr2Gh3Fhn43kqrHpvZ4n/SHzBifVHUB0kE6ndiThsnO0cysxzSEaxxoqNpU4
	6T9fiiQLObY4mJV34vjV+P32NCzOO2MZRCYDlyqokHhsQwTlqwtKGqqjq+a2yIDAX9QipbP4Lrs
	D9am8Tu8Ycw+eI6EK1WaMydBIk5sWty1MFWTpJUTWifOHLaMQXUbCorW9v4/OW1Xizfj46fnLFj
	weDXSd4g7wD1FMVqShFftJrQQbZMQ8Wj5w6IrpHLtFdp1ATMED9gj0v9e9J4NXs7rEkdCZ43EFF
	Ii/mCQvyLxlRRGsTyaJLkc0nPdqDtTUfDPzOMta3Ij4dotZ+YJVxARKQ+kwaHjInNWT0lCu4h/w
	zCxS/4IMhxOUanp5qFPNJi6j9inEhi2juf9bf0jVvIAF4ze27X2nBS+g4LroI9eagy1Ka+1Lrcj
	ZnTkLj0rejLR49QeoTCzEU2Y0h3BbtEaRZt5lfcFDU
X-Google-Smtp-Source: AGHT+IFPrk9tVTVBz41KYnlW1QsSt9GimApgrSc2GUBCRiJ/npEmQkOse3dF7kYR5r4uMD6Fu3ARMA==
X-Received: by 2002:a05:600c:a00c:b0:477:bf0:b9da with SMTP id 5b1f17b1804b1-4775cdf4569mr60998535e9.19.1762416759760;
        Thu, 06 Nov 2025 00:12:39 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:39 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 14/22] clk: renesas: rzg2l: Move pointers after hw member
Date: Thu,  6 Nov 2025 10:12:10 +0200
Message-ID: <20251106081218.2574950-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20431

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


