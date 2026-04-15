Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A464F42131
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 18:18:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1945.1776277096286510704
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 11:18:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: xhqEZaw3Sg2DVgri9/b/+Q==
X-CSE-MsgGUID: 2Ycmo8MyS7mtgNC/xPOcKw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Apr 2026 03:18:21 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 44C77405BF8A;
	Thu, 16 Apr 2026 03:18:20 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 5.10.y-cip 06/10] clk: renesas: rzg2l: Fix intin variable size
Date: Wed, 15 Apr 2026 14:18:05 -0400
Message-ID: <20260415181810.4073807-7-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260415181810.4073807-1-chris.brandt@renesas.com>
References: <20260415181810.4073807-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 18:18:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22726

[ Upstream commit a00655d98cd885472c311f01dff3e668d1288d0a ]

INTIN is a 12-bit register value, so u8 is too small.

Fixes: 1561380ee72f ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk support")
Cc: stable@vger.kernel.org
Reported-by: Hugo Villeneuve <hugo@hugovil.com>
Closes: https://lore.kernel.org/20251107113058.f334957151d1a8dd94dd740b@hugovil.com
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251114193711.3277912-1-chris.brandt@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 0c0d9d76c4d6..c45c22190fcd 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -121,8 +121,8 @@ struct div_hw_data {

 struct rzg2l_pll5_param {
 	u32 pl5_fracin;
+	u16 pl5_intin;
 	u8 pl5_refdiv;
-	u8 pl5_intin;
 	u8 pl5_postdiv1;
 	u8 pl5_postdiv2;
 	u8 pl5_spread;
--
2.52.0


