Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3417EC46CCD
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 23:07:04 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.34645.1703113611129381758
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Dec 2023 15:06:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,292,1695654000"; 
   d="scan'208";a="187185234"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Dec 2023 08:06:54 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.50])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6751440BF9C6;
	Thu, 21 Dec 2023 08:06:52 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 02/30] arm64: dts: renesas: rzg2ul: Move PMOD_SCI0_EN macro to board DTS
Date: Wed, 20 Dec 2023 23:06:18 +0000
Message-Id: <20231220230646.219816-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Dec 2023 23:07:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14138

It makes more sense to have all the configurable options in top level
board DTS as we already have the configurable macros in there. This makes
it easier for platforms who want to share the the DTS/I with other
platforms/architectures.

This change is in preparation for adding the Renesas RZ/Five RISC-V SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts | 3 +++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi      | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index 8e0107df2d46..ddb193d007ac 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -28,6 +28,9 @@
 #error "Cannot set as both PMOD_MTU3 and !SW_ET0_EN_N are mutually exclusive"
 #endif
 
+/* Please set this macro to 1 for enabling SCI0 on PMOD1 */
+#define PMOD_SCI0_EN	0
+
 #include "r9a07g043u.dtsi"
 #include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index 019bab4ce8e4..727e3268a15b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -5,9 +5,6 @@
  * Copyright (C) 2022 Renesas Electronics Corp.
  */
 
-/* Please set this macro to 1 for enabling SCI0 on PMOD1 */
-#define PMOD_SCI0_EN	0
-
 #include "rzg2ul-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
-- 
2.34.1


