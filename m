Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435E7C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:14:57 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web11.8669.1716970487047812832
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:14:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GobTunWv;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5295d509178so2239357e87.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970485; x=1717575285; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NKI3xJx6V4ZzQl3vXut9x0QUUSqRtJ7vZ2vRr6mGyw=;
        b=GobTunWvARXArK8rA+QFDB0s0IYD0lemAqu2bOomEsSEGPjw/u6dBJbqrt0b4UJpnW
         nD3Utdc1kQrOIsyFFruh9bF50dcIvAF08ZFL15UNSyGoKDPDbSB+gqUKsTMiTkB2G9t9
         SGm9RShN6x8sv4+qLHDFYQMWV4pTzaG1RE983giKUV6qpBYuWayk4/diUpDfxw+hC/Nm
         SCcomc1BsLHpigENVkS5cRvM4rUUzN9SgUDekHFGPtuTUs/JiZy94T7BExWIPYx46RM9
         LQ7/73NT+uvJmh6J3fYp+0z+lamhqXabUHOTQpjtob01gl0PlnyMgjQprVSXExywH7VI
         CbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970485; x=1717575285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NKI3xJx6V4ZzQl3vXut9x0QUUSqRtJ7vZ2vRr6mGyw=;
        b=RpHRBL/bES/nn6L34dvlApEURzBvtM0iiAsNEVffFE/xUN5d1Zdlj5h6IM9u9gcdZU
         0RzAxUz10KrA7o036KdzDtvjA5oC8GsgNFmpgdLhL7CluNZ6JM421He7Y5l6Lr7soOsM
         NLQVqBmut9AMRPGBoGtS6uZjdF+Uw+3QKSp6ZhxuNtmaqhdsGkIyabidC/54nXN2VKNO
         eGDBF4UcLmEvy/txYS1sY/el+KeYgcxJs8w3AE6vbt3S2pbdi2a29ydTX4x8sgg+659x
         t5zzT+VNeCCsopE9QeLxF9WI/DUy44vhPnf5yjzu1rKdN4YOWMjTYBEKrrB95M6KRgb4
         9afw==
X-Gm-Message-State: AOJu0Ywvp2JxmpMO/EEDOL+bZVZteeXkgYf8+fLQ2ZJo+4ygEiJxv9Gl
	ry7FWVg3IqUFCCR+879E754BtXKSqybuc8Al3UjrY26zEk3yMX5f3Yfjb78HTYkyZWasGvYSEbq
	oY2I=
X-Google-Smtp-Source: AGHT+IHXrfFUx4RIl5G3CGQWUc1crLdz2LFu1HTjX5D/OcuslYC8JiU741MxAlXSOUPa+vIy/rHReg==
X-Received: by 2002:a05:6512:2507:b0:51a:d9a3:dbf5 with SMTP id 2adb3069b0e04-52966f8f6b1mr17366206e87.47.1716970482146;
        Wed, 29 May 2024 01:14:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 04/33] pinctrl: renesas: rzg2l: Add support to select power source for Ethernet pins
Date: Wed, 29 May 2024 11:14:05 +0300
Message-Id: <20240529081434.639519-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16032

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
index e38a1ddcfc0c..38d319cebaf6 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -106,8 +106,10 @@
 #define IEN(off)		(0x1800 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
+#define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
 
+#define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
 #define PVDD_3300		0	/* I/O domain voltage >= 3.3V */
 
@@ -115,7 +117,6 @@
 #define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
 
 #define PM_MASK			0x03
-#define PVDD_MASK		0x01
 #define PFC_MASK		0x07
 #define IEN_MASK		0x01
 #define IOLH_MASK		0x03
@@ -134,10 +135,12 @@
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
@@ -603,6 +606,10 @@ static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *regs, u32
 		return SD_CH(regs->sd_ch, 0);
 	if (caps & PIN_CFG_IO_VMC_SD1)
 		return SD_CH(regs->sd_ch, 1);
+	if (caps & PIN_CFG_IO_VMC_ETH0)
+		return ETH_POC(regs->eth_poc, 0);
+	if (caps & PIN_CFG_IO_VMC_ETH1)
+		return ETH_POC(regs->eth_poc, 1);
 	if (caps & PIN_CFG_IO_VMC_QSPI)
 		return QSPI;
 
@@ -614,6 +621,7 @@ static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	int pwr_reg;
+	u8 val;
 
 	if (caps & PIN_CFG_SOFT_PS)
 		return pctrl->settings[pin].power_source;
@@ -622,7 +630,18 @@ static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
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
@@ -630,17 +649,32 @@ static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
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
@@ -1884,6 +1918,7 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 	.regs = {
 		.pwpr = 0x3014,
 		.sd_ch = 0x3000,
+		.eth_poc = 0x300c,
 	},
 	.iolh_groupa_ua = {
 		/* 3v3 power source */
@@ -1896,6 +1931,7 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg = {
 	.regs = {
 		.pwpr = 0x3000,
 		.sd_ch = 0x3004,
+		.eth_poc = 0x3010,
 	},
 	.iolh_groupa_ua = {
 		/* 1v8 power source */
-- 
2.39.2


