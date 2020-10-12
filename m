Return-Path: <SRS0=0WiP=DT=lists.cip-project.org=bounce+64572+5540+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CD7C43467
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03992076E
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="qrn0rTNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03992076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5540+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id U7aJYY4521723xGV3OZyn2Pt; Mon, 12 Oct 2020 07:20:33 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.41742.1602512378494256953
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:06 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59566834"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:05 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DACFD42A764A;
	Mon, 12 Oct 2020 23:20:04 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 20/50] PCI: endpoint: Skip odd BAR when skipping 64bit BAR
Date: Mon, 12 Oct 2020 15:19:03 +0100
Message-Id: <20201012141933.9652-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QsdicDdpIWOOcc8jDrGwbp8Bx4520388AA=
Content-Type: multipart/mixed; boundary="8i4ScZbe6WiZRWSfGpcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512433;
 bh=31SBEUq8WpLxioMWYaO0vWOREEHsoH7188YGxaWCmWs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qrn0rTNmrNBPbfzq5w3arEXPivavAEFhaiZVYz4qd0wBmYg6eWbUIyfhBR8KhPCPpTq
 prvrKDWaMKq6YWcNYYOBHzxMy7CYqjW6ffK7newKF9a8vfm+QFKpob6n5ChHsLnrLP+Hv
 qZOUsIDOy9voEg+N4GorJ/aop1YSx9EUChA=

--8i4ScZbe6WiZRWSfGpcj

From: Alan Mikhak <alan.mikhak@sifive.com>

commit 3041a643613a2530ade35a9ae97709a9da4c0c72 upstream.

Always skip odd BAR when skipping 64bit BARs in pci_epf_test_set_bar()
and pci_epf_test_alloc_space() otherwise pci_epf_test_set_bar() will
call pci_epc_set_bar() on an odd loop index when skipping reserved 64bit
BAR.

Moreover, pci_epf_test_alloc_space() will call pci_epf_alloc_space() on
bind for an odd loop index when BAR is 64bit but leaks on subsequent
unbind by not calling pci_epf_free_space().

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7d41e6684b87..e8bcc924dbf8 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -389,7 +389,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 static int pci_epf_test_set_bar(struct pci_epf *epf)
 {
-	int bar;
+	int bar, add;
 	int ret;
 	struct pci_epf_bar *epf_bar;
 	struct pci_epc *epc = epf->epc;
@@ -400,8 +400,14 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 
 	epc_features = epf_test->epc_features;
 
-	for (bar = BAR_0; bar <= BAR_5; bar++) {
+	for (bar = BAR_0; bar <= BAR_5; bar += add) {
 		epf_bar = &epf->bar[bar];
+		/*
+		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
+		 * if the specific implementation required a 64-bit BAR,
+		 * even if we only requested a 32-bit BAR.
+		 */
+		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
 
 		if (!!(epc_features->reserved_bar & (1 << bar)))
 			continue;
@@ -413,13 +419,6 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 			if (bar == test_reg_bar)
 				return ret;
 		}
-		/*
-		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
-		 * if the specific implementation required a 64-bit BAR,
-		 * even if we only requested a 32-bit BAR.
-		 */
-		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
-			bar++;
 	}
 
 	return 0;
@@ -431,7 +430,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	struct device *dev = &epf->dev;
 	struct pci_epf_bar *epf_bar;
 	void *base;
-	int bar;
+	int bar, add;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	const struct pci_epc_features *epc_features;
 	size_t test_reg_size;
@@ -451,8 +450,10 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	}
 	epf_test->reg[test_reg_bar] = base;
 
-	for (bar = BAR_0; bar <= BAR_5; bar++) {
+	for (bar = BAR_0; bar <= BAR_5; bar += add) {
 		epf_bar = &epf->bar[bar];
+		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
+
 		if (bar == test_reg_bar)
 			continue;
 
@@ -465,8 +466,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
 		epf_test->reg[bar] = base;
-		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
-			bar++;
 	}
 
 	return 0;
-- 
2.17.1


--8i4ScZbe6WiZRWSfGpcj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5540): https://lists.cip-project.org/g/cip-dev/message=
/5540
Mute This Topic: https://lists.cip-project.org/mt/77461686/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--8i4ScZbe6WiZRWSfGpcj--
