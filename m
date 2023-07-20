Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5989EEB64DD
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 10:04:05 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.9354.1689847436712834475
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 03:03:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,218,1684767600"; 
   d="scan'208";a="170239670"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Jul 2023 19:03:55 +0900
Received: from localhost.localdomain (unknown [10.226.92.157])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 438BC401227D;
	Thu, 20 Jul 2023 19:03:54 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip v2 01/13] arm64: dts: renesas: rzg2l-smarc: Use proper bool operator
Date: Thu, 20 Jul 2023 11:03:38 +0100
Message-Id: <20230720100350.247386-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720100350.247386-1-biju.das.jz@bp.renesas.com>
References: <20230720100350.247386-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 10:04:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12446

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 290cedeca6fa315c54e056b7bdd3fdd99e5303eb upstream.

When checking for defined macros, we want the boolean AND not the binary
one.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20220603232940.21736-1-wsa+renesas@sang-engineering.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index aa170492dd2b..6be25a8a28db 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -29,7 +29,7 @@
 #define SW_RSPI_CAN	1
 #endif
 
-#if (SW_SCIF_CAN & SW_RSPI_CAN)
+#if (SW_SCIF_CAN && SW_RSPI_CAN)
 #error "Can not set 1 to both SW_SCIF_CAN and SW_RSPI_CAN due to HW routing"
 #endif
 
-- 
2.25.1


