Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DBDC32772
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 18:37:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1591.1661279854585268560
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Aug 2022 11:37:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,258,1654527600";
   d="scan'208";a="130344634"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Aug 2022 03:37:32 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5E8E840A6B77;
	Wed, 24 Aug 2022 03:37:31 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip] PCI: Drop PCIE_RCAR config option
Date: Tue, 23 Aug 2022 19:37:29 +0100
Message-Id: <20220823183729.29203-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 18:37:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9313

commit ff591f7490cffef49c022e802b64499edb6137b6 upstream.

All the defconfig files have replaced PCIE_RCAR config option with
PCIE_RCAR_HOST config option which built the same driver, so we can
now safely drop PCIE_RCAR config option.

Link: https://lore.kernel.org/r/20201229170848.18482-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note:
- All the defconfig files have been updated to use PCIE_RCAR_HOST
- MR has been issued for cip-kernel-config [0]
[0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/70
---
 drivers/pci/controller/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 64e2f5e379aa..0d98d8dd448b 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -55,15 +55,6 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
-config PCIE_RCAR
-	bool "Renesas R-Car PCIe controller"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_RCAR_HOST
-	help
-	  Say Y here if you want PCIe controller support on R-Car SoCs.
-	  This option will be removed after arm64 defconfig is updated.
-
 config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
-- 
2.17.1


