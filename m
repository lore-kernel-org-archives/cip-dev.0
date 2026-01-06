Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E915FC47BEE
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 10:41:57 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.87379.1767696115454316735
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 02:41:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lpK3XSDV;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso303280f8f.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696114; x=1768300914; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgxNHChNWMORsni1KDVLWlOV77fDHfIOccKSgp+KBrw=;
        b=lpK3XSDVHnClU/0BsTwNpClb4yzJKjTeReZrpvNDK6jwjBgEQn1pKgfBE2sOcmv++G
         k1sgDSm0T9ENDcJtcTv2W7OytvB/CvsZohvQgXIu7x5O57cApZEjIvBlVHUwx0S8ULjm
         PSTjZszwxTDYXKZJ+LQTaPVz0OQM1g42sPrgbfcrQXuesJAl6mb7sOVThAjc7uYI2Pha
         STnxg+vygou39GWUCr+8P4EA6TdJeCkwgFOjDaRBoTVHZYoQ3Z9msnlriv5QI9Whunsu
         hn3TDI2ix7AX7mqxK5JUHHQo5foU/LkhE9qlEehHUgOXyqgNBQ2YfOyN2752o6PeyzAg
         kKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696114; x=1768300914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgxNHChNWMORsni1KDVLWlOV77fDHfIOccKSgp+KBrw=;
        b=FU0igZQlwCQYodfCZgzdlpMY7UDpzx2jwqMe2SQ5KdZBzWfMjBaQ0YLQm8X434tVK8
         ZRzOwAWDoqzBjkqB9ajNYuWZuRpjXOW4xiigvdmUE38n78ai+0l4fy4qa1yo7DVUJj6o
         m08CnuvscFp+BPlIqDUGeDUeS4Hi0gzvEZmxIE3ejH9lBwJqm7gOuwULqpFOKqTCEGLf
         k2nCRMjET5+6E1CHdBgIqbfFFK3SHlhMD2FBNaqDSntGyPgjm7lL/1IrGa8DhOt2NJ3l
         quRBxjv0sL3Ifeetji8WgaKDOmQZSRA/64upERDTqfn5ms1kieFOkwRDTadp3C8NstWg
         5lHw==
X-Gm-Message-State: AOJu0YzpAH8bpvd16Pj3coQwKyG/n+R8qhsiqKz3rHzP0Hq+UeYJ4wB+
	DxL9fENSqqH6RuMgHdBUKOOv1ttT6KC/qfRWw7+ZfsmoKCctFBJeHlN27wmk8w==
X-Gm-Gg: AY/fxX7FYzrdxQ6rzlgt05Biiyd9t3Us2B28G6qOARGuuWW9Wl2qwqEby+ysjJK6bg3
	Nxaq5kj9SOeWDKNSvxwGyb/xJHNcwz5JEy5hbpo3F1VMfe/2L5kyUuhLWHafP46/TcJBTPeCChw
	PKI1wgAzKW9HehxQlm4Hpxyl3Uu5qe6pOxWH8CEjNgHjWmf7JxvGXuL1hsVEWx4lnuzFvMDP9qU
	2mepgMLl2m1tZ7o2rmIO7EWo2Bt6GY5rYy60JR3DPoxT/dTZRCA5YvUioIjfaxMtP7/IGjNXDUd
	PXSwKKE9PTFwZnG+7LRm4LdoKCsx6pkPCL4zd/TweZE4Ygsz09Ka7H7eUrTiqHGCuvskPa29leM
	+xNQO134ScBMAAlWWJN9Fz7g7JFejxAthQRfDqVAuuF4mfoeZJnNXr6eSbMzgPue9ImUO4RP0VY
	r5ce3nBSweoDE+Z/MhTw==
X-Google-Smtp-Source: AGHT+IGvZzlnHglg48+PN/msWUHEr0Y1CmoBmRtCsLO+G5mnafdazda2Uvfz5sjwlrbNC/ytFXDifg==
X-Received: by 2002:a05:6000:1ac7:b0:430:feb3:f5b4 with SMTP id ffacd0b85a97d-432bca54010mr3247688f8f.59.1767696113570;
        Tue, 06 Jan 2026 02:41:53 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm3583184f8f.39.2026.01.06.02.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:41:53 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 2/6] pinctrl: renesas: rzg2l: Add suspend/resume support for Schmitt control registers
Date: Tue,  6 Jan 2026 10:41:44 +0000
Message-ID: <20260106104151.88020-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
References: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 10:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21327

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 837afa592c6234be82acb5d23e0a39e9befdaa85 ]

Renesas RZ/G3E supports a power-saving mode where power to most of the
SoC components is lost, including the PIN controller.  Save and restore
the Schmitt control register contents to ensure the functionality is
preserved after a suspend/resume cycle.

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250819084022.20512-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index be46f02c7c03..4a442317f495 100644
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
@@ -3018,6 +3025,9 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
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


