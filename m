Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C7BCA5FDD
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 12:51:07 +0000 (UTC)
Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11318.1790945458072233343
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 05:50:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=n+SJnin5;
 spf=pass (domain: gmail.com, ip: 74.125.225.106, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-48b0622cc90so1296243f8f.1
        for <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945456; x=1791550256; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jqrq0V/EJpMgj5sBvswe65VayhbVhRPiZVWp2YVfLRw=;
        b=n+SJnin5KNoNSSULKt4zeUkuWQcrcpO5CuNHxG1nmRR6jjtS02jwx4cyz4nbHCHV34
         GtVqaPQVgCs3TPSbW+DlaW6/1zmy9l2SMyF7keMf1pkL0jHgIL2f73Stmvj5CmfiI35f
         HGtWWpSHVxc949GNIjD1HJ8csJlbXe4s2Ry6CR20nvvQUvZxqN9nCA2GzFVeeL3rbZzl
         jBOC6b3XsPWA9tVeZLqVpcF+kSR17uEzqYdwAo9c7nKaJcuvb0MGG3TeQgK9XhlanGqj
         uCgqIwAY8xKhORCApcbWb60uaWe6jr6tFwwwp1Yj5fRIdYrYSmWXlkG6XtH+iD0y4ORs
         GcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945456; x=1791550256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jqrq0V/EJpMgj5sBvswe65VayhbVhRPiZVWp2YVfLRw=;
        b=LUN7AAccHQuXFe57PHFebrvlGtnLEEuTqJ1WPZTf5tJKFciziXsx5HOkWgVdrTIBY+
         XRnc3uIcLj4T5b5WM8dXIV9we0D+qa6YdjW7kZ2TcdZ6F8abPDKS3sYrfiALGrG0l6et
         FnW7A9oPQhzxNuEwOwB3j2enoKHvLvwujUMr9cxpx8XKIkdy8MiGnOEnwNbDqZa+HCPL
         ceXrB/4iW9KpXZVF5Okjn54GFX9QGvDHWaJKyaIhAcsP83RZH7rkL14aYFNx9mOE4J2O
         Zi9Tteo7Jb2pEvLJKJPsGjb7t776nWH8pWIdC4qYYr4MWUckm0yqo2ohZ+oj2T7fQMN1
         0niQ==
X-Gm-Message-State: AFq9FYJvM8BBN+Ij6d0cV6loOlmgEMd84Qnn0QKRXzaJwLSOdT3WhMNn
	ZAfFZgm3g+AeEzEdjg+UCxvcmfA2f2mwrJCMAmGDDkjx01bGi0/MEP3lsGYKBg==
X-Gm-Gg: AYBFou3yYt2ZlXmcBjGP94d2hjprfxP0n6KWvR3SUUQlcQRkAjTstBqFHYSemMDm2gb
	w55XiLFdN3oGIbZ7CEUx4LjBrf3L+q7EqWYVVuFCiR65WMtGo7MTUg/6Jwi8xnWpXL0b+Zl9zek
	H/pCEIYUSg3RGTPWIVQInMOmkv2Ht6fM30IDWayZZJWxeQkUNagHH/Tz+P+Babr3PbLRX8osj64
	GA6L6o5ICRhJ5vcBLsHgG4nNSAa9tP/l+HFHkEROiUM83BB1MHdbjrWAaNSSqfJNq0fURlsUtGo
	dSfrRthW+Unh5Qj/rtgAgoHejS3MlIFnLSzWWkFwkYbSQr2+FXZvkuPwvtZt0LimOT5VoFK7vnY
	t/ywIZEwaDqU7zIg+BhOUsedPVj/hwFAnfyYvZWcuk++AwC2PAlXXbKNgB7SMXdXzBe6TueZMbc
	EtuVCFt8lJT3cGgcy1xYM+NeR7ZuIbDb3UOe+kd2+D+waBCS2ObGZCQuzvgJEc8GBTLA1+eBTd6
	R20gcCS593iIHwrXA==
X-Received: by 2002:a05:6000:41d3:b0:48b:9d80:53a5 with SMTP id ffacd0b85a97d-48b9d8056bcmr3417800f8f.10.1790945456108;
        Fri, 02 Oct 2026 05:50:56 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:a3af:1973:c597:abc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b82253dc9sm5328356f8f.3.2026.10.02.05.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:50:55 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip] irqchip/renesas-rzg2l: Fix loss of interrupt
Date: Fri,  2 Oct 2026 13:50:53 +0100
Message-ID: <20261002125054.360202-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 12:51:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24415

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 50b10bd0c2d721ad38abd1abe3acdefb6caa0944 ]

rzg2l_clear_irq_int() and rzg2l_clear_tint_int() perform a
read-modify-write on the ISCR/TSCR status registers to clear the bit
for the interrupt just handled. Since these registers are
write-0-to-clear per bit, this is racy:

If another interrupt's status bit gets set between the read and the write,
that bit is written back as 0 by the software-constructed value, clearing
an interrupt that hasn't been serviced yet and losing it.

This can be reproduced by triggering multiple interrupts at once, e.g.:

  gpioset -c gpiochip0 355=0 353=0 328=0 352=0

Fix this by writing back only the bit being cleared, with all other bits
set to 1, instead of read-modify-writing the whole register.  Since 1-bits
are left unchanged by hardware, concurrently-set status bits for other
interrupts are preserved.

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260818110937.5816-1-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 This patch is present in 6.1,6.12 stable.
---
 drivers/irqchip/irq-renesas-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 1744a68db793..d7ac8a2bf33c 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -104,7 +104,7 @@ static void rzg2l_clear_irq_int(struct rzg2l_irqc_priv *priv, unsigned int hwirq
 	 * falling/rising-edge.
 	 */
 	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq))) {
-		writel_relaxed(iscr & ~bit, priv->base + ISCR);
+		writel_relaxed(~bit, priv->base + ISCR);
 		/*
 		 * Enforce that the posted write is flushed to prevent that the
 		 * just handled interrupt is raised again.
@@ -120,7 +120,7 @@ static void rzg2l_clear_tint_int(struct rzg2l_irqc_priv *priv, unsigned int hwir
 
 	reg = readl_relaxed(priv->base + TSCR);
 	if (reg & bit) {
-		writel_relaxed(reg & ~bit, priv->base + TSCR);
+		writel_relaxed(~bit, priv->base + TSCR);
 		/*
 		 * Enforce that the posted write is flushed to prevent that the
 		 * just handled interrupt is raised again.
-- 
2.43.0


