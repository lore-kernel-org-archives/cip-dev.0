Return-Path: <SRS0=S/z0=B7=lists.cip-project.org=bounce+64572+5184+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C0BC433E1
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A932072D
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oSPDMQ/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A932072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5184+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id trWVYY4521723x1jp114iW2N; Fri, 21 Aug 2020 03:58:34 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.130425.1598002998984331784
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:24 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170282"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:23 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 48C11423206E;
	Fri, 21 Aug 2020 18:43:22 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 04/36] soc: renesas: Add Renesas R8A774E1 config option
Date: Fri, 21 Aug 2020 10:42:40 +0100
Message-Id: <20200821094312.3249-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kSjH6TODBnErgdoBTSmmbQLCx4520388AA=
Content-Type: multipart/mixed; boundary="56p4C7OaZ5NXsufFNDm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007514;
 bh=tnoLLKFFaNyC7u2TBaqxk/UEBXgxqfhVi5liTupBNow=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=oSPDMQ/yPA9pm16CEG69Mh7XwrVNcHkADyBottt7UQo3/5H3LvMpnEGQTePMElkobG8
 fGlde4fRwd30SJtKj5J1F/eXurrSzEbq9myB1LMc82irSefzhlWrF7JhKGdi+5m0U2uC2
 E1B7bXTTfrsb6xk4g2wYJlaMmE3hAEZfNys=

--56p4C7OaZ5NXsufFNDm8

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit b88fc411e0e9c38058f6e3d2afdc96aaced4e72c upstream.

Add configuration option for the RZ/G2H (R8A774E1) SoC.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594138692-16816-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: Moved the configuration option from drivers/soc/renesas/Kconfig
to here inorder to support the same in 4.19.y-cip kernel]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 drivers/soc/renesas/Kconfig  | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b624ccee11b8..f744814b0a33 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -207,6 +207,12 @@ config ARCH_R8A774C0
 	help
 	  This enables support for the Renesas RZ/G2E SoC.
 
+config ARCH_R8A774E1
+	bool "Renesas RZ/G2H SoC Platform"
+	depends on ARCH_RENESAS
+	help
+	  This enables support for the Renesas RZ/G2H SoC.
+
 config ARCH_R8A7795
 	bool "Renesas R-Car H3 SoC Platform"
 	depends on ARCH_RENESAS
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 3b33e091ccff..0afb4b8c3e6f 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -4,9 +4,9 @@ config SOC_RENESAS
 	select SOC_BUS
 	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || \
 			   ARCH_R8A774A1 || ARCH_R8A774B1 || ARCH_R8A774C0 || \
-			   ARCH_R8A7795 || ARCH_R8A7796 || ARCH_R8A77965 || \
-			   ARCH_R8A77970 || ARCH_R8A77980 || ARCH_R8A77990 || \
-			   ARCH_R8A77995
+			   ARCH_R8A774E1 || ARCH_R8A7795 || ARCH_R8A7796 || \
+			   ARCH_R8A77965 || ARCH_R8A77970 || ARCH_R8A77980 || \
+			   ARCH_R8A77990 || ARCH_R8A77995
 	select SYSC_R8A7743 if ARCH_R8A7743
 	select SYSC_R8A7745 if ARCH_R8A7745
 	select SYSC_R8A77470 if ARCH_R8A77470
-- 
2.17.1


--56p4C7OaZ5NXsufFNDm8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5184): https://lists.cip-project.org/g/cip-dev/message=
/5184
Mute This Topic: https://lists.cip-project.org/mt/76326723/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--56p4C7OaZ5NXsufFNDm8--
