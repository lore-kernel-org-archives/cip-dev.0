Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E23DC48291
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 11:38:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20696.1706873879863132625
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 03:38:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,238,1701097200"; 
   d="scan'208";a="196569131"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Feb 2024 20:37:58 +0900
Received: from localhost.localdomain (unknown [10.226.93.210])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4E77D4000F90;
	Fri,  2 Feb 2024 20:37:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/6] Versa3 clk driver improvements
Date: Fri,  2 Feb 2024 11:37:48 +0000
Message-Id: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 11:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14615

This patch series aims to improve versa3 clock driver.

All the patches are cherry-picked from the mainline.

Biju Das (6):
  arm64: defconfig: Enable Renesas VersaClock 3 clock generator config
  clk: versaclock3: Update vc3_get_div() to avoid divide by zero
  clk: versaclock3: Avoid unnecessary padding
  clk: versaclock3: Use u8 return type for get_parent() callback
  clk: versaclock3: Add missing space between ')' and '{'
  clk: versaclock3: Drop ret variable

 arch/arm64/configs/defconfig  |  1 +
 drivers/clk/clk-versaclock3.c | 88 ++++++++++++++++-------------------
 2 files changed, 41 insertions(+), 48 deletions(-)

-- 
2.25.1


