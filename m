Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DCBC41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:10:55 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web11.8563.1716970249454568037
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:10:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rGPqDblY;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.179, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e95a7622cfso18379481fa.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970248; x=1717575048; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hkiJVmuVuG3EmX8P3qW7RhBmIImFt4kWHBoSr6CBEw=;
        b=rGPqDblYqCbBpmcwGUtn55irF3y/bAGhzMoF8LPgz3HltmMEq/vRx+nDHiCo8PtWpg
         rDLIqCiTO42ezZS1t+rzaB3+lcW8cv7MHc+1YtDTBo6iP6wGZpr6VDk1v2oYrrL9Q2dw
         WPQVJu5rdKzed/xgS7S7Al3ZPH5Ds/s4pWV0TJbgAk5obap2ZdGdt5W9U7cakUnrOp4f
         pzoih40bUOHu9FcMFIVpIXSUoIC1tptBz3FTzYuqYfq1wB6ECXGCMv6KdxV+nDgUiiMx
         VjmbHrAU9enqoKSFMauslooTwt7bYtX3SjeOo+kpn6B/RxGY10MjKubhh5EkvFLEcbGf
         LYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970248; x=1717575048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hkiJVmuVuG3EmX8P3qW7RhBmIImFt4kWHBoSr6CBEw=;
        b=jpA69UloN7CUI93mtKjDheciJutsecAWU51HkrSs/jG7xO1goSU8f5cib0y3jJ3ioC
         J+tssPdvyasZzlZSplT7g+8OaMdZyfAuowC7YTeIjFlGhFxAFMGxBUCnGdm3krZzxnp6
         HrjWLW+H84WVb1nbF7zJ6zb1GnGtqFQz8EdTbOxp1uAC2Ru0NNu56m9oKXb9B46TG115
         +iHE2bmdhvFFBa/HQB4seq5u4RlLRHcAYIGfWYKo1T6TptFV6oH/TsqCsFZrXqyw3+Bl
         z7jot5SD65f4asN5IsZ4NDe49ybMqO15/4hmNcyLumEWutKmXfSrVoJp6Vl4jslIEu1n
         mDPQ==
X-Gm-Message-State: AOJu0YxTJZWOIKAFhdRFzRQye3W/nxps3nNDyKijkX9dLC6fn5HtWM6D
	FtghEyeHi014+mTAKPC2o41pTeWa3bD0jzCpXSshMBmKijSnUKReQnQl0hgQzwZ9i3WQdcPB546
	zev8=
X-Google-Smtp-Source: AGHT+IHryTE4Qw4+KC7Oz3ZXsHCcbSTEdgUX0m03xP9+b9S8yJyMWp8aSSmORmrxQE1k0SlprVk3Ig==
X-Received: by 2002:a05:651c:546:b0:2ea:7f9e:34dd with SMTP id 38308e7fff4ca-2ea7f9e3577mr1060651fa.47.1716970247516;
        Wed, 29 May 2024 01:10:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:10:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 04/47] pinctrl: renesas: rzg2l: Add support to select power source for Ethernet pins
Date: Wed, 29 May 2024 11:09:56 +0300
Message-Id: <20240529081039.639010-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:10:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15984

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 51996952b8b50942ed3069141ebc1dee13756b95 upstream.

The GPIO controller available on RZ/G3S (but also on RZ/G2L) supports
setting the power source for Ethernet pins.  Based on the interface b/w
the Ethernet controller and the Ethernet PHY, and on board design, a
specific power source needs to be selected.  The GPIO controller
supports 1.8V, 2.5V, and 3.3V power source selection for the Ethernet
pins.  This can be selected though the ETHx_POC registers (x={0, 1}).

Adjust the driver to support this, and to do proper instantiation for
the RZ/G3S and RZ/G2L SoCs.  On RZ/G2L only the get operation has been
tested at the moment.

While at it, as the power registers on RZ/G2L support access sizes of 8
bits, and these registers on RZ/G3S support access sizes of 8/16/32
bits, replace writel()/readl() on these registers with writeb()/readb().
This should allow us to use the same code on both SoCs w/o any issues.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231207070700.4156557-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 42 +++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 329edc31ed00..4a649dc43946 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -103,8 +103,10 @@
 #define IEN(off)		(0x1800 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
+#define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
 
+#define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
 #define PVDD_3300		0	/* I/O domain voltage >= 3.3V */
 
@@ -112,7 +114,6 @@
 #define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
 
 #define PM_MASK			0x03
-#define PVDD_MASK		0x01
 #define PFC_MASK		0x07
 #define IEN_MASK		0x01
 #define IOLH_MASK		0x03
@@ -131,10 +132,12 @@
  * struct rzg2l_register_offsets - specific register offsets
  * @pwpr: PWPR register offset
  * @sd_ch: SD_CH register offset
+ * @eth_poc: ETH_POC register offset
  */
 struct rzg2l_register_offsets {
 	u16 pwpr;
 	u16 sd_ch;
+	u16 eth_poc;
 };
 
 /**
@@ -600,6 +603,10 @@ static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *regs, u32
 		return SD_CH(regs->sd_ch, 0);
 	if (caps & PIN_CFG_IO_VMC_SD1)
 		return SD_CH(regs->sd_ch, 1);
+	if (caps & PIN_CFG_IO_VMC_ETH0)
+		return ETH_POC(regs->eth_poc, 0);
+	if (caps & PIN_CFG_IO_VMC_ETH1)
+		return ETH_POC(regs->eth_poc, 1);
 	if (caps & PIN_CFG_IO_VMC_QSPI)
 		return QSPI;
 
@@ -611,6 +618,7 @@ static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	int pwr_reg;
+	u8 val;
 
 	if (caps & PIN_CFG_SOFT_PS)
 		return pctrl->settings[pin].power_source;
@@ -619,7 +627,18 @@ static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
 	if (pwr_reg < 0)
 		return pwr_reg;
 
-	return (readl(pctrl->base + pwr_reg) & PVDD_MASK) ? 1800 : 3300;
+	val = readb(pctrl->base + pwr_reg);
+	switch (val) {
+	case PVDD_1800:
+		return 1800;
+	case PVDD_2500:
+		return 2500;
+	case PVDD_3300:
+		return 3300;
+	default:
+		/* Should not happen. */
+		return -EINVAL;
+	}
 }
 
 static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps, u32 ps)
@@ -627,17 +646,32 @@ static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	int pwr_reg;
+	u8 val;
 
 	if (caps & PIN_CFG_SOFT_PS) {
 		pctrl->settings[pin].power_source = ps;
 		return 0;
 	}
 
+	switch (ps) {
+	case 1800:
+		val = PVDD_1800;
+		break;
+	case 2500:
+		val = PVDD_2500;
+		break;
+	case 3300:
+		val = PVDD_3300;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	pwr_reg = rzg2l_caps_to_pwr_reg(regs, caps);
 	if (pwr_reg < 0)
 		return pwr_reg;
 
-	writel((ps == 1800) ? PVDD_1800 : PVDD_3300, pctrl->base + pwr_reg);
+	writeb(val, pctrl->base + pwr_reg);
 	pctrl->settings[pin].power_source = ps;
 
 	return 0;
@@ -1882,6 +1916,7 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 	.regs = {
 		.pwpr = 0x3014,
 		.sd_ch = 0x3000,
+		.eth_poc = 0x300c,
 	},
 	.iolh_groupa_ua = {
 		/* 3v3 power source */
@@ -1894,6 +1929,7 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg = {
 	.regs = {
 		.pwpr = 0x3000,
 		.sd_ch = 0x3004,
+		.eth_poc = 0x3010,
 	},
 	.iolh_groupa_ua = {
 		/* 1v8 power source */
-- 
2.39.2


