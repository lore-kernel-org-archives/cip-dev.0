Return-Path: <SRS0=rWRV=D5=lists.cip-project.org=bounce+64572+5640+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB26C4363A
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE062419B
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WQGECT7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE062419B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5640+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id s7s8YY4521723xRbl2UnCmTC; Thu, 22 Oct 2020 03:16:19 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.8475.1603361778321978533
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 03:16:18 -0700
X-IronPort-AV: E=Sophos;i="5.77,404,1596466800"; 
   d="scan'208";a="60507847"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Oct 2020 19:16:16 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6B0A74002C32;
	Thu, 22 Oct 2020 19:16:15 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 00/13] Enhancements to PCIe EPF
Date: Thu, 22 Oct 2020 11:16:01 +0100
Message-Id: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LeJdm4Igw530Ygs9lBH2KyHyx4520388AA=
Content-Type: multipart/mixed; boundary="DMDXpvlWPdXdmDzXOGGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603361779;
 bh=5P4Pg0u282vGVFGQsqToUxmvsq2JROGoK7J1++6AGfw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WQGECT7K8iAndrozEMG9rzp8mYxOG79W4/Kh3YkO4nPQXuqhHFlRxSasHfsW6aU9xx9
 eWYB6i062rRXj8FO70gcvVm5w8wKr0mEeWnvO4SD04whYmk5DR6BLK205PYpA5OZHO9yb
 mT0+I4VUxIUJAnjGFQhNYNSOLPJPoyx36Qk=

--DMDXpvlWPdXdmDzXOGGX

Hi All,

This patch series is part of RFC series [1] ("Add PCIe EP support for
Renesas R-Car Gen3 and RZ/G2x"). For making it more cleaner and easier
to review series [1] is split up as suggested by Pavel, patches 23-29,
31, 33-37 are included in this set from [1].

This adds following features to EPF
* Deferred core initialization
* Support for notification after core init
* Replace spinlock with mutex
* Support to handle multiple base for mapping outbound memory

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=363279&state=*

Cheers,
Prabhakar


Kishon Vijay Abraham I (6):
  PCI: endpoint: Use notification chain mechanism to notify EPC events
    to EPF
  PCI: endpoint: Replace spinlock with mutex
  PCI: endpoint: Protect concurrent access to pci_epf_ops with mutex
  PCI: endpoint: Assign function number for each PF in EPC core
  PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments
  PCI: endpoint: functions/pci-epf-test: Print throughput information

Lad Prabhakar (4):
  PCI: endpoint: Pass page size as argument to pci_epc_mem_init()
  PCI: endpoint: Add support to handle multiple base for mapping
    outbound memory
  PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
  arm64: defconfig: Enable CONFIG_PCIE_RCAR_HOST

Vidya Sagar (3):
  PCI: endpoint: Add core init notifying feature
  PCI: endpoint: Add notification for core init completion
  PCI: pci-epf-test: Add support to defer core initialization

 arch/arm64/configs/defconfig                  |   2 +-
 drivers/pci/controller/Kconfig                |  10 +
 drivers/pci/controller/Makefile               |   2 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  27 ++-
 drivers/pci/controller/pcie-cadence-ep.c      |   2 +-
 .../{pcie-rcar.c => pcie-rcar-host.c}         |   0
 drivers/pci/controller/pcie-rockchip-ep.c     |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 195 +++++++++++++----
 drivers/pci/endpoint/pci-ep-cfs.c             |  27 +--
 drivers/pci/endpoint/pci-epc-core.c           | 137 ++++++------
 drivers/pci/endpoint/pci-epc-mem.c            | 204 ++++++++++++------
 drivers/pci/endpoint/pci-epf-core.c           |  33 +--
 include/linux/pci-epc.h                       |  62 ++++--
 include/linux/pci-epf.h                       |  14 +-
 14 files changed, 474 insertions(+), 243 deletions(-)
 rename drivers/pci/controller/{pcie-rcar.c => pcie-rcar-host.c} (100%)

-- 
2.17.1


--DMDXpvlWPdXdmDzXOGGX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5640): https://lists.cip-project.org/g/cip-dev/message=
/5640
Mute This Topic: https://lists.cip-project.org/mt/77727245/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DMDXpvlWPdXdmDzXOGGX--
