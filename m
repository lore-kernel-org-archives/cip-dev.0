Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB730C44501
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:38 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89971.1783076371377436106
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=aZqnBnL8;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so3035005e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076370; x=1783681170; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ut2/XpoP0v2KFKrEk7mQAXg6kIOQH3PefpWTv2OjAmk=;
        b=aZqnBnL8b3gwbm4z/YSL3qc0wNL8gJeo0cZb5ByqIToQQSJScFofNEKbl8RcgQXgQD
         i05j0G9jp9L9367q8EsJZMpxdKaU0FP/EyZyWLM/Dxjpw6oj+KemhQ0XxoUexeP7j+yj
         kwJ7DMGxFoV4cbhlJ/9+hOOqUcTIQKKeZ/zRS2t7IjxVSBjabTG4mbW1GZ6iT3zAcUwE
         cqkN8O8T0u9fW2zL7p4f32P1vnXQJCuSEssJNgMzc/eDOZvJ/RyNSg3hNxj4kuFa35fW
         /icXVrf5nkyhHL7UeMkAMFh6/zcyDFDrT82W8naXaHHy4YV5VMuSEGTb9tcyprjLQ7DA
         EMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076370; x=1783681170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ut2/XpoP0v2KFKrEk7mQAXg6kIOQH3PefpWTv2OjAmk=;
        b=nJjg5NbIXvoso0+vPG4zNJgVks3QQp2A8qF2O5ev1MKrXKmHiv3XcmSAgOWQARG5hB
         gdqye9ewtyKAqymGbzX/JYBw+uFHY75FosTgcJ//0yzrMviI4HjGYmXvLOHfaI3WpUH/
         ixyUU0XyMnuR+CmvotzaMoy+TZ460yyZI0p7lnpTG6nkARwe3bz6RWD3m+ffj1jVev6N
         vOP4+vE5AY4CMQYmmKoVkK3v35P/IcD7/biHto4eVZDZSsB3rG4LPMY3FE5gQSENQkyQ
         o+s7Srqg0GZMPGXABdxK5ywWis81NOATcErNPw06LG46JEpwF3Z5co2dBvbH+0E8nhsf
         qUcw==
X-Gm-Message-State: AOJu0YyErlycnn0U+Fxh/a29HuNtv6VtjYDR3pBfRNLqujPYxQc618sa
	cSpa4UK8+rfpMMwBzl3mD1SbiLyJdX/jnTkwQNqvOxx3ku83fFbSKCLafVRVuKJx
X-Gm-Gg: AfdE7ckSYOLw1K1nicYP3KQ+XtV0KDrUShy838Lvtb+r6m/p88OHODv8ESkE/RpMumo
	KeVEDrnuzIqgo6BVMyYce6+IZHLQQ5l9BumZtLtuk6Ktp7lVTBAI9a8vIuZf3MYsNtuQu6IuvqP
	PYyMh/j8hcdsYd3SgQS1TVgDNC1PEpycky6c/3N+hUWjonYuuFnTPbzI9Jye9RpJeiUF5u8P8nq
	LTZTC+yzIKddpqA5Q1swuLMqJg06V4HGgvjmNHQePtGc0eG/mAUg5LuxpPtzvIpSU96EWFVwSnf
	D9wt+D6PIbIqnaxASJxGHnEggXno7CIwYsDowiiFtBedrdOGZU2OBBa1CfkN6gON2wZyiC9a797
	gKcC2PFQjdCca4e5NBpwZqgqbhMb0fZ45auDjx0AfpUW984IJca2Vxw9bPsK5wHQkZDQvuNH/bT
	3JMzq/e9o5389qAEC/mCI4JMBNFZvEhVc=
X-Received: by 2002:a05:600c:828d:b0:493:bf86:85c5 with SMTP id 5b1f17b1804b1-493c3df3495mr130833045e9.36.1783076369479;
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
Subject: [PATCH 6.12.y-cip 10/23] pinctrl: renesas: rzg2l: Add support for selecting power source for {WDT,AWO,ISO}
Date: Fri,  3 Jul 2026 11:59:01 +0100
Message-ID: <20260703105923.251255-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23429

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit bbe2277dedbeb54bb251ae3e0599007253739aad ]

The RZ/G3L SoC has support for setting power source that are not
controlled by the following voltage control registers:
  - SD_CH{0,1,2}_POC, XSPI_POC, ETH{0,1}_POC, I3C_SET.POC

Add support for selecting voltages using OTHER_POC register for
setting I/O domain voltage for WDT, ISO and AWO by extending
rzg2l_caps_to_pwr_reg() with a mask output parameter so that callers
callers can identify which bit(s) within OTHER_POC correspond to the
requested domain. Update rzg2l_get_power_source() to extract the
relevant bit field via field_get() when reading OTHER_POC, and update
rzg2l_set_power_source() to perform a read-modify-write under the
spinlock when writing to OTHER_POC, since multiple domains share the
same register.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430093422.74812-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Biju: Added local field_get macro ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 55 +++++++++++++++++++++----
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 1525dedca76e..9136cc352b9c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -63,10 +63,18 @@
 #define PIN_CFG_SMT			BIT(16)	/* Schmitt-trigger input control */
 #define PIN_CFG_ELC			BIT(17)
 #define PIN_CFG_IOLH_RZV2H		BIT(18)
+#define PIN_CFG_PVDD1833_OTH_AWO_POC	BIT(19) /* known on RZ/G3L only */
+#define PIN_CFG_PVDD1833_OTH_ISO_POC	BIT(20) /* known on RZ/G3L only */
+#define PIN_CFG_WDTOVF_N_POC		BIT(21) /* known on RZ/G3L only */
 
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
 #define RZG2L_VARIABLE_CFG		BIT_ULL(62)	/* Variable cfg for port pins */
 
+#define PIN_CFG_OTHER_POC_MASK	\
+					(PIN_CFG_PVDD1833_OTH_AWO_POC | \
+					 PIN_CFG_PVDD1833_OTH_ISO_POC | \
+					 PIN_CFG_WDTOVF_N_POC)
+
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
 					 PIN_CFG_PUPD | \
@@ -146,6 +154,7 @@
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008) /* known on RZ/{G2L,G2LC,G2UL,Five} only */
+#define OTHER_POC		(0x3028) /* known on RZ/G3L only */
 
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
@@ -177,6 +186,8 @@
 /* Custom pinconf parameters */
 #define RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE	(PIN_CONFIG_END + 1)
 
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+
 static const struct pinconf_generic_params renesas_rzv2h_custom_bindings[] = {
 	{ "renesas,output-impedance", RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE, 1 },
 };
@@ -900,7 +911,8 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
-static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *regs, u32 caps)
+static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *regs,
+				 u32 caps, u8 *mask)
 {
 	if (caps & PIN_CFG_IO_VMC_SD0)
 		return SD_CH(regs->sd_ch, 0);
@@ -912,6 +924,16 @@ static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *regs, u32
 		return ETH_POC(regs->eth_poc, 1);
 	if (caps & PIN_CFG_IO_VMC_QSPI)
 		return QSPI;
+	if (caps & PIN_CFG_OTHER_POC_MASK) {
+		if (caps & PIN_CFG_PVDD1833_OTH_AWO_POC)
+			*mask = BIT(0);
+		else if (caps & PIN_CFG_PVDD1833_OTH_ISO_POC)
+			*mask = BIT(1);
+		else
+			*mask = BIT(2);
+
+		return OTHER_POC;
+	}
 
 	return -EINVAL;
 }
@@ -920,17 +942,20 @@ static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
 {
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	u8 val, mask;
 	int pwr_reg;
-	u8 val;
 
 	if (caps & PIN_CFG_SOFT_PS)
 		return pctrl->settings[pin].power_source;
 
-	pwr_reg = rzg2l_caps_to_pwr_reg(regs, caps);
+	pwr_reg = rzg2l_caps_to_pwr_reg(regs, caps, &mask);
 	if (pwr_reg < 0)
 		return pwr_reg;
 
 	val = readb(pctrl->base + pwr_reg);
+	if (pwr_reg == OTHER_POC)
+		val = field_get(mask, val);
+
 	switch (val) {
 	case PVDD_1800:
 		return 1800;
@@ -948,8 +973,8 @@ static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
 {
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	u8 poc_val, val, mask;
 	int pwr_reg;
-	u8 val;
 
 	if (caps & PIN_CFG_SOFT_PS) {
 		pctrl->settings[pin].power_source = ps;
@@ -958,25 +983,37 @@ static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
 
 	switch (ps) {
 	case 1800:
-		val = PVDD_1800;
+		poc_val = PVDD_1800;
 		break;
 	case 2500:
 		if (!(caps & (PIN_CFG_IO_VMC_ETH0 | PIN_CFG_IO_VMC_ETH1)))
 			return -EINVAL;
-		val = PVDD_2500;
+		poc_val = PVDD_2500;
 		break;
 	case 3300:
-		val = PVDD_3300;
+		poc_val = PVDD_3300;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	pwr_reg = rzg2l_caps_to_pwr_reg(regs, caps);
+	pwr_reg = rzg2l_caps_to_pwr_reg(regs, caps, &mask);
 	if (pwr_reg < 0)
 		return pwr_reg;
 
-	writeb(val, pctrl->base + pwr_reg);
+	if (pwr_reg == OTHER_POC) {
+		scoped_guard(raw_spinlock, &pctrl->lock) {
+			val = readb(pctrl->base + pwr_reg);
+			if (poc_val)
+				val |= mask;
+			else
+				val &= ~mask;
+			writeb(val, pctrl->base + pwr_reg);
+		}
+	} else {
+		writeb(poc_val, pctrl->base + pwr_reg);
+	}
+
 	pctrl->settings[pin].power_source = ps;
 
 	return 0;
-- 
2.43.0


