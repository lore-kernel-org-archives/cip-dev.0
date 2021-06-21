Return-Path: <SRS0=IeKJ=LP=lists.cip-project.org=bounce+64572+6556+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2972C48BC2
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAAF6054E
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAAF6054E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6556+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OHCwYY4521723xkfgk4SKHLI; Mon, 21 Jun 2021 10:09:50 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.50318.1624295388440408484
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 10:09:49 -0700
X-IronPort-AV: E=Sophos;i="5.83,289,1616425200"; 
   d="scan'208";a="84957096"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jun 2021 02:09:42 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AB083400754A;
	Tue, 22 Jun 2021 02:09:41 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 5.10.y-cip 11/16] clk: renesas: r8a774a1: Add RPC clocks
Date: Mon, 21 Jun 2021 18:09:20 +0100
Message-Id: <20210621170925.11328-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jkDsYA5em1sHWTQdyDhTDuKux4520388AA=
Content-Type: multipart/mixed; boundary="JmLNEJ2PUN7vo4fmehp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624295390;
 bh=qxY5nmJY9FQdg/gytlIMAqp31SrEOO1cwOWeRH/tzKo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=oDjbNuQrvdRxedW/9j03SzdhAdL8g5WCPzQheWt1mvLHg94zJwtw1AuF4Q9krxUJOjE
 IZPAVG9Zg3r110jdJr6d59z4wfKEi2G/joTrMlrS8R3Y3EaDj3n4weEwkZj4+JKyLEL8S
 +2uc0BsSE3Gi4XM6rxeUKS3Xj7kOVTLKtpk=

--JmLNEJ2PUN7vo4fmehp4

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 13d2617bf224351e78141183ca51971df83a9dd5 upstream.

Describe the RPCSRC internal clock and the RPC[D2] clocks derived from it,
as well as the RPC-IF module clock, in the RZ/G2M (R8A774A1) CPG/MSSR
driver.

Inspired by commit 94e3935b5756 ("clk: renesas: r8a77980: Add RPC clocks").

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20201016121709.8447-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index fd54b9f625da..4a43ebec7d5e 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -41,6 +41,7 @@ enum clk_ids {
 	CLK_S2,
 	CLK_S3,
 	CLK_SDSRC,
+	CLK_RPCSRC,
 	CLK_RINT,
 
 	/* Module Clocks */
@@ -67,6 +68,12 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 	DEF_FIXED(".s2",        CLK_S2,            CLK_PLL1_DIV2,  4, 1),
 	DEF_FIXED(".s3",        CLK_S3,            CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED(".sdsrc",     CLK_SDSRC,         CLK_PLL1_DIV2,  2, 1),
+	DEF_BASE(".rpcsrc",     CLK_RPCSRC, CLK_TYPE_GEN3_RPCSRC, CLK_PLL1),
+
+	DEF_BASE("rpc",         R8A774A1_CLK_RPC, CLK_TYPE_GEN3_RPC,
+		 CLK_RPCSRC),
+	DEF_BASE("rpcd2",       R8A774A1_CLK_RPCD2, CLK_TYPE_GEN3_RPCD2,
+		 R8A774A1_CLK_RPC),
 
 	DEF_GEN3_OSC(".r",      CLK_RINT,          CLK_EXTAL,      32),
 
@@ -200,6 +207,7 @@ static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
 	DEF_MOD("can-fd",		 914,	R8A774A1_CLK_S3D2),
 	DEF_MOD("can-if1",		 915,	R8A774A1_CLK_S3D4),
 	DEF_MOD("can-if0",		 916,	R8A774A1_CLK_S3D4),
+	DEF_MOD("rpc-if",		 917,	R8A774A1_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A774A1_CLK_S0D6),
 	DEF_MOD("i2c5",			 919,	R8A774A1_CLK_S0D6),
 	DEF_MOD("i2c-dvfs",		 926,	R8A774A1_CLK_CP),
-- 
2.17.1


--JmLNEJ2PUN7vo4fmehp4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6556): https://lists.cip-project.org/g/cip-dev/message=
/6556
Mute This Topic: https://lists.cip-project.org/mt/83693886/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--JmLNEJ2PUN7vo4fmehp4--
