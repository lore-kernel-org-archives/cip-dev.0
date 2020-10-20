Return-Path: <SRS0=uTUl=D3=lists.cip-project.org=bounce+64572+5621+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FE6C388F7
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B021421D7B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="czZj/xWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B021421D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5621+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id liUvYY4521723xTghZ7AvmPe; Tue, 20 Oct 2020 07:58:12 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.8069.1603205878331425469
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:58:11 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60088238"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2020 23:58:11 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2B8A1433DEA6;
	Tue, 20 Oct 2020 23:58:09 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 24/26] PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table address
Date: Tue, 20 Oct 2020 15:57:30 +0100
Message-Id: <20201020145732.30343-25-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NN6VTm04Mu5p2aQO9keviQb9x4520388AA=
Content-Type: multipart/mixed; boundary="1cvfuQSLtFktgrS1JhxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205892;
 bh=zkwANuTWr/NjxmLAtrWLqAUVDfP2g0rx9V3Sba+6E8k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=czZj/xWVRz5u+wKSVyncl60+em83u+eS4gPniFoyMpVsrGlb4HDBAYa3BuPw+rG2CVE
 Ai/GNqWPQP68jQRkh8R1N7SUc6z1e0VYOjTSX5X49O+Vd8c816upKdpd6pUfX01laA43h
 aV5TcwP6vsqJm6QBayCkv8HvTPCHjVJcgvY=

--1cvfuQSLtFktgrS1JhxM

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 6f5e193bfb55963ce5f4f68cc927f371ddb0913b upstream.

commit beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler"),
in order to raise MSI-X interrupt, obtained MSIX table address from
Base Address Register (BAR). However BAR only holds PCI address
programmed by the host whereas the MSI-X table should be in the local
memory.

Store the MSI-X table address (virtual address) as part of ->set_bar()
callback and use that to get the message address and message data
here.

Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
[PL: Dropped changes to designware driver]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/pci-epf-core.c |  2 ++
 include/linux/pci-epf.h             | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index fb1306de8f40..93ebe916949e 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -99,6 +99,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar)
 			  epf->bar[bar].phys_addr);
 
 	epf->bar[bar].phys_addr = 0;
+	epf->bar[bar].addr = NULL;
 	epf->bar[bar].size = 0;
 	epf->bar[bar].barno = 0;
 	epf->bar[bar].flags = 0;
@@ -135,6 +136,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	epf->bar[bar].phys_addr = phys_addr;
+	epf->bar[bar].addr = space;
 	epf->bar[bar].size = size;
 	epf->bar[bar].barno = bar;
 	epf->bar[bar].flags |= upper_32_bits(size) ?
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 2d6f07556682..bc5ce7afd79a 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -92,10 +92,12 @@ struct pci_epf_driver {
 /**
  * struct pci_epf_bar - represents the BAR of EPF device
  * @phys_addr: physical address that should be mapped to the BAR
+ * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
  */
 struct pci_epf_bar {
 	dma_addr_t	phys_addr;
+	void		*addr;
 	size_t		size;
 	enum pci_barno	barno;
 	int		flags;
@@ -127,6 +129,19 @@ struct pci_epf {
 	struct list_head	list;
 };
 
+/**
+ * struct pci_epf_msix_tbl - represents the MSIX table entry structure
+ * @msg_addr: Writes to this address will trigger MSIX interrupt in host
+ * @msg_data: Data that should be written to @msg_addr to trigger MSIX interrupt
+ * @vector_ctrl: Identifies if the function is prohibited from sending a message
+ * using this MSIX table entry
+ */
+struct pci_epf_msix_tbl {
+	u64 msg_addr;
+	u32 msg_data;
+	u32 vector_ctrl;
+};
+
 #define to_pci_epf(epf_dev) container_of((epf_dev), struct pci_epf, dev)
 
 #define pci_epf_register_driver(driver)    \
-- 
2.17.1


--1cvfuQSLtFktgrS1JhxM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5621): https://lists.cip-project.org/g/cip-dev/message=
/5621
Mute This Topic: https://lists.cip-project.org/mt/77683543/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1cvfuQSLtFktgrS1JhxM--
