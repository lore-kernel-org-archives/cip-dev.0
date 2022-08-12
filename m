Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712CCC25B0E
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 10:13:25 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.9010.1660299202401056416
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 03:13:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,231,1654527600";
   d="scan'208";a="129340318"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Aug 2022 19:13:20 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id ED483424396E;
	Fri, 12 Aug 2022 19:13:18 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/11] Renesas RPCI-IF and RSPI driver fixes and
 improvements
Date: Fri, 12 Aug 2022 11:13:06 +0100
Message-Id: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 10:13:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9172

Hi All,

This patch series backports RPCI-IF and RSPI driver fixes and
improvements.

Note: All the patches have been cherry picked from v5.19 kernel.

Cheers,
Prabhakar

Biju Das (1):
  spi: spi-rspi: Fix PIO fallback on RZ platforms

Geert Uytterhoeven (2):
  memory: renesas-rpc-if: Simplify single/double data register access
  spi: rpc-if: Fix RPM imbalance in probe error path

Krzysztof Kozlowski (2):
  memory: renesas-rpc-if: simplify platform_get_resource_byname()
  spi: rspi: drop unneeded MODULE_ALIAS

Lad Prabhakar (2):
  memory: renesas-rpc-if: Silence clang warning
  spi: spi-rspi: Drop redeclaring ret variable in qspi_transfer_in()

Wolfram Sang (4):
  memory: renesas-rpc-if: simplify register update
  memory: renesas-rpc-if: avoid use of undocumented bits
  memory: renesas-rpc-if: refactor MOIIO and IOFV macros
  spi: spi-rspi: : use proper DMAENGINE API for termination

 drivers/memory/renesas-rpc-if.c | 104 +++++++++++---------------------
 drivers/spi/spi-rpc-if.c        |   8 ++-
 drivers/spi/spi-rspi.c          |  13 ++--
 3 files changed, 49 insertions(+), 76 deletions(-)

-- 
2.17.1


