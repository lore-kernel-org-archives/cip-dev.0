X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.3708.1657869781519973448
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:23:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800"; 
   d="scan'208";a="127955805"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:23:03 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6F85E40158E5;
	Fri, 15 Jul 2022 16:23:01 +0900 (JST)
From: "Biju Das" <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/24] soc: renesas: Kconfig: Introduce ARCH_RZG2L config option
Date: Fri, 15 Jul 2022 08:22:26 +0100
Message-Id: <20220715072244.2298757-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-13"
List-Id: <cip-dev.lists.cip-project.org>

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 088659ad2a830124407edc38da278010c95bcc96 upstream.

The Renesas RZ/G2L, RZ/G2LC, RZ/G2UL and RZ/V2L SoCs have identical IP
blocks for which drivers are common.  To avoid updating the Kconfig
files for drivers in common to each SoC, introduce the ARCH_RZG2L config
option.
The ARCH_RZG2L config option will be selected by the above mentioned
SoCs, and the ARCH_RZG2L config option will be used as a dependency for
the drivers in common.

While at it, move PM and PM_GENERIC_DOMAINS under the ARCH_RZG2L config
option instead=C2=A0of keeping it for individual SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220224092114.25737-1-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 3469021427dd..cf695f624d79 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -40,6 +40,11 @@ config ARCH_RMOBILE
 	select SYS_SUPPORTS_SH_TMU
 	select SYSC_RMOBILE
=20
+config ARCH_RZG2L
+	bool
+	select PM
+	select PM_GENERIC_DOMAINS
+
 config ARCH_RZN1
 	bool
 	select ARM_AMBA
@@ -281,15 +286,13 @@ config ARCH_R8A774B1
=20
 config ARCH_R9A07G044
 	bool "ARM64 Platform support for RZ/G2L"
-	select PM
-	select PM_GENERIC_DOMAINS
+	select ARCH_RZG2L
 	help
 	  This enables support for the Renesas RZ/G2L SoC variants.
=20
 config ARCH_R9A07G054
 	bool "ARM64 Platform support for RZ/V2L"
-	select PM
-	select PM_GENERIC_DOMAINS
+	select ARCH_RZG2L
 	help
 	  This enables support for the Renesas RZ/V2L SoC variants.
=20
--=20
2.25.1


