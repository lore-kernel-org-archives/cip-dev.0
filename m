Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E34AC4450A
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90779.1783076372325613084
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cI/ImcZo;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-474560436c3so471087f8f.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076370; x=1783681170; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I78bDfj6I8K8efXiGrFC82NqoA+FqS/ckd8Vy6dT13Q=;
        b=cI/ImcZoQ1APDRevqwUK1odtIDN1XUnW3I0/iNAAt7dWyx4u970YbJ7WFnLWz4DCgJ
         j9lfvqmRzdAKUoTY+wHucrnsfqwvCV1B7ieRPj4+s8fncqhNgkkvY3zaObFv/HMoQDTa
         Rc84B/IeNEPwd4Q1kNJC2SGWNb2O3Pr3rnQ3N7TPpftPY6kFXwtruCGxQNxLSm0DpfP2
         WE/VJjofjIpUXRpz6+bKB9aU/Y5AOD9MlPE7SP4DOhZArBd48k7JJ+tXmJr84Yww0sci
         1aBMqDsETy+d6Hh9OiZDmH7mlJ3LFeuFD9Mwn6TT3c7sXnIqCRfq8RPORs9HZ6v52lSY
         pYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076370; x=1783681170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I78bDfj6I8K8efXiGrFC82NqoA+FqS/ckd8Vy6dT13Q=;
        b=Es3HSMFN7e4YzCDvbznt/cC6mp6eu09DEIwet2n15I6NSpozxwTWDQ+/jjOjlwS7+R
         VvG0sGUGb51iV+X0TRp4DnfooCo6pGPoDH90NoHWaUAIHb8EvoIBgJ/WEP/Bp/CCLZTD
         GHChMdc7+D5IaZyAQP+KpheZEN3hknOL/SBgnw0xXjveADnQp1WyqqwnqF2w0zNfpN8z
         /RL6ZNSTA9/5QUCvtji3t//WT+J8F2APBsRso9Uzxjb1N56tZpHWx65o5yX2cr8pdJXQ
         x1bYRMmLk1LOSEAro+YvFjIbJXRLObPSovUfix1v1CJcz1FsCSAoMZrH9vM07Xed88vY
         krfg==
X-Gm-Message-State: AOJu0Yx5eOR/sMvlibftFuQmt/Zdrpf+xJiCsmJOpRQJffCiSgOaPaH5
	WUUqiHIWgvFOe8HwZOMjLH2mL3HDw1lbxLXiid+llYU66qOv/2e6wSvincA37cBd
X-Gm-Gg: AfdE7cl1R/8NiZRvdwOM2v2qd4GqxdEjLwyRf/NDUfLQq38fAEqiwHErW6KsPu7jf0e
	xQj1udTlRDk0ZPxK2aiZkoFuhMrQXWBSbMxskRNmDqF2mAshyNocR7Z694+JKenCjQtyqH7g/r2
	g1PdBOJuurqz/R3rZ9f7bNq0qxd01p6W3lCWoF3sU/61i0VqrNvKiWHBTehjNPrBNGIvZ5/44Xc
	4vJlbbvYRaxGhtHKU4fmR5zsVO8rIPPULbTMI+ISHoF+ORob6erwYL/3VBipZYbnSo8giylKifH
	xQA9QdyHULXZgTZ9jL8U/fSuTLCvp+f7B6/1BcJHmPXnOPIM8UicV0JVIbql8eHa0E9e9ns3FO1
	3VF9F9ao+0P/kmEVwNjhGyEaPHFZadLnfnL4fW5KvITjbfJmYt020D0tslQ7W5L9qxYF8XWTCPg
	xm4ed5kZnt1Xk34WxubkTi
X-Received: by 2002:a5d:5443:0:b0:474:cd60:1160 with SMTP id ffacd0b85a97d-477b16c95cemr10072008f8f.46.1783076370391;
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
Subject: [PATCH 6.12.y-cip 12/23] pinctrl: renesas: rzg2l: Add support for RZ/G3L SoC
Date: Fri,  3 Jul 2026 11:59:03 +0100
Message-ID: <20260703105923.251255-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23431

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit a7d7aa8f5babac74ef780737e717bf9d90962eed ]

Add pinctrl driver support for RZ/G3L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430093422.74812-6-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 228 ++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 370ffb829287..c2976a6b2d5c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -26,6 +26,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
+#include <dt-bindings/pinctrl/renesas,r9a08g046-pinctrl.h>
 #include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
 #include <dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
@@ -93,6 +94,18 @@
 
 #define RZG2L_MPXED_ETH_PIN_FUNCS(x)	((x) | PIN_CFG_NF)
 
+#define RZG3L_MPXED_ETH_PIN_FUNCS(ether) \
+					(PIN_CFG_IO_VMC_##ether | \
+					 PIN_CFG_IOLH_C | \
+					 PIN_CFG_PUPD | \
+					 PIN_CFG_NF)
+
+#define RZG3L_MPXED_PIN_FUNCS(group)	(RZG2L_MPXED_COMMON_PIN_FUNCS(group) | \
+					 PIN_CFG_SOFT_PS)
+
+#define RZG3L_MPXED_PIN_FUNCS_POC(grp, poc) (RZG2L_MPXED_COMMON_PIN_FUNCS(grp) | \
+					 PIN_CFG_PVDD1833_OTH_##poc##_POC)
+
 #define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(61, 54)
 #define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(53, 46)
 #define PIN_CFG_MASK			GENMASK_ULL(31, 0)
@@ -232,6 +245,7 @@ static const struct pin_config_item renesas_rzv2h_conf_items[] = {
  * @eth_poc: ETH_POC register offset
  * @oen: OEN register offset
  * @qspi: QSPI register offset
+ * @other_poc: OTHER_POC register offset
  */
 struct rzg2l_register_offsets {
 	u16 pwpr;
@@ -239,6 +253,7 @@ struct rzg2l_register_offsets {
 	u16 eth_poc;
 	u16 oen;
 	u16 qspi;
+	u16 other_poc;
 };
 
 /**
@@ -339,6 +354,7 @@ struct rzg2l_pinctrl_pin_settings {
  * @nod: NOD registers cache
  * @sd_ch: SD_CH registers cache
  * @eth_poc: ET_POC registers cache
+ * @other_poc: OTHER_POC register cache
  * @oen: Output Enable register cache
  * @qspi: QSPI registers cache
  */
@@ -356,6 +372,7 @@ struct rzg2l_pinctrl_reg_cache {
 	u8	sd_ch[2];
 	u8	eth_poc[2];
 	u8	oen;
+	u8      other_poc;
 	u8	qspi;
 };
 
@@ -405,6 +422,60 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
 	return 0;
 }
 
+static const u64 r9a08g046_variable_pin_cfg[] = {
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PA, 0, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PA, 1, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PA, 2, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PA, 3, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PA, 4, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PA, 5, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PA, 6, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PA, 7, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PB, 0, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PB, 1, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0) | PIN_CFG_OEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PB, 2, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PB, 3, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PB, 4, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PB, 5, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PB, 6, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PB, 7, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PD, 0, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PD, 1, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PD, 2, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PD, 3, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PD, 4, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PD, 5, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PD, 6, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PD, 7, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PE, 0, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PE, 1, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1) | PIN_CFG_OEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PE, 2, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PE, 3, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PE, 4, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PE, 5, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PE, 6, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PE, 7, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 0, RZG3L_MPXED_PIN_FUNCS(B)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 1, RZG3L_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 2, RZG3L_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 3, RZG3L_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 4, RZG3L_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 5, RZG3L_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 6, RZG3L_MPXED_PIN_FUNCS_POC(B, ISO)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PG, 7, RZG3L_MPXED_PIN_FUNCS_POC(B, ISO)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 0, RZG3L_MPXED_PIN_FUNCS(B)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 1, RZG3L_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 2, RZG3L_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 3, RZG3L_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 4, RZG3L_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PH, 5, RZG3L_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PJ, 0, RZG3L_MPXED_PIN_FUNCS(A) | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PJ, 1, RZG3L_MPXED_PIN_FUNCS(A)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PJ, 2, RZG3L_MPXED_PIN_FUNCS(A)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PJ, 3, RZG3L_MPXED_PIN_FUNCS(A)),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3L_PJ, 4, RZG3L_MPXED_PIN_FUNCS(A)),
+};
+
 static const u64 r9a09g047_variable_pin_cfg[] = {
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 0, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
 	RZG2L_VARIABLE_PIN_CFG_PACK(RZG3E_PA, 1, RZV2H_MPXED_PIN_FUNCS),
@@ -2131,6 +2202,70 @@ static const u64 r9a09g047_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x3c, RZV2H_MPXED_PIN_FUNCS),	/* PS */
 };
 
+static const char * const rzg3l_gpio_names[] = {
+	"", "", "", "", "", "", "", "",
+	"", "", "", "", "", "", "", "",
+	"P20", "P21", "P22", "P23", "P24", "P25", "P26", "P27",
+	"P30", "P31", "P32", "P33", "P34", "P35", "P36", "P37",
+	"", "", "", "", "", "", "", "",
+	"P50", "P51", "P52", "P53", "P54", "P55", "P56", "P57",
+	"P60", "P61", "P62", "P63", "P64", "P65", "P66", "P67",
+	"P70", "P71", "P72", "P73", "P74", "P75", "P76", "P77",
+	"P80", "P81", "P82", "P83", "P84", "P85", "P86", "P87",
+	"", "", "", "", "", "", "", "",
+	"PA0", "PA1", "PA2", "PA3", "PA4", "PA5", "PA6", "PA7",
+	"PB0", "PB1", "PB2", "PB3", "PB4", "PB5", "PB6", "PB7",
+	"PC0", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7",
+	"PD0", "PD1", "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+	"PE0", "PE1", "PE2", "PE3", "PE4", "PE5", "PE6", "PE7",
+	"PF0", "PF1", "PF2", "PF3", "PF4", "PF5", "PF6", "PF7",
+	"PG0", "PG1", "PG2", "PG3", "PG4", "PG5", "PG6", "PG7",
+	"PH0", "PH1", "PH2", "PH3", "PH4", "PH5", "PH6", "PH7",
+	"", "", "", "", "", "", "", "",
+	"PJ0", "PJ1", "PJ2", "PJ3", "PJ4", "PJ5", "PJ6", "PJ7",
+	"PK0", "PK1", "PK2", "PK3", "PK4", "PK5", "PK6", "PK7",
+	"PL0", "PL1", "PL2", "PL3", "PL4", "PL5", "PL6", "PL7",
+	"PM0", "PM1", "PM2", "PM3", "PM4", "PM5", "PM6", "PM7",
+	"", "", "", "", "", "", "", "",
+	"", "", "", "", "", "", "", "",
+	"", "", "", "", "", "", "", "",
+	"", "", "", "", "", "", "", "",
+	"", "", "", "", "", "", "", "",
+	"PS0", "PS1", "PS2", "PS3", "PS4", "PS5", "PS6", "PS7",
+};
+
+static const u64 r9a08g046_gpio_configs[] = {
+	0x0,
+	0x0,
+	RZG2L_GPIO_PORT_PACK(2, 0x22, PIN_CFG_NF | PIN_CFG_IEN),	/* P2 */
+	RZG2L_GPIO_PORT_PACK(7, 0x23, RZG3L_MPXED_PIN_FUNCS_POC(A, AWO)), /* P3 */
+	0x0,
+	RZG2L_GPIO_PORT_PACK(7, 0x25, RZG3L_MPXED_PIN_FUNCS_POC(A, ISO)), /* P5 */
+	RZG2L_GPIO_PORT_PACK(7, 0x26, RZG3L_MPXED_PIN_FUNCS_POC(A, ISO)), /* P6 */
+	RZG2L_GPIO_PORT_PACK(8, 0x27, RZG3L_MPXED_PIN_FUNCS_POC(A, ISO)), /* P7 */
+	RZG2L_GPIO_PORT_PACK(6, 0x28, RZG3L_MPXED_PIN_FUNCS_POC(A, ISO)), /* P8 */
+	0x0,
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x2a),				/* PA */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x2b),				/* PB */
+	RZG2L_GPIO_PORT_PACK(3, 0x2c, RZG3L_MPXED_ETH_PIN_FUNCS(ETH0)),	/* PC */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x2d),				/* PD */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x2e),				/* PE */
+	RZG2L_GPIO_PORT_PACK(3, 0x2f, RZG3L_MPXED_ETH_PIN_FUNCS(ETH1)),	/* PF */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(8, 0x30),				/* PG */
+	RZG2L_GPIO_PORT_PACK_VARIABLE(6, 0x31),				/* PH */
+	0x0,
+	RZG2L_GPIO_PORT_PACK_VARIABLE(5, 0x33),				/* PJ */
+	RZG2L_GPIO_PORT_PACK(4, 0x34, RZG3L_MPXED_PIN_FUNCS_POC(B, ISO)), /* PK */
+	RZG2L_GPIO_PORT_PACK(5, 0x35, RZG3L_MPXED_PIN_FUNCS(C)),	/* PL */
+	RZG2L_GPIO_PORT_PACK(8, 0x36, RZG3L_MPXED_PIN_FUNCS(C)),	/* PM */
+	0x0,
+	0x0,
+	0x0,
+	0x0,
+	0x0,
+	RZG2L_GPIO_PORT_PACK(2, 0x3c, RZG3L_MPXED_PIN_FUNCS(A)),	/* PS */
+};
+
 static const char * const rzv2h_gpio_names[] = {
 	"P00", "P01", "P02", "P03", "P04", "P05", "P06", "P07",
 	"P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17",
@@ -2469,6 +2604,37 @@ static struct rzg2l_dedicated_configs rzg3e_dedicated_pins[] = {
 	 (PIN_CFG_IOLH_RZV2H | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_PUPD)) },
 };
 
+static const struct rzg2l_dedicated_configs rzg3l_dedicated_pins[] = {
+	{ "WDTOVF_N", RZG2L_SINGLE_PIN_PACK(0x5, 0,
+	  (PIN_CFG_IOLH_A | PIN_CFG_WDTOVF_N_POC)) },
+	{ "SCIF0_RXD", RZG2L_SINGLE_PIN_PACK(0x6, 0,
+	  (PIN_CFG_IOLH_A | PIN_CFG_PUPD | PIN_CFG_PVDD1833_OTH_AWO_POC)) },
+	{ "SCIF0_TXD", RZG2L_SINGLE_PIN_PACK(0x6, 1,
+	  (PIN_CFG_IOLH_A | PIN_CFG_PUPD | PIN_CFG_PVDD1833_OTH_AWO_POC)) },
+	{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x9, 0, PIN_CFG_IOLH_B) },
+	{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x9, 1,
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0_RST#", RZG2L_SINGLE_PIN_PACK(0x9, 2, PIN_CFG_IOLH_B) },
+	{ "SD0_DS", RZG2L_SINGLE_PIN_PACK(0x9, 5,
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0_DAT0", RZG2L_SINGLE_PIN_PACK(0x0a, 0,
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0_DAT1", RZG2L_SINGLE_PIN_PACK(0x0a, 1,
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0_DAT2", RZG2L_SINGLE_PIN_PACK(0x0a, 2,
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0_DAT3", RZG2L_SINGLE_PIN_PACK(0x0a, 3,
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0_DAT4", RZG2L_SINGLE_PIN_PACK(0x0a, 4,
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0_DAT5", RZG2L_SINGLE_PIN_PACK(0x0a, 5,
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0_DAT6", RZG2L_SINGLE_PIN_PACK(0x0a, 6,
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+	{ "SD0_DAT7", RZG2L_SINGLE_PIN_PACK(0x0a, 7,
+	  (PIN_CFG_IOLH_B | PIN_CFG_IEN | PIN_CFG_PUPD)) },
+};
+
 static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl)
 {
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[virq];
@@ -3036,6 +3202,9 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	BUILD_BUG_ON(ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzg2l_gpio_names));
 
+	BUILD_BUG_ON(ARRAY_SIZE(r9a08g046_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzg3l_gpio_names));
+
 	BUILD_BUG_ON(ARRAY_SIZE(r9a09g047_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzg3e_gpio_names));
 
@@ -3348,6 +3517,8 @@ static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
 	if (regs->qspi)
 		cache->qspi = readb(pctrl->base + regs->qspi);
 	cache->oen = readb(pctrl->base + pctrl->data->hwcfg->regs.oen);
+	if (regs->other_poc)
+		cache->other_poc = readb(pctrl->base + regs->other_poc);
 
 	if (!atomic_read(&pctrl->wakeup_path))
 		clk_disable_unprepare(pctrl->clk);
@@ -3374,6 +3545,8 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
 
 	if (regs->qspi)
 		writeb(cache->qspi, pctrl->base + regs->qspi);
+	if (regs->other_poc)
+		writeb(cache->other_poc, pctrl->base + regs->other_poc);
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	rzg2l_oen_write_with_pwpr(pctrl, cache->oen);
@@ -3442,6 +3615,40 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 	.oen_max_pin = 0,
 };
 
+static const struct rzg2l_hwcfg rzg3l_hwcfg = {
+	.regs = {
+		.pwpr = 0x3000,
+		.sd_ch = 0x3004,
+		.eth_poc = 0x3010,
+		.oen = 0x3018,
+		.other_poc = OTHER_POC,
+	},
+	.iolh_groupa_ua = {
+		/* 1v8 power source */
+		[RZG2L_IOLH_IDX_1V8] = 2200, 4400, 9000, 10000,
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 1900, 4000, 8000, 9000,
+	},
+	.iolh_groupb_ua = {
+		/* 1v8 power source */
+		[RZG2L_IOLH_IDX_1V8] = 7000, 8000, 9000, 10000,
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 4000, 6000, 8000, 9000,
+	},
+	.iolh_groupc_ua = {
+		/* 1v8 power source */
+		[RZG2L_IOLH_IDX_1V8] = 5200, 6000, 6550, 6800,
+		/* 2v5 source */
+		[RZG2L_IOLH_IDX_2V5] = 4700, 5300, 5800, 6100,
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 4500, 5200, 5700, 6050,
+	},
+	.tint_start_index = 17,
+	.drive_strength_ua = true,
+	.func_base = 0,
+	.oen_max_pin = 1, /* Pin 1 of P{B,E}1_ISO is the maximum OEN pin. */
+};
+
 static const struct rzg2l_hwcfg rzg3s_hwcfg = {
 	.regs = {
 		.pwpr = 0x3000,
@@ -3535,6 +3742,23 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
 	.bias_param_to_hw = &rzg2l_bias_param_to_hw,
 };
 
+static struct rzg2l_pinctrl_data r9a08g046_data = {
+	.port_pins = rzg3l_gpio_names,
+	.port_pin_configs = r9a08g046_gpio_configs,
+	.n_ports = ARRAY_SIZE(r9a08g046_gpio_configs),
+	.variable_pin_cfg = r9a08g046_variable_pin_cfg,
+	.n_variable_pin_cfg = ARRAY_SIZE(r9a08g046_variable_pin_cfg),
+	.dedicated_pins = rzg3l_dedicated_pins,
+	.n_port_pins = ARRAY_SIZE(r9a08g046_gpio_configs) * RZG2L_PINS_PER_PORT,
+	.n_dedicated_pins = ARRAY_SIZE(rzg3l_dedicated_pins),
+	.hwcfg = &rzg3l_hwcfg,
+	.pwpr_pfc_lock_unlock = &rzg2l_pwpr_pfc_lock_unlock,
+	.pmc_writeb = &rzg2l_pmc_writeb,
+	.pin_to_oen_bit = &rzg2l_pin_to_oen_bit,
+	.hw_to_bias_param = &rzg2l_hw_to_bias_param,
+	.bias_param_to_hw = &rzg2l_bias_param_to_hw,
+};
+
 static struct rzg2l_pinctrl_data r9a09g047_data = {
 	.port_pins = rzg3e_gpio_names,
 	.port_pin_configs = r9a09g047_gpio_configs,
@@ -3615,6 +3839,10 @@ static const struct of_device_id rzg2l_pinctrl_of_table[] = {
 		.compatible = "renesas,r9a08g045-pinctrl",
 		.data = &r9a08g045_data,
 	},
+	{
+		.compatible = "renesas,r9a08g046-pinctrl",
+		.data = &r9a08g046_data,
+	},
 	{
 		.compatible = "renesas,r9a09g047-pinctrl",
 		.data = &r9a09g047_data,
-- 
2.43.0


