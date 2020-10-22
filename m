Return-Path: <SRS0=+Qi0=D5=lists.cip-project.org=bounce+64572+5651+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D8C388F2
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BD92419B
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="HkNs2i3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BD92419B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5651+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5UuSYY4521723xrPkCjFCdKW; Thu, 22 Oct 2020 03:16:31 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.8438.1603361778788177942
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 03:16:31 -0700
X-IronPort-AV: E=Sophos;i="5.77,404,1596466800"; 
   d="scan'208";a="60292600"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Oct 2020 19:16:30 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0025B4002C32;
	Thu, 22 Oct 2020 19:16:29 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 11/13] PCI: endpoint: functions/pci-epf-test: Print throughput information
Date: Thu, 22 Oct 2020 11:16:12 +0100
Message-Id: <20201022101614.9298-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: eRvwA4VioeVMs9bPSeMhthYWx4520388AA=
Content-Type: multipart/mixed; boundary="XfipbqJAinLKxG8M3nAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603361791;
 bh=xnYpoi//gdhjVIt1KbmoK1nxq5V4eSiVu88vxfvhCsY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=HkNs2i3gY0CPDg8x+nNUnvfjn7jjk1VYBRv8TAoJYSMKYwXXIKWZnIZzRlRNhhV/ort
 zpj4vtUVpwwQtLMTuZkmPOdwzVIi/xqSyVvP1Qr4ancmgo2uy1xt1yORLA8ZcmW2zjlkM
 BfYxZLOiEXZ0pNgpqiJ0tT/D0Wn5Q66ZzYE=

--XfipbqJAinLKxG8M3nAe

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 5893c2e5353bb9a723d862d8b6ba8028a8f6a6eb upstream.

Print throughput information in KB/s after every completed transfer,
including information on whether DMA is used or not.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Alan Mikhak <alan.mikhak@sifive.com>
[PL: Applied changes to pci-epf-test.c manually, always pass dma variable
to pci_epf_test_print_rate() function as false since streaming DMA support
is missing in EPF]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index f6905c242194..8d9b5521ed50 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -73,6 +73,36 @@ static struct pci_epf_header test_header = {
 
 static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 
+static void pci_epf_test_print_rate(const char *ops, u64 size,
+				    struct timespec64 *start,
+				    struct timespec64 *end, bool dma)
+{
+	struct timespec64 ts;
+	u64 rate, ns;
+
+	ts = timespec64_sub(*end, *start);
+
+	/* convert both size (stored in 'rate') and time in terms of 'ns' */
+	ns = timespec64_to_ns(&ts);
+	rate = size * NSEC_PER_SEC;
+
+	/* Divide both size (stored in 'rate') and ns by a common factor */
+	while (ns > UINT_MAX) {
+		rate >>= 1;
+		ns >>= 1;
+	}
+
+	if (!ns)
+		return;
+
+	/* calculate the rate */
+	do_div(rate, (uint32_t)ns);
+
+	pr_info("\n%s => Size: %llu bytes\t DMA: %s\t Time: %llu.%09u seconds\t"
+		"Rate: %llu KB/s\n", ops, size, dma ? "YES" : "NO",
+		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
+}
+
 static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 {
 	int ret;
@@ -80,6 +110,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	void __iomem *dst_addr;
 	phys_addr_t src_phys_addr;
 	phys_addr_t dst_phys_addr;
+	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
@@ -118,7 +149,10 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err_dst_addr;
 	}
 
+	ktime_get_ts64(&start);
 	memcpy(dst_addr, src_addr, reg->size);
+	ktime_get_ts64(&end);
+	pci_epf_test_print_rate("COPY", reg->size, &start, &end, false);
 
 	pci_epc_unmap_addr(epc, epf->func_no, dst_phys_addr);
 
@@ -142,6 +176,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	void *buf;
 	u32 crc32;
 	phys_addr_t phys_addr;
+	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
@@ -170,7 +205,11 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		goto err_map_addr;
 	}
 
+	ktime_get_ts64(&start);
 	memcpy_fromio(buf, src_addr, reg->size);
+	ktime_get_ts64(&end);
+
+	pci_epf_test_print_rate("READ", reg->size, &start, &end, false);
 
 	crc32 = crc32_le(~0, buf, reg->size);
 	if (crc32 != reg->checksum)
@@ -194,6 +233,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	void __iomem *dst_addr;
 	void *buf;
 	phys_addr_t phys_addr;
+	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
@@ -225,7 +265,11 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	get_random_bytes(buf, reg->size);
 	reg->checksum = crc32_le(~0, buf, reg->size);
 
+	ktime_get_ts64(&start);
 	memcpy_toio(dst_addr, buf, reg->size);
+	ktime_get_ts64(&end);
+
+	pci_epf_test_print_rate("WRITE", reg->size, &start, &end, false);
 
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
-- 
2.17.1


--XfipbqJAinLKxG8M3nAe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5651): https://lists.cip-project.org/g/cip-dev/message=
/5651
Mute This Topic: https://lists.cip-project.org/mt/77727256/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XfipbqJAinLKxG8M3nAe--
