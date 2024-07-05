Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F4C30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 12:52:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.16470.1720183954468215174
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 05:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,184,1716217200"; 
   d="scan'208";a="214373446"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jul 2024 21:52:35 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.112])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6522644CC61C;
	Fri,  5 Jul 2024 21:52:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/10] clk: renesas: rzg2l: Fix build warning
Date: Fri,  5 Jul 2024 13:52:21 +0100
Message-Id: <20240705125230.125392-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 12:52:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16396

Type cast mtable to (u32 *) to avoid below build warning:

  drivers/clk/renesas/rzg2l-cpg.c: In function 'rzg2l_cpg_sd_clk_mux_set_parent':
  drivers/clk/renesas/rzg2l-cpg.c:476:50: warning: passing argument 1 of
  'clk_mux_index_to_val' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  476 |         val = clk_mux_index_to_val(sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, index);
      |                                    ~~~~~~~~~~~~~~^~~~~~~~

  In file included from drivers/clk/renesas/rzg2l-cpg.c:16:
  ./include/linux/clk-provider.h:934:40: note: expected
  'u32 *' {aka 'unsigned int *'} but argument is of type 'const u32 *' {aka 'const unsigned int *'}
  934 | unsigned int clk_mux_index_to_val(u32 *table, unsigned int flags, u8 index);
      |                                   ~~~~~^~~~~

drivers/clk/renesas/rzg2l-cpg.c: In function 'rzg2l_cpg_sd_clk_mux_get_parent':
drivers/clk/renesas/rzg2l-cpg.c:504:55: warning: passing argument 2 of
'clk_mux_val_to_index' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  504 |         return clk_mux_val_to_index(hw, sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, val);
      |                                         ~~~~~~~~~~~~~~^~~~~~~~
./include/linux/clk-provider.h:932:50: note: expected
'u32 *' {aka 'unsigned int *'} but argument is of type 'const u32 *' {aka 'const unsigned int *'}
  932 | int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index e05471a6ca8d7..b1952d2ee8c25 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -473,7 +473,7 @@ static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	u32 val;
 	int ret;
 
-	val = clk_mux_index_to_val(sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, index);
+	val = clk_mux_index_to_val((u32 *)sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, index);
 
 	spin_lock_irqsave(&priv->rmw_lock, flags);
 
@@ -501,7 +501,7 @@ static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
 	val >>= GET_SHIFT(clk_hw_data->conf);
 	val &= GENMASK(GET_WIDTH(clk_hw_data->conf) - 1, 0);
 
-	return clk_mux_val_to_index(hw, sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, val);
+	return clk_mux_val_to_index(hw, (u32 *)sd_mux_hw_data->mtable, CLK_MUX_ROUND_CLOSEST, val);
 }
 
 static const struct clk_ops rzg2l_cpg_sd_clk_mux_ops = {
-- 
2.34.1


