Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A49ACDC18B
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88525.1767701183221796356
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aPvojkB8;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775ae77516so9762435e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701181; x=1768305981; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKPkBHXsyZyeouh0JT1tfkB3YXfMz2HfII4lb6pFafM=;
        b=aPvojkB8ilp+f7zAOB+Vn1/lAA6MmEVo0e79wqQ/uWeE6GQV5JAJA4xWMxP8Z58aLo
         fzsCGutiVLvjEtAWYDT61QAKM7xF4CChIxnsGJTYXnbgvqBfx54W3LFDT7B/YeVCR/J6
         RqcpoRCHu0iB12HT8ulDNgv+gt1qyq9VA/ACJNfKlGUNLg/25Hv6o7fTI3na5F0yU8TH
         XF+V1tJUClmiyu0Kpgbx7FS8+COTPASXDjuwESD/nFtb3EuEEESadvWda22+2KJ9kAa/
         WIB1mczXaDucd08U/EjAWghDfZuODleNthblKulqEjaacM6nTM8SVBFUmmkDoL1R3/iK
         5fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701181; x=1768305981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fKPkBHXsyZyeouh0JT1tfkB3YXfMz2HfII4lb6pFafM=;
        b=ce73+/R6Av5dboEsvHISZGEAetlu7d1xWdfih01Cn5vyJ17TBmpZG0aH59jQvw7Cu2
         9y1Tdgx4bvmD3EDG4Ous7N7k5rSOvcTtNTNICc4sAjvRsyfdHAUpb1Btacwglsk4Znj0
         rXuBWUeX0dYXyokYYSR27ZdiEC2YHwfiNzLHqc1l3sjYdUG3lzS42H6wMR5eqX2m06Bu
         R7kBdUIlHmiaAw9oCR3ZhM+BdKeGfgLNk/q2jiK60s/VRT7m8/hbys8m3zbaIl2/VpRQ
         NcVZg4v92h1zjL0XE/MCY52dBIjkUteCQ+AV/8Enl+WR6UrtdV/RmMuWVy2uBg5ToNsA
         JHwQ==
X-Gm-Message-State: AOJu0Yzl4CBn5PQgRe7RM+tBEjGILacOhMJpWjV94a24PE/dTikcJYMa
	JN39VgxpIMeDkN7PqdXerw+A1273D1rqUW61SlHWHI3ZMnNb0/Eg5uLzT4Ieeg==
X-Gm-Gg: AY/fxX4jB8LggcHYVpniRTzfGatxhl0KAKJCnLDLwndMzqO1QBDnph++oPX82csGEhF
	8IBjUBARFpZD/a3b7x+rsTP13HNoD7L2PeFpqSCR3JloC55XZ49tvdTWE9H/H2U4fDLuGXhCMsr
	DOiYV+WEz09vN7sNtFFKqy1jFu65DG7KgJ9VzOInUqk+bP+fQFK9VJ+0SzdjJhc8RKF1s2tp7tz
	CRiWTUB0HSJ7anWRgImz3Ncv3M4VOeT2sYNFQraS7R0BE3rGOggQbSutLM7X6clSqI9CPZmATOC
	j9iWk0MMY1zS9ohkFAWnCFCCMJ6w6C+m7rkVJ4n4RTAdKCkJ5ql6pJV0UQiyrcC69alEr6XMCMh
	ZKCDahdPxnB7qkDpieTKz2Chjhn/IN7Af+6nLgHvabHzO9r2UEkmAxYQ7GIJkFULxyZNf0SY5Gk
	+YZssA7DQSjgdSxbWcsw==
X-Google-Smtp-Source: AGHT+IH97PKM5A/8IscAFk3A95eWRtY61c/EQYWo/UMxozNBXSNBFjGvxbAtjm59zQTq6szAytSUzA==
X-Received: by 2002:a05:600c:8484:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-47d7f06ba9fmr32751865e9.4.1767701181371;
        Tue, 06 Jan 2026 04:06:21 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:21 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 04/13] pinctrl: renesas: rzg2l: Add suspend/resume support for Schmitt control registers
Date: Tue,  6 Jan 2026 12:06:01 +0000
Message-ID: <20260106120618.181104-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21364

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


