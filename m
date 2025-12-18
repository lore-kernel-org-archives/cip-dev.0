Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F31D6D237
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:35 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44886.1766071946230508356
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h2zCMlgE;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so406849f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071944; x=1766676744; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvRccwHu/rlYn5iMvbvj6t+tNweNEArPCLz1vf1v6os=;
        b=h2zCMlgE1komxacqzTVuOmlVi55LXCdX/6PDswAC57rtx8fmmcuUPbzd6qITwj67hO
         FHNt6CfuXz6IJu9y71RMAOqhVswVAGjQqpJhDiY9nGgrdDHO3V10dfLUZHKQPXMmatAe
         Y9h9pOWsiot7ODrhwGrYMLiKBwLxWXWTcBe4K59057RKxeGaHntu53Ow82luJj7SyX/3
         J4kLesCHZZO2EpfV7e8H0RPDmlNp/i/Yk0PH6GzA8pAc+kAfhxwXk+Sg+EOVt5uXE4Vn
         pOG5B4/yy3lSCSE4fOlTSAq0KqE7gMBiVgfXHc/WebzkYWNUJWj86lGtXDQts19ltej0
         LRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071944; x=1766676744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VvRccwHu/rlYn5iMvbvj6t+tNweNEArPCLz1vf1v6os=;
        b=Ug5jjBx9JQgyLeaCQEfvCvgPZnN8hoTsVILkpO/zIZon/n93t5C5BCyyQLhIwrLJ5o
         UOTkmG/zwy85XHhNp93CVFPm9zpJqxIWaEVr5TnTYZjv4kpSNxXgnPGQVKNo/jJkX8gV
         8vX44M9H+5evMj9t05rZlxihB5YrQNAoM/On6YoLWKAoLSNf3930wVwzqidOcNvLvrPL
         tmRwrjfJAULx+wMoqAKA/k21n8swywqiShJqyOGJ20bZykP42B/rgcpKM+jIQj0vzXgB
         Z2FmELDKxIc7cngA3t4aXkNjnMzy/fdf+inS3XdX67yXV++Ez2R7uibWtfeaKsuxXd4G
         xiRg==
X-Gm-Message-State: AOJu0YzYIKz7MjF10bq1TEzEMDKlA97pfhkZFuX9IR+E455Kpve6gNTh
	3vz8dUFXi7jAjABPnTz4KYPXQd/CbT5ZkryDZESY65UhxR4PcIDduarHcHsHSA==
X-Gm-Gg: AY/fxX7GE5AOiXJL7KoAuzVnCB80C7mZ4tetE2Xxt3/jDS71W+ceM8YEfwMA8db7grD
	gUf3knn8qsp7z6NIAlpR5Ov6EQL4c190FOTeUwcDYevX/jv/6vCCCx0Wdma+tPqYvejxrhq2dWI
	tyMzb2XYwslKw2B5sPQi7cuuqHWcWp/eLjJLBsFukuRIEbHZj4IIbcmnNgf1YxQfFHyevFCCnpl
	57DovGVE/ERm55htIM00kWdwI3WYqnTJdgJfb5bIQPcIsbrVBuFPR/VRCMCUJuR1vpgKH9FfzKe
	l1sHZygrUI0M5/3CSgeXWgsQZJq67xFzYG7tpC+Yf/ROqNP94M7yGIQ447hq6ZK5g2MpVZRO8Fp
	E3BticXS53MMTEJQFlf4H6hBJpGuieXyefhRx+hW2U1+Uklnv4knW4nQtenK/7kAEZxR/uPjjQh
	pNv/+BsRMsvWrw85YlXg==
X-Google-Smtp-Source: AGHT+IEgSRbDN9XN+6c2WTRCfDwJWQXHUKBs8AeaSglpkJg3kmK1b+saLxM8RnCMc4DRdOC7oiwn/w==
X-Received: by 2002:a5d:6a11:0:b0:42f:bc6d:e468 with SMTP id ffacd0b85a97d-42fbc6de571mr14776249f8f.55.1766071944295;
        Thu, 18 Dec 2025 07:32:24 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm5637772f8f.40.2025.12.18.07.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:32:24 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 08/12] pinctrl: renesas: rzg2l: Remove extra semicolons
Date: Thu, 18 Dec 2025 15:31:57 +0000
Message-ID: <20251218153219.228506-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21133

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


