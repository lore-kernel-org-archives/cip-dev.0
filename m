Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAC7C48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:28:46 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.20171.1707222496328553437
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:28:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="193048795"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Feb 2024 21:28:38 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 53A3840029DB;
	Tue,  6 Feb 2024 21:28:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 30/44] cache: Add L2 cache management for Andes AX45MP RISC-V core
Date: Tue,  6 Feb 2024 12:27:20 +0000
Message-Id: <20240206122734.13477-31-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:28:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14814

commit d34599bcd2e4e93a28d5904bf94bc7dafc511f04 upstream.

I/O Coherence Port (IOCP) provides an AXI interface for connecting
external non-caching masters, such as DMA controllers. The accesses
from IOCP are coherent with D-Caches and L2 Cache.

IOCP is a specification option and is disabled on the Renesas RZ/Five
SoC due to this reason IP blocks using DMA will fail.

The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
block that allows dynamic adjustment of memory attributes in the runtime.
It contains a configurable amount of PMA entries implemented as CSR
registers to control the attributes of memory locations in interest.
Below are the memory attributes supported:
* Device, Non-bufferable
* Device, bufferable
* Memory, Non-cacheable, Non-bufferable
* Memory, Non-cacheable, Bufferable
* Memory, Write-back, No-allocate
* Memory, Write-back, Read-allocate
* Memory, Write-back, Write-allocate
* Memory, Write-back, Read and Write-allocate

More info about PMA (section 10.3):
Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf

As a workaround for SoCs with IOCP disabled CMO needs to be handled by
software. Firstly OpenSBI configures the memory region as
"Memory, Non-cacheable, Bufferable" and passes this region as a global
shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
allocations happen from this region and synchronization callbacks are
implemented to synchronize when doing DMA transactions.

Example PMA region passes as a DT node from OpenSBI:
    reserved-memory {
        #address-cells = <2>;
        #size-cells = <2>;
        ranges;

        pma_resv0@58000000 {
            compatible = "shared-dma-pool";
            reg = <0x0 0x58000000 0x0 0x08000000>;
            no-map;
            linux,dma-default;
        };
    };

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
Link: https://lore.kernel.org/r/20230818135723.80612-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
[PL: Dropped calling riscv_noncoherent_register_cache_ops() and also ax45mp_cmo_ops struct]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 MAINTAINERS                  |   7 ++
 drivers/Kconfig              |   2 +
 drivers/Makefile             |   1 +
 drivers/cache/Kconfig        |   9 ++
 drivers/cache/Makefile       |   3 +
 drivers/cache/ax45mp_cache.c | 185 +++++++++++++++++++++++++++++++++++
 6 files changed, 207 insertions(+)
 create mode 100644 drivers/cache/Kconfig
 create mode 100644 drivers/cache/Makefile
 create mode 100644 drivers/cache/ax45mp_cache.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f1f76eaf48d1..8f2e94c0ec199 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16672,6 +16672,13 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 F:	drivers/staging/
 
+STANDALONE CACHE CONTROLLER DRIVERS
+M:	Conor Dooley <conor@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
+F:	drivers/cache
+
 STARFIRE/DURALAN NETWORK DRIVER
 M:	Ion Badulescu <ionut@badula.org>
 S:	Odd Fixes
diff --git a/drivers/Kconfig b/drivers/Kconfig
index dcecc9f6e33f7..5c521370a5955 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -14,6 +14,8 @@ source "drivers/base/Kconfig"
 
 source "drivers/bus/Kconfig"
 
+source "drivers/cache/Kconfig"
+
 source "drivers/connector/Kconfig"
 
 source "drivers/gnss/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 5762280377186..1428e4d0755e4 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -6,6 +6,7 @@
 # Rewritten to use lists instead of if-statements.
 #
 
+obj-y				+= cache/
 obj-y				+= irqchip/
 obj-y				+= bus/
 
diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
new file mode 100644
index 0000000000000..3370a5f0e77f0
--- /dev/null
+++ b/drivers/cache/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+menu "Cache Drivers"
+
+config AX45MP_L2_CACHE
+	bool "Andes Technology AX45MP L2 Cache controller"
+	help
+	  Support for the L2 cache controller on Andes Technology AX45MP platforms.
+
+endmenu
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
new file mode 100644
index 0000000000000..2012e7fb978dc
--- /dev/null
+++ b/drivers/cache/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_AX45MP_L2_CACHE) += ax45mp_cache.o
diff --git a/drivers/cache/ax45mp_cache.c b/drivers/cache/ax45mp_cache.c
new file mode 100644
index 0000000000000..7984b90d04f28
--- /dev/null
+++ b/drivers/cache/ax45mp_cache.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * non-coherent cache functions for Andes AX45MP
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <linux/dma-direction.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+/* L2 cache registers */
+#define AX45MP_L2C_REG_CTL_OFFSET		0x8
+
+#define AX45MP_L2C_REG_C0_CMD_OFFSET		0x40
+#define AX45MP_L2C_REG_C0_ACC_OFFSET		0x48
+#define AX45MP_L2C_REG_STATUS_OFFSET		0x80
+
+/* D-cache operation */
+#define AX45MP_CCTL_L1D_VA_INVAL		0 /* Invalidate an L1 cache entry */
+#define AX45MP_CCTL_L1D_VA_WB			1 /* Write-back an L1 cache entry */
+
+/* L2 CCTL status */
+#define AX45MP_CCTL_L2_STATUS_IDLE		0
+
+/* L2 CCTL status cores mask */
+#define AX45MP_CCTL_L2_STATUS_C0_MASK		0xf
+
+/* L2 cache operation */
+#define AX45MP_CCTL_L2_PA_INVAL			0x8 /* Invalidate an L2 cache entry */
+#define AX45MP_CCTL_L2_PA_WB			0x9 /* Write-back an L2 cache entry */
+
+#define AX45MP_L2C_REG_PER_CORE_OFFSET		0x10
+#define AX45MP_CCTL_L2_STATUS_PER_CORE_OFFSET	4
+
+#define AX45MP_L2C_REG_CN_CMD_OFFSET(n)	\
+	(AX45MP_L2C_REG_C0_CMD_OFFSET + ((n) * AX45MP_L2C_REG_PER_CORE_OFFSET))
+#define AX45MP_L2C_REG_CN_ACC_OFFSET(n)	\
+	(AX45MP_L2C_REG_C0_ACC_OFFSET + ((n) * AX45MP_L2C_REG_PER_CORE_OFFSET))
+#define AX45MP_CCTL_L2_STATUS_CN_MASK(n)	\
+	(AX45MP_CCTL_L2_STATUS_C0_MASK << ((n) * AX45MP_CCTL_L2_STATUS_PER_CORE_OFFSET))
+
+#define AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM	0x80b
+#define AX45MP_CCTL_REG_UCCTLCOMMAND_NUM	0x80c
+
+#define AX45MP_CACHE_LINE_SIZE			64
+
+struct ax45mp_priv {
+	void __iomem *l2c_base;
+	u32 ax45mp_cache_line_size;
+};
+
+static struct ax45mp_priv ax45mp_priv;
+
+/* L2 Cache operations */
+static inline uint32_t ax45mp_cpu_l2c_get_cctl_status(void)
+{
+	return readl(ax45mp_priv.l2c_base + AX45MP_L2C_REG_STATUS_OFFSET);
+}
+
+static void ax45mp_cpu_cache_operation(unsigned long start, unsigned long end,
+				       unsigned int l1_op, unsigned int l2_op)
+{
+	unsigned long line_size = ax45mp_priv.ax45mp_cache_line_size;
+	void __iomem *base = ax45mp_priv.l2c_base;
+	int mhartid = smp_processor_id();
+	unsigned long pa;
+
+	while (end > start) {
+		csr_write(AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM, start);
+		csr_write(AX45MP_CCTL_REG_UCCTLCOMMAND_NUM, l1_op);
+
+		pa = virt_to_phys((void *)start);
+		writel(pa, base + AX45MP_L2C_REG_CN_ACC_OFFSET(mhartid));
+		writel(l2_op, base + AX45MP_L2C_REG_CN_CMD_OFFSET(mhartid));
+		while ((ax45mp_cpu_l2c_get_cctl_status() &
+			AX45MP_CCTL_L2_STATUS_CN_MASK(mhartid)) !=
+			AX45MP_CCTL_L2_STATUS_IDLE)
+			;
+
+		start += line_size;
+	}
+}
+
+/* Write-back L1 and L2 cache entry */
+static inline void ax45mp_cpu_dcache_wb_range(unsigned long start, unsigned long end)
+{
+	ax45mp_cpu_cache_operation(start, end, AX45MP_CCTL_L1D_VA_WB,
+				   AX45MP_CCTL_L2_PA_WB);
+}
+
+/* Invalidate the L1 and L2 cache entry */
+static inline void ax45mp_cpu_dcache_inval_range(unsigned long start, unsigned long end)
+{
+	ax45mp_cpu_cache_operation(start, end, AX45MP_CCTL_L1D_VA_INVAL,
+				   AX45MP_CCTL_L2_PA_INVAL);
+}
+
+static void ax45mp_dma_cache_inv(phys_addr_t paddr, size_t size)
+{
+	unsigned long start = (unsigned long)phys_to_virt(paddr);
+	unsigned long end = start + size;
+	unsigned long line_size;
+	unsigned long flags;
+
+	if (unlikely(start == end))
+		return;
+
+	line_size = ax45mp_priv.ax45mp_cache_line_size;
+
+	start = start & (~(line_size - 1));
+	end = ((end + line_size - 1) & (~(line_size - 1)));
+
+	local_irq_save(flags);
+
+	ax45mp_cpu_dcache_inval_range(start, end);
+
+	local_irq_restore(flags);
+}
+
+static void ax45mp_dma_cache_wback(phys_addr_t paddr, size_t size)
+{
+	unsigned long start = (unsigned long)phys_to_virt(paddr);
+	unsigned long end = start + size;
+	unsigned long line_size;
+	unsigned long flags;
+
+	line_size = ax45mp_priv.ax45mp_cache_line_size;
+	start = start & (~(line_size - 1));
+	local_irq_save(flags);
+	ax45mp_cpu_dcache_wb_range(start, end);
+	local_irq_restore(flags);
+}
+
+static int ax45mp_get_l2_line_size(struct device_node *np)
+{
+	int ret;
+
+	ret = of_property_read_u32(np, "cache-line-size", &ax45mp_priv.ax45mp_cache_line_size);
+	if (ret) {
+		pr_err("Failed to get cache-line-size, defaulting to 64 bytes\n");
+		return ret;
+	}
+
+	if (ax45mp_priv.ax45mp_cache_line_size != AX45MP_CACHE_LINE_SIZE) {
+		pr_err("Expected cache-line-size to be 64 bytes (found:%u)\n",
+		       ax45mp_priv.ax45mp_cache_line_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ax45mp_cache_ids[] = {
+	{ .compatible = "andestech,ax45mp-cache" },
+	{ /* sentinel */ }
+};
+
+static int __init ax45mp_cache_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	int ret;
+
+	np = of_find_matching_node(NULL, ax45mp_cache_ids);
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return ret;
+
+	ax45mp_priv.l2c_base = ioremap(res.start, resource_size(&res));
+	if (!ax45mp_priv.l2c_base)
+		return -ENOMEM;
+
+	ret = ax45mp_get_l2_line_size(np);
+	if (ret) {
+		iounmap(ax45mp_priv.l2c_base);
+		return ret;
+	}
+
+	return 0;
+}
+early_initcall(ax45mp_cache_init);
-- 
2.34.1


