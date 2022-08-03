Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7FCC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:54:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.169.1659545650200364617
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:54:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,214,1654527600";
   d="scan'208";a="130216127"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Aug 2022 01:54:09 +0900
Received: from localhost.localdomain (unknown [10.226.93.45])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9EFF140B100C;
	Thu,  4 Aug 2022 01:54:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 03/13] arm64: dts: renesas: rzg2lc-smarc-som:
 Enable watchdog
Date: Wed,  3 Aug 2022 17:53:48 +0100
Message-Id: <20220803165358.2156150-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
References: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:54:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9073

commit d05e409e4a66f62e863b140bd1c784f2d93f2562 upstream.

Enable watchdog{0, 1, 2} interfaces on RZ/G2LC SMARC EVK.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220223165813.24833-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
index 90cb7ec45751..88a7938017aa 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -206,3 +206,17 @@ &sdhi0 {
 };
 #endif
 
+&wdt0 {
+	status = "okay";
+	timeout-sec = <60>;
+};
+
+&wdt1 {
+	status = "okay";
+	timeout-sec = <60>;
+};
+
+&wdt2 {
+	status = "okay";
+	timeout-sec = <60>;
+};
-- 
2.25.1


