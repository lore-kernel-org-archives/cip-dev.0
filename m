Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0898BD33A3D
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:32 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31334.1768466186305927304
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=QFPCdKZ+;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so1331941a12.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466185; x=1769070985; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLrKsUKq42gjyo4U+pzTkejs8sL+52pdjk2i6snybIo=;
        b=QFPCdKZ+4hqv4FK3W5SBXOlir5DseaoKZuoe7eijyJrpwn7RpUB4Xi9sGif3Vke019
         u0GNleJ+l+1qoA2gVt6UrEd5dMmtkI4XeT0enmO+Iw/e9sBOsep2AzEkbcNuwdiCaHxj
         SyZOkS4kpCK+0aVcH5ZkqlU6QtfGm/KJiu7lsj64tKlQzRsZ2CONnKLjXHVPGc92o9cl
         mSekbuadfhz6LhK7Ar+w3VcvgPYE+xXN2kPwtFAv7IP0LUdklAPVXn23dUkSCSjVTM/n
         k8+dPLF2c+vZEvTzDHDWmJs3EAOJVo39+dj9kGXtEgOidaGnCi0sPHI2VWHF8sE5OSxR
         U8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466185; x=1769070985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLrKsUKq42gjyo4U+pzTkejs8sL+52pdjk2i6snybIo=;
        b=rmRQWo7BYGeZXMQCDnPEmRO2YiXSTW+aFzL37aVJfl7GBQu/CFUI4rnqgFpv5GzHe+
         R+09Ue4RdsDz8GGzsBksKEND0obd3PcGNipySpqVp1FxAHE+Bvsl3voGoc3o2tB07K3T
         vdNi0Oc5gVbugVbsxvyurWeggmnPvNsLpr5ijSUkwM37i8kB9+8SgAwO36fa54EfQAHX
         +Eswikst6KitQL21TuHL0dHV8tVl3t2NESxtBKfXS1YvplCTgwd0y0MUmhaZX3APZlac
         8y0ka7GPwb0D1P8zsTn/hCHP+30dfYEVi8FFa+uzol/OH7B5D5fjzmdueIBvdJjcLW8E
         nshg==
X-Gm-Message-State: AOJu0YxiKWkyAlWLxET9oU1Jc6XaZr8AfvAz822jAxZKE9rwoO/rntn+
	cSkmUXSxTI7eA4QlSVFUzT5gGDJS8E3o3IFPsK3Q4ICuUI7yvi7Lg+/HqGefLoXdjiQ=
X-Gm-Gg: AY/fxX6PNq0r+3uNcr7vt0U083CPGlqMALhb+BzXWRhpaOsiRrwv1c4ynX7F8GI1284
	6Wmh9tsMQ2uFVqZIJR2RDe2mRcs47wHtSFJkw8OzjhIe+9JALwtU5gffm4ToY1yBwIBchF6CRD+
	qSrC3azUvtDtwwQmTfygDjfvxtEJ9mbstjrR3yxi2J8w9uoy6uOREmSfctGOPl4PfA3Q+4J0cJN
	GjgwpDymz+3BPzD+r7dGcabteMChF1ISn/KRLbkfHQra/gCLcjcXf1uTPgbuvLsE27mLFsTK7jo
	RLFoHU1nIG9Gcx9nOjMDmf+yB2LGrdC+rJpTwjv8rBOLG3SoQcs7PYhvc2uiAARGT/2o5ElckW5
	atHKYL0v6RY3RfE4ZPbe4M7mOkQmrDg4MJ0u3fu88KtSO8oaEpitJPoZCbLlN76TvHI7LN8NfR+
	2PQlo35daIYhvDhF0itdo0ICCSeANYcJuS+t1weGajLMWt75y8a5eDSEgJjxhPa3fuzA==
X-Received: by 2002:a17:906:4784:b0:b87:2f29:2060 with SMTP id a640c23a62f3a-b876108aad9mr540277766b.26.1768466184667;
        Thu, 15 Jan 2026 00:36:24 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 10/19] clk: renesas: rzg2l: Add macro to loop through module clocks
Date: Thu, 15 Jan 2026 10:35:54 +0200
Message-ID: <20260115083604.1064260-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21610

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
index dd94eca21b19..fa5cfce2e9a1 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1207,6 +1207,13 @@ struct mstp_clock {
 
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
@@ -1319,17 +1326,10 @@ static struct mstp_clock
 *rzg2l_mod_clock_get_sibling(struct mstp_clock *clock,
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


