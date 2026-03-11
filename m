Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8A01062864
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:52 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18741.1773227204158180536
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RphT3Z1v;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48538c5956bso8997275e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227202; x=1773832002; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v8kE14GHCBPXbXT5SDNfHMx+AwI/D2GHR6ujGsYMfw=;
        b=RphT3Z1vVBJsvqouDJaspFdvevwsqPTsIZ0+sa1RXnml6f0iAOGzp/RO45gKriGSMx
         L1nPTUFFG8No1Z/ETbS1xqtDQKsyQUm3JkjA+aAJxpguIyKZiwt0eY1DvtWsA/1qgI+j
         hqiE+LWiZAfpGCG0qpA+x+Rx+TznzPsSmNwSKdoZGHjVo5Fjepvg2Ahgg0UjrEO8ATBF
         ZU2ybP/UOgXTEh67BKLXfGxtT6W857TC51eSUr1KvFXtmHcSUYp9vRCyTbrhiGxYKMph
         X3aM+DBDarq6Ya+KTdKs6UPjzY6m0lRYTuQGDoJJi9Rq/2+FD2A0ugi9xoeGfEN9QC+l
         X0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227202; x=1773832002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9v8kE14GHCBPXbXT5SDNfHMx+AwI/D2GHR6ujGsYMfw=;
        b=OzRyy9uSNs9Y9UXP5f8tXBPqvwkJ89aCRN6Wwnb1E/6of6kR2gEFH1j45h4o5KfQ3Q
         OwUFC+cKs///EY5ujTUKd6MsTFzjQky9N+YBwgMdXLjKcCti4DdjABs7MUAsdRdY9prv
         axfJ8uQOece+SXfkaoHZqrcGcclGRc2+9vxR+pFLR79ndi05cqr8dwLNELHlIbKrvXvI
         OvLVamDs7p5KRDW01rWO/xHLm8r0ei7Vnn80p+Twv3yNic68H7FTzlAOyB1cfRDI2SIF
         lZHMQE0tNbdxfn1H89k6sd+fTImFaOtYr5pt4waNcbIu/FCUF1kfIfKCJP3S+SRkBHkK
         k68g==
X-Gm-Message-State: AOJu0Yz7dssjX5tzRw/MsZP/vnK49svxkCmX4khM9Za5sxkQvWJ4ydVa
	2vVe6gmY+Z/2W6PLSxDow2k3PKyuCDTjIVC2IXmQqrr7iQZpB4aW14fi1DzbeaRWniY=
X-Gm-Gg: ATEYQzzffkNnRCFmLmMz6CMy/n3mKpe2msmNAqrsIkMcIMmFYknF7nG1AOZ4YXdSNLW
	zO3KZCVccb0GqIgLO2mjEnZsA8iKW5wATeTYKLCu8Ai6mbxXjBcOV1TsW4RmM1nkn8YeO1Gqn97
	t0PX1OgEafPkBvGCnNdkBUQHLcqw9FYopIRpKJmLDbwWWgyi4nKMAekGp52ri5r4vGosAwJESZL
	hTU7mi3jweH9p0uoV4y3A+PXDTLoMlAhz7RSq3XuKVptZu8ViHs4HZ5WvasXfSOS1BdKKqk2Zk+
	lrdBC18faOtJfmfJC8hYy9J5U7/NfZWl5nKvtW+ENb9i+V7BpiUcU5N0j0s9PEgXpd9tQOLeVu+
	HeYZmiX/ZDtSHRNdcn26+zuxtz7SPY3fJdKESrIpuPRL/vF+77me7C8y24SjzQL6/EyYSJF4/8U
	aqHZjUu8IuXFbM1gyY0Cb/PHXWX+IgsLrzrthMI9nPIk60WtlGmblXuIx+OoXRLss=
X-Received: by 2002:a05:600c:c178:b0:485:343b:38d with SMTP id 5b1f17b1804b1-485419dabdcmr120993735e9.5.1773227202441;
        Wed, 11 Mar 2026 04:06:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 06/13] PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
Date: Wed, 11 Mar 2026 13:06:26 +0200
Message-ID: <20260311110633.1938579-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22332

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 4b86eff47e205819eb862097493ec20e25ac8f56 upstream.

The Renesas RZ/G3S host controller allows writing to read-only PCIe
configuration registers when the RZG3S_PCI_PERM_CFG_HWINIT_EN bit is set in
the RZG3S_PCI_PERM register. However, callers of struct pci_ops::write
expect the semantics defined by the PCIe specification, meaning that writes
to read-only registers must not be allowed.

The previous custom struct pci_ops::write implementation for the root bus
temporarily enabled write access before calling pci_generic_config_write().
This breaks the expected semantics.

Remove the custom implementation and simply use pci_generic_config_write().

Along with this change, the updates of the PCI_PRIMARY_BUS,
PCI_SECONDARY_BUS, and PCI_SUBORDINATE_BUS registers were moved so that
they no longer depends on the RZG3S_PCI_PERM_CFG_HWINIT_EN bit in the
RZG3S_PCI_PERM_CFG register, since these registers are R/W.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20251217111510.138848-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 27 ++++--------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 81f8ddcdef79..59506f17562a 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -438,28 +438,9 @@ static void __iomem *rzg3s_pcie_root_map_bus(struct pci_bus *bus,
 	return host->pcie + where;
 }
 
-/* Serialized by 'pci_lock' */
-static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
-				 int where, int size, u32 val)
-{
-	struct rzg3s_pcie_host *host = bus->sysdata;
-	int ret;
-
-	/* Enable access control to the CFGU */
-	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
-		       host->axi + RZG3S_PCI_PERM);
-
-	ret = pci_generic_config_write(bus, devfn, where, size, val);
-
-	/* Disable access control to the CFGU */
-	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
-
-	return ret;
-}
-
 static struct pci_ops rzg3s_pcie_root_ops = {
 	.read		= pci_generic_config_read,
-	.write		= rzg3s_pcie_root_write,
+	.write		= pci_generic_config_write,
 	.map_bus	= rzg3s_pcie_root_map_bus,
 };
 
@@ -1087,14 +1068,14 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
 
+	/* Disable access control to the CFGU */
+	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
+
 	/* Update bus info */
 	writeb_relaxed(primary_bus, host->pcie + PCI_PRIMARY_BUS);
 	writeb_relaxed(secondary_bus, host->pcie + PCI_SECONDARY_BUS);
 	writeb_relaxed(subordinate_bus, host->pcie + PCI_SUBORDINATE_BUS);
 
-	/* Disable access control to the CFGU */
-	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
-
 	return 0;
 }
 
-- 
2.43.0


