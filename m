Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111CDC48299
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:41:56 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.61463.1707136900075202832
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:41:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="196827671"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Feb 2024 21:41:50 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BA02940065B6;
	Mon,  5 Feb 2024 21:41:48 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/48] arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into board DTS
Date: Mon,  5 Feb 2024 12:40:53 +0000
Message-Id: <20240205124135.14779-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:41:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14675

commit 53072ba67e534ddd208697d3465004738f1d4d61 upstream.

Move including the rzg2ul-smarc-som.dtsi from the carrier board
rzg2ul-smarc.dtsi to the actual RZ/G2UL SMARC EVK board dts
r9a07g043u11-smarc.dts. Also move the SW_SW0_DEV_SEL and
SW_ET0_EN_N macros to board dts as they are used by SoM and carrier
board DTS/I.

This is in preparation of re-using the SoM and carrier board DTSIs
for RZ/Five SMARC EVK.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220915165256.352843-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts | 11 +++++++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi      | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index d882661c6dde..990cb897083c 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -10,7 +10,18 @@
 /* Please set this macro to 1 for enabling SCI0 on PMOD1 */
 #define PMOD_SCI0_EN	0
 
+/*
+ * DIP-Switch SW1 setting
+ * 1 : High; 0: Low
+ * SW1-2 : SW_SD0_DEV_SEL	(0: uSD; 1: eMMC)
+ * SW1-3 : SW_ET0_EN_N		(0: ETHER0; 1: CAN0, CAN1, SSI1, SPI1)
+ * Please change below macros according to SW1 setting on the SoM
+ */
+#define SW_SW0_DEV_SEL	1
+#define SW_ET0_EN_N	1
+
 #include "r9a07g043.dtsi"
+#include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index 44d5c82a9f18..56c0752977d2 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -5,17 +5,6 @@
  * Copyright (C) 2022 Renesas Electronics Corp.
  */
 
-/*
- * DIP-Switch SW1 setting
- * 1 : High; 0: Low
- * SW1-2 : SW_SD0_DEV_SEL	(0: uSD; 1: eMMC)
- * SW1-3 : SW_ET0_EN_N		(0: ETHER0; 1: CAN0, CAN1, SSI1, RSPI1)
- * Please change below macros according to SW1 setting
- */
-#define SW_SW0_DEV_SEL	1
-#define SW_ET0_EN_N	1
-
-#include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
-- 
2.34.1


