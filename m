Return-Path: <SRS0=yKfb=D5=lists.cip-project.org=bounce+64572+5647+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC59EC388F7
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5B92419B
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IeWFLaAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5B92419B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5647+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LxibYY4521723xLsWqRjRiXs; Thu, 22 Oct 2020 03:16:26 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.8475.1603361778321978533
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 03:16:26 -0700
X-IronPort-AV: E=Sophos;i="5.77,404,1596466800"; 
   d="scan'208";a="60507862"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Oct 2020 19:16:25 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B0E7E40062B1;
	Thu, 22 Oct 2020 19:16:24 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 07/13] PCI: pci-epf-test: Add support to defer core initialization
Date: Thu, 22 Oct 2020 11:16:08 +0100
Message-Id: <20201022101614.9298-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: A6nCWoQOcqlhtEKjibQVI0PEx4520388AA=
Content-Type: multipart/mixed; boundary="rbOntjhRcWmMx6vykz8f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603361786;
 bh=bDfGHJEq5U6en4KQWrIlFqhKDuGSe/e93TgolR94omw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IeWFLaAc/eagk7OlO15SX0NEu7neVRlzzRvsoE1oUiWVrnfnlf2kaEOQO8YKdK4sNAO
 fbAuHS9M+voDCEFukVLVocwQy4ESErbfXWDcyNjupp0P+/H82kpAvmC5dmI2G8f38ebFU
 OnAqsN+rjpjqKGqbqTvi6nF48/Bo3jCbix4=

--rbOntjhRcWmMx6vykz8f

From: Vidya Sagar <vidyas@nvidia.com>

commit 5e50ee27d4a52a817ab152128c48690ec7c5cdf1 upstream.

Add support to defer core initialization for the endpoint mode of
operation.

This would enable support for implementations where the core
initialization needs to be deferred until the PCIe reference clock is
available from the host system.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++------
 1 file changed, 77 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7dd40ab8b5d2..865a09d583df 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -360,18 +360,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			   msecs_to_jiffies(1));
 }
 
-static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
-				 void *data)
-{
-	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
-	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
-
-	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
-			   msecs_to_jiffies(1));
-
-	return NOTIFY_OK;
-}
-
 static void pci_epf_test_unbind(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -428,6 +416,78 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	return 0;
 }
 
+static int pci_epf_test_core_init(struct pci_epf *epf)
+{
+	struct pci_epf_header *header = epf->header;
+	const struct pci_epc_features *epc_features;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	bool msix_capable = false;
+	bool msi_capable = true;
+	int ret;
+
+	epc_features = pci_epc_get_features(epc, epf->func_no);
+	if (epc_features) {
+		msix_capable = epc_features->msix_capable;
+		msi_capable = epc_features->msi_capable;
+	}
+
+	ret = pci_epc_write_header(epc, epf->func_no, header);
+	if (ret) {
+		dev_err(dev, "Configuration header write failed\n");
+		return ret;
+	}
+
+	ret = pci_epf_test_set_bar(epf);
+	if (ret)
+		return ret;
+
+	if (msi_capable) {
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI configuration failed\n");
+			return ret;
+		}
+	}
+
+	if (msix_capable) {
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI-X configuration failed\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
+				 void *data)
+{
+	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	int ret;
+
+	switch (val) {
+	case CORE_INIT:
+		ret = pci_epf_test_core_init(epf);
+		if (ret)
+			return NOTIFY_BAD;
+		break;
+
+	case LINK_UP:
+		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
+				   msecs_to_jiffies(1));
+		break;
+
+	default:
+		dev_err(&epf->dev, "Invalid EPF test notifier event\n");
+		return NOTIFY_BAD;
+	}
+
+	return NOTIFY_OK;
+}
+
 static int pci_epf_test_alloc_space(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -496,14 +556,11 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 {
 	int ret;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
-	struct pci_epf_header *header = epf->header;
 	const struct pci_epc_features *epc_features;
 	enum pci_barno test_reg_bar = BAR_0;
 	struct pci_epc *epc = epf->epc;
-	struct device *dev = &epf->dev;
 	bool linkup_notifier = false;
-	bool msix_capable = false;
-	bool msi_capable = true;
+	bool core_init_notifier = false;
 
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
@@ -511,8 +568,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	epc_features = pci_epc_get_features(epc, epf->func_no);
 	if (epc_features) {
 		linkup_notifier = epc_features->linkup_notifier;
-		msix_capable = epc_features->msix_capable;
-		msi_capable = epc_features->msi_capable;
+		core_init_notifier = epc_features->core_init_notifier;
 		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
 		pci_epf_configure_bar(epf, epc_features);
 	}
@@ -520,34 +576,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
 
-	ret = pci_epc_write_header(epc, epf->func_no, header);
-	if (ret) {
-		dev_err(dev, "Configuration header write failed\n");
-		return ret;
-	}
-
 	ret = pci_epf_test_alloc_space(epf);
 	if (ret)
 		return ret;
 
-	ret = pci_epf_test_set_bar(epf);
-	if (ret)
-		return ret;
-
-	if (msi_capable) {
-		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
-		if (ret) {
-			dev_err(dev, "MSI configuration failed\n");
-			return ret;
-		}
-	}
-
-	if (msix_capable) {
-		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
-		if (ret) {
-			dev_err(dev, "MSI-X configuration failed\n");
+	if (!core_init_notifier) {
+		ret = pci_epf_test_core_init(epf);
+		if (ret)
 			return ret;
-		}
 	}
 
 	if (linkup_notifier) {
-- 
2.17.1


--rbOntjhRcWmMx6vykz8f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5647): https://lists.cip-project.org/g/cip-dev/message=
/5647
Mute This Topic: https://lists.cip-project.org/mt/77727252/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--rbOntjhRcWmMx6vykz8f--
