Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15576C54E60
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 19:30:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1786.1710444594971668504
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 12:29:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.07,126,1708354800"; 
   d="scan'208";a="197762389"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Mar 2024 04:29:52 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 718694001B5F;
	Fri, 15 Mar 2024 04:29:51 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 4.19.y-cip 0/9] Add RPC-IF support for RZ/G2{EHMN}
Date: Thu, 14 Mar 2024 19:29:41 +0000
Message-Id: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 19:30:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15308

Hi All,

This patch series adds RPC-IF support for RZ/G2{EHMN} SoCs. Note by
default the RPC-IF is not enabled on the boards as the hyperflash is
locked by TF-A. To unlock the hyperflash one must build TF-A with
"RCAR_RPC_HYPERFLASH_LOCKED=0" flag and enable it in the board DTS.

Note: All the patches have been cherry picked from upstream kernel.

Cheers,
Prabhakar

Adam Ford (1):
  arm64: dts: renesas: rzg2: Add RPC-IF Support

Cong Dang (1):
  memory: renesas-rpc-if: Remove redundant division of dummy

Geert Uytterhoeven (2):
  memory: renesas-rpc-if: Fix HF/OSPI data transfer in Manual Mode
  memory: renesas-rpc-if: Simplify single/double data register access

Krzysztof Kozlowski (1):
  memory: renesas-rpc-if: fix possible NULL pointer dereference of
    resource

Lad Prabhakar (3):
  memory: renesas-rpc-if: Return error in case devm_ioremap_resource()
    fails
  memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
  spi: spi-rpc-if: Check return value of rpcif_sw_init()

Wolfram Sang (1):
  memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi |  17 +++
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi |  17 +++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi |  17 +++
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi |  17 +++
 drivers/memory/renesas-rpc-if.c           | 174 +++++++++++++++-------
 drivers/spi/spi-rpc-if.c                  |   4 +-
 include/memory/renesas-rpc-if.h           |   2 +
 7 files changed, 190 insertions(+), 58 deletions(-)

-- 
2.34.1


