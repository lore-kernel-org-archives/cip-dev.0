Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA0AC4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:27:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20215.1707222459519133424
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:27:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="193048673"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Feb 2024 21:27:38 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 823BB4003EA4;
	Tue,  6 Feb 2024 21:27:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 01/44] arm64: dts: renesas: rzg2ul-smarc: Move selecting PMOD_SCI0_EN to board DTS
Date: Tue,  6 Feb 2024 12:26:51 +0000
Message-Id: <20240206122734.13477-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:27:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14785

It makes sense to have the configuration options in board dts, so move
PMOD_SCI0_EN macro to r9a07g043u11-smarc.dts.

This is in preparation of re-using the SoM and carrier board DTSIs
for RZ/Five SMARC EVK.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts | 4 ++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi      | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index 121e55282d181..d882661c6dde3 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -6,6 +6,10 @@
  */
 
 /dts-v1/;
+
+/* Please set this macro to 1 for enabling SCI0 on PMOD1 */
+#define PMOD_SCI0_EN	0
+
 #include "r9a07g043.dtsi"
 #include "rzg2ul-smarc.dtsi"
 
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index c6981bea40a46..44d5c82a9f18a 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -15,9 +15,6 @@
 #define SW_SW0_DEV_SEL	1
 #define SW_ET0_EN_N	1
 
-/* Please set this macro to 1 for enabling SCI0 on PMOD1 */
-#define PMOD_SCI0_EN	0
-
 #include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
-- 
2.34.1


