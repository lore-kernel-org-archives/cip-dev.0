Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAE4C44509
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:06 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89137.1783073285009281356
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=K9LCvTvQ;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45fd464d51fso211545f8f.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073283; x=1783678083; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzBIVaZGlSMdrROWRgLIUp4FKoPUn9uI+mLN6xwcwww=;
        b=K9LCvTvQEbKmvtu90Ib34wCzmwv2Tkixe46tBXX+CrTInW7iRfEIS0LBfXaqrDf+P3
         7PZXF5H5eDhnZ7qFq+hOvH/GTbTriQHPI8Q8jO6Km1W77S9WexWTXY1UZYwXrPqBbfHa
         kQWQq7pOFA+2vP7zAeCPdHbzPsFtkqejMcVSF2sL18AhzzLWgDFq9BpLbvK0F2UKgLu0
         QnxTH/p1Zm5dR0U/Z97OYf6u/zdA9CaZCzpfSmH3TIrcW3s7QG486zriI87oncrSvCII
         Gh6H8htBmpcQJrkqctyUXXv/bL2rHCJ6UW/4bYvud21E+39kFIQpVi/GQx2DCxJf2X0v
         RczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073283; x=1783678083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzBIVaZGlSMdrROWRgLIUp4FKoPUn9uI+mLN6xwcwww=;
        b=D9HLfkkdnhYzoYLeV7TPr1WdUNV/pbOnICpwgNmymbruC+JgSPNliMI3xhA6lgZTWS
         dt5Yq2S7sjhXBEIs2Xr+yFqYFgs0pVX5rFUJak9I6qrRZ1vzRpONaBW64q3QSj90JRMN
         7ph4xfxZUEP3/YKnaxfAhFwyPshIYdhY0r+W05w4k6RSwXozan0uVSjwbt/mpgPKnfal
         KgDwaveTBJeUq7DAe6SgPsSdE7tmBArDpvwwdSd3OFwe1KJe4L61bd2MVfmkkJY2MiJB
         FXCY3VJNFWk5aQoAuj+BXPoxqa5U8KHF8z2Bu6l9E/TkV/3Tu6kYTwKLjNOws7i23O/a
         K7uA==
X-Gm-Message-State: AOJu0Yw9eUYznaYVnqPXrQmLbCPL/vQIoDzL/Cg+NycgWlVd2DRJr+Za
	VghBTTFBA0wrBRTCGs1b4CE6mca0mpPImb0Y4g0nJVtfHMdR/Dil20R1ZmFQrHUM
X-Gm-Gg: AfdE7cn+PixOX2GZVkSU+1O43heR5DWZEPcBf5pLOhTKuj1Dthvb0a0AGJvs16tjgr1
	b1M7ibi4z+wid8m321zy5VRKwjn7ieh5qzU6Oc5MqzdbudTubNZc6nmI0imhh5jfJMHTrcKZANT
	eOg1QBxgw0lTRCDUj/qH/8QrzXOJxvIP4WPW+facQYQ+IxtoZ4901FhjarPs75i8/hrWk+hSvkG
	xmgUghTOxJUJObhFDGMXgGGqKS0GWbDjA/I+0u9M6HG5gGflcO8/pMOWImtW+Umg60ySHZHtbRt
	esL5NaICjsBkr67cYkxOdncpMfCkXOu5J9ehOMak/MycFf08Z0PFH+R/Lo+7ZLXkZbc0y46He1N
	tmAfenQ5Qdchys/c5xZL1OnMAvWIMK4Nc9745tQnQbRv7JX3b54Vgv0+fC+HUOtXOYkBDhUphHx
	bw9+/0tsQv8gXNOGJjDngp+Vdhs03Y+ro=
X-Received: by 2002:a05:600c:c046:b0:492:5e22:ef18 with SMTP id 5b1f17b1804b1-493c2b490f3mr97443145e9.9.1783073282731;
        Fri, 03 Jul 2026 03:08:02 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:02 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/26] irqchip/renesas-rzg2l: Split EOI handler into separate IRQ and TINT functions
Date: Fri,  3 Jul 2026 11:07:30 +0100
Message-ID: <20260703100756.238233-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23403

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 6e5e0331dea48bbd6955af562aab4972a3950fa2 ]

The common rzg2l_irqc_eoi() handler uses a conditional to determine whether
to clear an IRQ or an TINT interrupt.

Split this into two dedicated handlers, rzg2l_irqc_irq_eoi() and
rzg2l_irqc_tint_eoi(), each handling only their respective interrupt type
without the need for range checks.

While at it, simplify rzg2l_irqc_{irq,tint}_eoi() by replacing
raw_spin_lock locking/unlocking with scoped_guard().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-7-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 4a4b6624ecb6..406b6ad45ef5 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -131,17 +131,25 @@ static void rzg2l_clear_tint_int(struct rzg2l_irqc_priv *priv, unsigned int hwir
 	}
 }
 
-static void rzg2l_irqc_eoi(struct irq_data *d)
+static void rzg2l_irqc_irq_eoi(struct irq_data *d)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
-	raw_spin_lock(&priv->lock);
-	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
+	scoped_guard(raw_spinlock, &priv->lock)
 		rzg2l_clear_irq_int(priv, hw_irq);
-	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
+
+	irq_chip_eoi_parent(d);
+}
+
+static void rzg2l_irqc_tint_eoi(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hw_irq = irqd_to_hwirq(d);
+
+	scoped_guard(raw_spinlock, &priv->lock)
 		rzg2l_clear_tint_int(priv, hw_irq);
-	raw_spin_unlock(&priv->lock);
+
 	irq_chip_eoi_parent(d);
 }
 
@@ -435,7 +443,7 @@ static struct syscore_ops rzg2l_irqc_syscore_ops = {
 
 static const struct irq_chip rzg2l_irqc_irq_chip = {
 	.name			= "rzg2l-irqc",
-	.irq_eoi		= rzg2l_irqc_eoi,
+	.irq_eoi		= rzg2l_irqc_irq_eoi,
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_disable		= rzg2l_irqc_irq_disable,
@@ -452,7 +460,7 @@ static const struct irq_chip rzg2l_irqc_irq_chip = {
 
 static const struct irq_chip rzg2l_irqc_tint_chip = {
 	.name			= "rzg2l-irqc",
-	.irq_eoi		= rzg2l_irqc_eoi,
+	.irq_eoi		= rzg2l_irqc_tint_eoi,
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_disable		= rzg2l_irqc_irq_disable,
@@ -469,7 +477,7 @@ static const struct irq_chip rzg2l_irqc_tint_chip = {
 
 static const struct irq_chip rzfive_irqc_irq_chip = {
 	.name			= "rzfive-irqc",
-	.irq_eoi		= rzg2l_irqc_eoi,
+	.irq_eoi		= rzg2l_irqc_irq_eoi,
 	.irq_mask		= rzfive_irqc_mask,
 	.irq_unmask		= rzfive_irqc_unmask,
 	.irq_disable		= rzfive_irqc_irq_disable,
@@ -486,7 +494,7 @@ static const struct irq_chip rzfive_irqc_irq_chip = {
 
 static const struct irq_chip rzfive_irqc_tint_chip = {
 	.name			= "rzfive-irqc",
-	.irq_eoi		= rzg2l_irqc_eoi,
+	.irq_eoi		= rzg2l_irqc_tint_eoi,
 	.irq_mask		= rzfive_irqc_mask,
 	.irq_unmask		= rzfive_irqc_unmask,
 	.irq_disable		= rzfive_irqc_irq_disable,
-- 
2.43.0


