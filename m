Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F40C7EE29
	for <webhook@archiver.kernel.org>; Tue, 13 Jun 2023 13:23:46 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.13015.1686662624922985808
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Jun 2023 06:23:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,239,1681138800"; 
   d="scan'208";a="163405926"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Jun 2023 22:23:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2CF43426DCD0;
	Tue, 13 Jun 2023 22:23:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 0/7] RZ/V2M UART FIFO support
Date: Tue, 13 Jun 2023 14:23:32 +0100
Message-Id: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Jun 2023 13:23:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11980

This patch series aims to add UART fifo support for RZ/V2M EVK.

All these patches are cherry-picked from the mainline.

Biju Das (7):
  serial: 8250_em: Simplify probe()
  serial: 8250_em: Drop unused header file
  serial: 8250_em: Add missing break statement
  serial: 8250_em: Use devm_clk_get_enabled()
  serial: 8250_em: Use pseudo offset for UART_FCR
  serial: 8250_em: Add serial8250_em_{reg_update(),out_helper()}
  arm64: dts: renesas: rzv2mevk2: Add uart0 pins

 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |  11 ++
 drivers/tty/serial/8250/8250_em.c             | 113 ++++++++++++++----
 2 files changed, 101 insertions(+), 23 deletions(-)

-- 
2.25.1


