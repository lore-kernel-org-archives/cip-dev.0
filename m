Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFDBC4450D
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90775.1783076369890095353
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AM75ODhL;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4720d22c94aso426969f8f.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076368; x=1783681168; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwf2WmsY43/4pD8UU9kf9L6MWzH5t8oDyRFflPMPRQM=;
        b=AM75ODhLxqCtP1U/PRaakYTXy7XIHWl2IaBNtgLR/o+99mOVKHAsvPxvPOnhJcdIdU
         D7SqXqHZBIbzY8FMKiuFSJXRjfS9Sx3eeyQAvcAd/LHK33auZ1l41ruKHwj2w+6Fhx1F
         5rAJ6F9M3HOfJu6ehuSLEWecRcSVhs0PFIKcgAROZQZPxftX5wJxCOwlRNWFOL+9deR0
         T3yzvFyOe+HBwClv8Osal1tphS9akcBwTLWSl1zVMUL9OSsAiA+Fxlodn5rHY11srqSg
         u6WeIQeBcUIysgqdd26CAuFSAtEh9WhtIbbOWFjM42JJPW5LaTpBh7uD3xKNVPp2nGBF
         sikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076368; x=1783681168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xwf2WmsY43/4pD8UU9kf9L6MWzH5t8oDyRFflPMPRQM=;
        b=VfTqBKqvwvGfKwI+BUHJYNuvgYPAj7qogiNsxDnYK+GU4QNhBCOZx/+Pbsh+zcFOt5
         OnfS+W7MWOO4CL8bmWf/g8yymLJXc6Bk44Sqp8J2AjIAgIsKmrSyvWWZNwpdNeuymGKp
         fhlH47CuYjmv6tr9tFkScwDa3uOZi8lhip37y4HjjK+30AKB5ihB/TvNLx/fEsu8o/Ii
         T0Qc6Nc7KukmAJ20whZAE8lFdPAPEn+h4+13la3B+ayK19nhUOS+9d78MZ7lCZXvn29F
         XR/LG0I45UFezkxIwLZ9gFhcJm+/zS5hi442PpUvaHQKudmfTuyU16KaLHFfQ9ebqtyd
         9LXw==
X-Gm-Message-State: AOJu0YzJ2iM8nSZxJLu8yR3yqN6Xe0C5hQoBGJ9X/0+rhTfh3t3f4Wjb
	iC4jDrxg7ADMbFdNuPG2QcOFd6nYAn9UeKyWwGGo7uCxZ5msCJW8v+DmFONGUhi9
X-Gm-Gg: AfdE7clwU+kIzwoMvisct7XsyInaD8arsgBK/B7KflhihmpB8jEi0SLssTPXH7uwxWh
	61AEObxdpPepyiTJIOccAAy6P4/XSpFeHYCDTbFcenVFWTUPXvuBBYsnO90tWE6Yfx9K0yGTUs3
	A0vBvJM+aQfPM6H9M+mdU4qTGQGDuOojmtd/smE8DX6x/5FqYleHM0Z17BdEnbLOQHn6on8g+JY
	7X7NekgrESeVOXoWluxbOCRCV2a3mXocGppCNE4xvjf6x+UBykDxyMRNHm1NXvJyX5xTu61971z
	irvgijfQMfgeBcTNBd3Lrs3ekQUsA5itwb7S8CW5AjiUHT3dFtJRRQa4SVDcQjabFE7UL+/VzDh
	j4rD/2untKBntxE+uAB1DAGI6Dx5LeitGKHWZnzFYS7pG99/CfNhJ3AkcnGMeUGxhmSPiFda7dy
	lQchQLS+xUHQuGsDg2vv6h
X-Received: by 2002:a05:6000:468c:b0:474:3b78:b229 with SMTP id ffacd0b85a97d-477aeb5c73bmr9069956f8f.11.1783076367831;
        Fri, 03 Jul 2026 03:59:27 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:27 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/23] pinctrl: renesas: rzg2l: Add NOD register cache for PM suspend/resume
Date: Fri,  3 Jul 2026 11:58:58 +0100
Message-ID: <20260703105923.251255-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23426

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 25e71db480358c1993f91e69078cb5d9b26cd705 ]

Include the NOD (N-ch Open Drain) register in the PM suspend/resume
register cache.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260413182456.811543-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 37 +++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 8d04aa031a71..c6af14ffe319 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -323,6 +323,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @ien: IEN registers cache
  * @smt: SMT registers cache
  * @sr: SR registers cache
+ * @nod: NOD registers cache
  * @sd_ch: SD_CH registers cache
  * @eth_poc: ET_POC registers cache
  * @oen: Output Enable register cache
@@ -338,6 +339,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u32	*pupd[2];
 	u32	*smt[2];
 	u32	*sr[2];
+	u32	*nod[2];
 	u8	sd_ch[2];
 	u8	eth_poc[2];
 	u8	oen;
@@ -2776,6 +2778,11 @@ static int rzg2l_pinctrl_reg_cache_alloc(struct rzg2l_pinctrl *pctrl)
 		if (!cache->sr[i])
 			return -ENOMEM;
 
+		cache->nod[i] = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->nod[i]),
+					     GFP_KERNEL);
+		if (!cache->nod[i])
+			return -ENOMEM;
+
 		/* Allocate dedicated cache. */
 		dedicated_cache->iolh[i] = devm_kcalloc(pctrl->dev, n_dedicated_pins,
 							sizeof(*dedicated_cache->iolh[i]),
@@ -2794,6 +2801,12 @@ static int rzg2l_pinctrl_reg_cache_alloc(struct rzg2l_pinctrl *pctrl)
 						      GFP_KERNEL);
 		if (!dedicated_cache->sr[i])
 			return -ENOMEM;
+
+		dedicated_cache->nod[i] = devm_kcalloc(pctrl->dev, n_dedicated_pins,
+						       sizeof(*dedicated_cache->nod[i]),
+						       GFP_KERNEL);
+		if (!dedicated_cache->nod[i])
+			return -ENOMEM;
 	}
 
 	pctrl->cache = cache;
@@ -3025,7 +3038,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
 
 	for (u32 port = 0; port < nports; port++) {
-		bool has_iolh, has_ien, has_pupd, has_smt, has_sr;
+		bool has_iolh, has_ien, has_pupd, has_smt, has_sr, has_nod;
 		u32 off, caps;
 		u8 pincnt;
 		u64 cfg;
@@ -3047,6 +3060,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 		has_pupd = !!(caps & PIN_CFG_PUPD);
 		has_smt = !!(caps & PIN_CFG_SMT);
 		has_sr = !!(caps & PIN_CFG_SR);
+		has_nod = !!(caps & PIN_CFG_NOD);
 
 		if (suspend)
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PFC(off), cache->pfc[port]);
@@ -3107,6 +3121,15 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 							 cache->sr[1][port]);
 			}
 		}
+
+		if (has_nod) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + NOD(off),
+						 cache->nod[0][port]);
+			if (pincnt >= 4) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + NOD(off) + 4,
+							 cache->nod[1][port]);
+			}
+		}
 	}
 }
 
@@ -3121,7 +3144,7 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 	 * port offset are close together.
 	 */
 	for (i = 0, caps = 0; i < pctrl->data->n_dedicated_pins; i++) {
-		bool has_iolh, has_ien, has_sr;
+		bool has_iolh, has_ien, has_sr, has_nod;
 		u32 off, next_off = 0;
 		u64 cfg, next_cfg;
 		u8 pincnt;
@@ -3144,6 +3167,7 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 				      PIN_CFG_IOLH_C | PIN_CFG_IOLH_RZV2H));
 		has_ien = !!(caps & PIN_CFG_IEN);
 		has_sr = !!(caps & PIN_CFG_SR);
+		has_nod = !!(caps & PIN_CFG_NOD);
 		pincnt = hweight8(FIELD_GET(RZG2L_SINGLE_PIN_BITS_MASK, cfg));
 
 		if (has_iolh) {
@@ -3158,6 +3182,10 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + SR(off),
 						 cache->sr[0][i]);
 		}
+		if (has_nod) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + NOD(off),
+						 cache->nod[0][i]);
+		}
 		if (pincnt >= 4) {
 			if (has_iolh) {
 				RZG2L_PCTRL_REG_ACCESS32(suspend,
@@ -3174,6 +3202,11 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 							 pctrl->base + SR(off) + 4,
 							 cache->sr[1][i]);
 			}
+			if (has_nod) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend,
+							 pctrl->base + NOD(off) + 4,
+							 cache->nod[1][i]);
+			}
 		}
 		caps = 0;
 	}
-- 
2.43.0


