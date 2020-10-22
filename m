Return-Path: <SRS0=RLS0=D5=lists.cip-project.org=bounce+64572+5641+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749B5C388F2
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5216124248
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="j1i6HcTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5216124248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5641+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iPpYYY4521723x4T8Bo0MgGd; Thu, 22 Oct 2020 03:16:19 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.8438.1603361778788177942
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 03:16:19 -0700
X-IronPort-AV: E=Sophos;i="5.77,404,1596466800"; 
   d="scan'208";a="60292577"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Oct 2020 19:16:17 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B5DAB40062B1;
	Thu, 22 Oct 2020 19:16:16 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 01/13] PCI: endpoint: Use notification chain mechanism to notify EPC events to EPF
Date: Thu, 22 Oct 2020 11:16:02 +0100
Message-Id: <20201022101614.9298-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: z822j8YbxMnnN7V5XLoeVzPWx4520388AA=
Content-Type: multipart/mixed; boundary="kRyblqvk94oCpJuuX5bf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603361779;
 bh=QIuQuFRrpzQxoSr2Qdgp6LyrkuHPAch4KmOlZaSfASs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=j1i6HcTUssLtpTP627rXNgNZFZUHfbKGxOPtUYOtgv+kog6fSQ73hDkrXA0ZKQ8umxr
 ANu87Re9NRYelJfZcjRE81Nl7IHeUD8OhGdPtJ9vBdMTjl++dnBecPOi7xivr00IQ2JsY
 FEpONGappVOPtUSIBA3VilxgsY3nYw1yzLM=

--kRyblqvk94oCpJuuX5bf

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 5779dd0a7dbd71e82478fb0bf125cc6cd3c43266 upstream.

Use atomic_notifier_call_chain() to notify EPC events like linkup to EPF
driver instead of using linkup ops in EPF driver. This is in preparation
for adding proper locking mechanism to EPF ops. This will also enable to
add more events (in addition to linkup) in the future.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++++---
 drivers/pci/endpoint/pci-epc-core.c           |  9 ++------
 drivers/pci/endpoint/pci-epf-core.c           | 22 +------------------
 include/linux/pci-epc.h                       |  8 +++++++
 include/linux/pci-epf.h                       |  6 ++---
 5 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 1cfe3687a211..7dd40ab8b5d2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -360,12 +360,16 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			   msecs_to_jiffies(1));
 }
 
-static void pci_epf_test_linkup(struct pci_epf *epf)
+static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
+				 void *data)
 {
+	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 
 	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
 			   msecs_to_jiffies(1));
+
+	return NOTIFY_OK;
 }
 
 static void pci_epf_test_unbind(struct pci_epf *epf)
@@ -546,8 +550,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		}
 	}
 
-	if (!linkup_notifier)
+	if (linkup_notifier) {
+		epf->nb.notifier_call = pci_epf_test_notifier;
+		pci_epc_register_notifier(epc, &epf->nb);
+	} else {
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
+	}
 
 	return 0;
 }
@@ -580,7 +588,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 static struct pci_epf_ops ops = {
 	.unbind	= pci_epf_test_unbind,
 	.bind	= pci_epf_test_bind,
-	.linkup = pci_epf_test_linkup,
 };
 
 static struct pci_epf_driver test_driver = {
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2091508c1620..2f6436599fcb 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -539,16 +539,10 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
  */
 void pci_epc_linkup(struct pci_epc *epc)
 {
-	unsigned long flags;
-	struct pci_epf *epf;
-
 	if (!epc || IS_ERR(epc))
 		return;
 
-	spin_lock_irqsave(&epc->lock, flags);
-	list_for_each_entry(epf, &epc->pci_epf, list)
-		pci_epf_linkup(epf);
-	spin_unlock_irqrestore(&epc->lock, flags);
+	atomic_notifier_call_chain(&epc->notifier, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
@@ -612,6 +606,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 
 	spin_lock_init(&epc->lock);
 	INIT_LIST_HEAD(&epc->pci_epf);
+	ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
 
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 93ebe916949e..642f233efcaf 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -20,26 +20,6 @@ static DEFINE_MUTEX(pci_epf_mutex);
 static struct bus_type pci_epf_bus_type;
 static const struct device_type pci_epf_type;
 
-/**
- * pci_epf_linkup() - Notify the function driver that EPC device has
- *		      established a connection with the Root Complex.
- * @epf: the EPF device bound to the EPC device which has established
- *	 the connection with the host
- *
- * Invoke to notify the function driver that EPC device has established
- * a connection with the Root Complex.
- */
-void pci_epf_linkup(struct pci_epf *epf)
-{
-	if (!epf->driver) {
-		dev_WARN(&epf->dev, "epf device not bound to driver\n");
-		return;
-	}
-
-	epf->driver->ops->linkup(epf);
-}
-EXPORT_SYMBOL_GPL(pci_epf_linkup);
-
 /**
  * pci_epf_unbind() - Notify the function driver that the binding between the
  *		      EPF device and EPC device has been lost
@@ -216,7 +196,7 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 	if (!driver->ops)
 		return -EINVAL;
 
-	if (!driver->ops->bind || !driver->ops->unbind || !driver->ops->linkup)
+	if (!driver->ops->bind || !driver->ops->unbind)
 		return -EINVAL;
 
 	driver->driver.bus = &pci_epf_bus_type;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 0c12d69dde92..8c61908d2c41 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -92,6 +92,7 @@ struct pci_epc_mem {
  * @max_functions: max number of functions that can be configured in this EPC
  * @group: configfs group representing the PCI EPC device
  * @lock: spinlock to protect pci_epc ops
+ * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
 	struct device			dev;
@@ -102,6 +103,7 @@ struct pci_epc {
 	struct config_group		*group;
 	/* spinlock to protect against concurrent access of EP controller */
 	spinlock_t			lock;
+	struct atomic_notifier_head	notifier;
 };
 
 /**
@@ -144,6 +146,12 @@ static inline void *epc_get_drvdata(struct pci_epc *epc)
 	return dev_get_drvdata(&epc->dev);
 }
 
+static inline int
+pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&epc->notifier, nb);
+}
+
 struct pci_epc *
 __devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 		      struct module *owner);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index bc5ce7afd79a..75aa1003646b 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -55,13 +55,10 @@ struct pci_epf_header {
  * @bind: ops to perform when a EPC device has been bound to EPF device
  * @unbind: ops to perform when a binding has been lost between a EPC device
  *	    and EPF device
- * @linkup: ops to perform when the EPC device has established a connection with
- *	    a host system
  */
 struct pci_epf_ops {
 	int	(*bind)(struct pci_epf *epf);
 	void	(*unbind)(struct pci_epf *epf);
-	void	(*linkup)(struct pci_epf *epf);
 };
 
 /**
@@ -114,6 +111,7 @@ struct pci_epf_bar {
  * @epc: the EPC device to which this EPF device is bound
  * @driver: the EPF driver to which this EPF device is bound
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
+ * @nb: notifier block to notify EPF of any EPC events (like linkup)
  */
 struct pci_epf {
 	struct device		dev;
@@ -127,6 +125,7 @@ struct pci_epf {
 	struct pci_epc		*epc;
 	struct pci_epf_driver	*driver;
 	struct list_head	list;
+	struct notifier_block   nb;
 };
 
 /**
@@ -169,5 +168,4 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
-void pci_epf_linkup(struct pci_epf *epf);
 #endif /* __LINUX_PCI_EPF_H */
-- 
2.17.1


--kRyblqvk94oCpJuuX5bf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5641): https://lists.cip-project.org/g/cip-dev/message=
/5641
Mute This Topic: https://lists.cip-project.org/mt/77727246/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kRyblqvk94oCpJuuX5bf--
