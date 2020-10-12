Return-Path: <SRS0=9tRW=DT=lists.cip-project.org=bounce+64572+5558+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B97DC433DF
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:15 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D554B2087E
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="icj5KdYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D554B2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5558+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vb2TYY4521723x0peupIlvSH; Mon, 12 Oct 2020 07:21:14 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.42187.1602512428927900524
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:33 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351965"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:32 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B35F441D31C7;
	Mon, 12 Oct 2020 23:20:31 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 38/50] PCI: rcar: Move shareable code to a common file
Date: Mon, 12 Oct 2020 15:19:21 +0100
Message-Id: <20201012141933.9652-39-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DDhm6TiVUmNNTOYdepgvDOMAx4520388AA=
Content-Type: multipart/mixed; boundary="sOubbOhgecSHCdFM89kX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512474;
 bh=o90WXwl+b4hu5BVXdkz/Eagd6vgYBFEh6G7b5QKLMtw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=icj5KdYymhTeIyYCk1Umd5c/T4xgjU89+mIxjsIvgq0pPNiP46LrVo+nHwbCL771xWr
 VS4ftwhEqQp/dFHBzxQZFtn1x7uxQO6J3BfGlos2gk8Np86ZoOGt7j6wbJxuq0aekzqW/
 hfsgONGu4w9oxxH6F2RCHWAST6OETZEF7UI=

--sOubbOhgecSHCdFM89kX

commit 78a0d7f2f5a31357bce68012d886507b4cf33598 upstream.

Move shareable code to common file pcie-rcar.c and the #defines to
pcie-rcar.h so that the common code can be reused with endpoint driver.
There are no functional changes with this patch for the host controller
driver.

Link: https://lore.kernel.org/r/1588854799-13710-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[PL: Dropped changes to pcie-rcar-host.c as it doesnt apply cleanly and
manually applying the changes would result in huge change]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rcar.c | 117 ++++++++++++++++++++++++++
 drivers/pci/controller/pcie-rcar.h | 131 +++++++++++++++++++++++++++++
 2 files changed, 248 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-rcar.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
new file mode 100644
index 000000000000..cf8840d180c3
--- /dev/null
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe driver for Renesas R-Car SoCs
+ *  Copyright (C) 2014-2020 Renesas Electronics Europe Ltd
+ *
+ * Author: Phil Edworthy <phil.edworthy@renesas.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/pci.h>
+
+#include "pcie-rcar.h"
+
+void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, unsigned int reg)
+{
+	writel(val, pcie->base + reg);
+}
+
+u32 rcar_pci_read_reg(struct rcar_pcie *pcie, unsigned int reg)
+{
+	return readl(pcie->base + reg);
+}
+
+void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
+{
+	unsigned int shift = BITS_PER_BYTE * (where & 3);
+	u32 val = rcar_pci_read_reg(pcie, where & ~3);
+
+	val &= ~(mask << shift);
+	val |= data << shift;
+	rcar_pci_write_reg(pcie, val, where & ~3);
+}
+
+int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie)
+{
+	unsigned int timeout = 10;
+
+	while (timeout--) {
+		if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
+			return 0;
+
+		msleep(5);
+	}
+
+	return -ETIMEDOUT;
+}
+
+int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
+{
+	unsigned int timeout = 10000;
+
+	while (timeout--) {
+		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
+			return 0;
+
+		udelay(5);
+		cpu_relax();
+	}
+
+	return -ETIMEDOUT;
+}
+
+void rcar_pcie_set_outbound(struct rcar_pcie *pcie, int win,
+			    struct resource_entry *window)
+{
+	/* Setup PCIe address space mappings for each resource */
+	struct resource *res = window->res;
+	resource_size_t res_start;
+	resource_size_t size;
+	u32 mask;
+
+	rcar_pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
+
+	/*
+	 * The PAMR mask is calculated in units of 128Bytes, which
+	 * keeps things pretty simple.
+	 */
+	size = resource_size(res);
+	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
+	rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
+
+	if (res->flags & IORESOURCE_IO)
+		res_start = pci_pio_to_address(res->start) - window->offset;
+	else
+		res_start = res->start - window->offset;
+
+	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
+	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
+			   PCIEPALR(win));
+
+	/* First resource is for IO */
+	mask = PAR_ENABLE;
+	if (res->flags & IORESOURCE_IO)
+		mask |= IO_SPACE;
+
+	rcar_pci_write_reg(pcie, mask, PCIEPTCTLR(win));
+}
+
+void rcar_pcie_set_inbound(struct rcar_pcie *pcie, u64 cpu_addr,
+			   u64 pci_addr, u64 flags, int idx, bool host)
+{
+	/*
+	 * Set up 64-bit inbound regions as the range parser doesn't
+	 * distinguish between 32 and 64-bit types.
+	 */
+	if (host)
+		rcar_pci_write_reg(pcie, lower_32_bits(pci_addr),
+				   PCIEPRAR(idx));
+	rcar_pci_write_reg(pcie, lower_32_bits(cpu_addr), PCIELAR(idx));
+	rcar_pci_write_reg(pcie, flags, PCIELAMR(idx));
+
+	if (host)
+		rcar_pci_write_reg(pcie, upper_32_bits(pci_addr),
+				   PCIEPRAR(idx + 1));
+	rcar_pci_write_reg(pcie, upper_32_bits(cpu_addr), PCIELAR(idx + 1));
+	rcar_pci_write_reg(pcie, 0, PCIELAMR(idx + 1));
+}
diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/pcie-rcar.h
new file mode 100644
index 000000000000..97640e16af58
--- /dev/null
+++ b/drivers/pci/controller/pcie-rcar.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCIe driver for Renesas R-Car SoCs
+ *  Copyright (C) 2014-2020 Renesas Electronics Europe Ltd
+ *
+ * Author: Phil Edworthy <phil.edworthy@renesas.com>
+ */
+
+#ifndef _PCIE_RCAR_H
+#define _PCIE_RCAR_H
+
+#define PCIECAR			0x000010
+#define PCIECCTLR		0x000018
+#define  CONFIG_SEND_ENABLE	BIT(31)
+#define  TYPE0			(0 << 8)
+#define  TYPE1			BIT(8)
+#define PCIECDR			0x000020
+#define PCIEMSR			0x000028
+#define PCIEINTXR		0x000400
+#define PCIEPHYSR		0x0007f0
+#define  PHYRDY			BIT(0)
+#define PCIEMSITXR		0x000840
+
+/* Transfer control */
+#define PCIETCTLR		0x02000
+#define  DL_DOWN		BIT(3)
+#define  CFINIT			BIT(0)
+#define PCIETSTR		0x02004
+#define  DATA_LINK_ACTIVE	BIT(0)
+#define PCIEERRFR		0x02020
+#define  UNSUPPORTED_REQUEST	BIT(4)
+#define PCIEMSIFR		0x02044
+#define PCIEMSIALR		0x02048
+#define  MSIFE			BIT(0)
+#define PCIEMSIAUR		0x0204c
+#define PCIEMSIIER		0x02050
+
+/* root port address */
+#define PCIEPRAR(x)		(0x02080 + ((x) * 0x4))
+
+/* local address reg & mask */
+#define PCIELAR(x)		(0x02200 + ((x) * 0x20))
+#define PCIELAMR(x)		(0x02208 + ((x) * 0x20))
+#define  LAM_PREFETCH		BIT(3)
+#define  LAM_64BIT		BIT(2)
+#define  LAR_ENABLE		BIT(1)
+
+/* PCIe address reg & mask */
+#define PCIEPALR(x)		(0x03400 + ((x) * 0x20))
+#define PCIEPAUR(x)		(0x03404 + ((x) * 0x20))
+#define PCIEPAMR(x)		(0x03408 + ((x) * 0x20))
+#define PCIEPTCTLR(x)		(0x0340c + ((x) * 0x20))
+#define  PAR_ENABLE		BIT(31)
+#define  IO_SPACE		BIT(8)
+
+/* Configuration */
+#define PCICONF(x)		(0x010000 + ((x) * 0x4))
+#define PMCAP(x)		(0x010040 + ((x) * 0x4))
+#define EXPCAP(x)		(0x010070 + ((x) * 0x4))
+#define VCCAP(x)		(0x010100 + ((x) * 0x4))
+
+/* link layer */
+#define IDSETR1			0x011004
+#define TLCTLR			0x011048
+#define MACSR			0x011054
+#define  SPCHGFIN		BIT(4)
+#define  SPCHGFAIL		BIT(6)
+#define  SPCHGSUC		BIT(7)
+#define  LINK_SPEED		(0xf << 16)
+#define  LINK_SPEED_2_5GTS	(1 << 16)
+#define  LINK_SPEED_5_0GTS	(2 << 16)
+#define MACCTLR			0x011058
+#define  MACCTLR_NFTS_MASK	GENMASK(23, 16)	/* The name is from SH7786 */
+#define  SPEED_CHANGE		BIT(24)
+#define  SCRAMBLE_DISABLE	BIT(27)
+#define  LTSMDIS		BIT(31)
+#define  MACCTLR_INIT_VAL	(LTSMDIS | MACCTLR_NFTS_MASK)
+#define PMSR			0x01105c
+#define MACS2R			0x011078
+#define MACCGSPSETR		0x011084
+#define  SPCNGRSN		BIT(31)
+
+/* R-Car H1 PHY */
+#define H1_PCIEPHYADRR		0x04000c
+#define  WRITE_CMD		BIT(16)
+#define  PHY_ACK		BIT(24)
+#define  RATE_POS		12
+#define  LANE_POS		8
+#define  ADR_POS		0
+#define H1_PCIEPHYDOUTR		0x040014
+
+/* R-Car Gen2 PHY */
+#define GEN2_PCIEPHYADDR	0x780
+#define GEN2_PCIEPHYDATA	0x784
+#define GEN2_PCIEPHYCTRL	0x78c
+
+#define INT_PCI_MSI_NR		32
+
+#define RCONF(x)		(PCICONF(0) + (x))
+#define RPMCAP(x)		(PMCAP(0) + (x))
+#define REXPCAP(x)		(EXPCAP(0) + (x))
+#define RVCCAP(x)		(VCCAP(0) + (x))
+
+#define PCIE_CONF_BUS(b)	(((b) & 0xff) << 24)
+#define PCIE_CONF_DEV(d)	(((d) & 0x1f) << 19)
+#define PCIE_CONF_FUNC(f)	(((f) & 0x7) << 16)
+
+#define RCAR_PCI_MAX_RESOURCES	4
+#define MAX_NR_INBOUND_MAPS	6
+
+struct rcar_pcie {
+	struct device		*dev;
+	void __iomem		*base;
+};
+
+enum {
+	RCAR_PCI_ACCESS_READ,
+	RCAR_PCI_ACCESS_WRITE,
+};
+
+void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, unsigned int reg);
+u32 rcar_pci_read_reg(struct rcar_pcie *pcie, unsigned int reg);
+void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data);
+int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie);
+int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie);
+void rcar_pcie_set_outbound(struct rcar_pcie *pcie, int win,
+			    struct resource_entry *window);
+void rcar_pcie_set_inbound(struct rcar_pcie *pcie, u64 cpu_addr,
+			   u64 pci_addr, u64 flags, int idx, bool host);
+
+#endif
-- 
2.17.1


--sOubbOhgecSHCdFM89kX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5558): https://lists.cip-project.org/g/cip-dev/message=
/5558
Mute This Topic: https://lists.cip-project.org/mt/77461717/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--sOubbOhgecSHCdFM89kX--
