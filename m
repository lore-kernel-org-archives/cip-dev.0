Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA360C4450C
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89969.1783076369025872899
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BRmJ5mZD;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47488efcf30so283088f8f.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076367; x=1783681167; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qESb2V8wJ3GZxYbQGdZAHkU3RAjr0Hr5t2mdWIT+ezM=;
        b=BRmJ5mZDjzSRSmIamGbX9zNToFiIdRn4c2tTA29fKi/ewy3dKXNvz+hhQPUNXvWXnn
         pxFTk/auD++fkV9hVus1WJRFBpJPaQYDasJu8eCAa+fHh4dVasQPquQO9DLPswJcquo4
         Wc/6K9I37LWoB+WBtjR9amRsrDpAFi4gpAFq5Qkc+dMr7/+rUvcOiWzzN5DPXMYwfYhA
         yBF264x2LsIlxGuFDiBegUCMAcJvCz1cS5M+X0sikmHHYISvk/Jue+q35JGg56ZKbMfX
         V8u+8ixkzitNsrGxEd+gcjVNvShkYyGkKl1tFPqmRusZyvSl2juifd2C50qx0AeBOAUF
         moTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076367; x=1783681167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qESb2V8wJ3GZxYbQGdZAHkU3RAjr0Hr5t2mdWIT+ezM=;
        b=gx/X7yxQrB/tOFmr2y074SBbzj0hFg4IppluwvBAq+hiGjpGjqC32SWgqD93qNzWBM
         KgoIYs0Q9Pxky+FiGW+s38MHT9cBiYXautyF7f7OTpj1dDIU5F2cH16PyDfsz6teYy/g
         OH/t2ECpduIAi/gOFgt/oRU2B+e+ONwh0HgDJ24RfJ+9FvXYqrPO3LdvddTdxEmua80+
         Lsk1yXDpS8GvgcfIxwRlkLlpJ+CNw+EorEWmH55YKB83Cd66Ln7vNdr9t1UvorbMLAXE
         S98e3zBu3dkiXPd5Hl9FZ5O8FT7xK5/zHH9PNNUCRQ0H4rEYX3MU+7anWHZqCyrNuJjN
         AZBQ==
X-Gm-Message-State: AOJu0YwutYFfqdMMRpS1BjNbE29xvaHyRH9YUuBlmkqp+6ikbTJnulAn
	Fme5itWETWuz15a2l+6XyLAbq6AAQrcbapLO7FjweYy0sDC3F1ST8V55RKhlVrYo
X-Gm-Gg: AfdE7cm9U3T1PM4OTV3N22U8h4y2jJwdMkJCVjItl59SLO81fAyhr7vI7mdSFEuz9M6
	vOO7RV6yY18d64ojS08P4Rx3fLkS5kXFiPVV9ysA+0xOZL+P6oeiGWsMyn7qRLBMcXMGz+LKhjt
	bZf1FNMmd59lOSl0EkeQVuBjGGZttdxeYkQErl5TWsILBFrXSUjEjzFGnudJRJmCVb6cCZRWuPG
	rs9qIXp2Ake05TWXSfwqsWsW13rbjQKg2DANR8Kxa8YxoCDzBe3QBLsQJqLSIYPrv/aY9fWvvmX
	silK/whomt3pOXuorVa1gH1Y/mZF/Jt5HBybdh+a6VgJX2Hta+eH0UVSX5vwIesA/X1jogU1bDk
	jtLDV46DwPEBWdgnC1maip6ZRgyBRbTlz/w5lgBj5jTSdADYUvBw43VF4G/8LCc+y9UhXA0/XlB
	dsGb1dDPGBXvXOG9EIrm/z
X-Received: by 2002:a05:6000:29db:b0:476:cb01:6393 with SMTP id ffacd0b85a97d-47757e57fc1mr10986093f8f.11.1783076367231;
        Fri, 03 Jul 2026 03:59:27 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:26 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/23] pinctrl: renesas: rzg2l: Handle RZ/V2H(P) IOLH configuration in PM cache
Date: Fri,  3 Jul 2026 11:58:57 +0100
Message-ID: <20260703105923.251255-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23425

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit d0fc9f8eb2ce55eb00dbfdc0f19c844df5aee5b8 ]

Include PIN_CFG_IOLH_RZV2H in the IOLH capability checks when saving
and restoring pin configuration registers.

On RZ/V2H(P), RZ/V2N, and RZ/G3E, the IOLH configuration is defined by
the PIN_CFG_IOLH_RZV2H capability.  The previous implementation did not
account for this, causing the IOLH registers to be skipped during PM
save/restore.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260413182456.811543-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 509f1866e5a4..8d04aa031a71 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -3140,7 +3140,8 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 		}
 
 		/* And apply them in a single shot. */
-		has_iolh = !!(caps & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C));
+		has_iolh = !!(caps & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B |
+				      PIN_CFG_IOLH_C | PIN_CFG_IOLH_RZV2H));
 		has_ien = !!(caps & PIN_CFG_IEN);
 		has_sr = !!(caps & PIN_CFG_SR);
 		pincnt = hweight8(FIELD_GET(RZG2L_SINGLE_PIN_BITS_MASK, cfg));
-- 
2.43.0


