Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8C6C5DF96
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7138.1787318229926731630
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=kMoPvEAw;
 spf=pass (domain: renesas.com, ip: 40.107.74.62, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCnZCxIkAqRdyN94fJIYtZuAMa7728KCO5jNenOD/+/ScV8yA0cs1WqmIUNUs5z2mg2Sq1igthQn8Z82qjZk2uVnIMJgSrjz0HVibDRlT0shA9avVWTHmY+wUp+Ya3IeFmL3LO/IeyawW1KXT9cZG/2HcFyuugTr2HaCmXcu+bC0Bflpu5YNNrZNkW85rJrBXvIkd4rEIF61pRo9Ni0DWjaQrQV3Ij5weNT7JzUsZtfTril3+0fEIqq5IdwyIAcetU3Y1uCXuBbxno965jcP6k4A7i2ht8LNzVNFBdeJ2/XW73Wj+m3hOynqCrmqP+hazamu94hZtFdxm7jb6KeP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTYClB7W5afyVsg/jXfuJwZkfLAPbZ6gkSNr2yDKps4=;
 b=WvBu0Q9hi3znGkdOMFIBLEggGCDI9VfjDTKOu+/F8VbViwG23TTND9jv/xRk6/xtn5GYiUyXuduRrCMGAMVXKSPovdtr37aJZOWoo2i+NqL2hoDXRjP4PMWxHC+psjdVX78OjQfH4pxlLWKW5B+306gD2mN5Etl0UVythheTCIEyBJt92kIKkUofduksuL3O3AQcoS8Kjwn8FWy+rPBj9WfUhvIJ19h/GlPyx5+fgytzMalVuCLk49td6EU39Qlfd8I93pCFYC5IoMitIrToelTa/hl2G8P9s/PmY2ZzAOqgDrIewwJBSUCWIpa0SPprSKplnwzwXi7q5vW5JgXyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTYClB7W5afyVsg/jXfuJwZkfLAPbZ6gkSNr2yDKps4=;
 b=kMoPvEAwY6Iui0WaBmWT1AltZC5z9k3nWb1qoGeD/msgFIxDLDI5w4vo5rvAgFUwr8cdy/p/RIb0pcpdluNvruUdVnupk8z6REhKnNxzfwGaWdCyS/mqgSV0w+r6j47fVvrurVj6pS0SCYpSzUUC/GC9IMu8Hsd9sJbGaKV+02s=
Received: from TY4PR01CA0065.jpnprd01.prod.outlook.com (2603:1096:405:370::19)
 by TYCPR01MB9571.jpnprd01.prod.outlook.com (2603:1096:400:197::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:17:03 +0000
Received: from TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:370:cafe::6) by TY4PR01CA0065.outlook.office365.com
 (2603:1096:405:370::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 13:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005621.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:17:02 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 64267300037C;
	Fri, 21 Aug 2026 22:17:01 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 09/18] irqchip: Add RZ/{T2H,N2H} Interrupt Controller (ICU) driver
Date: Fri, 21 Aug 2026 16:15:45 +0300
Message-ID: <20260821131554.638741-10-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005621:EE_|TYCPR01MB9571:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 62011114-f19b-43d4-dd00-08deff867d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	mkQsLLjAAm9qKolgwNZMpPydqwZ23P6OHomMifm1oxraT1a2GtcFhm9stpG9li06I45EzS7sZUrdByyTsBcS3XdQtDpDq65vxtWoiccJZjbDgEcmQIcAx4idbom+iJtvlKyu044OPvmvaCxgWFHychwza0ZyX7qJUZ8yqVd87L42+APXcZvjRIgOcM0HUnwHpfIJeBBuxBsi9esXGCAkxacud4sf5aVSHBidqd0MDDx9zomyzDzwkgcO2bfpJh32F9dygqbOKO5B8f3xOafb8tR+8S0GxD+qCpJgn4PXzbLdvXqoIvsX7qnJg+1rKU1ooRcRqHTNykB5tK5grxBJ0e5Ao//5Q6v7yp9piixOO90mODwihqj35NM+nc+JSI1G1Apu5e1IFQaEzEogdICUkZQiVw1cPK0POyQNBX+ekS7Q9euZQdt6rNfpw6L/F9yCHKFb8n8D+yyCcKXroFtg1Ftq7UOHnDyQm3TjUvmsGxk+aaDq8jiMvF/ZsicO0evzx7JCE8FwyiKIKS3dOnSe3hA5mAT9uJDRyMNLG30av6GtLbtop1vbSAW8ZmuIzX5pZ9HN/tyWpqETdwM3F95Ewq/k6/zbEmn90u1NUoqLojZ5LTv0gOZ5kaRwdoyDwbRT+sO6yDioxmZLQ1YB36fG/akoqR9CIAnWAPm/kGR8fw4=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	If3Q6d5k6MGSijWmR56cNJSCuln6SM1KFJj/+OTRMdGTamhjbTluDlhE93Lium0Y11EAUBWko5MRdLpDyUUOCK3MyQaeyi/TkWuV0HwC7ljF/qPu9/ZdGac24XPVybquiFn8+ImDheWiJNz9PvAiMI8OgF6XPDw+/QjNifrFToMq0vvS1ebvPNW4/lChnS7S2RLTURO4odbGh1iwFD7wuAt8J15Fw5qn2+5D3aRJ9L35P7lWfJwJeVouQro4fibC3JiCGkidgr0MqxCydV57BpZQtm5jkiqrA75M5+dJPucLG3D++xIvwQTSEDP+Y7LSwkeRQ6xZDCfiiELI3vGM+gNw332UVH+FO9Rp06DVtptRueWrWGYI1vT1RJMwqkrCUTcR/gtBe06SgaEPSP6ctSYnCnDg4G+1nWtmM9GNv9YxP9QHIeXwXCq2OBtDMrVh
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:17:02.6612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62011114-f19b-43d4-dd00-08deff867d5c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9571
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23967

commit 13e7b3305b647cf58c47c979fe8a04e08caa6098 upstream.

The Renesas RZ/T2H (R9A09G077) and Renesas RZ/N2H (R9A09G087) SoCs have an
Interrupt Controller (ICU) that supports interrupts from external pins IRQ0
to IRQ15, and SEI, and software-triggered interrupts INTCPU0 to INTCPU15.

INTCPU0 to INTCPU13, IRQ0 to IRQ13 are non-safety interrupts, while
INTCPU14, INTCPU15, IRQ14, IRQ15 and SEI are safety interrupts, and are
exposed via a separate register space.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251201112933.488801-3-cosmin-gabriel.tanis=
lav.xa@renesas.com
[ctani: adapt to current definition of IRQCHIP_MATCH()]
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/irqchip/Kconfig                   |   8 +
 drivers/irqchip/Makefile                  |   1 +
 drivers/irqchip/irq-renesas-rzt2h.c       | 295 ++++++++++++++++++++++
 drivers/soc/renesas/Kconfig               |   1 +
 include/linux/irqchip/irq-renesas-rzt2h.h |  23 ++
 5 files changed, 328 insertions(+)
 create mode 100644 drivers/irqchip/irq-renesas-rzt2h.c
 create mode 100644 include/linux/irqchip/irq-renesas-rzt2h.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a72943b47a5d..727b69c245cb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -260,6 +260,14 @@ config RENESAS_RZG2L_IRQC
 	  Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt Control=
ler
 	  for external devices.
=20
+config RENESAS_RZT2H_ICU
+	bool "Renesas RZ/{T2H,N2H} ICU support" if COMPILE_TEST
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Enable support for the Renesas RZ/{T2H,N2H} Interrupt Controller
+	  (ICU).
+
 config RENESAS_RZV2H_ICU
 	bool "Renesas RZ/V2H(P) ICU support" if COMPILE_TEST
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 94ecaebff37f..76d4793386b1 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+=3D irq-renesas-intc-i=
rqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+=3D irq-renesas-irqc.o
 obj-$(CONFIG_RENESAS_RZA1_IRQC)		+=3D irq-renesas-rza1.o
 obj-$(CONFIG_RENESAS_RZG2L_IRQC)	+=3D irq-renesas-rzg2l.o
+obj-$(CONFIG_RENESAS_RZT2H_ICU)		+=3D irq-renesas-rzt2h.o
 obj-$(CONFIG_RENESAS_RZV2H_ICU)		+=3D irq-renesas-rzv2h.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+=3D irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_NSPIRE)		+=3D irq-zevio.o
diff --git a/drivers/irqchip/irq-renesas-rzt2h.c b/drivers/irqchip/irq-rene=
sas-rzt2h.c
new file mode 100644
index 000000000000..4b0cd5f66c34
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-rzt2h.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/irq-renesas-rzt2h.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define RZT2H_ICU_INTCPU_NS_START		0
+#define RZT2H_ICU_INTCPU_NS_COUNT		14
+
+#define RZT2H_ICU_INTCPU_S_START		(RZT2H_ICU_INTCPU_NS_START +	\
+						 RZT2H_ICU_INTCPU_NS_COUNT)
+#define RZT2H_ICU_INTCPU_S_COUNT		2
+
+#define RZT2H_ICU_IRQ_NS_START			(RZT2H_ICU_INTCPU_S_START +	\
+						 RZT2H_ICU_INTCPU_S_COUNT)
+#define RZT2H_ICU_IRQ_NS_COUNT			14
+
+#define RZT2H_ICU_IRQ_S_START			(RZT2H_ICU_IRQ_NS_START +	\
+						 RZT2H_ICU_IRQ_NS_COUNT)
+#define RZT2H_ICU_IRQ_S_COUNT			2
+
+#define RZT2H_ICU_SEI_START			(RZT2H_ICU_IRQ_S_START +	\
+						 RZT2H_ICU_IRQ_S_COUNT)
+#define RZT2H_ICU_SEI_COUNT			1
+
+#define RZT2H_ICU_NUM_IRQ			(RZT2H_ICU_INTCPU_NS_COUNT +	\
+						 RZT2H_ICU_INTCPU_S_COUNT +	\
+						 RZT2H_ICU_IRQ_NS_COUNT +	\
+						 RZT2H_ICU_IRQ_S_COUNT +	\
+						 RZT2H_ICU_SEI_COUNT)
+
+#define RZT2H_ICU_IRQ_IN_RANGE(n, type)						\
+	((n) >=3D RZT2H_ICU_##type##_START &&					\
+	 (n) <  RZT2H_ICU_##type##_START + RZT2H_ICU_##type##_COUNT)
+
+#define RZT2H_ICU_PORTNF_MD			0xc
+#define RZT2H_ICU_PORTNF_MDi_MASK(i)		(GENMASK(1, 0) << ((i) * 2))
+#define RZT2H_ICU_PORTNF_MDi_PREP(i, val)	(FIELD_PREP(GENMASK(1, 0), val) =
<< ((i) * 2))
+
+#define RZT2H_ICU_MD_LOW_LEVEL			0b00
+#define RZT2H_ICU_MD_FALLING_EDGE		0b01
+#define RZT2H_ICU_MD_RISING_EDGE		0b10
+#define RZT2H_ICU_MD_BOTH_EDGES			0b11
+
+#define RZT2H_ICU_DMACn_RSSELi(n, i)		(0x7d0 + 0x18 * (n) + 0x4 * (i))
+#define RZT2H_ICU_DMAC_REQ_SELx_MASK(x)		(GENMASK(9, 0) << ((x) * 10))
+#define RZT2H_ICU_DMAC_REQ_SELx_PREP(x, val)	(FIELD_PREP(GENMASK(9, 0), va=
l) << ((x) * 10))
+
+struct rzt2h_icu_priv {
+	void __iomem		*base_ns;
+	void __iomem		*base_s;
+	struct irq_fwspec	fwspec[RZT2H_ICU_NUM_IRQ];
+	raw_spinlock_t		lock;
+};
+
+void rzt2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_i=
ndex, u8 dmac_channel,
+				u16 req_no)
+{
+	struct rzt2h_icu_priv *priv =3D platform_get_drvdata(icu_dev);
+	u8 y, upper;
+	u32 val;
+
+	y =3D dmac_channel / 3;
+	upper =3D dmac_channel % 3;
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+	val =3D readl(priv->base_ns + RZT2H_ICU_DMACn_RSSELi(dmac_index, y));
+	val &=3D ~RZT2H_ICU_DMAC_REQ_SELx_MASK(upper);
+	val |=3D RZT2H_ICU_DMAC_REQ_SELx_PREP(upper, req_no);
+	writel(val, priv->base_ns + RZT2H_ICU_DMACn_RSSELi(dmac_index, y));
+}
+EXPORT_SYMBOL_GPL(rzt2h_icu_register_dma_req);
+
+static inline struct rzt2h_icu_priv *irq_data_to_priv(struct irq_data *dat=
a)
+{
+	return data->domain->host_data;
+}
+
+static inline int rzt2h_icu_irq_to_offset(struct irq_data *d, void __iomem=
 **base,
+					  unsigned int *offset)
+{
+	struct rzt2h_icu_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+
+	/*
+	 * Safety IRQs and SEI use a separate register space from the non-safety =
IRQs.
+	 * SEI interrupt number follows immediately after the safety IRQs.
+	 */
+	if (RZT2H_ICU_IRQ_IN_RANGE(hwirq, IRQ_NS)) {
+		*offset =3D hwirq - RZT2H_ICU_IRQ_NS_START;
+		*base =3D priv->base_ns;
+	} else if (RZT2H_ICU_IRQ_IN_RANGE(hwirq, IRQ_S) || RZT2H_ICU_IRQ_IN_RANGE=
(hwirq, SEI)) {
+		*offset =3D hwirq - RZT2H_ICU_IRQ_S_START;
+		*base =3D priv->base_s;
+	} else {
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int rzt2h_icu_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct rzt2h_icu_priv *priv =3D irq_data_to_priv(d);
+	unsigned int offset, parent_type;
+	void __iomem *base;
+	u32 val, md;
+	int ret;
+
+	ret =3D rzt2h_icu_irq_to_offset(d, &base, &offset);
+	if (ret)
+		return ret;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		md =3D RZT2H_ICU_MD_LOW_LEVEL;
+		parent_type =3D IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		md =3D RZT2H_ICU_MD_FALLING_EDGE;
+		parent_type =3D IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		md =3D RZT2H_ICU_MD_RISING_EDGE;
+		parent_type =3D IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		md =3D RZT2H_ICU_MD_BOTH_EDGES;
+		parent_type =3D IRQ_TYPE_EDGE_RISING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	scoped_guard(raw_spinlock, &priv->lock) {
+		val =3D readl_relaxed(base + RZT2H_ICU_PORTNF_MD);
+		val &=3D ~RZT2H_ICU_PORTNF_MDi_MASK(offset);
+		val |=3D RZT2H_ICU_PORTNF_MDi_PREP(offset, md);
+		writel_relaxed(val, base + RZT2H_ICU_PORTNF_MD);
+	}
+
+	return irq_chip_set_type_parent(d, parent_type);
+}
+
+static int rzt2h_icu_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+
+	/* IRQn and SEI are selectable, others are edge-only. */
+	if (RZT2H_ICU_IRQ_IN_RANGE(hw_irq, IRQ_NS) ||
+	    RZT2H_ICU_IRQ_IN_RANGE(hw_irq, IRQ_S) ||
+	    RZT2H_ICU_IRQ_IN_RANGE(hw_irq, SEI))
+		return rzt2h_icu_irq_set_type(d, type);
+
+	if ((type & IRQ_TYPE_SENSE_MASK) !=3D IRQ_TYPE_EDGE_RISING)
+		return -EINVAL;
+
+	return irq_chip_set_type_parent(d, IRQ_TYPE_EDGE_RISING);
+}
+
+static const struct irq_chip rzt2h_icu_chip =3D {
+	.name			=3D "rzt2h-icu",
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+	.irq_eoi		=3D irq_chip_eoi_parent,
+	.irq_set_type		=3D rzt2h_icu_set_type,
+	.irq_set_wake		=3D irq_chip_set_wake_parent,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int rzt2h_icu_alloc(struct irq_domain *domain, unsigned int virq, u=
nsigned int nr_irqs,
+			   void *arg)
+{
+	struct rzt2h_icu_priv *priv =3D domain->host_data;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	ret =3D irq_domain_translate_twocell(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &rzt2h_icu_chi=
p, NULL);
+	if (ret)
+		return ret;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &priv->fwspec[=
hwirq]);
+}
+
+static const struct irq_domain_ops rzt2h_icu_domain_ops =3D {
+	.alloc		=3D rzt2h_icu_alloc,
+	.free		=3D irq_domain_free_irqs_common,
+	.translate	=3D irq_domain_translate_twocell,
+};
+
+static int rzt2h_icu_parse_interrupts(struct rzt2h_icu_priv *priv, struct =
device_node *np)
+{
+	struct of_phandle_args map;
+	unsigned int i;
+	int ret;
+
+	for (i =3D 0; i < RZT2H_ICU_NUM_IRQ; i++) {
+		ret =3D of_irq_parse_one(np, i, &map);
+		if (ret)
+			return ret;
+
+		of_phandle_args_to_fwspec(np, map.args, map.args_count, &priv->fwspec[i]=
);
+	}
+
+	return 0;
+}
+
+static int rzt2h_icu_init(struct device_node *node, struct device_node *pa=
rent)
+{
+	struct platform_device *pdev =3D of_find_device_by_node(node);
+	struct device *dev __free(put_device) =3D pdev ? &pdev->dev : NULL;
+	struct irq_domain *irq_domain, *parent_domain;
+	struct rzt2h_icu_priv *priv;
+	int ret;
+
+	if (!pdev)
+		return -ENODEV;
+
+	parent_domain =3D irq_find_host(parent);
+	if (!parent_domain)
+		return dev_err_probe(dev, -ENODEV, "cannot find parent domain\n");
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&priv->lock);
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->base_ns =3D devm_of_iomap(dev, dev->of_node, 0, NULL);
+	if (IS_ERR(priv->base_ns))
+		return PTR_ERR(priv->base_ns);
+
+	priv->base_s =3D devm_of_iomap(dev, dev->of_node, 1, NULL);
+	if (IS_ERR(priv->base_s))
+		return PTR_ERR(priv->base_s);
+
+	ret =3D rzt2h_icu_parse_interrupts(priv, node);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot parse interrupts: %d\n", ret);
+
+	ret =3D devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "devm_pm_runtime_enable failed: %d\n", re=
t);
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "pm_runtime_resume_and_get failed: %d\n",=
 ret);
+
+	irq_domain =3D irq_domain_create_hierarchy(parent_domain, 0, RZT2H_ICU_NU=
M_IRQ,
+						 dev_fwnode(dev), &rzt2h_icu_domain_ops, priv);
+	if (!irq_domain) {
+		pm_runtime_put(dev);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Prevent the cleanup function from invoking put_device by assigning
+	 * NULL to dev.
+	 *
+	 * make coccicheck will complain about missing put_device calls, but
+	 * those are false positives, as dev will be automatically "put" via
+	 * __free_put_device on the failing path.
+	 * On the successful path we don't actually want to "put" dev.
+	 */
+	dev =3D NULL;
+
+	return 0;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(rzt2h_icu)
+IRQCHIP_MATCH("renesas,r9a09g077-icu", rzt2h_icu_init)
+IRQCHIP_PLATFORM_DRIVER_END(rzt2h_icu)
+MODULE_AUTHOR("Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/T2H ICU Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 90ba65072af2..67496adfcb52 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -377,6 +377,7 @@ config ARCH_R9A09G057
 config ARCH_R9A09G077
 	bool "ARM64 Platform support for RZ/T2H"
 	default y if ARCH_RENESAS
+	select RENESAS_RZT2H_ICU
 	help
 	  This enables support for the Renesas RZ/T2H SoC variants.
=20
diff --git a/include/linux/irqchip/irq-renesas-rzt2h.h b/include/linux/irqc=
hip/irq-renesas-rzt2h.h
new file mode 100644
index 000000000000..853fd5ee0b22
--- /dev/null
+++ b/include/linux/irqchip/irq-renesas-rzt2h.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Renesas RZ/T2H Interrupt Control Unit (ICU)
+ *
+ * Copyright (C) 2025 Renesas Electronics Corporation.
+ */
+
+#ifndef __LINUX_IRQ_RENESAS_RZT2H
+#define __LINUX_IRQ_RENESAS_RZT2H
+
+#include <linux/platform_device.h>
+
+#define RZT2H_ICU_DMAC_REQ_NO_DEFAULT		0x3ff
+
+#ifdef CONFIG_RENESAS_RZT2H_ICU
+void rzt2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_i=
ndex, u8 dmac_channel,
+				u16 req_no);
+#else
+static inline void rzt2h_icu_register_dma_req(struct platform_device *icu_=
dev, u8 dmac_index,
+					      u8 dmac_channel, u16 req_no) { }
+#endif
+
+#endif /* __LINUX_IRQ_RENESAS_RZT2H */
--=20
2.55.0


