Return-Path: <SRS0=+Gew=DT=lists.cip-project.org=bounce+64572+5537+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EABC2D0A3
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:31 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E3620838
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="USFDvI/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E3620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5537+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id erNMYY4521723x3s1RcvtLDp; Mon, 12 Oct 2020 07:20:31 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.41742.1602512378494256953
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:02 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59566826"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:01 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6371542A7637;
	Mon, 12 Oct 2020 23:20:00 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 17/50] PCI: endpoint: Add support to specify alignment for buffers allocated to BARs
Date: Mon, 12 Oct 2020 15:19:00 +0100
Message-Id: <20201012141933.9652-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KJL4neLgLiPGpwKnMDFakDLQx4520388AA=
Content-Type: multipart/mixed; boundary="RGUvf3yPQ4sOdUgkQtBL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512431;
 bh=nCeYY7mI/OzQmtx9N6lirkOpzscqPjqQFYoPqr7quis=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=USFDvI/EMcoe1D/Xv8Dlpgyfc618dvf94N9cWAzolI9Tq6cL3VNQmh6+t8AHMJeJHCM
 oIeh1O9P+tN95O/mtHG8BQQ3gZxOYzjwbi9dRDKC8vdddDXmpBauVj1HmmbZk4i7tHifH
 W2234+a6CzrctcncR0Z5+K56LEwW7SoVTEs=

--RGUvf3yPQ4sOdUgkQtBL

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 2a9a801620efac92885fc9cd53594c0b9aba87a4 upstream.

The address that is allocated using pci_epf_alloc_space() is
directly written to the target address of the Inbound Address
Translation unit (ie the HW component implementing inbound address
decoding) on endpoint controllers.

Designware IP [1] has a configuration parameter (CX_ATU_MIN_REGION_SIZE
[2]) which has 64KB as default value and the lower 16 bits of the Base,
Limit and Target registers of the Inbound ATU are fixed to zero. If the
programmed memory address is not aligned to 64 KB boundary this causes
memory corruption.

Modify pci_epf_alloc_space() API to take alignment size as argument in
order to allocate buffers to be mapped to BARs with an alignment that
suits the platform where they are used.

Add an 'align' parameter to epc_features which can be used by platform
drivers to specify the BAR allocation alignment requirements and use
this while invoking pci_epf_alloc_space().

[1] "I/O and MEM Match Modes" section in DesignWare Cores PCI Express
     Controller Databook version 4.90a
[2]  http://www.ti.com/lit/ug/spruid7c/spruid7c.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c |  5 +++--
 drivers/pci/endpoint/pci-epf-core.c           | 10 ++++++++--
 include/linux/pci-epc.h                       |  2 ++
 include/linux/pci-epf.h                       |  3 ++-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ed5cd28b9572..27806987e93b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -438,7 +438,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	epc_features = epf_test->epc_features;
 
 	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
-				   test_reg_bar);
+				   test_reg_bar, epc_features->align);
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
@@ -453,7 +453,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		if (!!(epc_features->reserved_bar & (1 << bar)))
 			continue;
 
-		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
+		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
+					   epc_features->align);
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8bfdcd291196..fb1306de8f40 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -109,10 +109,12 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
  * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
  * @size: the size of the memory that has to be allocated
  * @bar: the BAR number corresponding to the allocated register space
+ * @align: alignment size for the allocation region
  *
  * Invoke to allocate memory for the PCI EPF register space.
  */
-void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
+void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
+			  size_t align)
 {
 	void *space;
 	struct device *dev = epf->epc->dev.parent;
@@ -120,7 +122,11 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
 
 	if (size < 128)
 		size = 128;
-	size = roundup_pow_of_two(size);
+
+	if (align)
+		size = ALIGN(size, align);
+	else
+		size = roundup_pow_of_two(size);
 
 	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
 	if (!space) {
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index b3a3c0805603..0c12d69dde92 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -112,6 +112,7 @@ struct pci_epc {
  * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
  * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
  * @bar_fixed_size: Array specifying the size supported by each BAR
+ * @align: alignment size required for BAR buffer allocation
  */
 struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
@@ -120,6 +121,7 @@ struct pci_epc_features {
 	u8	reserved_bar;
 	u8	bar_fixed_64bit;
 	u64	bar_fixed_size[BAR_5 + 1];
+	size_t	align;
 };
 
 #define to_pci_epc(device) container_of((device), struct pci_epc, dev)
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index ec02f58758c8..2d6f07556682 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -149,7 +149,8 @@ void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,
 			      struct module *owner);
 void pci_epf_unregister_driver(struct pci_epf_driver *driver);
-void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar);
+void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
+			  size_t align);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
-- 
2.17.1


--RGUvf3yPQ4sOdUgkQtBL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5537): https://lists.cip-project.org/g/cip-dev/message=
/5537
Mute This Topic: https://lists.cip-project.org/mt/77461678/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--RGUvf3yPQ4sOdUgkQtBL--
