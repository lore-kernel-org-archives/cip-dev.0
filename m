Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73602C46CD8
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 23:07:24 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.35075.1703113642283345487
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Dec 2023 15:07:22 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,292,1695654000"; 
   d="scan'208";a="191072719"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Dec 2023 08:07:21 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.50])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0BFB440BF9EC;
	Thu, 21 Dec 2023 08:07:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 14/30] riscv: errata: Add Andes alternative ports
Date: Wed, 20 Dec 2023 23:06:30 +0000
Message-Id: <20231220230646.219816-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Dec 2023 23:07:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14150

commit e021ae7f5145d46ab64cb058cbffda31059f37e5 upstream.

Add required ports of the Alternative scheme for Andes CPU cores.

I/O Coherence Port (IOCP) provides an AXI interface for connecting external
non-caching masters, such as DMA controllers. IOCP is a specification
option and is disabled on the Renesas RZ/Five SoC due to this reason cache
management needs a software workaround.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
Link: https://lore.kernel.org/r/20230818135723.80612-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
[PL: manually applied changes to Makefile and Kconfig.erratas]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/Kconfig.erratas           | 21 +++++++++
 arch/riscv/errata/Makefile           |  1 +
 arch/riscv/errata/andes/Makefile     |  1 +
 arch/riscv/errata/andes/errata.c     | 66 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/alternative.h |  3 ++
 arch/riscv/include/asm/errata_list.h |  5 +++
 arch/riscv/kernel/alternative.c      |  5 +++
 7 files changed, 102 insertions(+)
 create mode 100644 arch/riscv/errata/andes/Makefile
 create mode 100644 arch/riscv/errata/andes/errata.c

diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
index f3623df23b5f..c2ddfc2b187c 100644
--- a/arch/riscv/Kconfig.erratas
+++ b/arch/riscv/Kconfig.erratas
@@ -1,5 +1,26 @@
 menu "CPU errata selection"
 
+config ERRATA_ANDES
+	bool "Andes AX45MP errata"
+	depends on RISCV_ALTERNATIVE
+	help
+	  All Andes errata Kconfig depend on this Kconfig. Disabling
+	  this Kconfig will disable all Andes errata. Please say "Y"
+	  here if your platform uses Andes CPU cores.
+
+	  Otherwise, please say "N" here to avoid unnecessary overhead.
+
+config ERRATA_ANDES_CMO
+	bool "Apply Andes cache management errata"
+	depends on ERRATA_ANDES && MMU && ARCH_R9A07G043
+	select RISCV_DMA_NONCOHERENT
+	default y
+	help
+	  This will apply the cache management errata to handle the
+	  non-standard handling on non-coherent operations on Andes cores.
+
+	  If you don't know what to do here, say "Y".
+
 config ERRATA_SIFIVE
 	bool "SiFive errata"
 	depends on !XIP_KERNEL
diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
index a1055965fbee..6f1c693af92d 100644
--- a/arch/riscv/errata/Makefile
+++ b/arch/riscv/errata/Makefile
@@ -1,2 +1,3 @@
+obj-$(CONFIG_ERRATA_ANDES) += andes/
 obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
 obj-$(CONFIG_ERRATA_THEAD) += thead/
diff --git a/arch/riscv/errata/andes/Makefile b/arch/riscv/errata/andes/Makefile
new file mode 100644
index 000000000000..2d644e19caef
--- /dev/null
+++ b/arch/riscv/errata/andes/Makefile
@@ -0,0 +1 @@
+obj-y += errata.o
diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
new file mode 100644
index 000000000000..197db68cc8da
--- /dev/null
+++ b/arch/riscv/errata/andes/errata.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Erratas to be applied for Andes CPU cores
+ *
+ *  Copyright (C) 2023 Renesas Electronics Corporation.
+ *
+ * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+ */
+
+#include <linux/memory.h>
+#include <linux/module.h>
+
+#include <asm/alternative.h>
+#include <asm/cacheflush.h>
+#include <asm/errata_list.h>
+#include <asm/patch.h>
+#include <asm/processor.h>
+#include <asm/sbi.h>
+#include <asm/vendorid_list.h>
+
+#define ANDESTECH_AX45MP_MARCHID	0x8000000000008a45UL
+#define ANDESTECH_AX45MP_MIMPID		0x500UL
+#define ANDESTECH_SBI_EXT_ANDES		0x0900031E
+
+#define ANDES_SBI_EXT_IOCP_SW_WORKAROUND	1
+
+static long ax45mp_iocp_sw_workaround(void)
+{
+	struct sbiret ret;
+
+	/*
+	 * ANDES_SBI_EXT_IOCP_SW_WORKAROUND SBI EXT checks if the IOCP is missing and
+	 * cache is controllable only then CMO will be applied to the platform.
+	 */
+	ret = sbi_ecall(ANDESTECH_SBI_EXT_ANDES, ANDES_SBI_EXT_IOCP_SW_WORKAROUND,
+			0, 0, 0, 0, 0, 0);
+
+	return ret.error ? 0 : ret.value;
+}
+
+static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
+{
+	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
+		return false;
+
+	if (arch_id != ANDESTECH_AX45MP_MARCHID || impid != ANDESTECH_AX45MP_MIMPID)
+		return false;
+
+	if (!ax45mp_iocp_sw_workaround())
+		return false;
+
+	/* Set this just to make core cbo code happy */
+	riscv_cbom_block_size = 1;
+	riscv_noncoherent_supported();
+
+	return true;
+}
+
+void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
+					      unsigned long archid, unsigned long impid,
+					      unsigned int stage)
+{
+	errata_probe_iocp(stage, archid, impid);
+
+	/* we have nothing to patch here ATM so just return back */
+}
diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index 6511dd73e812..f51cd367fe2c 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -40,6 +40,9 @@ struct errata_checkfunc_id {
 	bool (*func)(struct alt_entry *alt);
 };
 
+void andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
+			     unsigned long archid, unsigned long impid,
+			     unsigned int stage);
 void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 			      unsigned long archid, unsigned long impid,
 			      unsigned int stage);
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 7d2675bb7161..d19cf1c7fb69 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -8,6 +8,11 @@
 #include <asm/alternative.h>
 #include <asm/vendorid_list.h>
 
+#ifdef CONFIG_ERRATA_ANDES
+#define ERRATA_ANDESTECH_NO_IOCP	0
+#define ERRATA_ANDESTECH_NUMBER		1
+#endif
+
 #ifdef CONFIG_ERRATA_SIFIVE
 #define	ERRATA_SIFIVE_CIP_453 0
 #define	ERRATA_SIFIVE_CIP_1200 1
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index a7d26a00beea..04e23b4cbd43 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -38,6 +38,11 @@ static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_inf
 #endif
 
 	switch (cpu_mfr_info->vendor_id) {
+#ifdef CONFIG_ERRATA_ANDES
+	case ANDESTECH_VENDOR_ID:
+		cpu_mfr_info->patch_func = andes_errata_patch_func;
+		break;
+#endif
 #ifdef CONFIG_ERRATA_SIFIVE
 	case SIFIVE_VENDOR_ID:
 		cpu_mfr_info->patch_func = sifive_errata_patch_func;
-- 
2.34.1


