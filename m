Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F89C4450E
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90781.1783076372657883113
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=g6h5aojy;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-479b7aada85so455542f8f.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076371; x=1783681171; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vN/0eCEM6RDIC9Pk44FT8kdT/Qq6wtrSbdsMOE3I+9M=;
        b=g6h5aojyV0acqRVhaOLQ8ImCwPTbqUH2eXG05Lr895qm4sg69e6dSthqxyveU6gdjN
         rwhX+Cc9hJlajHbIoSyG0SteaYRjJlKisMO551m4bSFrek2bvJZ7/ktAcC6rmuAl6aKs
         i56DIZqXZhkf7/lH8c7639ULLwHm2BQhwh/4LLtyyBA7HfFvHJElUQo9rE7XznGdNlfv
         uXkZya6YedtSojMeRFwSmeVu0ryD/+NDuFSWA5rgfbf6tObw5edj0SaknYlzZU7NzADw
         dt4AB6JARA2P3CHvzexm4JdG/6ucM1iOEU8euz3kHpZGZPm1F93bLOo4XZt54ntGKcAQ
         Z0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076371; x=1783681171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vN/0eCEM6RDIC9Pk44FT8kdT/Qq6wtrSbdsMOE3I+9M=;
        b=SeYflZG/kM3nUY3eZbD4bFFzmFxjqrW9WLItQYTVSfU82Lk+bfHJJDzSfbCVEODTnS
         vn9lNg/iu0QYXaWRFjzYvBezW7cSG3OMM9LQ2cncloNcsgGq9YiTKvF/8m/nxp7IsvEh
         Ls1zQFnsLwpwVqBRZdoo03tOOLUz3L/gm7nJ2+a8GC9Y8QkyTEMgEZeijWZnn+3p9mhD
         OQg0JnZsk6eN6inCEcMPvWz3C4c5vL0nM3Bbj34zbpcf3BF4ZSAaU1ph6bxy4LilU5pW
         VsK4oje9oeap5DklLdUxF8uBUvVKCrE57uGbErYPIQdYClFp4Rc0ZCyLnoglstunBtF5
         I+NA==
X-Gm-Message-State: AOJu0YwrUvMuyx8HpW0n51+DsuNAyCLFE3tocP5Uo09JAec6YEBr23gU
	rmd5J/7WsAhkeIr5qtR1Gl505gdwp/FcltHlTFBK3AfOpFQw4sJhH6GK577A9cYM
X-Gm-Gg: AfdE7cmVTWFtxyCUsH2Amerj75gAy9mM6XN8EiiWLf4roRAqUDNcygGz7tP5eNdzw/7
	7wwFirM70sFy9t8UGPuWBKIHBpaKohwekYW0OtZkjxwIlzcj3jHEaOITDEr6rh/QV5eXi0FzIfs
	Rl+qDCe0pHTmWKNNyoQzM/bYUJNaY/q8ya3FtXeCtiNLlNM/wWIB7e++XGzyofNBRr7mcri5aj6
	CjNHYwdczx0dYTsHR5gV/r3Gkr0XbyVqyPKbRZCeW473GB1/5z6ut5AIJmoF0d/NAyOxg6tdMgD
	2KEx3afJHEbvb5mdBS5yl8KKb0DZKFdDEwJKY7DbLfLOxO+NDJvVofRvS2Jv+puil0NG2n/m9+1
	ql8JeTayR7tuH3Zb3GnH3uwilYWwY+TBQpRyi3MnZ8DTotPrcSd4vnUR0WpRGQ450eVrIm3RiRJ
	tbw6PmsSQ5yCF6tDoHUhVc
X-Received: by 2002:a05:6000:41e4:b0:473:1706:7efe with SMTP id ffacd0b85a97d-477b398440emr13431523f8f.24.1783076370807;
        Fri, 03 Jul 2026 03:59:30 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/23] pinctrl: renesas: rzg2l: Simplify rzg2l_pinctrl_set_mux()
Date: Fri,  3 Jul 2026 11:59:04 +0100
Message-ID: <20260703105923.251255-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23432

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit b2aff3c99facba8174eb594870b7eeb909aa9e1a ]

The port and function selectors are evaluated multiple times
in rzg2l_pinctrl_set_mux(). Simplify the function by dropping
dupicate evaluation storing them in local variables.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430093422.74812-7-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c2976a6b2d5c..780e4c86a7c2 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -689,16 +689,18 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	for (i = 0; i < group->grp.npins; i++) {
 		u64 *pin_data = pctrl->desc.pins[pins[i]].drv_data;
 		u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+		u32 port = RZG2L_PIN_ID_TO_PORT(pins[i]);
 		u32 pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
+		unsigned int func;
 
-		ret = rzg2l_validate_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(pins[i]), pin);
+		ret = rzg2l_validate_pin(pctrl, *pin_data, port, pin);
 		if (ret)
 			return ret;
 
-		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n",
-			RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i] - hwcfg->func_base);
+		func = psel_val[i] - hwcfg->func_base;
+		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n", port, pin, off, func);
 
-		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i] - hwcfg->func_base);
+		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, func);
 	}
 
 	return 0;
-- 
2.43.0


