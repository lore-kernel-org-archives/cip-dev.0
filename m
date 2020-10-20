Return-Path: <SRS0=cQOh=D3=lists.cip-project.org=bounce+64572+5611+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7BBC4363D
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862B52222C
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pRdGaKoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862B52222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5611+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NSbpYY4521723xFdWr0u7VVB; Tue, 20 Oct 2020 07:57:57 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.7918.1603205873822040734
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:56 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60303495"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:56 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 20788433DEA2;
	Tue, 20 Oct 2020 23:57:54 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 14/26] PCI: designware-plat: Remove setting epc->features in Designware plat EP driver
Date: Tue, 20 Oct 2020 15:57:20 +0100
Message-Id: <20201020145732.30343-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pdHMIuUKh0BXoHGs08BWuecCx4520388AA=
Content-Type: multipart/mixed; boundary="7juXSgBGCzMz8iSLQpUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205877;
 bh=39yDlEPuGuwunhK1rHcJLjbSitXhsU0oOgDk/e3Up8c=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pRdGaKoyc+SRgoLzPN61tutNPZ0AyVq7vcbP52rYf9QNJu89I5fjP625cwAByEzuQWp
 Mm3MsOwBV519v7IqOuO6DXx2aVCaKKMZaOltKmZ+HHAx+/trAEVGwDZJW+aYF7G1LfnSv
 tgmeTi2iFWAVGNpUqTCQo2ttbo1KFG/bjoI=

--7juXSgBGCzMz8iSLQpUb

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 92f2b028418c6f59f92703eed111136ca0d22c39 upstream.

Now that pci-epf-test uses get_features callback and
dw_plat_pcie_epc_features in Designware plat EP driver already indicates
it doesn't support linkup notification and is MSIX capable, remove setting
epc->features which is not used anymore by the endpoint function driver.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index bd0516afc86f..3be87126aef3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -70,14 +70,10 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	struct pci_epc *epc = ep->epc;
 	enum pci_barno bar;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
-
-	epc->features |= EPC_FEATURE_NO_LINKUP_NOTIFIER;
-	epc->features |= EPC_FEATURE_MSIX_AVAILABLE;
 }
 
 static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
-- 
2.17.1


--7juXSgBGCzMz8iSLQpUb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5611): https://lists.cip-project.org/g/cip-dev/message=
/5611
Mute This Topic: https://lists.cip-project.org/mt/77683528/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7juXSgBGCzMz8iSLQpUb--
