Return-Path: <SRS0=FltQ=DT=lists.cip-project.org=bounce+64572+5525+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130ABC4363D
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7643A2076E
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CBi72gcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7643A2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5525+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id A8KiYY4521723xZNMrDW8EyD; Mon, 12 Oct 2020 07:20:24 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.41774.1602512378241754205
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:19:44 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351891"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:19:43 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8B1C542A7637;
	Mon, 12 Oct 2020 23:19:42 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 05/50] PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
Date: Mon, 12 Oct 2020 15:18:48 +0100
Message-Id: <20201012141933.9652-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: y9cgC8mAJ3IYcEu06mIzLUPux4520388AA=
Content-Type: multipart/mixed; boundary="mYyCDvwZkXaR01XJpTFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512424;
 bh=7qP7Gwn/fh+u8hmxId0reFfPMis2GJNWnd4R8K/7LNw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=CBi72gcgOUZLXQVsaneOaIt8d/6+oN2i5ogI1fLo1DvhBfHmIGL/kPdqqzPHvO8cKa1
 sHCNtT2uADjbyCAlky+jUFQBRNwQVhuvpvNao90PPrjZhc2CAhulqwEAVxuvr/bN0lNTC
 yItnJmwYKHJaRI15u+xwiIJgdv75FEyY+sI=

--mYyCDvwZkXaR01XJpTFo

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


--mYyCDvwZkXaR01XJpTFo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5525): https://lists.cip-project.org/g/cip-dev/message=
/5525
Mute This Topic: https://lists.cip-project.org/mt/77461660/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mYyCDvwZkXaR01XJpTFo--
