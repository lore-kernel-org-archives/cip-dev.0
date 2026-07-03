Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E929DC44510
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90776.1783076370359908367
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ClEtMecJ;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso242123f8f.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076369; x=1783681169; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjWRNlvt87pFVin8dTmw01YWGJXQbO5wOmhV2GNCPac=;
        b=ClEtMecJJZlQ4TBaI/rrsyCKJWyhzj/YelHT85EN8j099KCwh0V4zY7Zxq0c0wcjSV
         sDIxBc3t+MZK1V8F89Uh+7eED9MD53BBuQjir3YH6pB4Y1FwCSwAdvJSxg7KCHlOvmpq
         BjP4kHdID5+9mUes7Um1XCsu/mG6FPSaKK2ELWFnEbuLWPKuEXNJf+sRy2wCDKNfduwL
         rXbxXvEz3HfKCxDrqH/DoqKKB4y7ihdiSbllkNcJ4mEn7PsntUnN4GKn9f62OXJ3GnKs
         odnBo863CcjkdgHq2mPskf6Pr+0BoKKBFZNnWIScjUMcKUhS7Rn88r+SUddeuXcgLT59
         7LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076369; x=1783681169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjWRNlvt87pFVin8dTmw01YWGJXQbO5wOmhV2GNCPac=;
        b=OpvEG+VtsH1a60tU6RNwbbBMlbgi9uDUnQzYpJUTD+D0eQ8xs3l3HrcIonSF7SzM8i
         kdDW1uKpg6oKnEJGI1aALU39x5eV+vnKUkBmblTMKu1eB8FNL/8eq4nzqaJb5UCLfknF
         a8ZYOA/YMG8PCOsUnKFkjLVBgnDX22GXjPL1FqTU1PLki2KluqV1fWOWWcnBYKfxR2x4
         WbtGOSCX9JrBBrOyTvOEiaqPAbL/j9MSefjoJmqHclhu+AY3gnjQ3GjS7XV9TaG1yfU2
         YTk5PT+bkXNGYK3WrJXHmJmI1g9XNbhC7P7i9NqpmkzZiQzpzEXtQDyfyIoQG0C8l7VT
         YXfg==
X-Gm-Message-State: AOJu0YyK82/dLE41UJnk6S9sRFmIQu03lcKcdzBU51ohjpZaKj9EjHzq
	PRurRnNTq25LnTx/UPBV0RjXAKsWznh8igZdTc7QLycSosxmf/RnxH922CWAgMxc
X-Gm-Gg: AfdE7cmB5cmr2YN1sSE6VVGDt+1cwBF8jkBlmmW9mANIEiWOgsXApQCpEXYuh2kmhNr
	L2u3F/EZK3hskwLcMgjJ4x+Ihu7M+G0SV1gdS/cQCw+MQPCG8WyWyz9+NljSqW62Hx/iPmM4WIX
	2CM36suXjoFq06L9CciKWqcGDk0bSLWCSwRn8bSz9jEAvoNKLNMncs8MGV6RpvyTK5QqVBlGa5K
	H5bt2XXq/sSe+/A+O0ZHMQjCx5BjdfYyRROnu4IDlPIDTYpNATI8nLFbVGYafdSs5fgy4XfROu/
	wRJ57yr5+JNyQChWs9xA/xjwdOsqjg711ROlnnuOYcKgWm9TXK/s+k4tKHyEZ4V5cTzghnuEs0l
	m7RYEok0yU4HLp/5Z00uBid/6bA/FO9sUStKeykWwWcrf2EXtsrOkL4NMjzrcYeKFuhAtAkaFDu
	YmsEHaxg41/v1ozjgNQV++
X-Received: by 2002:a5d:5886:0:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-47757797b7amr14780479f8f.15.1783076368450;
        Fri, 03 Jul 2026 03:59:28 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:28 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/23] pinctrl: renesas: rzg2l: Handle PUPD for RZ/V2H(P) dedicated pins in PM
Date: Fri,  3 Jul 2026 11:58:59 +0100
Message-ID: <20260703105923.251255-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23427

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit eea549769cb7cae28cc3158befa2de1b7e92bf58 ]

On RZ/V2H(P), dedicated pins support pull-up/pull-down configuration
via PIN_CFG_PUPD. Add PUPD handling for dedicated pins in the PM
save/restore path.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260413182456.811543-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c6af14ffe319..f7cb57e26f90 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2807,6 +2807,12 @@ static int rzg2l_pinctrl_reg_cache_alloc(struct rzg2l_pinctrl *pctrl)
 						       GFP_KERNEL);
 		if (!dedicated_cache->nod[i])
 			return -ENOMEM;
+
+		dedicated_cache->pupd[i] = devm_kcalloc(pctrl->dev, n_dedicated_pins,
+							sizeof(*dedicated_cache->pupd[i]),
+							GFP_KERNEL);
+		if (!dedicated_cache->pupd[i])
+			return -ENOMEM;
 	}
 
 	pctrl->cache = cache;
@@ -3144,7 +3150,7 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 	 * port offset are close together.
 	 */
 	for (i = 0, caps = 0; i < pctrl->data->n_dedicated_pins; i++) {
-		bool has_iolh, has_ien, has_sr, has_nod;
+		bool has_iolh, has_ien, has_sr, has_nod, has_pupd;
 		u32 off, next_off = 0;
 		u64 cfg, next_cfg;
 		u8 pincnt;
@@ -3168,6 +3174,7 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 		has_ien = !!(caps & PIN_CFG_IEN);
 		has_sr = !!(caps & PIN_CFG_SR);
 		has_nod = !!(caps & PIN_CFG_NOD);
+		has_pupd = !!(caps & PIN_CFG_PUPD);
 		pincnt = hweight8(FIELD_GET(RZG2L_SINGLE_PIN_BITS_MASK, cfg));
 
 		if (has_iolh) {
@@ -3186,6 +3193,11 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + NOD(off),
 						 cache->nod[0][i]);
 		}
+		if (has_pupd) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PUPD(off),
+						 cache->pupd[0][i]);
+		}
+
 		if (pincnt >= 4) {
 			if (has_iolh) {
 				RZG2L_PCTRL_REG_ACCESS32(suspend,
@@ -3207,6 +3219,11 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 							 pctrl->base + NOD(off) + 4,
 							 cache->nod[1][i]);
 			}
+			if (has_pupd) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend,
+							 pctrl->base + PUPD(off) + 4,
+							 cache->pupd[1][i]);
+			}
 		}
 		caps = 0;
 	}
-- 
2.43.0


