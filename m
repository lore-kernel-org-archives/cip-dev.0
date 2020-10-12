Return-Path: <SRS0=1ZBW=DT=lists.cip-project.org=bounce+64572+5520+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F145C433E7
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:23 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B85920838
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PzjNiq8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B85920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5520+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bTy1YY4521723xCC8UvZTKzo; Mon, 12 Oct 2020 07:20:21 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.41774.1602512378241754205
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:19:38 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351880"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:19:36 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 23CB142A7637;
	Mon, 12 Oct 2020 23:19:34 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Date: Mon, 12 Oct 2020 15:18:43 +0100
Message-Id: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AX0hdMLxANBGjl6qx1n6tOjfx4520388AA=
Content-Type: multipart/mixed; boundary="JcPulk3IPOOqaDPvoX0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512421;
 bh=JFWSYZISq+K8q5d08WG5r5c/HVWTmRdtobuqjTfl1QQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PzjNiq8yEb6zHncJ6SgVVnDbN1DoJ1ZjzOY11jGuFZyC2klJBjIGwajkC4okr8XFqb2
 GyisSsMaYTQ4amHPSkR5P9ovy2f9ett4Rcu6inP6JRvVaFhfEmMhq+K6M9YPAYGADNMFL
 dS1SyvjKTd4B8aWoAUMfR6e06JHnFhpTY8s=

--JcPulk3IPOOqaDPvoX0X

Hi All,

This patch series adds support for PCIe EP on Renesas R-Car Gen3 and
RZ/G2x platforms.

* Required EP framework changes and fixes are ported as well.
* All the patches have been cheery picked from upstream kernel.
* Patches [43, 44, 45, 46, 48]/50 are picked from linux-next.
* I was skeptic with patch 36/50 "Rename pcie-rcar.c to pcie-rcar-host.c"
  this is required as patch 38/50 adds a new file named pcie-rcar.c. Open
  for suggestions if this can be handled differently.
* In patch 37/48 I have dropped the changes for host driver as the patch
  doesn't apply cleanly and manually applying it was resulting in a big diff.
* As the changes touches three other controller drivers I have build tested them
  as done similarly while upstreaming R-Car Gen3 PCIe EP driver.
* Since the changes are huge I am sending the patches as RFC.

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

Kishon Vijay Abraham I (23):
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
  PCI: endpoint: Use notification chain mechanism to notify EPC events
    to EPF
  PCI: endpoint: Replace spinlock with mutex
  PCI: endpoint: Protect concurrent access to pci_epf_ops with mutex
  PCI: endpoint: Assign function number for each PF in EPC core
  PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments
  PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table
    address
  PCI: endpoint: functions/pci-epf-test: Print throughput information

Kunihiko Hayashi (1):
  PCI: endpoint: Fix clearing start entry in configfs

Lad Prabhakar (15):
  PCI: endpoint: Pass page size as argument to pci_epc_mem_init()
  PCI: endpoint: Add support to handle multiple base for mapping
    outbound memory
  PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
  arm64: defconfig: Enable CONFIG_PCIE_RCAR_HOST
  PCI: rcar: Move shareable code to a common file
  PCI: rcar: Fix calculating mask for PCIEPAMR register
  dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
    controller
  PCI: rcar: Add endpoint mode support
  arm64: defconfig: Enable R-Car PCIe endpoint driver
  dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and r8a774b1
  arm64: dts: renesas: r8a774c0: Add PCIe EP node
  arm64: dts: renesas: r8a774a1: Add PCIe EP nodes
  arm64: dts: renesas: r8a774b1: Add PCIe EP nodes
  misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller
  misc: pci_endpoint_test: Add Device ID for RZ/G2M and RZ/G2N PCIe
    controllers

Vidya Sagar (3):
  PCI: endpoint: Add core init notifying feature
  PCI: endpoint: Add notification for core init completion
  PCI: pci-epf-test: Add support to defer core initialization

 .../devicetree/bindings/pci/rcar-pci-ep.yaml  |   80 ++
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi     |   38 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi     |   38 +
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi     |   19 +
 arch/arm64/configs/defconfig                  |    7 +-
 drivers/misc/pci_endpoint_test.c              |    7 +
 drivers/pci/controller/Kconfig                |   18 +
 drivers/pci/controller/Makefile               |    3 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   13 +
 .../pci/controller/dwc/pcie-designware-ep.c   |   39 +-
 .../pci/controller/dwc/pcie-designware-plat.c |   17 +-
 drivers/pci/controller/dwc/pcie-designware.h  |    1 +
 drivers/pci/controller/pcie-cadence-ep.c      |   27 +-
 drivers/pci/controller/pcie-rcar-ep.c         |  563 ++++++++
 drivers/pci/controller/pcie-rcar-host.c       | 1264 +++++++++++++++++
 drivers/pci/controller/pcie-rcar.c            | 1224 +---------------
 drivers/pci/controller/pcie-rcar.h            |  140 ++
 drivers/pci/controller/pcie-rockchip-ep.c     |   18 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  295 +++-
 drivers/pci/endpoint/pci-ep-cfs.c             |   28 +-
 drivers/pci/endpoint/pci-epc-core.c           |  187 ++-
 drivers/pci/endpoint/pci-epc-mem.c            |  204 ++-
 drivers/pci/endpoint/pci-epf-core.c           |   49 +-
 include/linux/pci-epc.h                       |   95 +-
 include/linux/pci-epf.h                       |   32 +-
 tools/pci/pcitest.c                           |    5 +-
 26 files changed, 2919 insertions(+), 1492 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
 create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
 create mode 100644 drivers/pci/controller/pcie-rcar-host.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

-- 
2.17.1


--JcPulk3IPOOqaDPvoX0X
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5520): https://lists.cip-project.org/g/cip-dev/message=
/5520
Mute This Topic: https://lists.cip-project.org/mt/77461654/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--JcPulk3IPOOqaDPvoX0X--
