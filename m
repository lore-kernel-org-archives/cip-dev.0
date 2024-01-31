Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD87BC46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 13:56:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.18531.1706622981629523681
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 05:56:22 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 40UDuDEe3658544; Tue, 30 Jan 2024 22:56:13 +0900
X-Iguazu-Qid: 2yAbtK6A2lMLR2kTvk
X-Iguazu-QSIG: v=2; s=0; t=1706622973; q=2yAbtK6A2lMLR2kTvk; m=5t1m9Z8IyuEtKC+6eTlQ6vyco/hu9PzEH+69t6eXgnE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 40UDuCLN1260046
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 30 Jan 2024 22:56:12 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        pavel@denx.de
Cc: biju.das.jz@bp.renesas.com, yuki.saito@toshiba.co.jp
Subject: [PATCH 1/1] clk: Fix best_parent_rate after moving code into a separate function
Date: Wed, 31 Jan 2024 22:56:04 +0900
X-TSB-HOP2: ON
Message-Id: <20240131135604.1488157-2-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240131135604.1488157-1-kazuhiro3.hayashi@toshiba.co.jp>
References: <20240131135604.1488157-1-kazuhiro3.hayashi@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 13:56:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14500

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit be8fa5fd0a48fd2decc4de81ffe72bb3ceacecd9 upstream.

best_parent_rate entry is still being used in the code and needs to be
always updated regardless of the CLK_SET_RATE_NO_REPARENT flag.

Fixes: 1b4e99fda73f ("clk: Move no reparent case into a separate function")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20230613131631.270192-1-m.szyprowski@samsung.com
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Reported-by: Yuki Saito <yuki.saito@toshiba.co.jp>
Reviewed-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fe61fdc7c025..c048c6b1b8c3 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -614,6 +614,7 @@ clk_core_determine_rate_no_reparent(struct clk_hw *hw,
 		best = clk_core_get_rate_nolock(core);
 	}
 
+	req->best_parent_rate = best;
 	req->rate = best;
 
 	return 0;
-- 
2.30.2



