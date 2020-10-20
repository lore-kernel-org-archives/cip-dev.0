Return-Path: <SRS0=P++W=D3=lists.cip-project.org=bounce+64572+5607+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0A9C5517A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:53 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0428C206DB
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aWCI9ewB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0428C206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5607+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8ndMYY4521723xHo02iDaDLu; Tue, 20 Oct 2020 07:57:52 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.8061.1603205857454945281
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:50 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60088194"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:50 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0B858433DEA0;
	Tue, 20 Oct 2020 23:57:48 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 10/26] PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is 64Bit
Date: Tue, 20 Oct 2020 15:57:16 +0100
Message-Id: <20201020145732.30343-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dAsSS8ripNr2It85DIj1QMwfx4520388AA=
Content-Type: multipart/mixed; boundary="WmZ0KwzsVUudskDY7KiZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205872;
 bh=Pz5W8jdlUL6DWtg4kxBjsqByIyPI7o151zTSZYzf5yM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=aWCI9ewBd4O/Q9M474UH/jCfbsqyOqnXwE0YiIG74C7f9wz4wsa3cD7r8sNaQTQrxTi
 Au4d76+nWrvjRMas/sy7gqRZZpjzTZCYcXCz/Vq7V13FO+duLoOEbo/Rac1+jIqZMXg5M
 vtT+1N5+cRhT9RtW9850cEEv1bfF9gwa/Hs=

--WmZ0KwzsVUudskDY7KiZ

From: Kishon Vijay Abraham I <kishon@ti.com>

commit b866c56b66d88a632e2fa6b922c4ea051937acbd upstream.

It's useless to allocate memory for next BAR if the current BAR is a
64Bit BAR. Stop allocating memory for the next BAR, if the current
BARs flag indicates this is a 64Bit BAR.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ad0efa4446ba..a385927a9239 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -429,6 +429,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct device *dev = &epf->dev;
+	struct pci_epf_bar *epf_bar;
 	void *base;
 	int bar;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
@@ -442,6 +443,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	epf_test->reg[test_reg_bar] = base;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		epf_bar = &epf->bar[bar];
 		if (bar == test_reg_bar)
 			continue;
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
@@ -449,6 +451,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
 		epf_test->reg[bar] = base;
+		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
+			bar++;
 	}
 
 	return 0;
-- 
2.17.1


--WmZ0KwzsVUudskDY7KiZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5607): https://lists.cip-project.org/g/cip-dev/message=
/5607
Mute This Topic: https://lists.cip-project.org/mt/77683524/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WmZ0KwzsVUudskDY7KiZ--
