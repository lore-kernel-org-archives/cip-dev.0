Return-Path: <SRS0=vwxV=D3=lists.cip-project.org=bounce+64572+5609+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B896C4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE06C2222C
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sxhUfRbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE06C2222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5609+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id x2lSYY4521723xqMcagwEUQ8; Tue, 20 Oct 2020 07:57:59 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7918.1603205873822040734
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:54 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60303489"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:53 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1B735433DEA1;
	Tue, 20 Oct 2020 23:57:51 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 12/26] PCI: cadence: Remove pci_epf_linkup() from Cadence EP driver
Date: Tue, 20 Oct 2020 15:57:18 +0100
Message-Id: <20201020145732.30343-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OTZdA2Ka7NMAkHXfxnfICBYAx4520388AA=
Content-Type: multipart/mixed; boundary="iJOVHTE6bWf2uH9QNVgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205879;
 bh=2jhxK7mYpWkXl7uI766VUARFbEaMsjqIVKd3nsSiLpI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=sxhUfRbLub1gOwxsabIVzkEhz5DE79sjc8ijekKY2j7v4bhX/6IsFJQyrE4pithyjj2
 1PgVg6I5umv4uTi+f0xHLFKrG3MxhJ3fvM8NvEZSS4LSe8gcrrO6h3IvC4Pm8F+Xy9qwG
 OQoJ8avv/NrBbwLDQ9Yndw8uhmXp9uiCIw0=

--iJOVHTE6bWf2uH9QNVgK

From: Kishon Vijay Abraham I <kishon@ti.com>

commit c274c9f4ea758bd6667a363f275e45275f2b5672 upstream.

pci_epf_linkup() is intended to be invoked if the EPC supports linkup
notification. Now that pci-epf-test uses the get_features() callback,
which indicates Cadence EP driver doesn't support the linkup notification,
remove pci_epf_linkup() from Cadence EP driver.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 14c2545bb17e..def7820cb824 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -396,18 +396,6 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 		cfg |= BIT(epf->func_no);
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
 
-	/*
-	 * The PCIe links are automatically established by the controller
-	 * once for all at powerup: the software can neither start nor stop
-	 * those links later at runtime.
-	 *
-	 * Then we only have to notify the EP core that our links are already
-	 * established. However we don't call directly pci_epc_linkup() because
-	 * we've already locked the epc->lock.
-	 */
-	list_for_each_entry(epf, &epc->pci_epf, list)
-		pci_epf_linkup(epf);
-
 	return 0;
 }
 
-- 
2.17.1


--iJOVHTE6bWf2uH9QNVgK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5609): https://lists.cip-project.org/g/cip-dev/message=
/5609
Mute This Topic: https://lists.cip-project.org/mt/77683526/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--iJOVHTE6bWf2uH9QNVgK--
