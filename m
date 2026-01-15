Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B081D33A0E
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:34:01 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31260.1768466037630138891
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=gFATi6qb;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8765b7f4c0so111572466b.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466036; x=1769070836; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3QpKJSS/RqMDV7t32NxMPN6FlaTXUkHuu7M10R90Us=;
        b=gFATi6qbLXfczC89gIkpfqcvdChXDB+V6y+ak1AhirfoQWdFFms+h8WgecTgP0Xn3X
         g93n7ZK8qL8L3PCzcbecnmxBq3CN4cCp4z3Lpzp6MvKf9vveCkKcjEWIvmS27vuODDbZ
         j2mmjo8N389tI1527u66p4bYXJM12HllGJGqcurwSoXVerFf6cWc5lg9NpwKq9fkQQGS
         S1vD8IsowVuzUE8Qd+JKrRV9a3DlzhLOl+0TQs3riJ8RXguPFyjsLxOfc6xqFiVLoxrG
         BeIHFT/95B5wkjUMmURCoKP/uO57JAfapyI3jlPUiU+Ml/doiRSDsfF+tv2HHHRPqiKy
         Sk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466036; x=1769070836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3QpKJSS/RqMDV7t32NxMPN6FlaTXUkHuu7M10R90Us=;
        b=JmegSd5Ag3X/nISEG+P++Q/4dOds9OaGbCWtaxXKgwDwXHijGrcb5d2Nd7RTDI3DeU
         JhiytWJAC3hv0Fs/8XlLuZkijQOlfc8I/lR0OjElCV/DpKsYV/tZ+RFN7CABDlWQXBtk
         bzC69ty92G/wsV6Q5G24EQ3DHFmU4UF25kooUpbN5uSqNDf36lqsiX+OPYA/NYb43RqL
         ZZ4+NQpXVOzEsZEZ2086J+IFwFOP/+/JL3xMEbMl+mbtwkFz6HY8ob8LJFYayNfneANn
         J9JqXUr0OUDUCtJ7enHSbPyY66FdeASkjlsQMYmOPRbg6WIASldtO+a4WGeORAwXmyyu
         C+Kg==
X-Gm-Message-State: AOJu0YyTDIWNkD7zYgvDxZT30B9X8xUxiOl0V9KnkSRt8y2F6l0+Ixa5
	wyZKrXuH/ShwjrDvQLNEejR8RvlFx8/0QMzvMq00zJYq0D+fNdbRAjBmbTAls1xaTddCBm8brKj
	UvWxx
X-Gm-Gg: AY/fxX7gl8mgxouOIxaucgBXiIYR+cgUlp9sgUI4r5jbaz1jvJ+8EbnFzUDdl0eUUVb
	/EBM/Ikjco7nXDEBCX//24467fLt1tnm4C7/x6a0WAvSN7LEeCPvw0c7SJvX4sOXlZQcQotocJO
	PlGm99n54J/ZvZtOKTfhd3owUW0ljWMoDAIkobwdfb0FI0oYxIAmQGpqZnKNo5fymL9Q0ZGc5Me
	wLSCGb0F51W4qEq0D4jwf9rhBcmSTro7npph2OzzPQhjWzdlKt02dtxnX0q0hmKK2asGUYEif44
	nclWgcOc4CYNeVctHZ16PsLKDBI+ngtgw5B97QO0aayEsy2JM4Cs1eKK9CwmizilyuEC2gm+229
	jbvLKaFv3o95r//sw+JT2V41tkCg1a5iYe53VnjH2rJmxicVfIyPsZgCRSz8H8Xidb8tz/4BKmK
	WzqpAw3nA5iWaWutMnJ+or3Uzk7K3U8eH+YYqrq3dz8bjt7cLWss66ZhXyA9HWDCavbVVvB0CYV
	KC2
X-Received: by 2002:a17:907:3c8a:b0:b87:2604:972e with SMTP id a640c23a62f3a-b87612dc1b8mr487510166b.59.1768466035943;
        Thu, 15 Jan 2026 00:33:55 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:55 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 12/18] clk: renesas: rzg2l: Add macro to loop through module clocks
Date: Thu, 15 Jan 2026 10:33:26 +0200
Message-ID: <20260115083332.1063820-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:34:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21573

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
index 015fbfb8351b..e5067332da13 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1211,6 +1211,13 @@ struct mstp_clock {
 
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
@@ -1323,17 +1330,11 @@ static struct mstp_clock
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


