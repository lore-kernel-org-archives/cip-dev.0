Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C2C4167B
	for <webhook@archiver.kernel.org>; Tue,  5 Dec 2023 20:39:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.5134.1701808775748925018
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Dec 2023 12:39:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,253,1695654000"; 
   d="scan'208";a="185417449"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2023 05:39:34 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2B6B44075A4E;
	Wed,  6 Dec 2023 05:39:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/5] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
Date: Tue,  5 Dec 2023 20:39:25 +0000
Message-Id: <20231205203929.444113-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205203929.444113-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231205203929.444113-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Dec 2023 20:39:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13787

commit 1ca318459c026eaaf7984edcf6e79eaf0aaea185 upstream.

WDT CH2 is specifically to check the operation of Cortex-M33 CPU so
don't enable WDT2 by default.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index be29e446e60f..ec8d063e712a 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -263,8 +263,3 @@ &wdt0 {
 	status = "okay";
 	timeout-sec = <60>;
 };
-
-&wdt2 {
-	status = "okay";
-	timeout-sec = <60>;
-};
-- 
2.34.1


