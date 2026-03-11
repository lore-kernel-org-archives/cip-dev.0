Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ACF105D290
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:29 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18278.1773227066843803852
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=AZeTCkbA;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so35353825e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227065; x=1773831865; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scps0WHGS6CjliGr39qcalJrYER4i9ocE1jMCdVDryE=;
        b=AZeTCkbAehoFGqff6zGfF4qbWzwCH6JJasAmfctG6R24s8KuovkmOid4xWoJYUPb5e
         erzc/IFoyWq7UWxQVrtXzmhd8qlcnCcHLP4tnTnQnLEVRfioNQf5ksDYpNHze7XYhD3O
         OzUj3qyeG2J1xWkg8lG9lvKc+zivXplPd7zAOXTlvwWfMTzajlCGBb9N+QAP7whypHcz
         B4YrEHWG8vtYqFFx1YrO3ZGoAJTSjYECfItT/XX/MrzVfr/iHaXHEWBD61mILLJ5YnVJ
         etNdnSTP/tD3z7PcQJ+6QvXaeAdUqlWpi57K2yPmsMx0Jv3wJOTBR42DlNhucBaNv+Zq
         ZRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227065; x=1773831865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scps0WHGS6CjliGr39qcalJrYER4i9ocE1jMCdVDryE=;
        b=Xatcm9KXucusRWpxFMMrRXhRDeliACxdxv0yZUU7v6xbDAODwtmoEhoCDYSvtHgTxm
         P3uRanb4vWn6Sq12LotAX1ppl/BZKK4Ycsk0yHcxV5Z5/WoqlHAdE9wy+3xaYlevRS4/
         ZQmyuOXdnUBeM4h6jiBB9awSz1x4HydsIpD3r0Vl/h8HHzrEYTFyqDjkeM/cfllI8RPL
         lnyXM6udOqOsZ9Zd35UYknrsFqFIxgrlo6R81pDVxNyJ28h97p9FTAc/ffHICkgkRNGX
         lrnxjbDv2DlNq579XXmkBHInG9Uv15+M3tSFpYCPi3MnXQth6Pyzy89KGMPCBaewFNG5
         981w==
X-Gm-Message-State: AOJu0Yz3N+Uw7McY2KOb1xlGeYfWkDBmfA73/BBdZ1cGfOS39/bZ/Xuv
	q/HlKEZEdH/P8jNsbNdVOGHuCZke39Dkp3b6sti2X0tpbMel8HC9HPSlFNP++ptXZ2PPCCrdRIH
	GBlQF
X-Gm-Gg: ATEYQzwvMo1dEJVFrN3TEuZ2bIUmgOQ5v8Q2IPxXQ7pElaZW0XMY0QYd8Typ2DWDHJx
	CKnUvcTJ9ZosonlZ1P1VUhCjX045Zbn5mK0Rr2nDH5C3j9uihm0Fo8Kp8x7d7TYA4D4x2rLis/V
	5Lo5ad3Xt9gIuai+sgr5xXqqEUHqxI+6eTuRnnzLWcP+6ujeFSQLIV8uAzM7GQchZblV8axOAt0
	vTqO0oJkaSrxgLRnDkQKCJwM/9sZCd5xgj+fCOVWZlu87TO/KxqSkWyel1TFWuRrsdxkJWEd0Lg
	ABD2CemQsyi8M1U5nmPe4Wx3vHrt+c1cfpqupo85Zl5+6XvZHuKNDjRIw2W1/5z8CmZlwAfCeXX
	+GgHytiTZqHBYhRmqTz0QXmhdUch/GfjHVLB+HnUjcaohz1A1tOyWD3mkofWw3syENpl3GMDb51
	S68C+yjw1DSlMcJYnkLzvTDbMrNvC6PfO3WmU5aKArzVP1b4vqhTJrxr/r5HIlIJ8=
X-Received: by 2002:a05:600c:1f87:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-4854b0a4a9dmr34128815e9.5.1773227065015;
        Wed, 11 Mar 2026 04:04:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 20/28] PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
Date: Wed, 11 Mar 2026 13:03:49 +0200
Message-ID: <20260311110357.1938200-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22299

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
index 794515e5a6f0..8291f4642c91 100644
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
 
@@ -1104,14 +1085,14 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
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


