Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA2BC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 10:55:15 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.80888.1701946513569399649
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 02:55:13 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189532832"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 19:55:11 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 033CF420A72E;
	Thu,  7 Dec 2023 19:55:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/12]  Add display/dsi/gpt/poeg clk support
Date: Thu,  7 Dec 2023 10:54:56 +0000
Message-Id: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 10:55:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13812

This patch series aims to add display/dsi/gpt/poeg clk support support on
RZ/{G2L,G2LC,V2L} SMARC EVKs.
 
All the patches are cherry-picked from the mainline.

Display is tested with these clock patches. Will send DSI/VSPD
driver/dt patches soon.

This patch series is depend upon [1]
[1] https://patchwork.kernel.org/project/cip-dev/list/?series=807162

Biju Das (12):
  clk: renesas: rzg2l: Add FOUTPOSTDIV clk support
  clk: renesas: rzg2l: Add PLL5_4 clk mux support
  clk: renesas: rzg2l: Add DSI divider clk support
  clk: renesas: r9a07g044: Add M1 clock support
  clk: renesas: r9a07g044: Add {M2, M2_DIV2} Clocks support
  clk: renesas: r9a07g044: Add M3 Clock support
  clk: renesas: r9a07g044: Add M4 Clock support
  clk: renesas: r9a07g044: Add LCDC clock and reset entries
  clk: renesas: r9a07g044: Add DSI clock and reset entries
  clk: renesas: r9a07g044: Add GPT clock and reset entry
  clk: renesas: r9a07g044: Add POEG clock and reset entries
  clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write

 drivers/clk/renesas/r9a07g044-cpg.c |  72 ++++-
 drivers/clk/renesas/rzg2l-cpg.c     | 428 ++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h     |  42 +++
 3 files changed, 540 insertions(+), 2 deletions(-)

-- 
2.25.1


