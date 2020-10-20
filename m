Return-Path: <SRS0=HZm8=D3=lists.cip-project.org=bounce+64572+5602+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8780EC388F7
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:51 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE5F21741
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jLaiGhFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE5F21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5602+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Xmx1YY4521723x3Bp6znkxFe; Tue, 20 Oct 2020 07:57:50 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.8061.1603205857454945281
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:43 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60088179"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:42 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7CE7D433DEA0;
	Tue, 20 Oct 2020 23:57:41 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 05/26] PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
Date: Tue, 20 Oct 2020 15:57:11 +0100
Message-Id: <20201020145732.30343-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BSQ0ofWn2IRK3q7IdGKoRj8Hx4520388AA=
Content-Type: multipart/mixed; boundary="swSuwkppkUSA2upg3ZyA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205870;
 bh=hLRLGhvkHkoRokLs7grtNYvxzPYyyE7Lh3w4hhF5tiI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jLaiGhFif/Pye2yBtdl1R49CiCQoJkpyJRd817RSbHViH56QG+SRDCU1/4+DuTdHRSw
 3My6R3Qvu+x9bhUo1MSJbdy59ekco6Yjsb+ZRrRxF7hevAh4CgkoDFEljKfo7UxAac4Yb
 5oPTFpw7mr542LpuGDJmEKt3Jg+WCt7EcA8=

--swSuwkppkUSA2upg3ZyA

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 146221768c74bbd969f968b61ec95a0254a6b311 upstream.

Populate ->get_features() dw_pcie_ep_ops to return the EPC features
supported by Rockchip PCIe endpoint controller.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index caf34661d38d..ab6478334101 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -505,6 +505,18 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 	return 0;
 }
 
+static const struct pci_epc_features rockchip_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features*
+rockchip_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+{
+	return &rockchip_pcie_epc_features;
+}
+
 static const struct pci_epc_ops rockchip_pcie_epc_ops = {
 	.write_header	= rockchip_pcie_ep_write_header,
 	.set_bar	= rockchip_pcie_ep_set_bar,
@@ -515,6 +527,7 @@ static const struct pci_epc_ops rockchip_pcie_epc_ops = {
 	.get_msi	= rockchip_pcie_ep_get_msi,
 	.raise_irq	= rockchip_pcie_ep_raise_irq,
 	.start		= rockchip_pcie_ep_start,
+	.get_features	= rockchip_pcie_ep_get_features,
 };
 
 static int rockchip_pcie_parse_ep_dt(struct rockchip_pcie *rockchip,
-- 
2.17.1


--swSuwkppkUSA2upg3ZyA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5602): https://lists.cip-project.org/g/cip-dev/message=
/5602
Mute This Topic: https://lists.cip-project.org/mt/77683517/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--swSuwkppkUSA2upg3ZyA--
