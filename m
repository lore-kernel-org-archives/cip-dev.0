Return-Path: <SRS0=icsN=D3=lists.cip-project.org=bounce+64572+5601+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344A7C4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:51 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71921206DB
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BVHs78xY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71921206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5601+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id oRD9YY4521723xZzF7M0FFgi; Tue, 20 Oct 2020 07:57:50 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.8062.1603205857220566607
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:41 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60303471"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:41 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 04000433DEA0;
	Tue, 20 Oct 2020 23:57:39 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 04/26] PCI: pci-dra7xx: Populate ->get_features() dw_pcie_ep_ops
Date: Tue, 20 Oct 2020 15:57:10 +0100
Message-Id: <20201020145732.30343-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xyKKc9wku58aTvWPHM4xeTKAx4520388AA=
Content-Type: multipart/mixed; boundary="zn9shJYL9H5PAATZqKrN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205870;
 bh=MH/lyTdhdifZIO9VFwYa7SlcSYiJMtrqsQ55HZR6ALs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BVHs78xY0rEaCgF24K7TWplNQBLmr9ysesS3qQYpICtbIdVkrjaYA2cjxfcWS2dq8rX
 nLtq7EIfLUlykXhki9h6RWCnDOWNR7Qff7FZJE2O0tyrdUN4QHbgO/1mt67vw9gIkgrsH
 +8I0RCPIfyKK825o14soaY5fvQSCSKt1vCY=

--zn9shJYL9H5PAATZqKrN

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 4894467e78619232a79e39c2f26ae8378c4500ed upstream.

Populate ->get_features() dw_pcie_ep_ops to return the EPC features
supported by DRA7xx PCIe endpoint controller.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 412524aa1fde..49417092f5e3 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -390,9 +390,22 @@ static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+static const struct pci_epc_features dra7xx_pcie_epc_features = {
+	.linkup_notifier = true,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features*
+dra7xx_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &dra7xx_pcie_epc_features;
+}
+
 static struct dw_pcie_ep_ops pcie_ep_ops = {
 	.ep_init = dra7xx_pcie_ep_init,
 	.raise_irq = dra7xx_pcie_raise_irq,
+	.get_features = dra7xx_pcie_get_features,
 };
 
 static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
-- 
2.17.1


--zn9shJYL9H5PAATZqKrN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5601): https://lists.cip-project.org/g/cip-dev/message=
/5601
Mute This Topic: https://lists.cip-project.org/mt/77683514/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zn9shJYL9H5PAATZqKrN--
