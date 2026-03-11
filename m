Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C7710611EF
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:40 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18314.1773227139128548840
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NSzia8bL;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so44761675e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227137; x=1773831937; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDBlSqw2zLoLO6CIH1tCeN3MXGyHIKF/Him3pfPvbkA=;
        b=NSzia8bLZQ1JJn1i1HoS+woD63B0UMI2cesvQUyOrN8NrBYTC4yLtAC1XB00ogWJVj
         P4v3LV/NL02NnHYWuZbaxOjL/On/5U3W8kX12qBwuNOhhFnslfa8G/5tZ7+2hbTklLTB
         fpYQZyVHvK0mrLhlISJ/u2WbD9GfKQKtydqoITdWH1chRF7RiC5WLS+O9yBR8zKPs1zd
         Ja85wDFXi5xGeY7FLZQ3owNOMO+MsERGvBO20zUXrt5yDWK+DrQ9HuzRJe9mfxxjNELT
         aGmyUiNMwDFfj9bdg4FCfOFaRTKduPKgDjeyyNMbaS1Q3P4T8zlYXYN8QXlsOrRaKUP1
         xrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227137; x=1773831937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fDBlSqw2zLoLO6CIH1tCeN3MXGyHIKF/Him3pfPvbkA=;
        b=Ohi0P3ymWBrzbAqCdexBGtQ9HjkHXF5f3k4ROczHIdx1gKoJV65LEVDDA1ne7SSK2o
         Z6uRnkVXdGAPPSznQ9cQ5OTsqvzvhfrSIAPp0e3P+d37DCtJnzpfyQntw2v+u8nrBmug
         EMbjr+rr+WCNZS9P2YrGgOsLJ9vUVIwgKrw9/sY+O5s347HrohagCr2A1r04Czm4Zu/y
         e5VdjL8hc0Bd6M1cI3XPCjizIeVtK/0hMUmf3wB1xUZqmZyR+0IPs6r/LVQt2SH4Oq2E
         NFDlJJkJ/qDJxVfd0UgsOSz4iimayDroLjUNb5GcAGVOX28+LcccsoS5QdWAUY4elLho
         QlSw==
X-Gm-Message-State: AOJu0Yyk7IU3oivDeD1c92VfPdO3nZaLkVvgbXep8NXElta/2kCzYSFr
	k7RAP4o+y13/DEGhxmJ3HzzGzywjW06paweZyOgII3jDFQ+jKm+XevlmWQy32nhsg9701JBU/rC
	9QU0F
X-Gm-Gg: ATEYQzyK+73AVlsRAOxWhi5eT1UdZegngedu5guFcg6jVLjFqTtpEvIH8bJ8fRdLKCl
	+zUb61ThG7Ix+/BkejfUUCVUbSasiV9GpEQjyoKT1ooFvucogJs/w30TI3QdUqT8AjjUP7/G4dy
	7pkKxoGzboBF0piy5c3L6235TqZEUx3f99y01RTHtG/D8vq0JcDXLW9DzxYPkZOhJ7s8p/NOMwI
	zszQAr1t7LN/w4bvr+ZfSCFLkO3wFtYr5O0l1WicqJ8RKMApPyboXBS6YKxPovfS3CamzsiT2TM
	ywBzkW7juXlkmHudNcRWaRKDeb1S+tWBFh+Me70UwthDeTON79dn5mDRetKWzGw+HVa+AYjXx3c
	tZG14T0Jl12yy/Ne+MrUtzlaoBbsXsIep3XDlu0Fd7MjuPyvfzyAIbN9UlUjkXvyAGj5mjGMX5X
	KJo+E9bDPa1YQsIhmDmA/9FzFHRiVXVEDBlypl4D515hMxn8AkDxYR
X-Received: by 2002:a05:600c:3551:b0:485:2f6a:6ed with SMTP id 5b1f17b1804b1-4854b10cf6amr35328055e9.28.1773227137336;
        Wed, 11 Mar 2026 04:05:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:35 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 11/17] PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and RZG3S_PCI_PINTRCVIS
Date: Wed, 11 Mar 2026 13:05:14 +0200
Message-ID: <20260311110520.1938414-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22319

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 62d4911290f9cbb16f5b6ba6782660148a656fc7 upstream.

The RZG3S_PCI_MSIRS and RZG3S_PCI_PINTRCVIS registers are of the R/W1C
type. According to the RZ/G3S HW Manual, Rev. 1.10, chapter 34.2.1
Register Type, R/W1C register bits are cleared to 0b by writing 1b, while
writing 0b has no effect. Therefore, there is no need to take a lock
around writes to these registers.

Drop the locking.

Along with this, add a note about the R/W1C register type to the register
offset definitions.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20251217111510.138848-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 59506f17562a..5f007569d824 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -72,6 +72,7 @@
 #define RZG3S_PCI_PINTRCVIE_INTX(i)		BIT(i)
 #define RZG3S_PCI_PINTRCVIE_MSI			BIT(4)
 
+/* Register is R/W1C, it doesn't require locking. */
 #define RZG3S_PCI_PINTRCVIS			0x114
 #define RZG3S_PCI_PINTRCVIS_INTX(i)		BIT(i)
 #define RZG3S_PCI_PINTRCVIS_MSI			BIT(4)
@@ -113,6 +114,8 @@
 #define RZG3S_PCI_MSIRE_ENA			BIT(0)
 
 #define RZG3S_PCI_MSIRM(id)			(0x608 + (id) * 0x10)
+
+/* Register is R/W1C, it doesn't require locking. */
 #define RZG3S_PCI_MSIRS(id)			(0x60c + (id) * 0x10)
 
 #define RZG3S_PCI_AWBASEL(id)			(0x1000 + (id) * 0x20)
@@ -530,8 +533,6 @@ static void rzg3s_pcie_msi_irq_ack(struct irq_data *d)
 	u8 reg_bit = d->hwirq % RZG3S_PCI_MSI_INT_PER_REG;
 	u8 reg_id = d->hwirq / RZG3S_PCI_MSI_INT_PER_REG;
 
-	guard(raw_spinlock_irqsave)(&host->hw_lock);
-
 	writel_relaxed(BIT(reg_bit), host->axi + RZG3S_PCI_MSIRS(reg_id));
 }
 
@@ -862,8 +863,6 @@ static void rzg3s_pcie_intx_irq_ack(struct irq_data *d)
 {
 	struct rzg3s_pcie_host *host = irq_data_get_irq_chip_data(d);
 
-	guard(raw_spinlock_irqsave)(&host->hw_lock);
-
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
 			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq),
 			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq));
-- 
2.43.0


