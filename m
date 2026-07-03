Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B34C44508
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90778.1783076371764372499
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DuQF82E3;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso451442f8f.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076370; x=1783681170; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPiM815nQTK+jME9r7FHyYPELldbM4BDk9NJ6JkBdAg=;
        b=DuQF82E3Ef38B7wjJDPl5E5x9OnHIaw0c8Aje607LqmNbiMgWcGC1eN5mR3CSJkYQT
         br4NCs+1Qguv2/7f63BevmtxiiQo1ygNEfdcWMI1B3axzQx79RqmgZNGu/JKTaYE/qNy
         qhv2ZjTBPEw9DAbs9UwlXbR3WRYkr6lPaPP7A+i3C/trzWsEMSUYPLKz3BsVOswvDxKf
         8LrdazK5sQhp9cRnjB68zJygRM6hnKmp7uXROSFUJsCXBbrGSSrF1wquTtwcJeuhraMb
         mrW8MfClxriwASa4qxdYjXNKq/QTMAaFf4IEis3DG96tL7utBOEfUFbm3w70I0BnhmB+
         yVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076370; x=1783681170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fPiM815nQTK+jME9r7FHyYPELldbM4BDk9NJ6JkBdAg=;
        b=DRRb9Zs085IhpSq2okeZUY44GttwcZn2r9Sy0GvLlO3Jcd/oPDSrWQ+D2SmMnlUgYg
         hVZ9ri0PQQEjDzBwx71PpZ6X2o+Y9Jaunoc8ll8wvq8jAsH3aGHbajiqyfrwX6GeuJ9i
         qIzmoTF4JHAa8mkJH07grAIPiwnAN8sftoRkZnveZmMdcW5muC7xnmMCUrODp5gfEvWW
         BHqgF7KcsXEDNRksFdAoCQepvigVm3tNVZ5waIdSFbs+q5jVJSaUMzmEfX2NkhPu+eiO
         c2/0L5fdFGE9dRg85LWxhHOX6qMgiZKbfxKGCrgohOGa6zWHbAjMDjNb1fxELTNv2Um6
         47uQ==
X-Gm-Message-State: AOJu0YwXd1zX/Nmm/yzdNZdOpuwNET/nBjWpNflT0CFThoxUS+XAeNL+
	0M8kZVhowCSDDKKSxfDmzfb6JFs3lZnVaNtEeZWUC4K/o8KE1CgLzppmGhxgHwoG
X-Gm-Gg: AfdE7cmy735ne9kUFCJQisdEf6Czt9gRsLaiZcU9GhtxAdYX227cZ8xzcMh+NRKjwQs
	Z3OZhkOrr4k9c6+UpE31dvOcm5NTp6T501nhkU1SJSKGmC/bqpY97SU1nwNUlj3vGZs0k7MrpP3
	ThRMCBrxcUUrQx7R48udEZ5MBMBbrXlyuOT/SE/Mp2yONuUCcIFuHe1GYsKk2HUqfYDE8FSaVXN
	t2tAtFl8n9fNZYR8O4BsV6fyGI9gWrkHnVH5RYBy7n4uUW7uIcjkqTvz5yhYK1gj6B+LKxEBiqg
	YCIdmRbjk8AAo4GJZOReGhGaMNGh6R6QBr5v/9whgKEBVKX91dCQPivx+//6gXr/U3/lfzhO0Mk
	Z/8D7AYikgFJtr8Vh2oXnwI6Gk8VulxofVNcVvvCWu53rNZkQ/2JRPveFxE9cfqJv+WrMV9dpTZ
	5Xaz6KpgtjIbWknnce3hpe
X-Received: by 2002:a05:6000:4207:b0:472:f8b5:aaca with SMTP id ffacd0b85a97d-47758327ae8mr14951828f8f.15.1783076369913;
        Fri, 03 Jul 2026 03:59:29 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:29 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/23] pinctrl: renesas: rzg2l: Update OEN pin validation to use exact match
Date: Fri,  3 Jul 2026 11:59:02 +0100
Message-ID: <20260703105923.251255-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23430

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit da4a37540b780c386eb2362bfcc638f769918cb1 ]

The RZ/G2L SoC uses pin 0 from a port for OEN while RZ/G3L uses pin 1. The
existing greater-than comparison against oen_max_pin in
rzg2l_pin_to_oen_bit() would incorrectly accept any pin below that value
rather than enforcing the single valid OEN pin for each SoC. Replace the
range check with an exact equality test so that only the designated OEN
pin is accepted.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430093422.74812-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 9136cc352b9c..370ffb829287 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1126,7 +1126,7 @@ static int rzg2l_pin_to_oen_bit(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 	u64 caps = FIELD_GET(PIN_CFG_MASK, *pin_data);
 	u8 pin = RZG2L_PIN_ID_TO_PIN(_pin);
 
-	if (pin > pctrl->data->hwcfg->oen_max_pin)
+	if (pin != pctrl->data->hwcfg->oen_max_pin)
 		return -EINVAL;
 
 	/*
-- 
2.43.0


