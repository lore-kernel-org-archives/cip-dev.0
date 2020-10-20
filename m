Return-Path: <SRS0=njFz=D3=lists.cip-project.org=bounce+64572+5603+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B124C4363D
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8E5206DB
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WnayFU7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8E5206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5603+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FVirYY4521723xcnOtjvg029; Tue, 20 Oct 2020 07:57:50 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.8062.1603205857220566607
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:44 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60303478"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:44 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 01A42433DEA0;
	Tue, 20 Oct 2020 23:57:42 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 06/26] PCI: cadence: Populate ->get_features() cdns_pcie_epc_ops
Date: Tue, 20 Oct 2020 15:57:12 +0100
Message-Id: <20201020145732.30343-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NooZWWCw264yICzvUXN850QMx4520388AA=
Content-Type: multipart/mixed; boundary="jehTBmAMpBpXNenE75ej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205870;
 bh=HL85Mgra19qReOtW3kGi9/GGt4ZuRU7wfmGQkJfOfTo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WnayFU7rDoVfumdXbvdTd69Xysv/6nMgr04/3l43xsCrZV0lk4bKgXvWO97+EaE/OsD
 Mi4YDqnd+30Uq9HGRPQp4oOAVJQpVIs2X/+W4ZFRr9o+vL06t0cpAc+DFAcwnAbtaihPD
 H+ZTkbWN3lZ6IcdeeRMq/ZAlUWintBDt4nA=

--jehTBmAMpBpXNenE75ej

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 67c777e6015d857a5e9662c68281d83d946d9b70 upstream.

Populate ->get_features() dw_pcie_ep_ops to return the EPC features
supported by Cadence PCIe endpoint controller.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index c3a088910f48..14c2545bb17e 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -411,6 +411,18 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	return 0;
 }
 
+static const struct pci_epc_features cdns_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features*
+cdns_pcie_ep_get_features(struct pci_epc *epc, u8 func_no)
+{
+	return &cdns_pcie_epc_features;
+}
+
 static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.write_header	= cdns_pcie_ep_write_header,
 	.set_bar	= cdns_pcie_ep_set_bar,
@@ -421,6 +433,7 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.get_msi	= cdns_pcie_ep_get_msi,
 	.raise_irq	= cdns_pcie_ep_raise_irq,
 	.start		= cdns_pcie_ep_start,
+	.get_features	= cdns_pcie_ep_get_features,
 };
 
 static const struct of_device_id cdns_pcie_ep_of_match[] = {
-- 
2.17.1


--jehTBmAMpBpXNenE75ej
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5603): https://lists.cip-project.org/g/cip-dev/message=
/5603
Mute This Topic: https://lists.cip-project.org/mt/77683518/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jehTBmAMpBpXNenE75ej--
