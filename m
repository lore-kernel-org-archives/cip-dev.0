Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23A6F53D68
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 15:00:16 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52771.1773673200178532310
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 08:00:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: JXjUWAQ6RH+bGOVT0IdkQQ==
X-CSE-MsgGUID: M0o7bX6cQzGHgydqcXVJUg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 17 Mar 2026 00:00:10 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B98EF41B7CD1;
	Tue, 17 Mar 2026 00:00:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 30/35] net: pcs: Kconfig: Fix unmet dependency warning
Date: Mon, 16 Mar 2026 14:59:07 +0000
Message-ID: <20260316145915.8580-31-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 15:00:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22422

commit dfc85640796b414385e50c932eb2b8ce4d38ce72 upstream.

Fix the Kconfig dependencies for PCS_RZN1_MIIC to avoid the unmet direct
dependency warning when enabling DWMAC_RENESAS_GBETH. The PCS driver is
used on multiple Renesas SoCs including RZ/N1, RZ/N2H and RZ/T2H, but the
existing condition only allowed ARCH_RZN1, ARCH_R9A09G077, or
ARCH_R9A09G087. This conflicted with the GBETH/GMAC driver which selects
PCS_RZN1_MIIC under ARCH_RENESAS.

Update the dependency to ARCH_RENESAS || COMPILE_TEST so that the PCS
driver is available on all Renesas platforms.

Fixes: 08f89e42121d ("net: pcs: rzn1-miic: Add RZ/T2H MIIC support")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/aMlgg_QpJOEDGcEA@monster/
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250916162335.3339558-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/pcs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index 76dbc11d9575..ecbc3530e780 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -28,7 +28,7 @@ config PCS_MTK_LYNXI
 config PCS_RZN1_MIIC
 	tristate "Renesas RZ/N1, RZ/N2H, RZ/T2H MII converter"
 	depends on OF
-	depends on ARCH_RZN1 || ARCH_R9A09G077 || ARCH_R9A09G087 || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	help
 	  This module provides a driver for the MII converter available on
 	  Renesas RZ/N1, RZ/N2H, and RZ/T2H SoCs. This PCS converts MII to
-- 
2.43.0


