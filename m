Return-Path: <SRS0=gRRb=B7=lists.cip-project.org=bounce+64572+5181+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A24C433EA
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC2D207BB
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="by4GeynQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC2D207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5181+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sQVnYY4521723x4VZcQEBy7G; Fri, 21 Aug 2020 03:58:34 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.130425.1598002998984331784
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:27 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170291"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:27 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E0879423205B;
	Fri, 21 Aug 2020 18:43:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 06/36] soc: renesas: Identify RZ/G2H
Date: Fri, 21 Aug 2020 10:42:42 +0100
Message-Id: <20200821094312.3249-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mK5qRXgGnVPqckXbKHDBY5ztx4520388AA=
Content-Type: multipart/mixed; boundary="r5zd6mWEuPXOO84Yra35"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007514;
 bh=einJnmo+LGbjsfnTeZPgqpAy6Io/uDa3Cz/4jqWJiIg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=by4GeynQSeUq/oNa9eASPuUKvxaTx4VUhoxNYqT5d5umubLhkqpRplJzZNqFk3r83nb
 ugabirvBLxoTiipVH8nkSdIwFTcuXSRu0fcwIhrCN62vDblTA82YeGETzn2tq2Ux22E3T
 3GtaqR8xYAVEznKkUpgjHiIW+da1Y3XvogA=

--r5zd6mWEuPXOO84Yra35

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 5b83cc42cf871d3079cc370432de6b5925c71ce5 upstream.

This patch adds support for identifying the RZ/G2H (r8a774e1) SoC.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594138692-16816-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 1a40c1e7ba27..7f29182a1d08 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -125,6 +125,11 @@ static const struct renesas_soc soc_rz_g2e __initconst __maybe_unused = {
 	.id	= 0x57,
 };
 
+static const struct renesas_soc soc_rz_g2h __initconst __maybe_unused = {
+	.family	= &fam_rzg2,
+	.id	= 0x4f,
+};
+
 static const struct renesas_soc soc_rcar_m1a __initconst __maybe_unused = {
 	.family	= &fam_rcar_gen1,
 };
@@ -234,6 +239,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A774C0
 	{ .compatible = "renesas,r8a774c0",	.data = &soc_rz_g2e },
 #endif
+#ifdef CONFIG_ARCH_R8A774E1
+	{ .compatible = "renesas,r8a774e1",	.data = &soc_rz_g2h },
+#endif
 #ifdef CONFIG_ARCH_R8A7778
 	{ .compatible = "renesas,r8a7778",	.data = &soc_rcar_m1a },
 #endif
-- 
2.17.1


--r5zd6mWEuPXOO84Yra35
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5181): https://lists.cip-project.org/g/cip-dev/message=
/5181
Mute This Topic: https://lists.cip-project.org/mt/76326720/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--r5zd6mWEuPXOO84Yra35--
