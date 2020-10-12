Return-Path: <SRS0=Fq4j=DT=lists.cip-project.org=bounce+64572+5555+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA4EC4363A
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:05 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D4520838
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LkB9SSAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D4520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5555+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iV5rYY4521723xm7DOTsIGa3; Mon, 12 Oct 2020 07:21:05 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.42187.1602512428927900524
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:29 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351959"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:28 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4695141D31C7;
	Mon, 12 Oct 2020 23:20:27 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 35/50] PCI: endpoint: functions/pci-epf-test: Print throughput information
Date: Mon, 12 Oct 2020 15:19:18 +0100
Message-Id: <20201012141933.9652-36-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: miY26lOefLMJwCFbJpSxwMMXx4520388AA=
Content-Type: multipart/mixed; boundary="yO37nWxqTXFKDAjG5Yeq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512465;
 bh=vVhI3e1DaztJwRJvBmaGkvuzCAsJ+ixLH6EbjbB+Gv8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LkB9SSAqZzon6qUHOEahCc/7syAMHef/RQbrdpjxlQkjYKJqRQMdYOrZeXt6vXhhCVF
 IEfghcFK6SxCN8sHaBNoHgMnnyySOBerFwqzgMydiRD1YJbj1BHv665SdQRxxIWCh5UwG
 3qMXPCNPz344GouY2iimVKPfvacSeUAVfK8=

--yO37nWxqTXFKDAjG5Yeq

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


--yO37nWxqTXFKDAjG5Yeq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5555): https://lists.cip-project.org/g/cip-dev/message=
/5555
Mute This Topic: https://lists.cip-project.org/mt/77461713/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--yO37nWxqTXFKDAjG5Yeq--
