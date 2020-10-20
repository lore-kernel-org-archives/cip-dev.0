Return-Path: <SRS0=57pI=D3=lists.cip-project.org=bounce+64572+5597+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE3AC388F7
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24035206DB
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="f/Fyd2Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24035206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5597+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vhqrYY4521723xNCJqeSgHHP; Tue, 20 Oct 2020 07:57:38 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.8062.1603205857220566607
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:37 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60303457"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:35 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 08B65433DEA0;
	Tue, 20 Oct 2020 23:57:33 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 00/26] Fixes and extension to PCIe EPF
Date: Tue, 20 Oct 2020 15:57:06 +0100
Message-Id: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7zMjpZsRrCX0of65m0KJfbcjx4520388AA=
Content-Type: multipart/mixed; boundary="3mzqSWALIJ2n1V1N4WSD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205858;
 bh=aG9xjTv6p0mR2aeO6OkPe2uYzfK3XyuyTOU27oHZ6zA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=f/Fyd2GvokM77R6CmpNk/O7b6EBRdGSReifmTSFeCKFy14e9U4jZznpJyeLVo62UBMD
 IWpGhDMf8yT2TGOH7JfT3V5js6A4bNSeihCee8VR2ykxUG2TJxYQGb/JsrHXZSS2gWFB+
 8Yk4QyxNo4jCt0qiEqm4YN5hQF3fpOIm4Yk=

--3mzqSWALIJ2n1V1N4WSD

Hi All,

This patch series is part of RFC series [1] ("Add PCIe EP support for
Renesas R-Car Gen3 and RZ/G2x"). For making it more cleaner and easier
to review series [1] is split up as suggested by Pavel, patches 1-22,
30, 32, 49, 50  are included in this set from [1].

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=363279

Cheers,
Prabhakar


Alan Mikhak (5):
  PCI: endpoint: Set endpoint controller pointer to NULL
  PCI: endpoint: Allocate enough space for fixed size BAR
  PCI: endpoint: Skip odd BAR when skipping 64bit BAR
  PCI: endpoint: Clear BAR before freeing its space
  PCI: endpoint: Cast the page number to phys_addr_t

Hewenliang (1):
  tools: PCI: Fix fd leakage

Jean-Jacques Hiblot (1):
  tools: PCI: Exit with error code when test fails

Kangjie Lu (1):
  PCI: endpoint: Fix a potential NULL pointer dereference

Kishon Vijay Abraham I (17):
  PCI: endpoint: Add new pci_epc_ops to get EPC features
  PCI: dwc: Add ->get_features() callback function to dw_pcie_ep_ops
  PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
  PCI: pci-dra7xx: Populate ->get_features() dw_pcie_ep_ops
  PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
  PCI: cadence: Populate ->get_features() cdns_pcie_epc_ops
  PCI: endpoint: Add helper to get first unreserved BAR
  PCI: endpoint: Fix pci_epf_alloc_space() to set correct MEM TYPE flags
  PCI: pci-epf-test: Remove setting epf_bar flags in function driver
  PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is
    64Bit
  PCI: pci-epf-test: Use pci_epc_get_features() to get EPC features
  PCI: cadence: Remove pci_epf_linkup() from Cadence EP driver
  PCI: rockchip: Remove pci_epf_linkup() from Rockchip EP driver
  PCI: designware-plat: Remove setting epc->features in Designware plat
    EP driver
  PCI: endpoint: Remove features member in struct pci_epc
  PCI: endpoint: Add support to specify alignment for buffers allocated
    to BARs
  PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table
    address

Kunihiko Hayashi (1):
  PCI: endpoint: Fix clearing start entry in configfs

 drivers/pci/controller/dwc/pci-dra7xx.c       |  13 ++
 .../pci/controller/dwc/pcie-designware-ep.c   |  12 ++
 .../pci/controller/dwc/pcie-designware-plat.c |  17 ++-
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 drivers/pci/controller/pcie-cadence-ep.c      |  25 ++--
 drivers/pci/controller/pcie-rockchip-ep.c     |  16 ++-
 drivers/pci/endpoint/functions/pci-epf-test.c | 134 +++++++++++-------
 drivers/pci/endpoint/pci-ep-cfs.c             |   1 +
 drivers/pci/endpoint/pci-epc-core.c           |  56 +++++++-
 drivers/pci/endpoint/pci-epc-mem.c            |   2 +-
 drivers/pci/endpoint/pci-epf-core.c           |  16 ++-
 include/linux/pci-epc.h                       |  33 +++--
 include/linux/pci-epf.h                       |  18 ++-
 tools/pci/pcitest.c                           |   5 +-
 14 files changed, 263 insertions(+), 86 deletions(-)

-- 
2.17.1


--3mzqSWALIJ2n1V1N4WSD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5597): https://lists.cip-project.org/g/cip-dev/message=
/5597
Mute This Topic: https://lists.cip-project.org/mt/77683509/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3mzqSWALIJ2n1V1N4WSD--
