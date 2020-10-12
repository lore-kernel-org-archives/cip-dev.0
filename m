Return-Path: <SRS0=DeYV=DT=lists.cip-project.org=bounce+64572+5551+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AB4C04EBE
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C683620878
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Dk5Mx3Xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C683620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5551+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LEguYY4521723xhTvHibVEnj; Mon, 12 Oct 2020 07:21:05 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.42182.1602512420027305830
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:23 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351954"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:22 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 52C1241D31C7;
	Mon, 12 Oct 2020 23:20:21 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 31/50] PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments
Date: Mon, 12 Oct 2020 15:19:14 +0100
Message-Id: <20201012141933.9652-32-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bKmrlGSIPfICTPZjLhWLDFhdx4520388AA=
Content-Type: multipart/mixed; boundary="182wvNb03jqboSr4qsEu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512465;
 bh=YI+ijLTpDryqv6Q1jfOzDMwv5y+DQv9SDsxFr2mek1A=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Dk5Mx3XtIIhP9ypVqs9RtYVo3ydex4a7rxQSRncrEBmUSg9/zbIFdrmXXGkqoatKPOk
 cPY+5X8Uu5kMdx2B4JBFrRa1llOM3Cht2XyhtIvO9k+bgPLbJ0QumUwKNfBt2bA+GKTgr
 E7ZtQunGMu3f5jUTAkgV2jgQuZbXe50N614=

--182wvNb03jqboSr4qsEu

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 83153d9f36e24978c6211d246cb6f532bf54e5dc upstream.

commit 8963106eabdc ("PCI: endpoint: Add MSI-X interfaces") while
adding support to raise MSI-X interrupts from endpoint didn't include
BAR Indicator register (BIR) configuration and MSI-X table offset as
arguments in pci_epc_set_msix(). This would result in endpoint
controller register using random BAR indicator register, the memory
for which might not be allocated by the endpoint function driver.
Add BAR indicator register and MSI-X table offset as arguments in
pci_epc_set_msix() and allocate space for MSI-X table and pending
bit array (PBA) in pci-epf-test endpoint function driver.

Fixes: 8963106eabdc ("PCI: endpoint: Add MSI-X interfaces")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 15 +++++++--
 drivers/pci/endpoint/functions/pci-epf-test.c | 32 +++++++++++++++----
 drivers/pci/endpoint/pci-epc-core.c           |  7 ++--
 include/linux/pci-epc.h                       |  6 ++--
 4 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d1bb4b852b6c..667763fd868f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -302,7 +302,8 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
 	return val;
 }
 
-static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
+static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
+			       enum pci_barno bir, u32 offset)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -311,12 +312,22 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
 	if (!ep->msix_cap)
 		return -EINVAL;
 
+	dw_pcie_dbi_ro_wr_en(pci);
+
 	reg = ep->msix_cap + PCI_MSIX_FLAGS;
 	val = dw_pcie_readw_dbi(pci, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
 	val |= interrupts;
-	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, reg, val);
+
+	reg = ep->msix_cap + PCI_MSIX_TABLE;
+	val = offset | bir;
+	dw_pcie_writel_dbi(pci, reg, val);
+
+	reg = ep->msix_cap + PCI_MSIX_PBA;
+	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	dw_pcie_writel_dbi(pci, reg, val);
+
 	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 865a09d583df..f6905c242194 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -47,6 +47,7 @@ struct pci_epf_test {
 	void			*reg[6];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
+	size_t			msix_table_offset;
 	struct delayed_work	cmd_handler;
 	const struct pci_epc_features *epc_features;
 };
@@ -418,6 +419,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 
 static int pci_epf_test_core_init(struct pci_epf *epf)
 {
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epf_header *header = epf->header;
 	const struct pci_epc_features *epc_features;
 	struct pci_epc *epc = epf->epc;
@@ -451,7 +453,9 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	}
 
 	if (msix_capable) {
-		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts,
+				       epf_test->test_reg_bar,
+				       epf_test->msix_table_offset);
 		if (ret) {
 			dev_err(dev, "MSI-X configuration failed\n");
 			return ret;
@@ -493,6 +497,10 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct device *dev = &epf->dev;
 	struct pci_epf_bar *epf_bar;
+	size_t msix_table_size = 0;
+	size_t test_reg_bar_size;
+	size_t pba_size = 0;
+	bool msix_capable;
 	void *base;
 	int bar, add;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
@@ -501,13 +509,25 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 
 	epc_features = epf_test->epc_features;
 
-	if (epc_features->bar_fixed_size[test_reg_bar])
+	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
+
+	msix_capable = epc_features->msix_capable;
+	if (msix_capable) {
+		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
+		epf_test->msix_table_offset = test_reg_bar_size;
+		/* Align to QWORD or 8 Bytes */
+		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
+	}
+	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
+
+	if (epc_features->bar_fixed_size[test_reg_bar]) {
+		if (test_reg_size > bar_size[test_reg_bar])
+			return -ENOMEM;
 		test_reg_size = bar_size[test_reg_bar];
-	else
-		test_reg_size = sizeof(struct pci_epf_test_reg);
+	}
 
-	base = pci_epf_alloc_space(epf, test_reg_size,
-				   test_reg_bar, epc_features->align);
+	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
+				   epc_features->align);
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 0d22a377a0cf..82ba0dc7f2f5 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -297,10 +297,13 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
  * @epc: the EPC device on which MSI-X has to be configured
  * @func_no: the endpoint function number in the EPC device
  * @interrupts: number of MSI-X interrupts required by the EPF
+ * @bir: BAR where the MSI-X table resides
+ * @offset: Offset pointing to the start of MSI-X table
  *
  * Invoke to set the required number of MSI-X interrupts.
  */
-int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
+		     enum pci_barno bir, u32 offset)
 {
 	int ret;
 
@@ -312,7 +315,7 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
+	ret = epc->ops->set_msix(epc, func_no, interrupts - 1, bir, offset);
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 77e04ee1fe05..8c86841fcdaf 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -53,7 +53,8 @@ struct pci_epc_ops {
 			      phys_addr_t addr);
 	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 interrupts);
 	int	(*get_msi)(struct pci_epc *epc, u8 func_no);
-	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts);
+	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u16 interrupts,
+			    enum pci_barno, u32 offset);
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
@@ -180,7 +181,8 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
 			phys_addr_t phys_addr);
 int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no);
-int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts);
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts,
+		     enum pci_barno, u32 offset);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no);
 int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
-- 
2.17.1


--182wvNb03jqboSr4qsEu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5551): https://lists.cip-project.org/g/cip-dev/message=
/5551
Mute This Topic: https://lists.cip-project.org/mt/77461708/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--182wvNb03jqboSr4qsEu--
