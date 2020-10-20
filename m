Return-Path: <SRS0=hHH8=D3=lists.cip-project.org=bounce+64572+5610+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3ADC4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD732222C
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="c8XWs0wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD732222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5610+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VS3IYY4521723xDt1xfrlc2z; Tue, 20 Oct 2020 07:57:56 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.7918.1603205873822040734
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:55 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60303492"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:54 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 98982433DEA1;
	Tue, 20 Oct 2020 23:57:53 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 13/26] PCI: rockchip: Remove pci_epf_linkup() from Rockchip EP driver
Date: Tue, 20 Oct 2020 15:57:19 +0100
Message-Id: <20201020145732.30343-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: W9VgmsZ4fQAZMnHWftNpF4aix4520388AA=
Content-Type: multipart/mixed; boundary="TNu8DDensdN1VvhiMI9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205876;
 bh=+SqUh6WJNk/UeaQ4V0/U9KAcyx2pDmT/NhTsJxVyYps=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=c8XWs0waKdPb+ojOvt+Lkc1LRDXGxeitTP0pcaygyQXqtSTSIltWEP8f/+BKm25OdqB
 jopXE1Trn1B0Oemi8whe4Xon5NopWYeeDUek193fWG8sntTeM1/zXp48dqVHhcgMI40Pu
 dMXt+ekSW6E3vte98PlFyQv2XxW44iAVObQ=

--TNu8DDensdN1VvhiMI9g

From: Kishon Vijay Abraham I <kishon@ti.com>

commit f1267978457e77ae7ddabe82ad48cf34f54e96fb upstream.

pci_epf_linkup() is intended to be invoked if the EPC supports linkup
notification. Now that pci-epf-test uses get_features callback, which
indicates Rockchip EP driver doesn't support linkup notification, remove
pci_epf_linkup() from Rockchip EP driver.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index ab6478334101..d743b0a48988 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -499,9 +499,6 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 
 	rockchip_pcie_write(rockchip, cfg, PCIE_CORE_PHY_FUNC_CFG);
 
-	list_for_each_entry(epf, &epc->pci_epf, list)
-		pci_epf_linkup(epf);
-
 	return 0;
 }
 
-- 
2.17.1


--TNu8DDensdN1VvhiMI9g
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5610): https://lists.cip-project.org/g/cip-dev/message=
/5610
Mute This Topic: https://lists.cip-project.org/mt/77683527/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--TNu8DDensdN1VvhiMI9g--
