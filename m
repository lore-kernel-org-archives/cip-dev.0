Return-Path: <SRS0=K6WF=DT=lists.cip-project.org=bounce+64572+5546+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20531C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81AB2076E
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ck3jg6ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81AB2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5546+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TkCkYY4521723xBaWEt1Klyj; Mon, 12 Oct 2020 07:20:59 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.41794.1602512415549265316
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:16 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59566847"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:14 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D9CB241D31C7;
	Mon, 12 Oct 2020 23:20:13 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 26/50] PCI: endpoint: Assign function number for each PF in EPC core
Date: Mon, 12 Oct 2020 15:19:09 +0100
Message-Id: <20201012141933.9652-27-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mGlpIrEIa5LFlyZFMOwdDUHTx4520388AA=
Content-Type: multipart/mixed; boundary="l6RobmMQfgb0XRlSdaog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512459;
 bh=pLzP1eqFjJMFtHIJ45hKQpJo9LduDxr6oj+ibsDqWJY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ck3jg6ngS2aaO8cZG5wBK41a90NG9jB6E+kFygDvKBk4zi1ILt2T0OwYfb8OwdSifp2
 ceg2qS3gvkF6H3217sXFUy5PWxqFTjgyQBArd5ENWHLSvVq9TuIZ/7MkvnqxoaO7gohMj
 MWO1gWZqh+s9hTFPN3cfKs7Akfi/VIFh2O8=

--l6RobmMQfgb0XRlSdaog

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 2499ee84e02774a8573b7b4c76c8f2ea38669313 upstream.

The PCIe endpoint core relies on the drivers that invoke the
pci_epc_add_epf() API to allocate and assign a function number
to each physical function (PF). Since endpoint function device can
be created by multiple mechanisms (configfs, devicetree, etc..),
allowing each of these mechanisms to assign a function number
would result in mutliple endpoint function devices having the
same function number. In order to avoid this, let EPC core assign
a function number to the endpoint device.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c   | 27 +++++----------------------
 drivers/pci/endpoint/pci-epc-core.c | 26 ++++++++++++++++++++++----
 include/linux/pci-epc.h             |  2 ++
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d1288a0bd530..e7e8367eead1 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -29,7 +29,6 @@ struct pci_epc_group {
 	struct config_group group;
 	struct pci_epc *epc;
 	bool start;
-	unsigned long function_num_map;
 };
 
 static inline struct pci_epf_group *to_pci_epf_group(struct config_item *item)
@@ -89,37 +88,22 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 			    struct config_item *epf_item)
 {
 	int ret;
-	u32 func_no = 0;
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
 	struct pci_epc *epc = epc_group->epc;
 	struct pci_epf *epf = epf_group->epf;
 
-	func_no = find_first_zero_bit(&epc_group->function_num_map,
-				      BITS_PER_LONG);
-	if (func_no >= BITS_PER_LONG)
-		return -EINVAL;
-
-	set_bit(func_no, &epc_group->function_num_map);
-	epf->func_no = func_no;
-
 	ret = pci_epc_add_epf(epc, epf);
 	if (ret)
-		goto err_add_epf;
+		return ret;
 
 	ret = pci_epf_bind(epf);
-	if (ret)
-		goto err_epf_bind;
+	if (ret) {
+		pci_epc_remove_epf(epc, epf);
+		return ret;
+	}
 
 	return 0;
-
-err_epf_bind:
-	pci_epc_remove_epf(epc, epf);
-
-err_add_epf:
-	clear_bit(func_no, &epc_group->function_num_map);
-
-	return ret;
 }
 
 static void pci_epc_epf_unlink(struct config_item *epc_item,
@@ -134,7 +118,6 @@ static void pci_epc_epf_unlink(struct config_item *epc_item,
 
 	epc = epc_group->epc;
 	epf = epf_group->epf;
-	clear_bit(epf->func_no, &epc_group->function_num_map);
 	pci_epf_unbind(epf);
 	pci_epc_remove_epf(epc, epf);
 }
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e51a12ed85bb..dc1c673534e0 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -471,22 +471,39 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
  */
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
+	u32 func_no;
+	int ret = 0;
+
 	if (epf->epc)
 		return -EBUSY;
 
 	if (IS_ERR(epc))
 		return -EINVAL;
 
-	if (epf->func_no > epc->max_functions - 1)
-		return -EINVAL;
+	mutex_lock(&epc->lock);
+	func_no = find_first_zero_bit(&epc->function_num_map,
+				      BITS_PER_LONG);
+	if (func_no >= BITS_PER_LONG) {
+		ret = -EINVAL;
+		goto ret;
+	}
+
+	if (func_no > epc->max_functions - 1) {
+		dev_err(&epc->dev, "Exceeding max supported Function Number\n");
+		ret = -EINVAL;
+		goto ret;
+	}
 
+	set_bit(func_no, &epc->function_num_map);
+	epf->func_no = func_no;
 	epf->epc = epc;
 
-	mutex_lock(&epc->lock);
 	list_add_tail(&epf->list, &epc->pci_epf);
+
+ret:
 	mutex_unlock(&epc->lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epc_add_epf);
 
@@ -503,6 +520,7 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
 		return;
 
 	mutex_lock(&epc->lock);
+	clear_bit(epf->func_no, &epc->function_num_map);
 	list_del(&epf->list);
 	epf->epc = NULL;
 	mutex_unlock(&epc->lock);
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 9b21692bc2e4..44bfbeb480bb 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -92,6 +92,7 @@ struct pci_epc_mem {
  * @max_functions: max number of functions that can be configured in this EPC
  * @group: configfs group representing the PCI EPC device
  * @lock: mutex to protect pci_epc ops
+ * @function_num_map: bitmap to manage physical function number
  * @notifier: used to notify EPF of any EPC events (like linkup)
  */
 struct pci_epc {
@@ -103,6 +104,7 @@ struct pci_epc {
 	struct config_group		*group;
 	/* mutex to protect against concurrent access of EP controller */
 	struct mutex			lock;
+	unsigned long			function_num_map;
 	struct atomic_notifier_head	notifier;
 };
 
-- 
2.17.1


--l6RobmMQfgb0XRlSdaog
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5546): https://lists.cip-project.org/g/cip-dev/message=
/5546
Mute This Topic: https://lists.cip-project.org/mt/77461698/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--l6RobmMQfgb0XRlSdaog--
