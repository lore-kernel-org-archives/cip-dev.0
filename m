Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A82DCDC18E
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88496.1767701181972170464
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=S+ebjzvf;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47774d3536dso8451595e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701180; x=1768305980; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1E4DlRS3Sz6wQ7ZqQJrCzeZLgMNxxjPnWbnZCMK03g=;
        b=S+ebjzvfQU+gzbXtVVTtXrCwVgU6arCaz/4aitX/nwwD3KX0lJ3pYh3euCAsdzJcG7
         cxlF1EIk7Zi47fjBmCM0x7qS6jgVrurpwf+179ZQbneolAWJJVihIKFmOJtl9ni5EiMv
         v2xeMOJRf/3K4xfoN6v6acH2RwlJOCqmvSCYwQaz3SPFjJMUzPQu65CiqmQVoDN+ulrR
         jKHS7aj8FT7z2Nx0hlTjvkwu3jSLHON3hofckwdHDvLAc7DANczq3yRwF1xU6XS4MlGS
         2Ye9b2Dls9gsm94aCgdWSmHuWvYfCFOf4/+GwZiBaSfj4rjh5uLrrHtzf1SgZKDH81rL
         wt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701180; x=1768305980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1E4DlRS3Sz6wQ7ZqQJrCzeZLgMNxxjPnWbnZCMK03g=;
        b=NUmIE1xiVQnD2p3oTkt4uU4NELcONbbvxKoPEbVpnhxnzyMSZaGq93j6+DUK6S6u01
         4UWZAIu9zNOMDbLtqwjll+iQThBYQHWxfX571rqB5TMgh5sUrPcAIfsJhgMgDQNb6uru
         XvnVG+eWQgV63sn60ZBX3tHX2EeTkucqWf2625Cfal1ry9JDbogtty4QV5EkQ+S6BYl2
         lbtfGEGxG5Hy3K/4XGT09W7ZXE7Abf+ng1wyMiHo2eTcS9ZYN6h60N1Lu1o3plpUw6Lr
         TAz+wjRvpXOHXq0HWtMDMi9D0GOAe5CHu8qxhkMQyEFuzA6rRjFzwWCV2jVW+REk0Yex
         wR2w==
X-Gm-Message-State: AOJu0YxAaizhAZ31h9WcNjrrNy9/YZQeCLOvVwRLVGZ1sasTpQxCpwLs
	raRwXDFB82Fb6LVyTun1cWCZynlovjaPMtlxQurbF4+ygdd9VaEME2TPt7HfIw==
X-Gm-Gg: AY/fxX644r+OPZPZPXagLK78nHtTZ4M/E2jDZANsD7F/EQERoFzcoxfKU/9CTbKq6zN
	Sa924uHRucw3eR5xq2bhY9aQRYPDW8aY07bUyUppBf80HQcymTg4ajaxmJjDsl02EVt5AP86PN8
	E7oELZUIg4Xw/b3n/+MmjL5W9czzulBobLi3erNSr/n+OidwGqFU+1x3tnU3ZSvpS6yFoGkImxF
	G9DmCkBa2SuWmWgnZVKrxo/d1uSYcqpRiAIWm5ZHn5VBYeX5mfc7Jlxc584ffvO+rWT2PqxBbfy
	WXStTVXBip96dz//JiB9Vl+YN0mAX2Lk2v53+ptq2hEVAuIq6JJAIYBcYchBM29Q5uRKIj1Q1cy
	s0kt98iNzBzJXKCfvTr8gYq6ff4LXFhZeB62N7/xXe/mO23wWoagQ7ihNPfKGz0yIa+xfUzRHN1
	BaEcPMOv0shAvOiHxAnA==
X-Google-Smtp-Source: AGHT+IGoUH1CplNXX9jZj7tCfmxH1TxhCnJqNqPfz28Bm4tfAkD4ggcHXz2oIUaU7Pkoy9V39Y2TGQ==
X-Received: by 2002:a05:600c:1f0f:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-47d7f422387mr28516745e9.15.1767701179963;
        Tue, 06 Jan 2026 04:06:19 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:19 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 01/13] pinctrl: renesas: rzg2l: Add suspend/resume support for pull up/down
Date: Tue,  6 Jan 2026 12:05:58 +0000
Message-ID: <20260106120618.181104-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21361

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit b2bd65fbb617353e3c46ba5206b3b030fa0f260c ]

The Renesas RZ/G3S supports a power-saving mode where power to most of
the SoC components is lost, including the PIN controller.  Save and
restore the pull-up/pull-down register contents to ensure the
functionality is preserved after a suspend/resume cycle.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250205100116.2032765-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 8475a1f5fcc0..b196105ab293 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -318,6 +318,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @pmc: PMC registers cache
  * @pfc: PFC registers cache
  * @iolh: IOLH registers cache
+ * @pupd: PUPD registers cache
  * @ien: IEN registers cache
  * @sd_ch: SD_CH registers cache
  * @eth_poc: ET_POC registers cache
@@ -331,6 +332,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u32	*pfc;
 	u32	*iolh[2];
 	u32	*ien[2];
+	u32	*pupd[2];
 	u8	sd_ch[2];
 	u8	eth_poc[2];
 	u8	oen;
@@ -2708,6 +2710,11 @@ static int rzg2l_pinctrl_reg_cache_alloc(struct rzg2l_pinctrl *pctrl)
 		if (!cache->ien[i])
 			return -ENOMEM;
 
+		cache->pupd[i] = devm_kcalloc(pctrl->dev, nports, sizeof(*cache->pupd[i]),
+					      GFP_KERNEL);
+		if (!cache->pupd[i])
+			return -ENOMEM;
+
 		/* Allocate dedicated cache. */
 		dedicated_cache->iolh[i] = devm_kcalloc(pctrl->dev, n_dedicated_pins,
 							sizeof(*dedicated_cache->iolh[i]),
@@ -2951,7 +2958,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 	struct rzg2l_pinctrl_reg_cache *cache = pctrl->cache;
 
 	for (u32 port = 0; port < nports; port++) {
-		bool has_iolh, has_ien;
+		bool has_iolh, has_ien, has_pupd;
 		u32 off, caps;
 		u8 pincnt;
 		u64 cfg;
@@ -2963,6 +2970,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 		caps = FIELD_GET(PIN_CFG_MASK, cfg);
 		has_iolh = !!(caps & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C));
 		has_ien = !!(caps & PIN_CFG_IEN);
+		has_pupd = !!(caps & PIN_CFG_PUPD);
 
 		if (suspend)
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PFC(off), cache->pfc[port]);
@@ -2981,6 +2989,15 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 			}
 		}
 
+		if (has_pupd) {
+			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PUPD(off),
+						 cache->pupd[0][port]);
+			if (pincnt >= 4) {
+				RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PUPD(off),
+							 cache->pupd[1][port]);
+			}
+		}
+
 		RZG2L_PCTRL_REG_ACCESS16(suspend, pctrl->base + PM(off), cache->pm[port]);
 		RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + P(off), cache->p[port]);
 
-- 
2.43.0


