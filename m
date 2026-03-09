Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B97EF3704
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 07:51:21 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9056.1773042677224188405
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 00:51:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hJXLhSIV;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439bcec8613so5700557f8f.3
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 00:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773042675; x=1773647475; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+wCfH9QSrSPvSdx9W92F2K6/k+zLgehahmgt7AEjgE=;
        b=hJXLhSIVfMe3F9WqImc08bLnxRGH0b2J0OregCagNx17znnL5deHlhWOwmj9T5iM+t
         +OwPKnZO+9ud5AY/9tnx2l9IZgqpBaGRm8NB2K+DTFbQQqoTIqb3nwQT7MNSv1nV4Ca2
         bq5grDY8Sy32cR921p8QyMoO392tsO1aeno4etQE/XBCN5L/mHoV7kkNYyHjC7+s5gNm
         pg2Tb4sm9zPZTiPDQl0sNsdBCAMp0v5wUbzA11YlUyX9U07blptqT8L8hg6D3cu3ryYA
         grgoAFaQj9gwv6Dw/PwBHli+5AueFhVnZeMg2/8JJVgtIAFhEMJuMYUkeNStmDQ6GR4a
         TA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042675; x=1773647475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+wCfH9QSrSPvSdx9W92F2K6/k+zLgehahmgt7AEjgE=;
        b=aiXwbUEaV0jsE4N+xNG2+oImzgg1hmzE7fuqfTdO6E0MKuuna1d0USqjB0LSP+S1lS
         9adpD0ZGcszxnE1rfEnIF/7PJpXOkhS/lYVvP0MbWtBJJQqNufYarTFnlVZX6gAbEPOi
         oqb9mez4WBNj0Gzs5wLCOfcjsOKGm+tIkB0SCrkSWIZ2aOZyfDasOam8xUVZAX36OB5w
         UG/66I/C8BvA8g9TB2ENpo2MruM5vthcjstZrMEBN+pUtLtEffSTaQ73pnOL6yZ7LzV/
         Bd2AlPbC8lQt3pnR3tScjS5taCUprEbjM7YY/JtUuOfmR60n+GOK2r56N7qrvBdiMFvz
         ZQ5g==
X-Gm-Message-State: AOJu0YwW0Uxnxvmf1EsArbZkp610vf8uikKeyAe/yZQ05hAcRUMnA/q7
	qAEvAxT5tzqHMxDbIKZ2cW6WIvHHY607r2nDYCVgV2Y8okHDnz7Mfcg9D5CRog==
X-Gm-Gg: ATEYQzwUOWNCsQx9A1x+Fey1f7nqChmpcFFkHet+Z26ArhbWN1Sb2gVxT9qqLq3qOkq
	tR8ailriq7il+aBhaAHRRMJ2JdOPAhfCvEnr2UlsK4nzLnnJiVc43mzz6O4GNmDeWpj7NTTrbDS
	6+yYfXi3zP4X1vKI8RQcJC3/D4wuZBK0cBDgVS5XpiGen0v/XMfdBRuy7Qu92HHqSOQhSsYruAI
	Qvx66SDu3+4fimh/hCOSfekmkoWK41xuM4aXYL0wfVi/vFPZFvWLacIPSRoYKgOw7LXtCqZiG/a
	6S6dsF2sPlniV1+3QvAJvfV20RbGHFdIEV7+TrIhvCNOZdRwDYTBGg14h/MkrVcDnyNEMaJZHBu
	cUgUuE7a8HAQlGDo46XZIAF+ooZgkvq3JW0zoi20I+Q/tdJJhtPp4Le+rX30ANP+d/OfmI2M3yZ
	iTm5k/UTRUZCuehRkl87XOQZ02fGAUxVc6zcejtqiAq8kelalZ
X-Received: by 2002:a05:6000:1845:b0:439:c5cf:fc68 with SMTP id ffacd0b85a97d-439da3483b0mr17081784f8f.1.1773042674962;
        Mon, 09 Mar 2026 00:51:14 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba06sm25639376f8f.24.2026.03.09.00.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 00:51:14 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/6] irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during resume
Date: Mon,  9 Mar 2026 07:51:03 +0000
Message-ID: <20260309075112.35445-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
References: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:51:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22149

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
index 766adccf11dc..ea67da9459b7 100644
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


