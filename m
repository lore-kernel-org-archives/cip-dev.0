Return-Path: <SRS0=u/QV=D3=lists.cip-project.org=bounce+64572+5600+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1200C4363D
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279E921741
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UOnDaS43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279E921741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5600+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Rb04YY4521723x5fcCJDPMGr; Tue, 20 Oct 2020 07:57:40 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.8062.1603205857220566607
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:40 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60303468"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:39 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7FCC1433DEA0;
	Tue, 20 Oct 2020 23:57:38 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 03/26] PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
Date: Tue, 20 Oct 2020 15:57:09 +0100
Message-Id: <20201020145732.30343-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lA3g263JMJwyfPyZ6m32Yi8sx4520388AA=
Content-Type: multipart/mixed; boundary="BKd9gGIlkVt8ZLfhjn4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205860;
 bh=EfSQRPVXxb9WiEEcpgqqQyQzMceO8Oaq2+SJ6dPvRY4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UOnDaS43eCXOdAhUlnC6ogzxcbxe+799mMfSN0AOMd5MQQvBCMbwUb8ZGL6MTQdtxsJ
 8uTbGK1Jh+Znxnt3RpKyjpqMYBM4TYl3ez7ZcCUudpEJ4Ezd9oWx4CHJc1+MDqFcAmdTi
 otCnafHShTM8J/cCo7r+teCCZmmdBHcI1sY=

--BKd9gGIlkVt8ZLfhjn4s

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 3b4322e589a630fe35944ced5852655fcc4a5d24 upstream.

Populate ->get_features() dw_pcie_ep_ops to return the EPC features
supported by Designware PCIe endpoint controller.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index c12bf794d69c..bd0516afc86f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -100,9 +100,22 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+static const struct pci_epc_features dw_plat_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = true,
+};
+
+static const struct pci_epc_features*
+dw_plat_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &dw_plat_pcie_epc_features;
+}
+
 static struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = dw_plat_pcie_ep_init,
 	.raise_irq = dw_plat_pcie_ep_raise_irq,
+	.get_features = dw_plat_pcie_get_features,
 };
 
 static int dw_plat_add_pcie_port(struct dw_plat_pcie *dw_plat_pcie,
-- 
2.17.1


--BKd9gGIlkVt8ZLfhjn4s
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5600): https://lists.cip-project.org/g/cip-dev/message=
/5600
Mute This Topic: https://lists.cip-project.org/mt/77683512/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BKd9gGIlkVt8ZLfhjn4s--
