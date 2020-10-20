Return-Path: <SRS0=abgK=D3=lists.cip-project.org=bounce+64572+5613+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07226C388F9
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:01 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A2821D7B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EksPpzNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A2821D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5613+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Aqc1YY4521723xdMESuMb1YR; Tue, 20 Oct 2020 07:58:00 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.8069.1603205878331425469
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:59 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60088207"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:59 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1F2F9433DEA2;
	Tue, 20 Oct 2020 23:57:57 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 16/26] PCI: endpoint: Fix a potential NULL pointer dereference
Date: Tue, 20 Oct 2020 15:57:22 +0100
Message-Id: <20201020145732.30343-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0z3bndMMfJIOg605jw6rdYcbx4520388AA=
Content-Type: multipart/mixed; boundary="I1WVyCvoTd7MUOByDXNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205880;
 bh=NNBDcmoa4iEssLy13ef+N3dGB/bxQg3zpMYhsH8mR2Q=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EksPpzNB6Inft+cD8W3HBmN4ln/EF0ZhxyAYarW7VngeL5bRmQuG3D7w9n3Kfdwxql/
 VScw9wwFq2Y6b4w/5juZFfTXPDWzmgXJbBRSxjVOrwDUCAf+jezvAFvUml8XTK6PXeN44
 H01Q+ggXuPrFzxhZ5V1XinaNvE7LZaAB5gs=

--I1WVyCvoTd7MUOByDXNV

From: Kangjie Lu <kjlu@umn.edu>

commit 507b820009a457afa78202da337bcb56791fbb12 upstream.

In case alloc_workqueue() fails, return -ENOMEM to avoid
potential NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
[lorenzo.pieralisi@arm.com: commit log and code update]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d0b91da49bf4..ed5cd28b9572 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -591,6 +591,11 @@ static int __init pci_epf_test_init(void)
 
 	kpcitest_workqueue = alloc_workqueue("kpcitest",
 					     WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	if (!kpcitest_workqueue) {
+		pr_err("Failed to allocate the kpcitest work queue\n");
+		return -ENOMEM;
+	}
+
 	ret = pci_epf_register_driver(&test_driver);
 	if (ret) {
 		pr_err("Failed to register pci epf test driver --> %d\n", ret);
-- 
2.17.1


--I1WVyCvoTd7MUOByDXNV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5613): https://lists.cip-project.org/g/cip-dev/message=
/5613
Mute This Topic: https://lists.cip-project.org/mt/77683530/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--I1WVyCvoTd7MUOByDXNV--
