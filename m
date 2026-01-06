Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62068CDC184
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88500.1767701184949933105
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CQivYCuP;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477632d9326so5363535e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701183; x=1768305983; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvRccwHu/rlYn5iMvbvj6t+tNweNEArPCLz1vf1v6os=;
        b=CQivYCuPTXWO/oJsmFORtB9KUi9YyTK1Jk4YGKP0l6zzjhfQy26QtlxfKJOI013drD
         6BDoifmfUlTIr8wcSPxgqK1PF249gKL2Il2KmYTfc0Wu5D6zt9aq+iTKbKr2h1aFJoRl
         DKrEv3tpVDfpM3F1C2ALGIhk5Pi7Jwu4QRRdVEJLkW48Zv7z4BmWmqGlcBH/f84nuTQl
         NQxmsVhyNHjH2o6VDHlDQjJ0MLSPw/j9LAr+3QHg/V/x5NPy6pThn8vFGx/quJbYD8x6
         dYcZ0k+gpfxqKXo7Pi1dsPVfk83GHPoWIFK5ELlj+3+aAp1daCF6nSzfyoZCKHetgRRi
         Iyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701183; x=1768305983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VvRccwHu/rlYn5iMvbvj6t+tNweNEArPCLz1vf1v6os=;
        b=or5ugrkZBtVJKg3iSjjTHojCcWJcPuUq4TI0cU2wCJzM8geI4DRS3yQBE3LrR2TRu4
         fqXb8dUyo7VGAQEFRhi9VCLXnSgevkpjm4NBx1/9kzmesgaKfnMetzhF/hXCTX1F4o8J
         CcY6G6E+TrVsqfXPVJd1mZvGg9H7g13Vq9T9mZPHQxxYFMQG4UX5ZBQIS7LrRBeqt5Yh
         oJs6oA67xGKa8M94kTv/292lSDGM7zWkcksGlP2poEKIRaoJCDLIv15XddFqpamdgPR6
         /AczJLo81iyXX/30iCMnw4v54EIyNHjz5yeoGasji33F2EwaMjAgNOkdhuJiUj+xsCc2
         h/Gg==
X-Gm-Message-State: AOJu0YyJZolk0rzqJxukCBSf2lAP7Al2pgLfDb9zMEkiiEkUD4vARko7
	3VmHcKi7hAh+dfjZn+CHQmOPHEMs7I71yxnDILXx1YQWC6Ouxm2gIpP/FgtS/g==
X-Gm-Gg: AY/fxX4vKdnKGFi0J2VDB1EOOH287RDcuDotVMl326Vzvar/zqtnrefy9ioxTl4g1b9
	kKic9/ZHeOCuPhHJ/gCZSSbKJ5Akw8JPWzR6TlmLCqQQymBCI05VGU8HbSr/HRkON9/6DfxF0l6
	owWpPdvOSFw8G3XITmv0q1+YdFNla4Uyi/9jKjl8xessKCQ7urp2RohabDYhsdVfz6LgCzpEO5M
	4lypNYhovVsToMPjOPP+vHhsf38AVm0VcKesOU2+FeXAiocIdcmtGO+c5ags+K8UnfBEkqIHDIr
	2FTWrysiuaIMxl2BHCZjtCc8I6sCsnKtng+fqCDPnI8RlvVHL+bqxw8LjTgkbZowmqBgEQy7Ras
	2Ip82EE/+qkzfrY2KYYwCTkv0/AnasbY3q93wFi+lX+AoJDKDIrnFcLVfCWWSU6Wy972/3qJScD
	RsMwhM5/BkNSjNkDoV0Q==
X-Google-Smtp-Source: AGHT+IGh5c3/+8EX0FLA0B7+DC2R6tKTdvrjUu7bt4g3FdcoOgiMhrgZ2LENkSHmOOaWCFUR2isaHQ==
X-Received: by 2002:a05:600c:5288:b0:479:1a09:1c4a with SMTP id 5b1f17b1804b1-47d7f09ed16mr33899765e9.31.1767701183137;
        Tue, 06 Jan 2026 04:06:23 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:22 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 08/13] pinctrl: renesas: rzg2l: Remove extra semicolons
Date: Tue,  6 Jan 2026 12:06:05 +0000
Message-ID: <20260106120618.181104-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21368

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

[ Upstream commit 647a6b1808dbec19acaba29d512767b3d4d9cd71 ]

Semicolons after end of function braces are unnecessary, remove them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250923174951.1136259-1-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 493c81ba4827..90ad19adb3c7 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -573,7 +573,7 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	pctrl->data->pwpr_pfc_lock_unlock(pctrl, true);
 
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-};
+}
 
 static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				 unsigned int func_selector,
@@ -613,7 +613,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	}
 
 	return 0;
-};
+}
 
 static int rzg2l_map_add_config(struct pinctrl_map *map,
 				const char *group_or_pin,
@@ -1419,7 +1419,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	*config = pinconf_to_config_packed(param, arg);
 
 	return 0;
-};
+}
 
 static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
@@ -1619,7 +1619,7 @@ static int rzg2l_pinctrl_pinconf_group_set(struct pinctrl_dev *pctldev,
 	}
 
 	return 0;
-};
+}
 
 static int rzg2l_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
 					   unsigned int group,
@@ -1646,7 +1646,7 @@ static int rzg2l_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
 	}
 
 	return 0;
-};
+}
 
 static const struct pinctrl_ops rzg2l_pinctrl_pctlops = {
 	.get_groups_count = pinctrl_generic_get_group_count,
-- 
2.43.0


