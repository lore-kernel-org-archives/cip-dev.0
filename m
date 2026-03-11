Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C367F105D294
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:29 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18658.1773227068194165839
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jYPNT1Uj;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so52511335e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227067; x=1773831867; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp5jKumLZs73w/EkEmG1BZMzqq/mw3c7ShBYrXbkQIg=;
        b=jYPNT1UjKeaZV/h32bFLTPOQaYKYH8B+ENe9TcEg6ZARdSAT+KE8JVPynVPg1TRwxV
         HTVyQs3xF+joWtWUxbs6DyBa32DKHnlgIyVu3b8usEHaf85J+92ZKrui64/M8Sddejwp
         6evKrrzx5fHIkc/seo1+Nkf1F0uSf8bOi1TXHTiZEW6oq1ik0fBmaYT8oe7ZqVl2D93j
         53WjRrv1R+WrGsaKfh1LPLpsQ1BXWJq+xXI+oU9R5p0ZjIQlUQil4IXFRWlCc3XRMNcg
         16PtkfoSYYc7i4cnleXpe6uo6IsVWs2sZf2zrNcqjGVFM8pWlG0H5KLo2zigmIhzmxPW
         6b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227067; x=1773831867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dp5jKumLZs73w/EkEmG1BZMzqq/mw3c7ShBYrXbkQIg=;
        b=Nb4KiCvg/RQATJlDXujQzHU3f7DgyYurOGXCWgc8wqgbiOgjT44w9OBrEsmCQwgQLe
         xDN2IQQhS7Jk8egqAzqv6KrIfEDupCgTQuG/zVepW9zDaGCa9Wathrz18oPnpnR90bIc
         7EuruMT9JpDZUDGP8QLrjnaD854MfOGI3amtJAdFnG0CovMDv4dM1PxaFrx+iFa4QQlj
         1lzESsIBnMa6LcYatMAz3NIFn4glYFNq71JSGrBpEaQ8yohyTafWHMex5ns2bOTfEFVE
         4aeg4PaKumx39HgvPdxq2SyhyUH2AYvUhaPn9rAsJsXJvMiPwxkkJON+ymFEf6sC7B2m
         fodg==
X-Gm-Message-State: AOJu0Yx48a/+M+S7iY/+6gRiOYQTJ/+EtgHObS9mOU+se3tlVZXWCCbB
	QngSJOlPuinAy3cGrKltHpoOyQ/ndRC2b5qPP/ZdTFKuWwTNfo6mMFjlQZp9TupjQlseInQamxd
	EOjhr
X-Gm-Gg: ATEYQzyh0sdhchU975l/yDOJuOolCaDxfa7mNPS6sEnCCX26mivHssmkmeBhLkYWFD9
	ytkq1MzGZmOSdiiBPHGuJJzGubHQUidGaO1hRk6fjhCo7mSzJG7wtXugwhzfl6YYUn80XjNDO7H
	XQcsurwwH0YkteIvCjNQo9CPfTyG9IGGbE2+yAP10q7uqcZm4wa7AQjH6/Y9DHb/9Jf4DMyxj4R
	j5RyiL+uMTQX8dgHZOaufJx0OEp063BjNMnLSwuaPuzM9MnjMdxUH0Ze2EYRJYzdA6FSF3PS01H
	NWxHjXOnpAhBkj75JNh9Zd9qkQDtuKmEuXUv+/eiNbeiRImSfljbKvEfpRMOKiRmhnY/l0ZSsP7
	CCHTkWMxf7fbtGyRYDkhneEG6BJq+mS2Ax/4VfCCzvXsbxUQQauy5HCxJlKyCyJ3B1SsCjpsxoQ
	bPlhtz82bezNmV9UGm4JMB+jC5xL/VHVOm83etI5QcTLUjD4HFPeu0dCvMb7vi1FI=
X-Received: by 2002:a05:600c:6092:b0:485:43a4:6f5 with SMTP id 5b1f17b1804b1-4854b0f6b07mr35323445e9.14.1773227066413;
        Wed, 11 Mar 2026 04:04:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 21/28] PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and RZG3S_PCI_PINTRCVIS
Date: Wed, 11 Mar 2026 13:03:50 +0200
Message-ID: <20260311110357.1938200-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22300

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
index 8291f4642c91..80d4a4623ccc 100644
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
@@ -536,8 +539,6 @@ static void rzg3s_pcie_msi_irq_ack(struct irq_data *d)
 	u8 reg_bit = d->hwirq % RZG3S_PCI_MSI_INT_PER_REG;
 	u8 reg_id = d->hwirq / RZG3S_PCI_MSI_INT_PER_REG;
 
-	guard(raw_spinlock_irqsave)(&host->hw_lock);
-
 	writel_relaxed(BIT(reg_bit), host->axi + RZG3S_PCI_MSIRS(reg_id));
 }
 
@@ -878,8 +879,6 @@ static void rzg3s_pcie_intx_irq_ack(struct irq_data *d)
 {
 	struct rzg3s_pcie_host *host = irq_data_get_irq_chip_data(d);
 
-	guard(raw_spinlock_irqsave)(&host->hw_lock);
-
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
 			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq),
 			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq));
-- 
2.43.0


