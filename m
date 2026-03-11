Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804B4105D295
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:19 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18643.1773227051926397889
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=l94nPU5l;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so53648005e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227050; x=1773831850; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOcRKPHOjobY8+hCVIxWKU3WfUEC5iVy/sysQ+o45eo=;
        b=l94nPU5lKYBY5D5UgzLclKhYzvxpGs28Bbn9HtD9nJcvFu/FhgzaVkgD7HUsPbbck9
         VoyZm2zXbLvwucR8R6ThSDDNOHO3xycglntH+DylE42rU+WIyLNzN0rekJXe2UYwuHGA
         qeJi1bmL9hSpZwFDVnJcMH7uxqIFcGAVMF7l25DrYdXM7zcme1o34S88KHhD092/AXTW
         Zfv3EpqNCVEuGeiL4IFWWE0opTMmG/cTNllc33tZQOS1/Ve+CHFC85mo/ZvhR56/gDbh
         Y+7E/jVIEsL+PJ7UZIyvA22QRBctsr8KE9Z2m5xFMyFKcS+bLSWwfqCGcJe5cqqdpBph
         h1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227050; x=1773831850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOcRKPHOjobY8+hCVIxWKU3WfUEC5iVy/sysQ+o45eo=;
        b=ftlSlYpFps3qwDbcFzlpXsyEs0siqPvaWJUS40lA22r1V1TV/ZtIWgfCY08O7ORVFr
         CkyeSreg7/zWGi4Oa8Lf2UQTW8VHD9xjYzEyP6d258xjvqOuUTUCW6m8K7+TUfUZymD9
         i88TKDM1WJ0ZnFqg5Epq6Mtu8hzZJtu8XR6C1A0VwlgnKPtmbpVSewo7jbZIO90r+5z/
         V15lMJQT5TnYOwsZ+knK9F52b8QS1ylDoUe/79i+BSj1SdAyhZ8RvEpZfWG0QScU645G
         59+j0K0/73hdQ58lQ6dq68REWvLOnZbiUSiF9ZRbbktsvMBQAKFpGm4V2SEMtwd336eD
         pmtw==
X-Gm-Message-State: AOJu0Ywmtd8pFZYA4ADGVaxgU0zIjyen+6bfU/jOj4D/rBE1jDbDJPzr
	nyfEobegIgy0E5nOYA7PdFfAm0br84E+Y8195ppt49r7sW/HABG7VysYVDNRfQfqj0o=
X-Gm-Gg: ATEYQzyae1oBSuHJxUX83ei48BOYydv7AATFS0lrgw+AYzI04+SPQXb7+7X43a1wzms
	xC83bkfzZubU1lQclHO/qE350kbIhwXrxaF/UNzNOzfNlRgwHIfDO9u0HhqwHRd0HU6MbzigwB3
	M+uqVYQtG4x3gxjV3Fhps8Ej9kM3fb+CzdChz/9Kw9jA3yrHn7FS0T9Amym7+AvmAtpDZ3VLOIC
	QEuTQKX1zs2gx2YM/XijKrD7ZQ2+5lwXXSwkpgMfNNuePNjSzgQIPg8duYZyP8eYOh/uMKVRxNv
	Rsw2WqqVrD/uqg+0CIThwgA+AccLq2UpkA691RJ9tNx2KnELrLrWivkZRNHiJpNIA5FL63PR3Pc
	fZvZsmYsDQ+PnkaR0uzCuUFkOS6HwV3Tw0M7H9qDN0cHqAgV6L5OIC2hiIPcnzCioR/y5Xig9N+
	eT2C0sCQG7S++LVksHSTKkxhrTmImhMs5J2bGkX3TPsyhsYqQ3ZB1+rj0uKtaX9QQ=
X-Received: by 2002:a05:600c:1da1:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-4854b0be170mr40374925e9.14.1773227050198;
        Wed, 11 Mar 2026 04:04:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 08/28] genirq/msi: Silence 'set affinity failed' warning
Date: Wed, 11 Mar 2026 13:03:37 +0200
Message-ID: <20260311110357.1938200-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22287

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

commit 5297bba507dc54045e6efeb9955c1271ca9aafe1 upstream.

Various PCI controllers that mux MSIs onto a single IRQ line produce these
"IRQ%d: set affinity failed" warnings when entering suspend. This has been
discussed before [1] [2] and an example test case is included at the end of
this commit message.

Controller drivers that create MSI IRQ domain with
MSI_FLAG_USE_DEF_CHIP_OPS and do not override the .irq_set_affinity()
irqchip callback get assigned the default msi_domain_set_affinity()
callback. That is not desired on controllers where it is not possible to
set affinity of each MSI IRQ line to a specific CPU core due to hardware
limitation.

Introduce flag MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity() unset
if the controller driver did not assign it.  This way, migrate_one_irq()
can exit right away, without printing the warning. The .irq_set_affinity()
implementations which only return -EINVAL can be removed from multiple
controller drivers.

  $ grep 25 /proc/interrupts
   25:   0 0 0 0 0 0 0 0   PCIe MSI   0   Edge   PCIe PME

  $ echo core > /sys/power/pm_test ; echo mem > /sys/power/state
  ...
  Disabling non-boot CPUs ...
  IRQ25: set affinity failed(-22). <---------- This is being silenced here
  psci: CPU7 killed (polled 4 ms)
  ...

[1] https://lore.kernel.org/all/d4a6eea3c5e33a3a4056885419df95a7@kernel.org/
[2] https://lore.kernel.org/all/5f4947b18bf381615a37aa81c2242477@kernel.org/

Link: https://lore.kernel.org/r/20240723132958.41320-2-marek.vasut+renesas@mailbox.org
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
[claudiu.beznea: fixed conflict in msi.h by keeping the 5.10 CIP
 definitions for MSI_FLAG_LEVEL_CAPABLE along with the MSI_FLAG_NO_AFFINITY
 introduced by this commit]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/msi.h | 2 ++
 kernel/irq/msi.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 70c910b23e13..5eb708a3bcc1 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -370,6 +370,8 @@ enum {
 	MSI_FLAG_MUST_REACTIVATE	= (1 << 5),
 	/* Is level-triggered capable, using two messages */
 	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
+	/* PCI MSIs cannot be steered separately to CPU cores */
+	MSI_FLAG_NO_AFFINITY		= (1 << 21),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 4457f3e966d0..2bde5ce72d70 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -272,7 +272,7 @@ static void msi_domain_update_chip_ops(struct msi_domain_info *info)
 	struct irq_chip *chip = info->chip;
 
 	BUG_ON(!chip || !chip->irq_mask || !chip->irq_unmask);
-	if (!chip->irq_set_affinity)
+	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
 		chip->irq_set_affinity = msi_domain_set_affinity;
 }
 
-- 
2.43.0


