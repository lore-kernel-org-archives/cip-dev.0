Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AEBC48292
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 10:32:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.19874.1706869926439663776
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 02:32:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,237,1701097200"; 
   d="scan'208";a="196564128"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Feb 2024 19:32:03 +0900
Received: from localhost.localdomain (unknown [10.226.93.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1F84B41EE375;
	Fri,  2 Feb 2024 19:32:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4.19.y-cip 0/2] Drop undocumented register definitions
Date: Fri,  2 Feb 2024 10:31:58 +0000
Message-Id: <20240202103200.171406-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 10:32:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14609

This patch series aims to remove undocumented register definitions on the
ethernet driver (ravb.h) in 4.19 cip kernel.

All the patches are cherry-picked from the mainline.

Sergey Shtylyov (1):
  ravb: update "undocumented" annotations

Simon Horman (1):
  ravb: remove undocumented endianness selection

 drivers/net/ethernet/renesas/ravb.h      | 27 ++++++++++++------------
 drivers/net/ethernet/renesas/ravb_main.c |  6 ------
 2 files changed, 13 insertions(+), 20 deletions(-)

-- 
2.25.1


