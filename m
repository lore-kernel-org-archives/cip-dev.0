Return-Path: <SRS0=xq/P=D3=lists.cip-project.org=bounce+64572+5599+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D7AC388F9
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CBA21D7B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="A7QoKj2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CBA21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5599+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HqgJYY4521723xyJKMUA2Gnj; Tue, 20 Oct 2020 07:57:39 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.8062.1603205857220566607
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:38 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60303464"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:38 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 05CBA433DEA1;
	Tue, 20 Oct 2020 23:57:36 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 02/26] PCI: dwc: Add ->get_features() callback function to dw_pcie_ep_ops
Date: Tue, 20 Oct 2020 15:57:08 +0100
Message-Id: <20201020145732.30343-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: YrxvRmjzcLhDCK0X9QuhpWUQx4520388AA=
Content-Type: multipart/mixed; boundary="oBPBk2X6Nkdm6TP08RFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205859;
 bh=oIee2Ti2oKJGPpp/nbtuq+avpNWhLRb/hji14jlOPho=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=A7QoKj2nOCFDQgkUitidQFm4Lbnr7/2zgR6ximsHv/kbHrStM6Vm4oBK8ep2euRS35S
 4Qv3O4zmeju0nHUx5euu9GP0nWmvkUr4K6USE595mGpMhovQMZJB/cZsEc2IBoN2gebPQ
 AXvWnzKBBdB3jyZ885B9qxvQ2ZTuFGBwZB0=

--oBPBk2X6Nkdm6TP08RFx

From: Kishon Vijay Abraham I <kishon@ti.com>

commit fee35cb76a54c87985410ea6aa12002e5d38b367 upstream.

Each platform using Designware PCIe core can support different set of
endpoint features. Add a new callback function ->get_features() in
dw_pcie_ep_ops so that each platform using Designware PCIe core can
advertise its supported features to the endpoint function driver.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index a3d07d9c598b..d1bb4b852b6c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -355,6 +355,17 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 	return pci->ops->start_link(pci);
 }
 
+static const struct pci_epc_features*
+dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+
+	if (!ep->ops->get_features)
+		return NULL;
+
+	return ep->ops->get_features(ep);
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -368,6 +379,7 @@ static const struct pci_epc_ops epc_ops = {
 	.raise_irq		= dw_pcie_ep_raise_irq,
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
+	.get_features		= dw_pcie_ep_get_features,
 };
 
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 14dcf6646699..90f978f2d1b0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -181,6 +181,7 @@ struct dw_pcie_ep_ops {
 	void	(*ep_init)(struct dw_pcie_ep *ep);
 	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
 			     enum pci_epc_irq_type type, u16 interrupt_num);
+	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
 };
 
 struct dw_pcie_ep {
-- 
2.17.1


--oBPBk2X6Nkdm6TP08RFx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5599): https://lists.cip-project.org/g/cip-dev/message=
/5599
Mute This Topic: https://lists.cip-project.org/mt/77683511/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--oBPBk2X6Nkdm6TP08RFx--
