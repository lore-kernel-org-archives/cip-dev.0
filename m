Return-Path: <SRS0=7Xj2=DT=lists.cip-project.org=bounce+64572+5536+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8125C41604
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992D620878
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ouzx0Fl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992D620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5536+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gUATYY4521723x3zPsTn2QxR; Mon, 12 Oct 2020 07:20:30 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.41742.1602512378494256953
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:00 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59566823"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Oct 2020 23:19:59 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E2B3A42A7638;
	Mon, 12 Oct 2020 23:19:58 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 16/50] PCI: endpoint: Fix a potential NULL pointer dereference
Date: Mon, 12 Oct 2020 15:18:59 +0100
Message-Id: <20201012141933.9652-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: v1ppA75bx2TfZKCAm7OdA28Zx4520388AA=
Content-Type: multipart/mixed; boundary="0l1oVuHgd2zjQa4MG27i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512430;
 bh=FxPXZwcW9upPeuFWFEzF2xpBkGSys4aqR9r0+mg9mJw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ouzx0Fl+Hk+pSnRa4QHU7zacJDq+CqF2VKHnc4dk3k1Ft/vZM3LXw62Q3wSEJerjpvP
 4WasHHTMHRsmN/YMzEv7/WGtwnGblqJLq0k3TE5gM9KY4RqwV6jN9fLrOyb8zB1ICHXtI
 2ePQTjSeGJGBcfGYuBGpcjRV3mR2nkuhb70=

--0l1oVuHgd2zjQa4MG27i

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


--0l1oVuHgd2zjQa4MG27i
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5536): https://lists.cip-project.org/g/cip-dev/message=
/5536
Mute This Topic: https://lists.cip-project.org/mt/77461677/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0l1oVuHgd2zjQa4MG27i--
