Return-Path: <SRS0=KzfU=B7=lists.cip-project.org=bounce+64572+5185+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2216C433E8
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA5B207DF
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pqKQ72Yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA5B207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5185+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LUkwYY4521723x83jta8gpdu; Fri, 21 Aug 2020 03:58:34 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.131152.1598003016916343991
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:40 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954570"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:40 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 965B94231AD9;
	Fri, 21 Aug 2020 18:43:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 13/36] clk: renesas: rzg2: Mark RWDT clocks as critical
Date: Fri, 21 Aug 2020 10:42:49 +0100
Message-Id: <20200821094312.3249-14-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Py2jGlvJ2hItUajAl4kwn5qsx4520388AA=
Content-Type: multipart/mixed; boundary="wj6hUjVITAiD2Np7ECaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007514;
 bh=etoaxKM41rn+UkC868sREOqc5h9lVRURwGkt5NN3SyI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pqKQ72Yzrfq9MqslgTG+h15051C4RyBwzDqDMB1Eg2TDgn3jjsi197Bhuqf8h8pI80z
 pSZL/JobPnZmeg8Uu2aJGSqGBJyh45LhEGT2Svd1Bdl1W3mf7ZXb7yZBDgv2J2Bu6GDnB
 JgsMejMAsVvUTLQzAndsWsl1VykicoVZglw=

--wj6hUjVITAiD2Np7ECaz

From: Ulrich Hecht <uli+renesas@fpond.eu>

commit 52bc5ea6edde35bc65ed6ecd7639534e78002c74 upstream.

Ensures RWDT remains alert throughout the boot process if enabled.

This patch applies the change to the following SoCs: r8a774a1,
r8a774b1 and r8a774c0.

Signed-off-by: Ulrich Hecht <uli+renesas@fpond.eu>
Link: https://lore.kernel.org/r/20200616162626.27944-4-uli+renesas@fpond.eu
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 1 +
 drivers/clk/renesas/r8a774b1-cpg-mssr.c | 1 +
 drivers/clk/renesas/r8a774c0-cpg-mssr.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index e05bfa200480..fd54b9f625da 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -237,6 +237,7 @@ static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
 };
 
 static const unsigned int r8a774a1_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(402),	/* RWDT */
 	MOD_CLK_ID(408),	/* INTC-AP (GIC) */
 };
 
diff --git a/drivers/clk/renesas/r8a774b1-cpg-mssr.c b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
index c9af70917312..f436691271ec 100644
--- a/drivers/clk/renesas/r8a774b1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
@@ -233,6 +233,7 @@ static const struct mssr_mod_clk r8a774b1_mod_clks[] __initconst = {
 };
 
 static const unsigned int r8a774b1_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(402),	/* RWDT */
 	MOD_CLK_ID(408),	/* INTC-AP (GIC) */
 };
 
diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index f91e7a484753..9fc9fa9e531a 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -238,6 +238,7 @@ static const struct mssr_mod_clk r8a774c0_mod_clks[] __initconst = {
 };
 
 static const unsigned int r8a774c0_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(402),	/* RWDT */
 	MOD_CLK_ID(408),	/* INTC-AP (GIC) */
 };
 
-- 
2.17.1


--wj6hUjVITAiD2Np7ECaz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5185): https://lists.cip-project.org/g/cip-dev/message=
/5185
Mute This Topic: https://lists.cip-project.org/mt/76326724/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wj6hUjVITAiD2Np7ECaz--
