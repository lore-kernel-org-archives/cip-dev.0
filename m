Return-Path: <SRS0=Ix9y=DT=lists.cip-project.org=bounce+64572+5531+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F69C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0B820838
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jzU9d8Rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0B820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5531+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CtTxYY4521723xVSk9RGE23W; Mon, 12 Oct 2020 07:20:28 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.41742.1602512378494256953
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:19:53 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59566815"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Oct 2020 23:19:52 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 79F0642A7637;
	Mon, 12 Oct 2020 23:19:51 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 11/50] PCI: pci-epf-test: Use pci_epc_get_features() to get EPC features
Date: Mon, 12 Oct 2020 15:18:54 +0100
Message-Id: <20201012141933.9652-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MhMOeuYLFYs6rEBQguTBK8fPx4520388AA=
Content-Type: multipart/mixed; boundary="P0hYq66wvxNSemyk0wdd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512428;
 bh=BJYw91Jd01ELFz/F1EMhdxLLH9O9mege/dgIutDMIt4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jzU9d8RwkThorrKeJO3AWpY5EP6r1SBoVZYwzOzluenMOtTOU2p+63/aPq7k9igfDUP
 wM49YNwIz4Bv22uQK5OHMmpzeBv7ziej5fuUV6k7y8B35TJnBvHisQCykKeSdP6bsj4YB
 Hb81+mvRqCJiT3xehfBFiDpaTktoPiVHXcY=

--P0hYq66wvxNSemyk0wdd

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 2c04c5b8eef797dca99699cfb55ff42dd3c12c23 upstream.

Use pci_epc_get_features() to get EPC features such as linkup
notifier support, MSI/MSIX capable, BAR configuration etc and use it
for configuring pci-epf-test. Since these features are now obtained
directly from EPC driver, remove pci_epf_test_data which was initially
added to have EPC features in endpoint function driver.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 87 ++++++++++++-------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index a385927a9239..d0b91da49bf4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -47,9 +47,8 @@ struct pci_epf_test {
 	void			*reg[6];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
-	bool			linkup_notifier;
-	bool			msix_available;
 	struct delayed_work	cmd_handler;
+	const struct pci_epc_features *epc_features;
 };
 
 struct pci_epf_test_reg {
@@ -71,11 +70,6 @@ static struct pci_epf_header test_header = {
 	.interrupt_pin	= PCI_INTERRUPT_INTA,
 };
 
-struct pci_epf_test_data {
-	enum pci_barno	test_reg_bar;
-	bool		linkup_notifier;
-};
-
 static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 
 static int pci_epf_test_copy(struct pci_epf_test *epf_test)
@@ -402,10 +396,16 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	struct device *dev = &epf->dev;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	const struct pci_epc_features *epc_features;
+
+	epc_features = epf_test->epc_features;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		epf_bar = &epf->bar[bar];
 
+		if (!!(epc_features->reserved_bar & (1 << bar)))
+			continue;
+
 		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
@@ -433,6 +433,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	void *base;
 	int bar;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	const struct pci_epc_features *epc_features;
+
+	epc_features = epf_test->epc_features;
 
 	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
 				   test_reg_bar);
@@ -446,6 +449,10 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		epf_bar = &epf->bar[bar];
 		if (bar == test_reg_bar)
 			continue;
+
+		if (!!(epc_features->reserved_bar & (1 << bar)))
+			continue;
+
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
@@ -458,25 +465,50 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	return 0;
 }
 
+static void pci_epf_configure_bar(struct pci_epf *epf,
+				  const struct pci_epc_features *epc_features)
+{
+	struct pci_epf_bar *epf_bar;
+	bool bar_fixed_64bit;
+	int i;
+
+	for (i = BAR_0; i <= BAR_5; i++) {
+		epf_bar = &epf->bar[i];
+		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
+		if (bar_fixed_64bit)
+			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+		if (epc_features->bar_fixed_size[i])
+			bar_size[i] = epc_features->bar_fixed_size[i];
+	}
+}
+
 static int pci_epf_test_bind(struct pci_epf *epf)
 {
 	int ret;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epf_header *header = epf->header;
+	const struct pci_epc_features *epc_features;
+	enum pci_barno test_reg_bar = BAR_0;
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
+	bool linkup_notifier = false;
+	bool msix_capable = false;
+	bool msi_capable = true;
 
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
 
-	if (epc->features & EPC_FEATURE_NO_LINKUP_NOTIFIER)
-		epf_test->linkup_notifier = false;
-	else
-		epf_test->linkup_notifier = true;
-
-	epf_test->msix_available = epc->features & EPC_FEATURE_MSIX_AVAILABLE;
+	epc_features = pci_epc_get_features(epc, epf->func_no);
+	if (epc_features) {
+		linkup_notifier = epc_features->linkup_notifier;
+		msix_capable = epc_features->msix_capable;
+		msi_capable = epc_features->msi_capable;
+		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
+		pci_epf_configure_bar(epf, epc_features);
+	}
 
-	epf_test->test_reg_bar = EPC_FEATURE_GET_BAR(epc->features);
+	epf_test->test_reg_bar = test_reg_bar;
+	epf_test->epc_features = epc_features;
 
 	ret = pci_epc_write_header(epc, epf->func_no, header);
 	if (ret) {
@@ -492,13 +524,15 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
-	ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
-	if (ret) {
-		dev_err(dev, "MSI configuration failed\n");
-		return ret;
+	if (msi_capable) {
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI configuration failed\n");
+			return ret;
+		}
 	}
 
-	if (epf_test->msix_available) {
+	if (msix_capable) {
 		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
 		if (ret) {
 			dev_err(dev, "MSI-X configuration failed\n");
@@ -506,7 +540,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		}
 	}
 
-	if (!epf_test->linkup_notifier)
+	if (!linkup_notifier)
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
 
 	return 0;
@@ -523,17 +557,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test;
 	struct device *dev = &epf->dev;
-	const struct pci_epf_device_id *match;
-	struct pci_epf_test_data *data;
-	enum pci_barno test_reg_bar = BAR_0;
-	bool linkup_notifier = true;
-
-	match = pci_epf_match_device(pci_epf_test_ids, epf);
-	data = (struct pci_epf_test_data *)match->driver_data;
-	if (data) {
-		test_reg_bar = data->test_reg_bar;
-		linkup_notifier = data->linkup_notifier;
-	}
 
 	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
 	if (!epf_test)
@@ -541,8 +564,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 
 	epf->header = &test_header;
 	epf_test->epf = epf;
-	epf_test->test_reg_bar = test_reg_bar;
-	epf_test->linkup_notifier = linkup_notifier;
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
-- 
2.17.1


--P0hYq66wvxNSemyk0wdd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5531): https://lists.cip-project.org/g/cip-dev/message=
/5531
Mute This Topic: https://lists.cip-project.org/mt/77461669/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--P0hYq66wvxNSemyk0wdd--
