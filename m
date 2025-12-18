Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7FD6E2A1
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:25 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44880.1766071942652580856
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZS+8mq2p;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so693265f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071941; x=1766676741; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1E4DlRS3Sz6wQ7ZqQJrCzeZLgMNxxjPnWbnZCMK03g=;
        b=ZS+8mq2pvd214z/lj79kd5V0+bO1VnWQ6xa3fpdKZTTWWaee7+Dx/WAVOSycste0sf
         2ju5Wxg7RQCNvNqx5DuKyZyAm5892zDY99U1fZODfUb5VfqB7jWQQOAUsyM0QAP7TNGg
         gRpBwrq0SXulmaAkk4sPCodTxVgYQ/Wm8oAk5lM6EgQEFURLzb2Z7tfXhy2cmU9cs77V
         LJkrow9+9yZmB3YpIXRIVECpk1CV3YU0T8i/GwIgPLpWE/VRJw704YCRYZseKCREkInI
         bY1Cytb4UmU5lb90N0FHjXfOHGSZU6erZS7Igmz7gwWybZ3bGiL1nX7BYLPWL9iWtm+n
         dauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071941; x=1766676741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1E4DlRS3Sz6wQ7ZqQJrCzeZLgMNxxjPnWbnZCMK03g=;
        b=j4MSz9LKjVeBMRNP757uvG87NaYW9PVxvFJkJdJdE3R4bsLw/1QpGN2weU1BGCv/gZ
         ZilEEWiAX+aoNqKD0NRn6yCdgCmnZ+raQ78fbD4BS/cR78FnX3SquVA8woRm1BeN3hPA
         tNh0M+CxHcwnWJkNSSR4t+6wj5vopvH3PUqEai6J7dMunFIUpGCkg5vj2xegpVRxWnUN
         zpfMY43DYM4nuvEw7SKo88zC+ibubCvOpCrO4fDcLcScxqyn+VTKocInZeYSZuwKebJM
         Avbb+B19S9/i5aISNrlogWORe094CMK3m4b/M0ajn9ThhRYcRX7nQI/3lP+/Ira2Kb31
         0KvQ==
X-Gm-Message-State: AOJu0Yw5o5x80fQnzYRiPMF0QJ48ctPx+BjN0SfahE3aUlJvlhoANMYH
	/hD21e1P038KBswvwPYBy90i0pjwDK0X+tt/jbeAI61Wcug3kP5GFyLeBs8YVg==
X-Gm-Gg: AY/fxX5je3iGrIV9tPvTyXQ9b3ag+59sGZi1g+XylpDjak2uXT/KAWSUA4TZNumUleN
	XVkVG8q9TIuw1zM4PBxugsLjIqkd8hFPqry0DrPyWxywG659yDv2DfLlr39MuRtms328/bY8dCV
	jJ54sQEJ4XhmxP3cT18LPQzg+WLqu8X5VNGyqCCWyU3DXXgFeTNgBxzKqfYPZxtQepG3HZUtqt9
	sI5cKYEz/I623EpoUMAyLrw6ctwCd5XCvC2wG6norzl85FsrgZToUqL6EZ3J090A4kPJ4wi3Qai
	wiB5ojmTokaIm3TTSWd1UU7rPtHctb2OobtxsAakoAscHCnKqWDkAp/z+5BUgtSAIV/NOmzkIO9
	EL5mbzz+JAc2Qcc+h9wrFsIZ1tppyUPluFTiWhmSy4auP+DVWiDTrjPiraojKiEoiOdbNt28DyP
	eHAJyyVUIUH0nFF0xjlg==
X-Google-Smtp-Source: AGHT+IH6Fnrb5ZYT2CvgD/eHgOqiu87G3Rd2tUAn09nP7uA5wM6vGs47k7wqSkM1pf5yJ6cHH0i8eA==
X-Received: by 2002:a05:6000:220c:b0:430:fdc1:ffd2 with SMTP id ffacd0b85a97d-430fdc2001bmr13652534f8f.55.1766071940671;
        Thu, 18 Dec 2025 07:32:20 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm5637772f8f.40.2025.12.18.07.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:32:20 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 01/12] pinctrl: renesas: rzg2l: Add suspend/resume support for pull up/down
Date: Thu, 18 Dec 2025 15:31:50 +0000
Message-ID: <20251218153219.228506-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21126

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


