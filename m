Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2380C19F2C
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:31 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.4832.1659438534534175527
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:09:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="130054376"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2022 20:09:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 731B9400D4CE;
	Tue,  2 Aug 2022 20:09:27 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 16/24] pinctrl: renesas: Kconfig: Select
 PINCTRL_RZG2L if RZ/V2L SoC is enabled
Date: Tue,  2 Aug 2022 12:08:42 +0100
Message-Id: <20220802110850.1496057-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9013

commit 0c8fce49f24e7c8ee2bdff4761f414ad59bfa29a upstream.

RZ/V2L uses the RZ/G2L GPIO and pinctrl driver.
Enable the RZ/G2L pinctrl driver if RZ/V2L is enabled.
Update the description for RZ/V2L pin control support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220110134659.30424-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Link: https://lore.kernel.org/r/20220206194614.13209-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 356a70739689..623d0c01e259 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -37,6 +37,7 @@ config PINCTRL_RENESAS
 	select PINCTRL_PFC_R8A77990 if ARCH_R8A77990
 	select PINCTRL_PFC_R8A77995 if ARCH_R8A77995
 	select PINCTRL_RZG2L if ARCH_R9A07G044
+	select PINCTRL_RZG2L if ARCH_R9A07G054
 	select PINCTRL_PFC_SH7203 if CPU_SUBTYPE_SH7203
 	select PINCTRL_PFC_SH7264 if CPU_SUBTYPE_SH7264
 	select PINCTRL_PFC_SH7269 if CPU_SUBTYPE_SH7269
@@ -173,14 +174,15 @@ config PINCTRL_RZA2
 	  This selects GPIO and pinctrl driver for Renesas RZ/A2 platforms.
 
 config PINCTRL_RZG2L
-	bool "pin control support for RZ/G2L" if COMPILE_TEST
+	bool "pin control support for RZ/{G2L,V2L}" if COMPILE_TEST
 	depends on OF
 	select GPIOLIB
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
 	help
-	  This selects GPIO and pinctrl driver for Renesas RZ/G2L platforms.
+	  This selects GPIO and pinctrl driver for Renesas RZ/{G2L,V2L}
+	  platforms.
 
 config PINCTRL_PFC_R8A77470
 	bool "pin control support for RZ/G1C" if COMPILE_TEST
-- 
2.25.1


