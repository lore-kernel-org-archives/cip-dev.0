Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5806E1062866
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:52 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18742.1773227205273668556
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fnJ8yoz4;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48538c5956bso8997485e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227204; x=1773832004; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDBlSqw2zLoLO6CIH1tCeN3MXGyHIKF/Him3pfPvbkA=;
        b=fnJ8yoz4Rz16PFoY1jOzScHhJNYCAGkTjj2zeVzW4ytiYeetu8ukNZ8Uhm5QYfpHHz
         BkP8A6iI577qf8R8VzFfJmEqY/FXvdcOAH6ILmYl/Ngg1yG3/YCtOUKcihdVOW7Aui+e
         cSbhFn7z8FAe2NN+mEA7Y80j8hZWcUpq2Jex4tp0JFUhW5dYjl/XWQ0fL/73j2n769Xm
         NCmpGDqrvkhvbB8WlKn7InaPBRE1wZUboMoL9DdM9lps79cTPY3h7C86z2P0qhgKyWGo
         tvCH+TUC2FbBfmIB4JRg8A9OLDecr5Iak6IE7LM5LbRGFDERoWaO6ZcQM70HyF2SC/Yw
         cRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227204; x=1773832004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fDBlSqw2zLoLO6CIH1tCeN3MXGyHIKF/Him3pfPvbkA=;
        b=wwDZR+qA4wmduSo96bakGyNu3p4mb5BFrXiE8DsSUAMUwLvfUuXqyMyoxp2+jz7PdP
         PnMO1gwcnZ7FcANLbBOisYUSTuOgB1bh6b7wYpKM4UsjQjVmId1OaGA/vrsuLGqwkENE
         u/cr01XWxwdGWAcjDmRy5N77LuImTxFPbWqPf9hidaE2gszQqbtykncqCrtLsoheGMEA
         9KMMFPLLkrfrZUHTrx0I9wmEWUjeVCMBY4B48jOLPKjsOokMNyPBVFFcKr5LXUOWWJyy
         EJZH4VRJBV++U5wTT8bWCy5t31UCu3NwMqN+S8fNKVTm2iUOcGmqg/0xWDEcfPnlDVbN
         XbEQ==
X-Gm-Message-State: AOJu0YwgVr5oqUv9hXfYDk73Lygfd3mmByRzC7EkTYGe2+V2qenWbdO/
	4VjrFWcuaQxBx1DRaYKieCwob61xA6t5DVfnY1BMw1jNDEdrj/sHpkdwCWJ5cOUQ83U=
X-Gm-Gg: ATEYQzwAXxXn4EIo2wr0MZad0V1w7D1bDafgvuRg9In3ONwMjPqTtKLPl4q7Z8hepty
	/YVSdeLB7BXHYN6KLmBfFx5RJ+NO6NTBw3Z6rGg6EHVYL8A7Ilm9e4uaRLLrpi2pPdNMA1T8HGh
	MZ33tMlqBcZNI1CaY/dSWlt2GPtjxVHlnUhS7uW6OSrqVxxQTkn4xrZEVIS/hKBrciLe2cuYvuj
	lNNFQRLVTqFRQ1frdKA9q0D3yfxcKflIDDQZy0SG7objzgOopTNdldolpqOs3pdbuWEpqEPDuXz
	pntl+emkGKkgrSzzHQdUbt+8A38l1zSOpdxCll7ctVys48cr8FiUk5ZwrnC0lA8VvF+h2Sn00fc
	ISffB/nmfnkwC96klz8X8GB5E/Az8mS0atD6+dR3b+u7pB4JxAo/wjz+1IF/+NQjcBSBRyRpbYP
	0teNdG4fQuMVjOLTGkaECL3S/kz8SZ+lrP3eLTx6LeRTqxYxdKO9Mc
X-Received: by 2002:a05:600c:c084:b0:485:3038:72c2 with SMTP id 5b1f17b1804b1-48541a70200mr103676755e9.17.1773227203591;
        Wed, 11 Mar 2026 04:06:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 07/13] PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and RZG3S_PCI_PINTRCVIS
Date: Wed, 11 Mar 2026 13:06:27 +0200
Message-ID: <20260311110633.1938579-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22333

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


