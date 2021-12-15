Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C308C433FE
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 00:46:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.34461.1639529178199819450
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Dec 2021 16:46:18 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,206,1635174000";
   d="scan'208";a="103952839"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Dec 2021 09:46:15 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2D74541657F4;
	Wed, 15 Dec 2021 09:46:14 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/7] Add binding and SoC identification for Renesas
 RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Date: Wed, 15 Dec 2021 00:46:05 +0000
Message-Id: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Dec 2021 00:46:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7100

Hi All,

This patch series adds initial support for Renesas RZ/G2L SoC [0] and
Renesas RZ/G2L SMARC EVK [1].

The RZ/G2L microprocessor includes a Cortex-A55 (1.2 GHz) CPU, 16-bit
DDR3L/DDR4 interface, 3D graphics engine with Arm Mali-G31 and video codec
(H.264). It also has many interfaces such as camera input, display output,
USB 2.0, and Gbit-Ether, making it ideal for applications such as
entry-class industrial human-machine interfaces (HMIs) and embedded devices
with video capabilities.

Patches add support for the following:
* Documentation for RZ/G2{L,LC,UL} SoC variants
* Documentation for Renesas SMARC EVK
* SYSC binding doc required for SoC identification
* SoC identification support
* Enabling ARCH_R9A07G044 in defconfig

All the patches have been cherry picked from v5.16-rc5

[0] https://www.renesas.com/us/en/products/microcontrollers-microprocessors/
rz-arm-based-high-end-32-64-bit-mpus/rzg2l-general-purpose-microprocessors-dual-
core-arm-cortex-a55-12-ghz-cpus-3d-graphics-and-video-codec
[1] https://www.renesas.com/us/en/products/microcontrollers-microprocessors/
rz-arm-based-high-end-32-64-bit-mpus/rtk9744l23s01000be-rzg2l-evaluation-board-kit

Cheers,
Prabhakar


Lad Prabhakar (7):
  dt-bindings: arm: renesas: Document Renesas RZ/G2UL SoC
  dt-bindings: arm: renesas: Document Renesas RZ/G2{L,LC} SoC variants
  dt-bindings: arm: renesas: Document SMARC EVK
  dt-bindings: power: renesas,rzg2l-sysc: Add DT binding documentation
    for SYSC controller
  soc: renesas: Add ARCH_R9A07G044 for the new RZ/G2L SoC's
  soc: renesas: Add support to read LSI DEVID register of RZ/G2{L,LC}
    SoC's
  arm64: defconfig: Enable ARCH_R9A07G044

 .../devicetree/bindings/arm/renesas.yaml      | 18 ++++++
 .../bindings/power/renesas,rzg2l-sysc.yaml    | 63 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/soc/renesas/Kconfig                   |  5 ++
 drivers/soc/renesas/renesas-soc.c             | 33 +++++++++-
 5 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml

-- 
2.17.1


