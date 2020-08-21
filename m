Return-Path: <SRS0=M04k=B7=lists.cip-project.org=bounce+64572+5178+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9B7C433EC
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5362078D
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="r08d6w8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5362078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5178+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HpDKYY4521723xWrXKVTviHA; Fri, 21 Aug 2020 03:58:34 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.131152.1598003016916343991
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:37 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954561"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:36 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E70344232061;
	Fri, 21 Aug 2020 18:43:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 11/36] clk: renesas: rcar-gen3: Allow changing the RPC[D2] clocks
Date: Fri, 21 Aug 2020 10:42:47 +0100
Message-Id: <20200821094312.3249-12-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: V66NE9UxWSV6yDekydAnWuuEx4520388AA=
Content-Type: multipart/mixed; boundary="mQHOm2cBIOzIb9Cw1dqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007514;
 bh=kiJ94pjcgSb5t8az0bEd/14DuTRFtdYreGrmOfnVgvo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=r08d6w8Qz+I6xacjlxMNxRCfGLpRS8pBPkIalAqqkKyH+Ww00CfrymMz7dJzF3KXiso
 eusn1MC8o60maL8Md3jeUJV/TkLwEKWxBMZWOzHEKwRwhFCckqGafr5mJmczVhMBVaCTg
 KIXgFVP9zq+6FKbXz4Qu+itkZTKSNOtPUwk=

--mQHOm2cBIOzIb9Cw1dqU

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 0d67c0340a60829c5c1b7d09629d23bbd67696f3 upstream.

I was unable to get clk_set_rate() setting a lower RPC-IF clock frequency
and that issue boiled down to me not passing CLK_SET_RATE_PARENT flag to
clk_register_composite() when registering the RPC[D2] clocks...

Fixes: db4a0073cc82 ("clk: renesas: rcar-gen3: Add RPC clocks")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Link: https://lore.kernel.org/r/be27a344-d8bf-9e0c-8950-2d1b48498496@cogentembedded.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index e8fc3b8a875a..6230a7c40244 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -467,7 +467,8 @@ static struct clk * __init cpg_rpc_clk_register(const char *name,
 
 	clk = clk_register_composite(NULL, name, &parent_name, 1, NULL, NULL,
 				     &rpc->div.hw,  &clk_divider_ops,
-				     &rpc->gate.hw, &clk_gate_ops, 0);
+				     &rpc->gate.hw, &clk_gate_ops,
+				     CLK_SET_RATE_PARENT);
 	if (IS_ERR(clk)) {
 		kfree(rpc);
 		return clk;
@@ -503,7 +504,8 @@ static struct clk * __init cpg_rpcd2_clk_register(const char *name,
 
 	clk = clk_register_composite(NULL, name, &parent_name, 1, NULL, NULL,
 				     &rpcd2->fixed.hw, &clk_fixed_factor_ops,
-				     &rpcd2->gate.hw, &clk_gate_ops, 0);
+				     &rpcd2->gate.hw, &clk_gate_ops,
+				     CLK_SET_RATE_PARENT);
 	if (IS_ERR(clk))
 		kfree(rpcd2);
 
-- 
2.17.1


--mQHOm2cBIOzIb9Cw1dqU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5178): https://lists.cip-project.org/g/cip-dev/message=
/5178
Mute This Topic: https://lists.cip-project.org/mt/76326717/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mQHOm2cBIOzIb9Cw1dqU--
