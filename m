Return-Path: <SRS0=PCWX=D3=lists.cip-project.org=bounce+64572+5616+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EC5C4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:05 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758A521D7B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="E2SK7nvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758A521D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5616+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xLkTYY4521723xlh6KpuHcqJ; Tue, 20 Oct 2020 07:58:05 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7925.1603205884374996046
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:58:04 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60303508"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Oct 2020 23:58:03 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9F9EE433DEA7;
	Tue, 20 Oct 2020 23:58:02 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 19/26] PCI: endpoint: Allocate enough space for fixed size BAR
Date: Tue, 20 Oct 2020 15:57:25 +0100
Message-Id: <20201020145732.30343-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rc7fvJtA6QtZMve5Q9AED0N1x4520388AA=
Content-Type: multipart/mixed; boundary="H9XukygDTl2mcCIdaCAb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205885;
 bh=ddMKnTwhiHuenJ24wpkr6d/tNysIkiKL4roLKdX+LWk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=E2SK7nvhI4iVZNgqDFwt7M7+8MSzSabfb/Qo4CM/Vga1x8RseGUAiM5IwEyqvtzIs7W
 EkrZEJo9C7G0s2bUCvvch0jVMryno8KcPl6fD+/sl68axVxEd+ZDkOFe/MVuOIg3QFu6d
 XcxuQxidJEATKPiC3QlytsJ5q8H4xlYeK7w=

--H9XukygDTl2mcCIdaCAb

From: Alan Mikhak <alan.mikhak@sifive.com>

commit f16fb16ed16c7f561e9c41c9ae4107c7f6aa553c upstream.

PCI endpoint test function code should honor the .bar_fixed_size parameter
from underlying endpoint controller drivers or results may be unexpected.

In pci_epf_test_alloc_space(), check if BAR being used for test
register space is a fixed size BAR. If so, allocate the required fixed
size.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 27806987e93b..7d41e6684b87 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -434,10 +434,16 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	int bar;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	const struct pci_epc_features *epc_features;
+	size_t test_reg_size;
 
 	epc_features = epf_test->epc_features;
 
-	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
+	if (epc_features->bar_fixed_size[test_reg_bar])
+		test_reg_size = bar_size[test_reg_bar];
+	else
+		test_reg_size = sizeof(struct pci_epf_test_reg);
+
+	base = pci_epf_alloc_space(epf, test_reg_size,
 				   test_reg_bar, epc_features->align);
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
-- 
2.17.1


--H9XukygDTl2mcCIdaCAb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5616): https://lists.cip-project.org/g/cip-dev/message=
/5616
Mute This Topic: https://lists.cip-project.org/mt/77683534/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--H9XukygDTl2mcCIdaCAb--
