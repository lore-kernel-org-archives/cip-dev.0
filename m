Return-Path: <SRS0=QyVE=GI=lists.cip-project.org=bounce+64572+6020+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A4FC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 14:17:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360DB22AAB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 14:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360DB22AAB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6020+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sBCzYY4521723xNl8jJiOKHL; Tue, 05 Jan 2021 06:17:39 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.5744.1609856256841821527
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 06:17:39 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="67869425"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jan 2021 23:17:38 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id ED3E8400A882;
	Tue,  5 Jan 2021 23:17:37 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 2/3] clk: renesas: r8a774b1: Add RPC clocks
Date: Tue,  5 Jan 2021 14:17:33 +0000
Message-Id: <20210105141734.11528-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105141734.11528-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105141734.11528-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0oRgkUS28ohJBUMMck9m0SjOx4520388AA=
Content-Type: multipart/mixed; boundary="BqBC19cMEQkn1KKDYNi6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609856259;
 bh=H2mDLH05A8HS82EVCelVaeDWxl8NKhGPz/VwaqTiRbY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=JKYTpETT48k/vcIzEfXoPtvqMkL3WuVbcF9EqXd2TOI0fBBGgpH6bD7sLrLzLpd/UR0
 Ln/iHoQGv+xQxas+VjePSzvxOUESYaV0GtNhmCC2FB5CFuqDZnRGg1GES/X2cIkGbMVZY
 AuLrTabhsSKnRlpbs7t5LQuZ/Sxj+thoedo=

--BqBC19cMEQkn1KKDYNi6

From: Biju Das <biju.das.jz@bp.renesas.com>

commit fb9805c51793339e0affbc8e3ce2b3210b41c9fa upstream.

Describe the RPCSRC internal clock and the RPC[D2] clocks derived from it,
as well as the RPC-IF module clock, in the RZ/G2N (R8A774B1) CPG/MSSR
driver.

Inspired by commit 94e3935b5756 ("clk: renesas: r8a77980: Add RPC clocks").

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20201016121709.8447-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r8a774b1-cpg-mssr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/renesas/r8a774b1-cpg-mssr.c b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
index f436691271ec..6f04c40fe237 100644
--- a/drivers/clk/renesas/r8a774b1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
@@ -40,6 +40,7 @@ enum clk_ids {
 	CLK_S2,
 	CLK_S3,
 	CLK_SDSRC,
+	CLK_RPCSRC,
 	CLK_RINT,
 
 	/* Module Clocks */
@@ -65,6 +66,12 @@ static const struct cpg_core_clk r8a774b1_core_clks[] __initconst = {
 	DEF_FIXED(".s2",        CLK_S2,            CLK_PLL1_DIV2,  4, 1),
 	DEF_FIXED(".s3",        CLK_S3,            CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED(".sdsrc",     CLK_SDSRC,         CLK_PLL1_DIV2,  2, 1),
+	DEF_BASE(".rpcsrc",     CLK_RPCSRC, CLK_TYPE_GEN3_RPCSRC, CLK_PLL1),
+
+	DEF_BASE("rpc",         R8A774B1_CLK_RPC, CLK_TYPE_GEN3_RPC,
+		 CLK_RPCSRC),
+	DEF_BASE("rpcd2",       R8A774B1_CLK_RPCD2, CLK_TYPE_GEN3_RPCD2,
+		 R8A774B1_CLK_RPC),
 
 	DEF_GEN3_OSC(".r",      CLK_RINT,          CLK_EXTAL,      32),
 
@@ -196,6 +203,7 @@ static const struct mssr_mod_clk r8a774b1_mod_clks[] __initconst = {
 	DEF_MOD("can-fd",		 914,	R8A774B1_CLK_S3D2),
 	DEF_MOD("can-if1",		 915,	R8A774B1_CLK_S3D4),
 	DEF_MOD("can-if0",		 916,	R8A774B1_CLK_S3D4),
+	DEF_MOD("rpc-if",		 917,	R8A774B1_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A774B1_CLK_S0D6),
 	DEF_MOD("i2c5",			 919,	R8A774B1_CLK_S0D6),
 	DEF_MOD("i2c-dvfs",		 926,	R8A774B1_CLK_CP),
-- 
2.17.1


--BqBC19cMEQkn1KKDYNi6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6020): https://lists.cip-project.org/g/cip-dev/message=
/6020
Mute This Topic: https://lists.cip-project.org/mt/79450575/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BqBC19cMEQkn1KKDYNi6--
