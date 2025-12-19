Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651BDD78771
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 12:29:29 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15747.1766147360349363410
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 04:29:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H0iX/FZH;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so2160413a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 04:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766147358; x=1766752158; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTcvG5U/AjQMa392CPx9cMNXh5ceQnjkIkvEbTAPUlI=;
        b=H0iX/FZH+N2R3a3LA14TZK9UnjUld3Dvk2AMPtGRTel9SPLyaxCTju+QzF/47zjTtT
         cyjgxJS6HsOj+5bH+zPQXiF3QXNgv8S35jrZchnmJbfWfU4x2LIfIIfgeFIad1ynzFdQ
         snXIomqh/izUfqRNzDH84lixyktzWqb0QjWydkyPlI1K2K+Rzzr8zPPSUKwdxbArDPm1
         ve/D4za9nO4Kx3yqCvBcj3NG9l0ozJImqoBmW0IUlXNmQaJPf4KhpId7G4jipYJp9wk6
         HBF7Gk3qWAUdHQOwj5T00VqxIlrv/cAFSKFxe+yeGLqwbgE+tx1jh9EFOc+0JoASf6mo
         MSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766147358; x=1766752158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTcvG5U/AjQMa392CPx9cMNXh5ceQnjkIkvEbTAPUlI=;
        b=aIqgxkLhq21Q6dyoiSInnkQpq7JCUg3oDrB9VTId7hy9ferPqMcFNGzbteq8i+6V9H
         5uEuIsCTEhFAr+7UcTpwHcAJMX5bYZaOVeHfD2GasVw33/wUnDw/v+u0BfFl8yUY8NtO
         W16AHDpoSUpBe0ebyZaAHYLmt6/Vzzj2emTG7jH+g1ARUvJOWn2638WKvHTqWhO5aK67
         ewhy1cuRzkwshawLY4a5tTsqmT9NXxmEf3DbkEIBqV9qMQYCkLWx9clzMmRPH3nqZV4W
         ctxAvGo7O8szLVwZBLW2DcdoW4tfP+STsYcjMk3NuMNplic+OAxIcYNuju7QMtuwcnwA
         rwpw==
X-Gm-Message-State: AOJu0YzMlba/hiNSka6LBMYBRZ+Ds+vG+HLUJFjYdpajXA7TJ0HHWC/k
	pxUVINzdr8YzCFxRhOGf3yG4wBBZRcEwPxkUa2dNBly5B9MdoFJLLPfOPEZvxQ==
X-Gm-Gg: AY/fxX5eEsh8BDlZibzQo92RKOWbDSSRJNTjgTrIcwTDWjxML3UVmKcAP+51sPRXb8S
	uYIeaSdWjTrgzSi0mijHjaVCxDGuCJIFGKoodzq2jmD54xcf6YcGX42hLZ7eSHYuHCBoMMCeQkx
	ZLPwv8gfexdXJ683QwD3iPaCg0tlkNHwc/+2nqsfXj6tgpdM2Wh8eXj7SpDHoha5B6/G7kU7+yp
	n3WXnrIjsgZsbQQJJKt6x+RuAKEha9PzqRIM3ow1bzF9oIeeJ/RcuYQjwvEa6fByacBAdrI08Qi
	IJfkmPnFGkXrOg2v7ab45m1g2b9sT4eGS2MV4C1x/ZtkoWlVeAbWG5WkRrP2EIWlJLuzN5V1KkR
	C06PUjnIp9Pt3o3T9XsaboZkBflkky4FlrGpVVwJ4kapqIlAE6OknakbDwtWDFTOsBIvHksUX4K
	5q+JYlhx7vdsfOfVWZjZGwTz7XB8exruZ/8g==
X-Google-Smtp-Source: AGHT+IF2IdkKrqHJE90h+Nfl/tuqhJQucVAAYzd28ciEeR84J43IfhHKrZfmu46XxyFsa2SwS2KLaA==
X-Received: by 2002:a17:907:e118:b0:b80:4066:aeed with SMTP id a640c23a62f3a-b804066af72mr107621166b.57.1766147358404;
        Fri, 19 Dec 2025 04:29:18 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bb1:f7ee:1376:35e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f511fesm223648666b.65.2025.12.19.04.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:29:18 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/5] pinctrl: renesas: rzg2l: Add suspend/resume support for Schmitt control registers
Date: Fri, 19 Dec 2025 12:29:08 +0000
Message-ID: <20251219122916.129256-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 12:29:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21176

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
index a8887acfdef8..8b5a8f0b2c4d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -321,6 +321,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @iolh: IOLH registers cache
  * @pupd: PUPD registers cache
  * @ien: IEN registers cache
+ * @smt: SMT registers cache
  * @sd_ch: SD_CH registers cache
  * @eth_poc: ET_POC registers cache
  * @oen: Output Enable register cache
@@ -334,6 +335,7 @@ struct rzg2l_pinctrl_reg_cache {
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


