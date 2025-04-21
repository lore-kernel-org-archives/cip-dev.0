Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7926BC369D3
	for <webhook@archiver.kernel.org>; Mon, 21 Apr 2025 16:59:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.19878.1745254765969818866
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Apr 2025 09:59:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: uxvlH7xGTwC0aHIefB2C8g==
X-CSE-MsgGUID: s2zALkyESq+xw+0kNWpnwQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Apr 2025 01:59:23 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.26])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 81A4F40134EF;
	Tue, 22 Apr 2025 01:59:22 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/4] clk: renesas: r9a07g043: Add/Fix missing clocks
Date: Mon, 21 Apr 2025 17:59:17 +0100
Message-ID: <20250421165921.631205-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Apr 2025 16:59:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18528

Hi All,

Add/Fix missing clocks for RZ/Five SoC, also included
miscellaneous fixes while at it.

Note, all the patches have been cherry-picked from upstream
kernel.

Cheers,
Prabhakar

Claudiu Beznea (1):
  clk: renesas: r9a07g04[34]: Fix typo for sel_shdi variable

Lad Prabhakar (2):
  clk: renesas: r9a07g043: Add clock and reset entry for PLIC
  clk: renesas: r9a07g043: Fix HP clock source for RZ/Five

Paul Barker (1):
  clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const

 drivers/clk/renesas/r9a07g043-cpg.c | 26 +++++++++++++++++++++-----
 drivers/clk/renesas/r9a07g044-cpg.c |  6 +++---
 2 files changed, 24 insertions(+), 8 deletions(-)


base-commit: dd908a8bc2a5540570d8e47f852d108d7e31f56d
-- 
2.43.0


