Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A6D33A2D
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:21 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31286.1768466117825627616
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EmiciETd;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8714a52072so114151466b.3
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466116; x=1769070916; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHqwhz0KgPGAc1hTTaj5EZP/oypyKHwomfjpYlGayIY=;
        b=EmiciETdmdbzEtTnO9WuR6DMKRK5A+gc9+kG6lIPFG+GAHhtEJOzRJI0ggEJeL/CGb
         abRHn0nYE9f3/tZFpU1ucxbEGidSju4DZfYHSDgta8u9ZdGiJxtqECS3HhRrCQHF30As
         71evw+uXBm5f2mfBAMAMB/8w7RCpS87UBW3BY0eouQb9EdJyzX1MqgkZ++mDIopj1Ua4
         nHegKBLEQoVi8J6cYUhg1b8HL5Vbnpstl/yvWbpUdx6AluGzfsG7duKca3OuWkonBK+e
         mQd819p0vyvsxnJSE8e2jSqoZYTCivhjru2ouGUAHMorABhkdNW9Kb4iVBVJRzHQM74H
         7LBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466116; x=1769070916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHqwhz0KgPGAc1hTTaj5EZP/oypyKHwomfjpYlGayIY=;
        b=HL7Ol9bFzs3itohxisZoUJP8QSLezgAcR+0yp7SYTODlTyAD/Iqv3hnGR+A+wn6yVP
         b93lldCUGKIWSPs/YfDY2JE9S1WJEg0yzmlKJriSZQC/pjkEIFLEv3LRe/x9Gr9azjBM
         4PyrPbOV+H2rIfcnrjQLEqkmPlrW8zKBRXDMqZV+IwIjHI5UdNYWB8+6GWbFeko3iyb+
         D5C7W78T1W+yv6A4bJBBZ0qscSW2Fp1s5vbSzFodnPImu9P4lclX1vEW4ZnwjYOO0DTD
         5H4s1j4yWQwD7+zAqB3DFnZPZvhAIxd1nNSxJE3w5bi8umxSwEcvsPIlslXCaQdV004+
         0R5w==
X-Gm-Message-State: AOJu0YwKz25QpNUjBiNkwrvIEmAtcX4JXMEQnAresizPQyByvYieseqZ
	zpyxx3OisrDS80VbtIzxCP99E5ugeG/yMtQ4YiziSNGrAX6F4uBmdbCoIw4DykJOceY=
X-Gm-Gg: AY/fxX74y94gKZcV7a06ZZGcVgfBwLxs6rQuOzQVn1xHeKtGCdParDPmwEz9pECFJmT
	9be7d2M8lnTHpSPOx3DCZhOybHOF7Z6oUKHkZq2p98p0XeFEjH3KWNICsNWWJO5hErytsh2MlHR
	D9Ssyof1LDS/SRFPSemt89WCtgEzcwolOw7TUWfrTmYi/P//m5TfnepeR+FjQabqDwXpnRLlI8N
	ZblLvpJAiAMylYfN0L6nTiPoaof1lqJ54DZrruowEBHcrRQdxktlGh3vJFwnGL8wgdOZijsJPLx
	n9kOi1S2qbVDIOqC8sb4PKYGdpnwe0RqVVfp6ZrHX9Z2G44PDThtRn3RhRHKg3twy3KY5AOx2HB
	CHwKOiL2LP+aNlcYCGqx2cgGvfwmkoNFYS+6nf4rMo5T3RYXZ3GwR7gPnogeb9CH/KLbp5xkeLC
	rmFoQaQVNEL+Y+ZwisTYFv92wRzRmjCly5avWaLHYzb9VLcIa9T4CH9VnWjfo0UaTJmQ==
X-Received: by 2002:a17:907:d08:b0:b83:8fc:c659 with SMTP id a640c23a62f3a-b8760fc1962mr434740866b.3.1768466116130;
        Thu, 15 Jan 2026 00:35:16 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:15 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 13/19] clk: renesas: rzg2l: Add macro to loop through module clocks
Date: Thu, 15 Jan 2026 10:34:45 +0200
Message-ID: <20260115083451.1064048-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21593

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
index 0fdd4b0aa5ce..ef44c73fc3cf 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1212,6 +1212,13 @@ struct mstp_clock {
 
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
@@ -1324,17 +1331,10 @@ static struct mstp_clock
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


