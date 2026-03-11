Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB8C10611EA
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:40 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18701.1773227137176085117
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=akyyXXFo;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-485392de558so20260205e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227135; x=1773831935; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v8kE14GHCBPXbXT5SDNfHMx+AwI/D2GHR6ujGsYMfw=;
        b=akyyXXFoWPxV90fda08N0ECnhAzAHIgEriIMpgfA7S/B80D1G2O3Z2FIc5R/PO4zOc
         Z9eC1jdCuwO2OVkFK/Fs/TPHYkluap5QsYmEPboJ0MBVdVlQBmVoa3C7+gzhZKKXbC2p
         uyKNcPu8k9SKFQH/69eNUVw+2EmjaUk32ulpqgPK5YuALnl3WDbP7MglOqOe1CkCtwoV
         8ieWuM4NY72VnYZ9EkN5HhrPIShT2oy9kIqsSVGKnjkV6GO+LUpTXvyg6HBUbxEXwENp
         wtXTwRkT6JC3n2DktZD41ug1UhYW6mzV8lOZC0wgQN6U0l2xcszqx4MOyR14o7Sv9gLh
         nPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227135; x=1773831935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9v8kE14GHCBPXbXT5SDNfHMx+AwI/D2GHR6ujGsYMfw=;
        b=ct+00Q1coCLxOeLId7V8LtgvGa+csqS5tJVrJziudBdV0V7QVKF8h6rOYGhym0+UHX
         8bTCjzTHyr7CCbQ/HixeDuXCnYgm/xt/nvefb0IpQIHeaxuys5Rq3qbknQ6jzVk1J6ME
         PaqR+BhAB6eW8YMzgqo+gg9DHoVchmfqc0lqKQyao9ndpNHrtqH7SK+QJ2NEoLjU3Wh/
         VWKj6OpufKoZSm0padwfd1S84jb1gvu5wWhf4i1Uh0fjvNziWeI6c8ZRJ2XqnwN2mUlr
         e9RulPDfR2zZZSwzoxIvOcHc0zUAuCMDHn+foihlN3G29fMVjc2R0V7BEuZO3j/7KQp3
         8yyA==
X-Gm-Message-State: AOJu0Yy0ue7k/tFAklImyqaGJMLHj0eSW/rJLE3kba8kW78nr5t1kyAj
	DAHktnXhxCIn+jteGUpH2AtRhVGiZuLi94G31oJPl8hEM4n1iNF6O9vJGpAg/0UHHcQrbiTJaOa
	48ig9
X-Gm-Gg: ATEYQzwGTnoSNdvEW/5iCC8ce8xeT3LYKYH+/I0EGEU9fCKLIlyi7cKULM12bfo00RD
	IT+BKctAYMHSQ8p/XFomdo5UjPIHMB7k2NEw68tk/ebDmMQuoX50ECirz5SzB+pbPXU7WquBkLM
	FxQA7+yHyGPjvbuQsMF4AvOc4y6G0v6kVgZRMc73E+1Xu+nryZVUlZaoSQeDD1mZU3gleDqj7FD
	CCro30osyk9+srTxjQkX51hwqYS1FmVTWQjd2LY0SK06b1CJAsfiHizM31CwU9fluWOpHYlD8Jm
	DqBINdNbbDrSL4n2bJM5VCq9KTl7Xe3SfYxQVOiirsFpAuv+Arq3+W+1q2gHs8GFtKxfTw/q4Hg
	aMkKqCmE10ArPPb6yC2c+wmaM/NiUB3/1CInkUwFuBvX0vgOLkV62Ctp9o5PBrAgFu/YXwFaM/+
	CO/6l6PKyTGaMI/xFzvpV3U6OEBPmfo5/iI3ZRLmM0409/uVltqP3F
X-Received: by 2002:a05:600c:314e:b0:485:3423:727c with SMTP id 5b1f17b1804b1-4854b109d52mr37644825e9.18.1773227135467;
        Wed, 11 Mar 2026 04:05:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 10/17] PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
Date: Wed, 11 Mar 2026 13:05:13 +0200
Message-ID: <20260311110520.1938414-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22318

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


