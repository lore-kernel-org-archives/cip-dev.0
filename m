Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B43C369D5
	for <webhook@archiver.kernel.org>; Mon, 21 Apr 2025 18:30:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.21988.1745260230135155029
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Apr 2025 11:30:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: v5X+Ch+JTrOeShNonfZV+w==
X-CSE-MsgGUID: Kl5P/Dz9SmGbFOPIYoh6JQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Apr 2025 03:30:28 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.26])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CF57D405E62D;
	Tue, 22 Apr 2025 03:30:26 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix clock source
Date: Mon, 21 Apr 2025 19:30:22 +0100
Message-ID: <20250421183025.632955-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Apr 2025 18:30:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18533

Hi All,

Fix HP clock source for RZ/Five SoC, also included
miscellaneous fixes while at it.

Note, all the patches have been cherry-picked from upstream
kernel.

Cheers,
Prabhakar


Claudiu Beznea (1):
  clk: renesas: r9a07g04[34]: Fix typo for sel_shdi variable

Lad Prabhakar (1):
  clk: renesas: r9a07g043: Fix HP clock source for RZ/Five

Paul Barker (1):
  clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const

 drivers/clk/renesas/r9a07g043-cpg.c | 17 ++++++++++++-----
 drivers/clk/renesas/r9a07g044-cpg.c |  6 +++---
 2 files changed, 15 insertions(+), 8 deletions(-)


base-commit: 38336ea2d1beb9af557adcc91b04e82478f539bc
-- 
2.43.0


