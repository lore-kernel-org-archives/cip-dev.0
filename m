Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED55C27C75
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 10:45:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5304.1718275499259771666
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 03:44:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="scan'208";a="207786193"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Jun 2024 19:44:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.168])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2B1D142D2364;
	Thu, 13 Jun 2024 19:44:54 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/7] Fix USBHS pipe configuration
Date: Thu, 13 Jun 2024 11:44:46 +0100
Message-Id: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 10:45:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16202

The USBHS IP found on RZ/G2L SoCs only has 10 pipe buffers compared to 16
pipe buffers on RZ/A2M.

Fix the USBHS Pipe configuration

All the patches are cherry-picked from the mainline.

Biju Das (6):
  dt-bindings: usb: renesas,usbhs: Document RZ/G2L family compatible
  usb: renesas_usbhs: Simplify obtaining device data
  usb: renesas_usbhs: Improve usbhsc_default_pipe[] for isochronous
    transfers
  usb: renesas_usbhs: Update usbhs pipe configuration for RZ/G2L family
  usb: renesas_usbhs: Remove trailing comma in the terminator entry for
    OF table
  arm64: dts: renesas: r9a07g0{43,44,54}: Update RZ/G2L family
    compatible

Lad Prabhakar (1):
  dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC

 .../bindings/usb/renesas,usbhs.yaml           |  8 +++-
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |  2 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  2 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  2 +-
 drivers/usb/renesas_usbhs/common.c            | 41 ++++++++++++-------
 drivers/usb/renesas_usbhs/rza.h               |  1 +
 drivers/usb/renesas_usbhs/rza2.c              | 13 ++++++
 7 files changed, 49 insertions(+), 20 deletions(-)

-- 
2.25.1


