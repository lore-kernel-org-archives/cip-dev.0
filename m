Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D8AC46CA3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:47:06 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.83957.1701956822418862823
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:47:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189544021"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 22:47:00 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A1F8242B1D1A;
	Thu,  7 Dec 2023 22:46:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/18] Add VSPD/FCPVD support
Date: Thu,  7 Dec 2023 13:46:39 +0000
Message-Id: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:47:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13843

This patch series aims to add VSPD/FCPVD support on
RZ/{G2L,G2LC,V2L} SMARC EVKs.
 
All the patches are cherry-picked from the mainline.

The first patch is to supress build warning with i2c_get_match_data().

Andy Shevchenko (1):
  device property: Add const qualifier to device_get_match_data()
    parameter

Biju Das (10):
  media: renesas: vsp1: Add support to deassert/assert reset line
  media: renesas: vsp1: Add support for VSP software version
  media: renesas: vsp1: Add VSP1_HAS_NON_ZERO_LBA feature bit
  media: dt-bindings: media: renesas,vsp1: Document RZ/G2L VSPD bindings
  media: dt-bindings: media: renesas,vsp1: Document RZ/V2L VSPD bindings
  media: renesas: vsp1: Add support for RZ/G2L VSPD
  arm64: dts: renesas: r9a07g044: Add fcpvd node
  arm64: dts: renesas: r9a07g044: Add vspd node
  arm64: dts: renesas: r9a07g054: Add fcpvd node
  arm64: dts: renesas: r9a07g054: Add vspd node

Cai Huoqing (1):
  media: vsp1: Make use of the helper function
    devm_platform_ioremap_resource()

Kieran Bingham (3):
  media: vsp1: Fix WPF macro names
  media: vsp1: Simplify DRM UIF handling
  media: vsp1: Use BIT macro for feature identification

Lad Prabhakar (1):
  media: vsp1: Use platform_get_irq() to get the interrupt

Mauro Carvalho Chehab (1):
  media: vsp1: use pm_runtime_resume_and_get()

Nikita Yushchenko (1):
  media: vsp1: mask interrupts before enabling

 .../bindings/media/renesas,vsp1.yaml          |  64 ++++++--
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  25 +++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  26 +++
 drivers/base/property.c                       |   4 +-
 drivers/media/platform/vsp1/vsp1.h            |  24 +--
 drivers/media/platform/vsp1/vsp1_drm.c        |   8 +-
 drivers/media/platform/vsp1/vsp1_drv.c        | 153 +++++++++++++-----
 drivers/media/platform/vsp1/vsp1_lif.c        |  12 +-
 drivers/media/platform/vsp1/vsp1_regs.h       |  15 +-
 drivers/media/platform/vsp1/vsp1_wpf.c        |   2 +-
 include/linux/property.h                      |   4 +-
 11 files changed, 252 insertions(+), 85 deletions(-)

-- 
2.25.1


