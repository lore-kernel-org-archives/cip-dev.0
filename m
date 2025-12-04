Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB13D29F80
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:38 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50486.1764872073797500878
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Agcvt770;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2d44c727so692370f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872072; x=1765476872; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUb9wuCd4vsWsqDyRiYE+XL0tDOmL/+v5YeHHd752kc=;
        b=Agcvt770EuSnNgy9P8DF9PUa4Frc1Y8vDnRoGqzaVZgfz3vQSnYMTMgJz6Mvf6frkg
         tKVH7xs5OzHnkO1XNQCCu/c4mwQ28XMO0zLaVIEMgSA8ls7vsxN3exFamDrdCnyaeb++
         +Cv2x7Vyhib26YbiPdKjm8nLYK9a6I08cRQrz5pwu2MZC9xpyLFh9sZjRgYe72GSdRl1
         surmq5b8LG6t0ko9ixL19DMrlRd0IQpl2pbiQTgqbYgnPkxZqGebH/3RG2GsB4WzBPVk
         WANeeobDiuE9q6CoKoQLJtUt6KwWGWCSYrRF3R10ZYzKHTIWXH5NiST9BT4U7g6yQKLy
         okRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872072; x=1765476872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUb9wuCd4vsWsqDyRiYE+XL0tDOmL/+v5YeHHd752kc=;
        b=ecsAMzfILo/ozH5qzLCZiPUhwAUibRJlTXOmu6dhTUynqio8oKMyHeALo1pzCb5Rft
         2YKQ5c3Ufzt/tjPJPIqHFsfLM9nnq0mk6Q9pzdo7Hd2Ohwu+1ZRVmFIH2VS7IEW4wC48
         K4A0uHSdRohPZfHwK4hex+JFy8rLxb6XmlXj1wkwLzPjiRjjQwSK3WX80ftqbLrYrQZu
         LO8BHQPavz7JLyM2CNyfUju9TgJRZAJbCUacG0Z4DuG46ihK2WOclqGKsiE944olZnIF
         nkFmIWF4VN8DDjVotC0UcVfPXqElwhK47koTCUC0muQfCCMsvxA6Fs5xw32edCbteeBp
         8eUw==
X-Forwarded-Encrypted: i=1; AJvYcCWokTvqkzNtdBtqy1GfGIlBAEAXilw0+6gMoYlp5J22MfmcXj/FXSz3YUcR+lyR6nv2LTZzXl/4@lists.cip-project.org
X-Gm-Message-State: AOJu0YwAQMJotgQR0DUPaO/pv40kk+4Anogqqjp+pf7vOeKcTrHG0UlU
	9HK8QMagkxruDbYL9kznksPL7VvNnwqOwHoAsKOpHsb14On0FuzgtkcuU3snh23YNKQVRPcLBEg
	QtAv3
X-Gm-Gg: ASbGncvrvvyl6BVHTdVian1sDSmEQ0mhrkRq9dExNvsbaB5IwJ+QUL+SUrtEWICPQmn
	HdOCQ3o+P9x+pi8wtJCKNWE9JuDLcRlEee0IUNHKJ/NwgKKXD3yLiafu9rRD1BBLHkvpcku660C
	SYezg79l10lsV43RKx5D6FUCnkn+Dvnu1wSOI+vu4IE2eCXJHMTvuwogskI0t6Xb9sTbnOaBE4n
	fYFG3HTUGfefypaS5c0pFHsyijP5dbTrBcdds+r/DwZOHFYbzu5XszSZZTExai9IdmDYsKOU0n8
	ybKMif4KWQ3FZRP9S40JZ8VUxeSPskZ97rj31BlsXy80EmDPEa2hw4YMgejmuqNpk4RCy6u0qB+
	OhwLpR0KksBA8eXJgpdUtpbskE4s0nU879wlnJx/sPC0B3CWEMWFK/0ULvZ1ZYYlfTTvSBmVw6C
	eY2Q3ydYU7jNi+E72cPNdMxa1Be6f9MBkHmMGi96vxZUeGfASqEcc=
X-Google-Smtp-Source: AGHT+IG0gzgyaIXZZtVwqGesm1ZVd2e3z1dfAsfkUqLOmK4JfHWAVFB54TU+lsY7vJ/2niP83lVifQ==
X-Received: by 2002:a05:6000:2dc2:b0:3ea:80ec:8552 with SMTP id ffacd0b85a97d-42f7320be7fmr6429843f8f.57.1764872072123;
        Thu, 04 Dec 2025 10:14:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:31 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 12/18] clk: renesas: rzg2l: Add macro to loop through module clocks
Date: Thu,  4 Dec 2025 20:14:09 +0200
Message-ID: <20251204181415.689009-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20859

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


