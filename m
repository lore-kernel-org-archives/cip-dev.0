Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E60C44501
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:06 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89135.1783073283543478054
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gIHYCe3I;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so2417955e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073282; x=1783678082; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mnk8bYmi6SR6z9zpENkiOmH99S/ziRgmeLUQptguCLs=;
        b=gIHYCe3IZUgoNU5oLhMJi8leYe7GQ7GkSqgBzgfHWmiFFcTP0X/M2v4Ws1PS8nnvf4
         9HvmauhCI1vtG6G9jI50r5EK9qO/mmf7UFW7V8xoabCO83V3gUq2gJYO63P5gCrefSsz
         Ccc3d4EXA14yntmvKvTGhrM2MMdqY6om911K17r5NOrBE1fqZswVjiSeHurD6PYkp4la
         qZ4qwGBm2lbS0plKFBUqkAmuiBp2RyGFKlEIUWuvyrwoVOkncEbqlG3v7X1tV5G4bies
         yWkao99lAXkW7OM1rDEjOtoKpBSaexDWckM6XmO6owPvY+CgMl346+AyMP0XLbbl4E9V
         rqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073282; x=1783678082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mnk8bYmi6SR6z9zpENkiOmH99S/ziRgmeLUQptguCLs=;
        b=dnen2GJ9GofCgfcdDgeB0q5zvURuJJLPp60PKjf9etlG09z3ShNTODqrHlMiqxt/1V
         0ZSgIgwWhayBKMlOAT9QymFsRDkYRfJ6SMMbolUuEdtbUU62i3lW1PHFnXrv0Ww20LMY
         O4Q0pZBiJ4wFDPeVXnRqzqS5bdcNoDu85VWm3k94/s8NryfjrJGdFjfyTMCxdpstzRrN
         P5eut35ThIivFSOYSPHoqAJUKSV8NaIpPboc4CSBHG1Z2LPUOmolBIHCSLIXHyddbhWs
         gviCpHSZgqPyqI3u0is6cgulOKu4iS5c3Ih1Qx3ScOt5DJ7DB1p9/OPdqomR8T4ymKEf
         fbkQ==
X-Gm-Message-State: AOJu0YwSKhXlXk5YfpLOPLm9S7o+pv8SCh6xF7s9o8fbeb55RDZfKpqE
	2MygP36gf0pRR9L8bmli6xpogzhHx3ubKyU/6DQqs+BeX+K1jgPnZcShXXiSHNgX
X-Gm-Gg: AfdE7clHNMfOWsmRm6cE9JBAvXC0HlhruStj+uKg9bnToW74clt0E0bgGM91QloBzPI
	Elx5RyRtgfm5h/ef+oSA/0ktdB3BS6m+K7yYmtbnEbJxfLB4yMo2ay5d8QtWuUVHuQ7fD5MpLic
	5dATJx1dzLV5p9kUKidJp3jCDCxkImQlOKKBcPDa0Uk8/l0AHFLhT9wr1kJ6HaI/Ha6zCnhStl7
	K689mp2TpggfW5wHcrcxljsDLllvBqr6dvOLBXchrfz7cvAPHwshXOUM2qEbFXseOJzO1GXezCx
	y7L+0gQS2HVU+gDJL2DjT5fofGbJP0tKUjxF2C3T2JTIxJ4Rta3w8elPpvElXW3LyW3EhTbJ7wt
	N4NF/Tc6KO5ezLfnspsb6YdZyKm6LptfvtNtPSNPN8Xb40KdOr09UsduE2rVu/UNVeJTRx66cdx
	Huf0XjN4VuOT0jUyvLhVYy
X-Received: by 2002:a05:600c:c165:b0:493:c9b9:415f with SMTP id 5b1f17b1804b1-493c9f22778mr40222625e9.25.1783073281636;
        Fri, 03 Jul 2026 03:08:01 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/26] irqchip/renesas-rzg2l: Drop redundant IRQC_TINT_START check in rzg2l_irqc_alloc()
Date: Fri,  3 Jul 2026 11:07:28 +0100
Message-ID: <20260703100756.238233-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23401

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0109d24b4cdc2cdbc127f86cbede83adae2187d7 ]

The check `hwirq < IRQC_TINT_START` in rzg2l_irqc_alloc() is unnecessary as
the condition is already guaranteed to be false at that point in the code.

The outer `if (hwirq > IRQC_IRQ_COUNT)` block ensures that hwirq is always
above IRQC_IRQ_COUNT before reaching this check, and since IRQC_TINT_START
<= IRQC_IRQ_COUNT, the guard can never trigger.

Remove the dead code to simplify the allocation path.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-5-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 5f67013227c4..122d744afdf9 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -488,9 +488,6 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 	if (hwirq > IRQC_IRQ_COUNT) {
 		tint = TINT_EXTRACT_GPIOINT(hwirq);
 		hwirq = TINT_EXTRACT_HWIRQ(hwirq);
-
-		if (hwirq < IRQC_TINT_START)
-			return -EINVAL;
 	}
 
 	if (hwirq > (IRQC_NUM_IRQ - 1))
-- 
2.43.0


