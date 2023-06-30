Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1169EB64DA
	for <webhook@archiver.kernel.org>; Fri, 30 Jun 2023 15:53:58 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.16139.1688140437361711337
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Jun 2023 08:53:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,171,1684767600"; 
   d="scan'208";a="166244272"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Jul 2023 00:53:55 +0900
Received: from localhost.localdomain (unknown [10.226.93.15])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3BF0C400D4BA;
	Sat,  1 Jul 2023 00:53:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 0/3] RZ/V2M I2C driver improvements
Date: Fri, 30 Jun 2023 16:53:49 +0100
Message-Id: <20230630155352.584589-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Jun 2023 15:53:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12167

This patch series aims to improve RZ/V2M I2C driver, based on the feedback
from Pavel.

All these patches are cherry-picked from the mainline.

Biju Das (3):
  i2c: rzv2m: Drop extra space
  i2c: rzv2m: Replace lowercase macros with static inline functions
  i2c: rzv2m: Disable the operation of unit in case of error

 drivers/i2c/busses/Kconfig     |  2 +-
 drivers/i2c/busses/i2c-rzv2m.c | 43 +++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.25.1


