Return-Path: <SRS0=eB2/=D3=lists.cip-project.org=bounce+64572+5598+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15804C4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250DA21741
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="g/VEm+tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250DA21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5598+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 178rYY4521723xTxNAWX9R1c; Tue, 20 Oct 2020 07:57:38 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.8061.1603205857454945281
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:37 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60088169"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:36 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 82823433DEA0;
	Tue, 20 Oct 2020 23:57:35 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 01/26] PCI: endpoint: Add new pci_epc_ops to get EPC features
Date: Tue, 20 Oct 2020 15:57:07 +0100
Message-Id: <20201020145732.30343-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wOsEOvWaoRXdLLWaW5skvJNJx4520388AA=
Content-Type: multipart/mixed; boundary="JgPw1PDY3zXc4sMOIasN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205858;
 bh=pYpNaScuXj4p7YqrKggxXeT9nH6tWjg0wMATS2wqE3E=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=g/VEm+tk/ZShutQfnE1zAATWc5VOr4SjLNaTzuvQvyNyOqnZR//wnUCYFgK8kAmkFcA
 AZplDPjOwIhftAox/MDmYJFEADIux6SSz4ZPJFzc+2wGYo5FAX13rkUmTi3AoaXYBB4/5
 7kj+fZNPCHRF98T3E6SkFcqnqX2PVqDkCx0=

--JgPw1PDY3zXc4sMOIasN

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 41cb8d189c9d4964df52a6f497cab7b301ae831b upstream.

Add a new pci_epc_ops ->get_features() to get the features
supported by the EPC. Since EPC can provide different features to
different functions, the ->get_features() ops takes _func_no_ as
an argument.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 30 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 22 +++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 094dcc3203b8..5a099479d9ab 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -83,6 +83,36 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 }
 EXPORT_SYMBOL_GPL(pci_epc_get);
 
+/**
+ * pci_epc_get_features() - get the features supported by EPC
+ * @epc: the features supported by *this* EPC device will be returned
+ * @func_no: the features supported by the EPC device specific to the
+ *	     endpoint function with func_no will be returned
+ *
+ * Invoke to get the features provided by the EPC which may be
+ * specific to an endpoint function. Returns pci_epc_features on success
+ * and NULL for any failures.
+ */
+const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
+						    u8 func_no)
+{
+	const struct pci_epc_features *epc_features;
+	unsigned long flags;
+
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+		return NULL;
+
+	if (!epc->ops->get_features)
+		return NULL;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	epc_features = epc->ops->get_features(epc, func_no);
+	spin_unlock_irqrestore(&epc->lock, flags);
+
+	return epc_features;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_features);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 931fda3e5e0d..fcd5e5047546 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -59,6 +59,8 @@ struct pci_epc_ops {
 			     enum pci_epc_irq_type type, u16 interrupt_num);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
+	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
+						       u8 func_no);
 	struct module *owner;
 };
 
@@ -103,6 +105,24 @@ struct pci_epc {
 	unsigned int			features;
 };
 
+/**
+ * struct pci_epc_features - features supported by a EPC device per function
+ * @linkup_notifier: indicate if the EPC device can notify EPF driver on link up
+ * @msi_capable: indicate if the endpoint function has MSI capability
+ * @msix_capable: indicate if the endpoint function has MSI-X capability
+ * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
+ * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
+ * @bar_fixed_size: Array specifying the size supported by each BAR
+ */
+struct pci_epc_features {
+	unsigned int	linkup_notifier : 1;
+	unsigned int	msi_capable : 1;
+	unsigned int	msix_capable : 1;
+	u8	reserved_bar;
+	u8	bar_fixed_64bit;
+	u64	bar_fixed_size[BAR_5 + 1];
+};
+
 #define EPC_FEATURE_NO_LINKUP_NOTIFIER		BIT(0)
 #define EPC_FEATURE_BAR_MASK			(BIT(1) | BIT(2) | BIT(3))
 #define EPC_FEATURE_MSIX_AVAILABLE		BIT(4)
@@ -161,6 +181,8 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
+const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
+						    u8 func_no);
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 
-- 
2.17.1


--JgPw1PDY3zXc4sMOIasN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5598): https://lists.cip-project.org/g/cip-dev/message=
/5598
Mute This Topic: https://lists.cip-project.org/mt/77683510/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--JgPw1PDY3zXc4sMOIasN--
