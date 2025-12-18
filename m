Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFDAD6E2A5
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:25 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44883.1766071944282676100
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=X4JF0W/h;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so5183115e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071942; x=1766676742; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKPkBHXsyZyeouh0JT1tfkB3YXfMz2HfII4lb6pFafM=;
        b=X4JF0W/hRua3JwWaX2qgWs4RUE92d5c4DYcJqorf5B+Bx9j3YVFpJUYPWjPbkeHY2l
         Uee1plFOGAUBWPHZBgt2DnimJOcWRglX0xdlhJGoPLsjvJsLWUTfRorBXsfgjZRTL+cJ
         OOncebmmWz5/dyCF8k9kxPVfAfatr28H9vCgS2cd6kEvqDVR0AHt5bSzTjbiBoMtyYpY
         4T6JNDEHuSD0JrpIzWwts+jLy3029vXqT6a9C7q/I7bzDwhzPnlu9+wvX8vwiShDWnXg
         JCv+skYg5NsnHRE6Ptq22QdUE21WYrYl0l0W9ELJ1cix5/QAWlWUEgHYxyjXWZcnoAtO
         HLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071942; x=1766676742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fKPkBHXsyZyeouh0JT1tfkB3YXfMz2HfII4lb6pFafM=;
        b=hb29Sb+iMkLQpxcR9FHzOsTs/tL3LqWjhXDW41o3PqQdkqmlfh1W9NIbWows7SxUCe
         V72BeDPjVQHURHcPSltbep42oYbiZHFtt6ztoQQyZTJaLz4CW3nBug8V9HkQbPzDfYX7
         LK07lKO4g5jXRhnXUahPESbvovWxIFNxtLTey/IMt/QuBineGno+zK227LwYKut5kdnu
         Lrnalwd/gc0iIhlFunQfiEgSNK+FFgC+zj88N82zDeJncaVLCfQg+Z6iBSZ0JfTYov49
         WK6gI97gMp6u+0tcj3zvxeFdUa3Dd8j+JBhFKYsYnRWyAyXFJvvxKTT+uLJj303zeWEO
         59PA==
X-Gm-Message-State: AOJu0YzrCQKKiUw2szwz3PkTzXkVb9nWah4z5Ly0V043wAKU+sLV2R5Y
	U36SqvrKJe6+0w4QNB7zmJ7m11lyarZRBsPBu+ctisTbrK1y/zvW4nAnCDY5pw==
X-Gm-Gg: AY/fxX5MgARhz/qT/8c08H9o2pD9yLZdhDavmqH52O30Gvxez1h0wR8mO161AS6iOtV
	c0IYEPotUTABGk9s7RCiW1ZZNwU4GefLMIz8JHjJEypCVwAtcHmSKPy3H/NKFdvNmzvv1mT4nfq
	4foA7EgXNFgbq3S9pQI4Bw464ZDYzbRJttkisC7mat/GpPO3sHBPVPDFKYfqw3tUYz018mdVTZo
	Cycfv8PVxg4QeAzpUwhtcJ9UmbVk+TvCu1Xyz57XiqcIiqt3yyMgqxS1J7jOAax5vbLsXAY1cFN
	ijZAT1WS777pjzleevUXLF4pfl3ZWBreqJVuaC7ZiQ7lSXYO7U0gc6solLG1cMHE4pWg+LwtaUz
	tQrx5OGPZPlxjTm8LK9cpQDz/HtrVesgHkBd9swCgJHbkBGIG++B1SBsB2LG74sIM/5Fn/+oolN
	or9eTTyYHzTWv6LjDkjg==
X-Google-Smtp-Source: AGHT+IHsQJKXAomWspBx37pwwIvsFoTYZUqQgK5D96y805c2zusyCcg+IhJbNm8Pb+/eOYCH4IjOIA==
X-Received: by 2002:a05:600c:1991:b0:479:3a89:121e with SMTP id 5b1f17b1804b1-47a8f9182ecmr218040545e9.37.1766071942200;
        Thu, 18 Dec 2025 07:32:22 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm5637772f8f.40.2025.12.18.07.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:32:21 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/12] pinctrl: renesas: rzg2l: Add suspend/resume support for Schmitt control registers
Date: Thu, 18 Dec 2025 15:31:53 +0000
Message-ID: <20251218153219.228506-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21129

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 837afa592c6234be82acb5d23e0a39e9befdaa85 ]

Renesas RZ/G3E supports a power-saving mode where power to most of the
SoC components is lost, including the PIN controller.  Save and restore
the Schmitt control register contents to ensure the functionality is
preserved after a suspend/resume cycle.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250819084022.20512-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index f8330265336e..c7d6914098f8 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -320,6 +320,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @iolh: IOLH registers cache
  * @pupd: PUPD registers cache
  * @ien: IEN registers cache
+ * @smt: SMT registers cache
  * @sd_ch: SD_CH registers cache
  * @eth_poc: ET_POC registers cache
  * @oen: Output Enable register cache
@@ -333,6 +334,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u32	*iolh[2];
 	u32	*ien[2];
 	u32	*pupd[2];
+	u32	*smt;
 	u8	sd_ch[2];
 	u8	eth_poc[2];
 	u8	oen;
@@ -2702,6 +2704,10 @@ static int rzg2l_pinctrl_reg_cache_alloc(struct rzg2l_pinctrl *pctrl)
 	if (!cache->pfc)
 		return -ENOMEM;
 
+	cache->smt = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->smt), GFP_KERNEL);
+	if (!cache->smt)
+		return -ENOMEM;
+
 	for (u8 i = 0; i < 2; i++) {
 		u32 n_dedicated_pins = pctrl->data->n_dedicated_pins;
 
@@ -2963,7 +2969,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
 
 	for (u32 port = 0; port < nports; port++) {
-		bool has_iolh, has_ien, has_pupd;
+		bool has_iolh, has_ien, has_pupd, has_smt;
 		u32 off, caps;
 		u8 pincnt;
 		u64 cfg;
@@ -2976,6 +2982,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 		has_iolh = !!(caps & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C));
 		has_ien = !!(caps & PIN_CFG_IEN);
 		has_pupd = !!(caps & PIN_CFG_PUPD);
+		has_smt = !!(caps & PIN_CFG_SMT);
 
 		if (suspend)
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PFC(off), cache->pfc[port]);
@@ -3014,6 +3021,9 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 							 cache->ien[1][port]);
 			}
 		}
+
+		if (has_smt)
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + SMT(off), cache->smt[port]);
 	}
 }
 
-- 
2.43.0


