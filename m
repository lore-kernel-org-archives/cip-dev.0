Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BE9C7EE23
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:05:22 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.4738.1685963118429121220
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:05:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,217,1681138800"; 
   d="scan'208";a="162244556"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jun 2023 20:05:16 +0900
Received: from localhost.localdomain (unknown [10.226.93.143])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7F3AC41CEAF2;
	Mon,  5 Jun 2023 20:05:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/7] Add SCI support for RZ/G2L alike SoCs
Date: Mon,  5 Jun 2023 12:05:05 +0100
Message-Id: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:05:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11788

This patch series aims to add SCI support for RZ/G2L alike SoCs.
While at it, added DMA fixes for SCIF IP.

All these patches are cherry-picked from the mainline except patch#7 as
we don't have proper DT overlay support in 5.10.

Biju Das (7):
  tty: serial: sh-sci: Fix TE setting on SCI IP
  tty: serial: sh-sci: Add support for tx end interrupt handling
  tty: serial: sh-sci: Fix end of transmission on SCI
  tty: serial: sh-sci: Remove setting {src,dst}_{addr,addr_width} based
    on DMA direction
  tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx support
  tty: serial: sh-sci: Add RZ/G2L SCIFA DMA rx support
  arm64: dts: renesas: rzg2ul-smarc: Enable SCI0

 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  26 ++++
 drivers/tty/serial/sh-sci.c                   | 111 ++++++++++++++----
 drivers/tty/serial/sh-sci.h                   |   3 +
 3 files changed, 117 insertions(+), 23 deletions(-)

-- 
2.25.1


