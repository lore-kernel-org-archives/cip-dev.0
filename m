Return-Path: <SRS0=cdks=D6=lists.cip-project.org=bounce+64572+5658+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0177EC388F9
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED865206BE
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DHGh9YAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED865206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5658+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aiklYY4521723xuYk5YD2LhM; Fri, 23 Oct 2020 09:58:11 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.12445.1603472289888512488
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 09:58:10 -0700
X-IronPort-AV: E=Sophos;i="5.77,409,1596466800"; 
   d="scan'208";a="60634044"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Oct 2020 01:58:08 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 02E40400F935;
	Sat, 24 Oct 2020 01:58:06 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 0/6] Add PCIe EP driver to Renesas R-Car Gen3 and RZ/G2x
Date: Fri, 23 Oct 2020 17:57:59 +0100
Message-Id: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ERleyGHFlKLbwHD9cMUpqmKnx4520388AA=
Content-Type: multipart/mixed; boundary="763yS4IUShewm8Nx7WfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603472291;
 bh=uyXyBYbqf8CHHHUuu003mPvmgcg/bdIPkADQ6GBfRIg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DHGh9YAQOKAss+zU1jvaAEzRV4YI9e531N6C4dY2AAdknsqvd6kDR9H6h8dE3Y2JMDW
 O4TS0/iLA40IxRQTJPh2ozyWl4vWOd/epMMXhmkJtf8Ym2k8XTNYYIYQtaGijtpsdvcxJ
 Q/BGElE9O7adNbp5VYeLUR8ZkbHwWhrqiVk=

--763yS4IUShewm8Nx7WfS

Hi All,

This patch series is part of RFC series [1] ("Add PCIe EP support for
Renesas R-Car Gen3 and RZ/G2x").

* Patches 38-42 and 47 from the RFC are included in this series.
* Patch 1/6 (== 38/50) now have changes to pcie-rcar-host.c driver which
  were dropped earlier in RFC series as per suggestion from Pavel.
* Rest of the patches are unchanged
* I have dropped patches 43-46 and 48 from the RFC series and will re-send
  them once it hits the -rc (currently they are present in -next)

[1] https://patchwork.kernel.org/project/cip-dev/list/
    ?series=363279&archive=both&state=*

Cheers,
Prabhakar

Lad Prabhakar (6):
  PCI: rcar: Move shareable code to a common file
  PCI: rcar: Fix calculating mask for PCIEPAMR register
  dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
    controller
  PCI: rcar: Add endpoint mode support
  arm64: defconfig: Enable R-Car PCIe endpoint driver
  misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller

 .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  77 +++
 arch/arm64/configs/defconfig                  |   5 +
 drivers/misc/pci_endpoint_test.c              |   4 +
 drivers/pci/controller/Kconfig                |   8 +
 drivers/pci/controller/Makefile               |   3 +-
 drivers/pci/controller/pcie-rcar-ep.c         | 563 ++++++++++++++++++
 drivers/pci/controller/pcie-rcar-host.c       | 373 +++---------
 drivers/pci/controller/pcie-rcar.c            | 120 ++++
 drivers/pci/controller/pcie-rcar.h            | 140 +++++
 9 files changed, 1014 insertions(+), 279 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
 create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
 create mode 100644 drivers/pci/controller/pcie-rcar.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

-- 
2.17.1


--763yS4IUShewm8Nx7WfS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5658): https://lists.cip-project.org/g/cip-dev/message=
/5658
Mute This Topic: https://lists.cip-project.org/mt/77756292/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--763yS4IUShewm8Nx7WfS--
