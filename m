Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8674C43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:38 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89968.1783076368729257726
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=k01l5KAW;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47640541585so285731f8f.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076367; x=1783681167; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0qdGUX7Hmz5nTpspd9bJwwvOGwuCscYY5TtkjYCyMg=;
        b=k01l5KAWKQXnYqiPwRs5RMhrN+zD2w1CqVIaPv8+RsZXBnDytlvb3fWN5YZRrWjdTn
         hH9WwwrwjtWQupmT115eKbv3GJDqiqZOghMjVNArhRBUIpyku6511bmWhn8ADFfxokZh
         2R1JmwM8U+7PMLeVpGz5lj7R4NhZFlyJzDkOwCh4PH8/XVVvtM6qSfzvFqdeiVyhC8ck
         kAQeFQ1/g3bgJBgL7MUoBJ1vnFqLzFqX81N2UDibwAvKA9xh5vAjTjW6RY1PyEAKtbcN
         FQoRgjMPdQN/32pUvmjcmkS4kzSqeQJwlEMMHi6UGgIvLk/TfKyzRj/rZsaqGPHHgjav
         xeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076367; x=1783681167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0qdGUX7Hmz5nTpspd9bJwwvOGwuCscYY5TtkjYCyMg=;
        b=ODntMaGrFNRG0Ov8P4JfSmm+Fl5ncSlkjJksDjTt6f3Ss5+xmMK7+SqonlFNGqWH0y
         xyFuimX+cXSWk+Slwy4qc1WqGkliDqqpec7Gi6wFo+f30FPc2/ELVl0tFlofN5FAVcSS
         wrLLqBDKxJALmBIHIt80bPqto/ulKCEWHvCkarJ+ACKlknbrSUZIrVKhBZedYuCKQiOR
         /P9G4jXBolGsaBWlOj15VZG1bOrancCJuLKZTlts4w3y/Hbm8DceLb1MXsgQlYdjardC
         cDJguo3p2DGQTgiZeEWwW7dDvw89WXTq6zg1I9RH4sezbkRs9KRhKEiSdGYl7ESDj1QE
         DInw==
X-Gm-Message-State: AOJu0Yw4/NhSQCURrwe+5mqttbHjhZat/Cun7nJ1ZiLdqgmCgsOWRauS
	cLr0yh2TQpC1wx+pXS6LgdbcqARINb9IIoBBGbKeM5Ow6o/8IG6LnQylk8XUAO91
X-Gm-Gg: AfdE7cmQHXU14F2uXJ2Fm8F4oVXHh5t9ICRpJjYF3ApA4j9bWBlNFxez3nD7dB1rCQo
	ae3CP4DbO325AJ7PQUZ4hR83MeG8VnmnYxIwy4s59Pt3d+4olB291dY69VCupOoo7zENXH8X5V3
	nm5EuPpLysHuK4M08k/ncbOR9b57m6bT1U3eqVQoUcOUzyU66ddQsUnSrV0hZKVY7jhZrW7hPCr
	aA17QwWDBjnZy5A5+VSOd3gYM4kUAJilyuu1BFWjZ2lhiQjngesGvC08INEB1Xee3ERRNseIBuM
	POqOC7jblkbpsPItqFmn5UGlS8A+oBbBGXNG92/y+H4sKOb2tDVJVSfgkCinJy3G3KOB7XvxF/R
	hkn9yI5C1+WDw6uMg/XI/FEi+PFJH7reYrrecXHRPMvJkApHu4AKyitDjJu27bC1Fl82QtLqs5i
	iQUxgxTWm4WhQav2xA//zw
X-Received: by 2002:a05:600c:5883:b0:493:b6ee:fcb7 with SMTP id 5b1f17b1804b1-493c2b506d8mr97123265e9.14.1783076366768;
        Fri, 03 Jul 2026 03:59:26 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:26 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 05/23] pinctrl: renesas: rzg2l: Add SR register cache for PM suspend/resume
Date: Fri,  3 Jul 2026 11:58:56 +0100
Message-ID: <20260703105923.251255-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23424

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 29df31ae3e8a0152dd8e8c2376816aad2f233473 ]

Include the SR (Slew Rate) register in the PM suspend/resume register
cache.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260413182456.811543-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 38 +++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 5d4ac07533cb..509f1866e5a4 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -322,6 +322,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @pupd: PUPD registers cache
  * @ien: IEN registers cache
  * @smt: SMT registers cache
+ * @sr: SR registers cache
  * @sd_ch: SD_CH registers cache
  * @eth_poc: ET_POC registers cache
  * @oen: Output Enable register cache
@@ -336,6 +337,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u32	*ien[2];
 	u32	*pupd[2];
 	u32	*smt[2];
+	u32	*sr[2];
 	u8	sd_ch[2];
 	u8	eth_poc[2];
 	u8	oen;
@@ -2769,6 +2771,11 @@ static int rzg2l_pinctrl_reg_cache_alloc(struct rzg2l_pinctrl *pctrl)
 		if (!cache->smt[i])
 			return -ENOMEM;
 
+		cache->sr[i] = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->sr[i]),
+					    GFP_KERNEL);
+		if (!cache->sr[i])
+			return -ENOMEM;
+
 		/* Allocate dedicated cache. */
 		dedicated_cache->iolh[i] = devm_kcalloc(pctrl->dev, n_dedicated_pins,
 							sizeof(*dedicated_cache->iolh[i]),
@@ -2781,6 +2788,12 @@ static int rzg2l_pinctrl_reg_cache_alloc(struct rzg2l_pinctrl *pctrl)
 						       GFP_KERNEL);
 		if (!dedicated_cache->ien[i])
 			return -ENOMEM;
+
+		dedicated_cache->sr[i] = devm_kcalloc(pctrl->dev, n_dedicated_pins,
+						      sizeof(*dedicated_cache->sr[i]),
+						      GFP_KERNEL);
+		if (!dedicated_cache->sr[i])
+			return -ENOMEM;
 	}
 
 	pctrl->cache = cache;
@@ -3012,7 +3025,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
 
 	for (u32 port = 0; port < nports; port++) {
-		bool has_iolh, has_ien, has_pupd, has_smt;
+		bool has_iolh, has_ien, has_pupd, has_smt, has_sr;
 		u32 off, caps;
 		u8 pincnt;
 		u64 cfg;
@@ -3033,6 +3046,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 		has_ien = !!(caps & PIN_CFG_IEN);
 		has_pupd = !!(caps & PIN_CFG_PUPD);
 		has_smt = !!(caps & PIN_CFG_SMT);
+		has_sr = !!(caps & PIN_CFG_SR);
 
 		if (suspend)
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PFC(off), cache->pfc[port]);
@@ -3084,6 +3098,15 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 							 cache->smt[1][port]);
 			}
 		}
+
+		if (has_sr) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + SR(off),
+						 cache->sr[0][port]);
+			if (pincnt >= 4) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + SR(off) + 4,
+							 cache->sr[1][port]);
+			}
+		}
 	}
 }
 
@@ -3098,7 +3121,7 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 	 * port offset are close together.
 	 */
 	for (i = 0, caps = 0; i < pctrl->data->n_dedicated_pins; i++) {
-		bool has_iolh, has_ien;
+		bool has_iolh, has_ien, has_sr;
 		u32 off, next_off = 0;
 		u64 cfg, next_cfg;
 		u8 pincnt;
@@ -3119,6 +3142,7 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 		/* And apply them in a single shot. */
 		has_iolh = !!(caps & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C));
 		has_ien = !!(caps & PIN_CFG_IEN);
+		has_sr = !!(caps & PIN_CFG_SR);
 		pincnt = hweight8(FIELD_GET(RZG2L_SINGLE_PIN_BITS_MASK, cfg));
 
 		if (has_iolh) {
@@ -3129,7 +3153,10 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IEN(off),
 						 cache->ien[0][i]);
 		}
-
+		if (has_sr) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + SR(off),
+						 cache->sr[0][i]);
+		}
 		if (pincnt >= 4) {
 			if (has_iolh) {
 				RZG2L_PCTRL_REG_ACCESS32(suspend,
@@ -3141,6 +3168,11 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 							 pctrl->base + IEN(off) + 4,
 							 cache->ien[1][i]);
 			}
+			if (has_sr) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend,
+							 pctrl->base + SR(off) + 4,
+							 cache->sr[1][i]);
+			}
 		}
 		caps = 0;
 	}
-- 
2.43.0


