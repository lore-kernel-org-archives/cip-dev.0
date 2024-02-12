Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDC9C48297
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 12:19:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.5104.1707740358989339571
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Feb 2024 04:19:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.06,263,1705330800"; 
   d="scan'208";a="193658430"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Feb 2024 21:19:17 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.152])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 606C741B7FFB;
	Mon, 12 Feb 2024 21:19:15 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev
Subject: [PATCH 5.10.y-cip] cache: Kconfig: Add dependency for RISCV on AX45MP_L2_CACHE config
Date: Mon, 12 Feb 2024 12:19:14 +0000
Message-Id: <20240212121914.38493-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Feb 2024 12:19:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14921

csr_write() is available only for RISC-V which caused build issues with
randconfig for ax45mp_cache.c. To avoid this issue add a RISCV dependency
on AX45MP_L2_CACHE config.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402101256.mOmaXuSb-lkp@intel.com/
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/cache/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 400cb09f6bd4..aacc36685945 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -3,6 +3,7 @@ menu "Cache Drivers"
 
 config AX45MP_L2_CACHE
 	bool "Andes Technology AX45MP L2 Cache controller"
+	depends on RISCV
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SETUP_DMA_OPS
-- 
2.25.1


