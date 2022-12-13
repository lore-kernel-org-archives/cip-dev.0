Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EC5C4332F
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 17:23:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.80092.1670952202674313393
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 09:23:23 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.96,242,1665414000"; 
   d="scan'208";a="146043455"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Dec 2022 02:23:20 +0900
Received: from localhost.localdomain (unknown [10.226.93.72])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4FD034053D05;
	Wed, 14 Dec 2022 02:23:18 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/7] CANFD Improvement
Date: Tue, 13 Dec 2022 17:23:09 +0000
Message-Id: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 17:23:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10221

This patch series aims to fix IRQ storm issue as well as
some enhancements to Renesas CANFD driver.

Biju Das (6):
  can: rcar_canfd: rcar_canfd_handle_global_receive(): fix IRQ storm on
    global FIFO receive
  can: rcar_canfd: Use devm_reset_control_get_optional_exclusive
  can: rcar_canfd: rcar_canfd_probe: Add struct rcar_canfd_hw_info to
    driver data
  can: rcar_canfd: Add shared_global_irqs to struct rcar_canfd_hw_info
  can: rcar_canfd: Add postdiv to struct rcar_canfd_hw_info
  can: rcar_canfd: Add multi_channel_irqs to struct rcar_canfd_hw_info

Geert Uytterhoeven (1):
  can: rcar_canfd: Add missing ECC error checks for channels 2-7

 drivers/net/can/rcar/rcar_canfd.c | 92 +++++++++++++++++--------------
 1 file changed, 51 insertions(+), 41 deletions(-)

-- 
2.25.1


