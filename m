Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4FACDC187
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88499.1767701184552660243
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XphiItgr;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47796a837c7so6754455e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701183; x=1768305983; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEYaBUCdktVP/dW4Sp8l7dD1cMdeiB29NTdKsl6xCS0=;
        b=XphiItgraXAe3OTxCikzm4UyV1gbLgkM1yLHxEliKsSjCwnmdL2JsOoeHN18EAyU6k
         zsAZuz+yJFjxDnyUAROr0tD/gBnj+v/34HBlgfcAfmoI3OD3lwbKB2uWqTM9iaHIkt2G
         6Y58dwE3f74fuGksjHMSSw1NCvEJTR+aibYX0l5Hr9wsd/1ebXkqj4xvTY5mvyb+PZYc
         bDpUPAe13b0JcgHooc1/Df5QEu3agdOWy3eRNUtNKqZ+xquHb4txpAbK6KaWXvMrnv/U
         UyMr6g/HWo1zE9eQFVkFC/glONX976Oc3i9qz6Nt0z+rbCAJGOoPXpQBVdSeTLb102Kv
         zSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701183; x=1768305983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mEYaBUCdktVP/dW4Sp8l7dD1cMdeiB29NTdKsl6xCS0=;
        b=H32i/Z8R5Xgkun26/N7WR5gnHzj3NrPr9nAYvQTlX6vWfLcLyTMcDdxmT0FKLRJ41d
         ZsQv7sdcYfd6m1dEc8lYjVkRPd6ra4uUybgdEMTBY6o4MBMulyVQiiUCDRFAtdavjbES
         w8i12fvV93/hs18GyKV5CX84ZYCCFfzhX27EDTCv6SeKK0BI8DtoQs+knqSSDaheh6gW
         3c1h/ZO5KN0AZ53ovhJad+P6X5wTPOmQ+TWzZBqOTYsaZ7/qdsmzRA8vQgdVZbqs/LlF
         oTUP5+Hmycjcs8VVbXufhxpCHajBo4HYUF4DSCboAtRDYzVCM2LwG3LoS+w5SF9I3/OY
         fVDA==
X-Gm-Message-State: AOJu0YydDI0gmJQ7Ry0R/leG6Yqw2quZwWLSWEGfwYA+hAdyxvGoX7rR
	ghXGPC/lCHYANi+0gEOL8W1SrdyfguYsvB8JPYPBIMKWe9VHc7rrG2t3Iz3ugQ==
X-Gm-Gg: AY/fxX5VmDn1k0TRcmZ4Ja93dJpS1cBtdcHJBlTcbTsjIatFHSM/wRVkuNDLfh+2rfQ
	WhOq4ghWXtymss9EzcUvBkvCdKaC52O1GJCTeswKbXnNaZhJxEox46MsfW90SsBoed+nU/67dOb
	l5Brx6oGIDaq+uVsdRrxGvUQUptL6NIEoVVou+mKYaSu9ASCcQLKnomjR+j4iLtJxCWK1GR0yCK
	5P33I9Nc4bqfCmznNEnIgdFWTEGfAy71O8vqjrcCDbcp5wiFupof1BuOipimmB/6wxkzprNSRnm
	f3y3mlwFQ0V0cm5I54a0KDHDvHDPMVDzyOkxN9Vwx6ral1oUUuUoZnmEyTwBmw2UXOSbCVKNJf/
	7P5imF2ZP052FVWbGu42mnGq3nJoSw6nI7gp3Q0tAEsqmgt4Cn4iRmr7zg7JcOxNneLRrp2i1Yy
	vVXT9dwS05zUjhPTBB8A==
X-Google-Smtp-Source: AGHT+IFhA+c4faZTwpBaf6UBijHnS0PcnJQqc2a4NUi+YeQktH1OfpLIQxnZ/P8xDLWAzN+NcGW9BA==
X-Received: by 2002:a05:600c:46ca:b0:471:1716:11c4 with SMTP id 5b1f17b1804b1-47d837edcccmr3088465e9.34.1767701182657;
        Tue, 06 Jan 2026 04:06:22 -0800 (PST)
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
Subject: [PATCH 6.1.y-cip v2 07/13] pinctrl: renesas: rzg2l: Fix PMC restore
Date: Tue,  6 Jan 2026 12:06:04 +0000
Message-ID: <20260106120618.181104-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21367

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit cea950101108b7bfffe26ec4007b8e263a4b56a8 ]

PMC restore needs unlocking the register using the PWPR register.

Fixes: ede014cd1ea6422d ("pinctrl: renesas: rzg2l: Add function pointer for PMC register write")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250921111557.103069-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 6a87da0ee50e..493c81ba4827 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -3014,7 +3014,11 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 		 * Now cache the registers or set them in the order suggested by
 		 * HW manual (section "Operation for GPIO Function").
 		 */
-		RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + PMC(off), cache->pmc[port]);
+		if (suspend)
+			RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + PMC(off), cache->pmc[port]);
+		else
+			pctrl->data->pmc_writeb(pctrl, cache->pmc[port], PMC(off));
+
 		if (has_iolh) {
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IOLH(off),
 						 cache->iolh[0][port]);
-- 
2.43.0


