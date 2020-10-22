Return-Path: <SRS0=puKr=D5=lists.cip-project.org=bounce+64572+5642+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3389C56201
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74EB2419B
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="SXD2Wlvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74EB2419B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5642+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PJoSYY4521723xGKbLoKHsuP; Thu, 22 Oct 2020 03:16:21 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.8475.1603361778321978533
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 03:16:19 -0700
X-IronPort-AV: E=Sophos;i="5.77,404,1596466800"; 
   d="scan'208";a="60507850"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Oct 2020 19:16:18 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0FD0D4002C32;
	Thu, 22 Oct 2020 19:16:17 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 02/13] PCI: endpoint: Replace spinlock with mutex
Date: Thu, 22 Oct 2020 11:16:03 +0100
Message-Id: <20201022101614.9298-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zzHa0RJfVMsD7G0PamLNU2Shx4520388AA=
Content-Type: multipart/mixed; boundary="oU8Fi4jsnGhsVXDofzof"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603361781;
 bh=7UF7n84RlqTpRUnLTw2Mr7tSFSAVFhD3OuZZKVicsN4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=SXD2WlvkeO7u+LhN2DsLym7RbWZUv88Y+ABfzNxrxC8r9yZ1FLyCjFDeym6cmmVJixZ
 rMUlypbJtE12jGlGIx+Z6eqFA7TxJIwZHgPN3sPRL+O4eZvZ6fy0ydb8fi/8eOhgVCf6d
 r6qhQTBIgHdn2kIa8je0FW8nkmDIkxgUJ68=

--oU8Fi4jsnGhsVXDofzof

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 3d3248dbd018502f654064c78efcd2e165ab3486 upstream.

The pci_epc_ops is not intended to be invoked from interrupt context.
Hence replace spin_lock_irqsave and spin_unlock_irqrestore with
mutex_lock and mutex_unlock respectively.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 82 +++++++++++------------------
 include/linux/pci-epc.h             |  6 +--
 2 files changed, 34 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2f6436599fcb..e51a12ed85bb 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -120,7 +120,6 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no)
 {
 	const struct pci_epc_features *epc_features;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return NULL;
@@ -128,9 +127,9 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 	if (!epc->ops->get_features)
 		return NULL;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	epc_features = epc->ops->get_features(epc, func_no);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return epc_features;
 }
@@ -144,14 +143,12 @@ EXPORT_SYMBOL_GPL(pci_epc_get_features);
  */
 void pci_epc_stop(struct pci_epc *epc)
 {
-	unsigned long flags;
-
 	if (IS_ERR(epc) || !epc->ops->stop)
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	epc->ops->stop(epc);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_stop);
 
@@ -164,7 +161,6 @@ EXPORT_SYMBOL_GPL(pci_epc_stop);
 int pci_epc_start(struct pci_epc *epc)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR(epc))
 		return -EINVAL;
@@ -172,9 +168,9 @@ int pci_epc_start(struct pci_epc *epc)
 	if (!epc->ops->start)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->start(epc);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -193,7 +189,6 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
@@ -201,9 +196,9 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->raise_irq)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->raise_irq(epc, func_no, type, interrupt_num);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -219,7 +214,6 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
 {
 	int interrupt;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return 0;
@@ -227,9 +221,9 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
 	if (!epc->ops->get_msi)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	interrupt = epc->ops->get_msi(epc, func_no);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	if (interrupt < 0)
 		return 0;
@@ -252,7 +246,6 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 {
 	int ret;
 	u8 encode_int;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
 	    interrupts > 32)
@@ -263,9 +256,9 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
 
 	encode_int = order_base_2(interrupts);
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->set_msi(epc, func_no, encode_int);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -281,7 +274,6 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msi);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
 {
 	int interrupt;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return 0;
@@ -289,9 +281,9 @@ int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
 	if (!epc->ops->get_msix)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	interrupt = epc->ops->get_msix(epc, func_no);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	if (interrupt < 0)
 		return 0;
@@ -311,7 +303,6 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
 	    interrupts < 1 || interrupts > 2048)
@@ -320,9 +311,9 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16 interrupts)
 	if (!epc->ops->set_msix)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -339,17 +330,15 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
 void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
 			phys_addr_t phys_addr)
 {
-	unsigned long flags;
-
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return;
 
 	if (!epc->ops->unmap_addr)
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	epc->ops->unmap_addr(epc, func_no, phys_addr);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
 
@@ -367,7 +356,6 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
 		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
@@ -375,9 +363,9 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->map_addr)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -394,8 +382,6 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
 void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
 		       struct pci_epf_bar *epf_bar)
 {
-	unsigned long flags;
-
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
 	    (epf_bar->barno == BAR_5 &&
 	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
@@ -404,9 +390,9 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->clear_bar)
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	epc->ops->clear_bar(epc, func_no, epf_bar);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
 
@@ -422,7 +408,6 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 		    struct pci_epf_bar *epf_bar)
 {
 	int ret;
-	unsigned long irq_flags;
 	int flags = epf_bar->flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
@@ -437,9 +422,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->set_bar)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, irq_flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->set_bar(epc, func_no, epf_bar);
-	spin_unlock_irqrestore(&epc->lock, irq_flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -460,7 +445,6 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 			 struct pci_epf_header *header)
 {
 	int ret;
-	unsigned long flags;
 
 	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
 		return -EINVAL;
@@ -468,9 +452,9 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 	if (!epc->ops->write_header)
 		return 0;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	ret = epc->ops->write_header(epc, func_no, header);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return ret;
 }
@@ -487,8 +471,6 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
  */
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
-	unsigned long flags;
-
 	if (epf->epc)
 		return -EBUSY;
 
@@ -500,9 +482,9 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 
 	epf->epc = epc;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	list_add_tail(&epf->list, &epc->pci_epf);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 
 	return 0;
 }
@@ -517,15 +499,13 @@ EXPORT_SYMBOL_GPL(pci_epc_add_epf);
  */
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
-	unsigned long flags;
-
 	if (!epc || IS_ERR(epc) || !epf)
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
+	mutex_lock(&epc->lock);
 	list_del(&epf->list);
 	epf->epc = NULL;
-	spin_unlock_irqrestore(&epc->lock, flags);
+	mutex_unlock(&epc->lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
 
@@ -604,7 +584,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		goto err_ret;
 	}
 
-	spin_lock_init(&epc->lock);
+	mutex_init(&epc->lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
 	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 8c61908d2c41..9b21692bc2e4 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -91,7 +91,7 @@ struct pci_epc_mem {
  * @mem: address space of the endpoint controller
  * @max_functions: max number of functions that can be configured in this EPC
  * @group: configfs group representing the PCI EPC device
- * @lock: spinlock to protect pci_epc ops
+ * @lock: mutex to protect pci_epc ops
  * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
@@ -101,8 +101,8 @@ struct pci_epc {
 	struct pci_epc_mem		*mem;
 	u8				max_functions;
 	struct config_group		*group;
-	/* spinlock to protect against concurrent access of EP controller */
-	spinlock_t			lock;
+	/* mutex to protect against concurrent access of EP controller */
+	struct mutex			lock;
 	struct atomic_notifier_head	notifier;
 };
 
-- 
2.17.1


--oU8Fi4jsnGhsVXDofzof
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5642): https://lists.cip-project.org/g/cip-dev/message=
/5642
Mute This Topic: https://lists.cip-project.org/mt/77727247/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--oU8Fi4jsnGhsVXDofzof--
