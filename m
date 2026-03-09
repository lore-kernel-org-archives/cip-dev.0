Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C1AEF3717
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 08:11:43 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9253.1773043894238798522
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 01:11:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ACyLZMIR;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so19159685e9.0
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773043892; x=1773648692; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9UZgnGWBS0AFQ58A45HaQIDRBNAf25OPoModeuQaMw=;
        b=ACyLZMIRS7M6M5zTg3WHAhc+TX3OW4hifAp6JtxM1ZAfeijrnAnNI/Whfxnhpfy+8P
         QgtcjB4fS2K96zwITfiAzOdhIhu5v74RHXOclpAjrJFMfmtUtppYy95JqICHG3DAvQqd
         g2snx1kdahHbbyPSUNaba4UkTQDjKEsRRG0PY4zRnPbS7Hzkf0meWzuyyqQ/yjhNfQhe
         o/7+prX+ina8N8lFrAayKrprXnhlUmokQ3+lZH89S92YpTjMCDxqx2yoJtbvHWahDkwX
         K3WAkyoM29YkOqVphTqoXheR65MgVBC7DhvpDI/TDNRpEXDsXzf4o1l3j3lReXXKWFrt
         89bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043892; x=1773648692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u9UZgnGWBS0AFQ58A45HaQIDRBNAf25OPoModeuQaMw=;
        b=ZX9NomgO6bcc6swSZe1OpWDwfYo2fEQ1ttISrP7EbIR0rfP7kUA76XigRcpK9b4AmF
         cCQBpP5YYVGoj2jV59JDMxY8CcMlBuN94k+P35QDAmQG04Fo6Iu2IrJHy0KnnBgCSRXA
         VLJ9WDhxiuNSlGqhxriO5EakaoBxAnAg1WCcLpjO1eM7NUxnqWUcCsDKZnco0wsRRMDn
         ReUATBn+mw5cWC8vHVTcn3oKW+wcL2CVcflLY89gA0a5UolHhfnVP+IuI/vogyNrN+ch
         6ZcxEkpMCTGwejyNfL4A/1JJ5bvvMnO6Wp2PXBUbabpTKM56jkyhl2CIWeSuQ/vEbboA
         rfYg==
X-Gm-Message-State: AOJu0Yxt/FfZHLbCMT9DkHpYMxHiTwXgqninfZlMPjc6m5FpWukP7QlW
	buxfJ/AjFvHm7l3g7vjShrdHUmNS7PvhTVvAcYPF1BQ2dGiQlttV9vZY7R8e1g==
X-Gm-Gg: ATEYQzzP2T673rpzweIqZLkLlJNUeyAfzK1YFX7d044gF3EBrCESB27MZjNrhGT65II
	xclW+RWBNv8zdXDZXpRHlYOlG6VjqjQz5d8/nDpmO4adO/Ci34P9APW24r0vlOErcfkEjYk6aer
	fPMxeLcdXq3BQ9o+IuY6yqgRK0+WDu6oGmP5sUhAJKLHPH2n56Nec9rqZHtBKrQxVfKLHSAesti
	3sOdkMfUYKvUAwbWSJSxH8L2aOxfbfxbbnCxDQk3dVZF395kP2rnVqBI63bleeyhJfnqB8si8tw
	vq0txOcC0gVYyZBVF8zInZ8vHPKoz4cO7NPAKaVd0KpcGnCW69RqcYDcUhWqd5R2W/vu1/7BUHM
	yD/KkARVOaABL8zKGSCesEFO9HJtMdlc0+fvv2n2X6GyP3D4FxUsf/GBed5cVHnDYAloz2PwaD0
	qeZiR3UZ4x1r/ygT9y/yGXSljcYUNjdhjCgvYpe/fez8ZlnebB
X-Received: by 2002:a05:600c:350e:b0:477:9b35:3e49 with SMTP id 5b1f17b1804b1-48526916bafmr153163585e9.3.1773043891769;
        Mon, 09 Mar 2026 01:11:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853f8f9938sm4252135e9.23.2026.03.09.01.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 01:11:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 1/6] irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during resume
Date: Mon,  9 Mar 2026 08:11:21 +0000
Message-ID: <20260309081129.154109-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
References: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 08:11:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22156

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit cd4a3ced4d1cdb14ffe905657b98a91e9d239dfb ]

A glitch in the edge detection circuit can cause a spurious interrupt. The
hardware manual recommends clearing the status flag after setting the
ICU_TSSRk register as a countermeasure.

Currently, a spurious interrupt is generated on the resume path of s2idle
for the PMIC RTC TINT interrupt due to a glitch related to unnecessary
enabling/disabling of the TINT enable bit.

Fix this issue by not setting TSSR(TINT Source) and TITSR(TINT Detection
Method Selection) registers if the values are the same as those set
in these registers.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260113125315.359967-2-biju.das.jz@bp.renesas.com
[ Biju: Added non-const variant of field_get ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 1d03ee911b2a..f826b680a286 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -92,6 +92,8 @@
 #define ICU_RZG3E_TSSEL_MAX_VAL			0x8c
 #define ICU_RZV2H_TSSEL_MAX_VAL			0x55
 
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+
 /**
  * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info structure.
  * @tssel_lut:		TINT lookup table
@@ -331,6 +333,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	u32 titsr, titsr_k, titsel_n, tien;
 	struct rzv2h_icu_priv *priv;
 	u32 tssr, tssr_k, tssel_n;
+	u32 titsr_cur, tssr_cur;
 	unsigned int hwirq;
 	u32 tint, sense;
 	int tint_nr;
@@ -379,12 +382,18 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	guard(raw_spinlock)(&priv->lock);
 
 	tssr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
+	titsr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr_k));
+
+	tssr_cur = field_get(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width), tssr);
+	titsr_cur = field_get(ICU_TITSR_TITSEL_MASK(titsel_n), titsr);
+	if (tssr_cur == tint && titsr_cur == sense)
+		return 0;
+
 	tssr &= ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien);
 	tssr |= ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
 
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 
-	titsr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr_k));
 	titsr &= ~ICU_TITSR_TITSEL_MASK(titsel_n);
 	titsr |= ICU_TITSR_TITSEL_PREP(sense, titsel_n);
 
-- 
2.43.0


