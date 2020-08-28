Return-Path: <SRS0=7Axh=CG=lists.cip-project.org=bounce+64572+5293+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C56C2BBDA
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B78208C9
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WHSCu6fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B78208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5293+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0NoCYY4521723xNOkdtMDNyV; Fri, 28 Aug 2020 09:07:46 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.45837.1598629320009468924
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:05 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587833"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:04 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 261B5400C9FD;
	Sat, 29 Aug 2020 00:42:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 03/30] soc: renesas: rcar-rst: Add support for RZ/G1H
Date: Fri, 28 Aug 2020 16:41:28 +0100
Message-Id: <20200828154155.5827-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AZ3oY4V1JmC0SiZIpfQ8194Sx4520388AA=
Content-Type: multipart/mixed; boundary="gCbbCmbSNQOOQbdz0WBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630866;
 bh=nuELaZo62wDzExREyIovR/7LxILNjyDww1k/V+z9/bE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WHSCu6fvr3InePFq6g7zidG0wLmovyhl9fWqH46LfLi6ivxy5288udDi3YQfRCX1BuY
 ooKJUwiT0q636NEDZAQ/azUc8IE6M/b7IKlIqUFSEgyjytFCk9bcVifEQXuO4o8gceneH
 yeYvRIbjklH7mIYPUEgg4cZErsAmhFqxwbE=

--gCbbCmbSNQOOQbdz0WBZ

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 2f71832755a9422f5a62a13ea3e805df7b173837 upstream.

Add support for RZ/G1H (R8A7742) to the R-Car RST driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1587678050-23468-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: Changed the text RZ/G to RZ/G1 ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/rcar-rst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index 8eaf736b2b86..869fb10d6de5 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -31,7 +31,8 @@ static const struct rst_config rcar_rst_gen2 __initconst = {
 };
 
 static const struct of_device_id rcar_rst_matches[] __initconst = {
-	/* RZ/G is handled like R-Car Gen2 */
+	/* RZ/G1 is handled like R-Car Gen2 */
+	{ .compatible = "renesas,r8a7742-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7743-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7744-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7745-rst", .data = &rcar_rst_gen2 },
-- 
2.17.1


--gCbbCmbSNQOOQbdz0WBZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5293): https://lists.cip-project.org/g/cip-dev/message=
/5293
Mute This Topic: https://lists.cip-project.org/mt/76477076/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--gCbbCmbSNQOOQbdz0WBZ--
