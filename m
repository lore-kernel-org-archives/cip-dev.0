Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFB6C3ABAF
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:07 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.20345.1745934478604708554
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EVO9m+3L;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso1066800266b.0
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934477; x=1746539277; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jr4lBaLNAeSuH2b3VsvlM5nFl3TRbFBF79aK932ukkg=;
        b=EVO9m+3Ld+6AfiOWmi7wnFSOYYaE0eu+D++Ptlf6Rlkb0tQbudftFaIxOsjrj9d81e
         e7hn0MBP6seQWoJuRKRT7uKVHaSFm6+aIbO7Br+HqDlQgaZP718dD4jyPuIbiIyuTEvA
         j78jVLLAu4x+pvWOuEnWFt2GMswnOxNJ/VO90MXa9wbIgLNLAYmt89Wt2OdhozjmPM/F
         s5i1N0t7forueMc9S7FEqA+7JlayDX5kA9UgdRkqz6siIIH2X12T5gEsWi5Kap8DUQ+z
         xdi5w4eOrqjs+51qP34pjIfhwc+GyrJCFLNYlhFD1oQUDA3tEE3/IiCyGR7s4CnYQo+q
         zsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934477; x=1746539277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jr4lBaLNAeSuH2b3VsvlM5nFl3TRbFBF79aK932ukkg=;
        b=muUMvtpOaSKhm/O4cS+W4RFJ+k5DGuTCm07AH1Nz0yfiZsuzSgSUOMbD/Kc/fwVSUa
         qfIQFuNs1wa2i+IS3V26hT2ME5e7PPPlguflf0N3V/E6k4OLRODzRDhKK79/ev5ClTTB
         Lza8/C/a09JiFrPojsa8CBAoe7bS2Sf3nx/7Tq+rsUMxPhiDr9wEUaqBq/Wyysj1N6ss
         IKXGCuPFwascQOPyjGKB1X2hmvOHLSPg0mZnqt2zgKNLaIcXNxERkmUzv5RWgVcE3FhL
         dDS2hTrTO7JKie9i729n5d602Bh9MWd9oRpW5YE5ZRj3mDJIyO6awDo//klY3VV88h/D
         1pNA==
X-Forwarded-Encrypted: i=1; AJvYcCWMCw+3XsO6vvDJMtHTR1hMNylhfYjqd+uD5625F0n0bAoRHME96J4v95nH/xhqKyCpjdv0uFp0@lists.cip-project.org
X-Gm-Message-State: AOJu0YxvwVVQF/p8tPmPJ9xUqqV4vwZhwHpj2RrV1LilgLCHGb8Erl0v
	WjI4RXRrirq7bgdoCu6t/ue7IjjE6Ic5Akq+bN/5l0TzQOdBzhnE0xhKn2P6TVI=
X-Gm-Gg: ASbGnct6aQ0W0Q9WSvFRrLCZg/SNnUKp6CnLQesSZ54HrvHQMCBJfPMaFD+EvTwMu9u
	za31JyNXCCo3WQe4ZYLls6pD3JsgwcAxwSRJu2l939ZCbrk2EqvRpz9vnyUtHMfS5g6a5v+LP5/
	gagwu/98wh6h46eF1Xxxl5giHa6otX+85ZpQeAob6qO3quaCmLC2Kum+hWcv3tC8fbxrgdLhIqR
	1Ts3M5Nd5pt+deWYBk59ReV6f3MDd8bA4Wx6RzgZJHNiPXtPoC3a6zQLkwX/zXcWNjvXEgFnb2u
	C8WrrYR5X082siLB7CikyTz/e+DHFGmFYKYdO1UA474yjXQJEWwz5Avek2zf0WKlDBlLJQo=
X-Google-Smtp-Source: AGHT+IFhOJFWHy+0nA7e0W72IfiDCPX7nOEUACdspqyTbVTnHI0FhQXF7DRb/cTVu+PkqlHZ+wDVBw==
X-Received: by 2002:a17:907:9446:b0:ac6:e33e:9ef8 with SMTP id a640c23a62f3a-acec692bfa9mr366058366b.2.1745934477034;
        Tue, 29 Apr 2025 06:47:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:56 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 16/21] i2c: riic: Add support for fast mode plus
Date: Tue, 29 Apr 2025 16:47:22 +0300
Message-ID: <20250429134727.2429662-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18729

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 3e3c9bea659a48388a7444b6c2c41e967b263a24 upstream.

Fast mode plus is available on most of the IP variants that RIIC driver
is working with. The exception is (according to HW manuals of the SoCs
where this IP is available) the Renesas RZ/A1H. For this, patch
introduces the struct riic_of_data::fast_mode_plus.

Fast mode plus was tested on RZ/G3S, RZ/G2{L,UL,LC}, RZ/Five by
instantiating the RIIC frequency to 1MHz and issuing i2c reads on the
fast mode plus capable devices (and the i2c clock frequency was checked on
RZ/G3S).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index bb1339ccfb49..8070d60d6974 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -64,6 +64,8 @@
 #define ICMR3_ACKWP	0x10
 #define ICMR3_ACKBT	0x08
 
+#define ICFER_FMPE	0x80
+
 #define ICIER_TIE	0x80
 #define ICIER_TEIE	0x40
 #define ICIER_RIE	0x20
@@ -81,6 +83,7 @@ enum riic_reg_list {
 	RIIC_ICCR2,
 	RIIC_ICMR1,
 	RIIC_ICMR3,
+	RIIC_ICFER,
 	RIIC_ICSER,
 	RIIC_ICIER,
 	RIIC_ICSR2,
@@ -93,6 +96,7 @@ enum riic_reg_list {
 
 struct riic_of_data {
 	const u8 *regs;
+	bool fast_mode_plus;
 };
 
 struct riic_dev {
@@ -312,11 +316,15 @@ static int riic_init_hw(struct riic_dev *riic)
 	int total_ticks, cks, brl, brh;
 	struct i2c_timings *t = &riic->i2c_t;
 	struct device *dev = riic->adapter.dev.parent;
+	bool fast_mode_plus = riic->info->fast_mode_plus;
 
-	if (t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) {
+	if ((!fast_mode_plus && t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) ||
+	    (fast_mode_plus && t->bus_freq_hz > I2C_MAX_FAST_MODE_PLUS_FREQ)) {
 		dev_err(&riic->adapter.dev,
 			"unsupported bus speed (%dHz). %d max\n",
-			t->bus_freq_hz, I2C_MAX_FAST_MODE_FREQ);
+			t->bus_freq_hz,
+			fast_mode_plus ? I2C_MAX_FAST_MODE_PLUS_FREQ :
+					 I2C_MAX_FAST_MODE_FREQ);
 		return -EINVAL;
 	}
 
@@ -402,6 +410,9 @@ static int riic_init_hw(struct riic_dev *riic)
 	riic_writeb(riic, 0, RIIC_ICSER);
 	riic_writeb(riic, ICMR3_ACKWP | ICMR3_RDRFS, RIIC_ICMR3);
 
+	if (fast_mode_plus && t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ)
+		riic_clear_set_bit(riic, 0, ICFER_FMPE, RIIC_ICFER);
+
 	riic_clear_set_bit(riic, ICCR1_IICRST, 0, RIIC_ICCR1);
 
 	pm_runtime_mark_last_busy(dev);
@@ -530,6 +541,7 @@ static const u8 riic_rz_a_regs[RIIC_REG_END] = {
 	[RIIC_ICCR2] = 0x04,
 	[RIIC_ICMR1] = 0x08,
 	[RIIC_ICMR3] = 0x10,
+	[RIIC_ICFER] = 0x14,
 	[RIIC_ICSER] = 0x18,
 	[RIIC_ICIER] = 0x1c,
 	[RIIC_ICSR2] = 0x24,
@@ -541,6 +553,11 @@ static const u8 riic_rz_a_regs[RIIC_REG_END] = {
 
 static const struct riic_of_data riic_rz_a_info = {
 	.regs = riic_rz_a_regs,
+	.fast_mode_plus = true,
+};
+
+static const struct riic_of_data riic_rz_a1h_info = {
+	.regs = riic_rz_a_regs,
 };
 
 static const u8 riic_rz_v2h_regs[RIIC_REG_END] = {
@@ -548,6 +565,7 @@ static const u8 riic_rz_v2h_regs[RIIC_REG_END] = {
 	[RIIC_ICCR2] = 0x01,
 	[RIIC_ICMR1] = 0x02,
 	[RIIC_ICMR3] = 0x04,
+	[RIIC_ICFER] = 0x05,
 	[RIIC_ICSER] = 0x06,
 	[RIIC_ICIER] = 0x07,
 	[RIIC_ICSR2] = 0x09,
@@ -559,6 +577,7 @@ static const u8 riic_rz_v2h_regs[RIIC_REG_END] = {
 
 static const struct riic_of_data riic_rz_v2h_info = {
 	.regs = riic_rz_v2h_regs,
+	.fast_mode_plus = true,
 };
 
 static int riic_i2c_suspend(struct device *dev)
@@ -612,6 +631,7 @@ static const struct dev_pm_ops riic_i2c_pm_ops = {
 
 static const struct of_device_id riic_i2c_dt_ids[] = {
 	{ .compatible = "renesas,riic-rz", .data = &riic_rz_a_info },
+	{ .compatible = "renesas,riic-r7s72100", .data =  &riic_rz_a1h_info, },
 	{ .compatible = "renesas,riic-r9a09g057", .data = &riic_rz_v2h_info },
 	{ /* Sentinel */ },
 };
-- 
2.43.0


