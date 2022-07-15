Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106FFCCA480
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:23:04 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.3708.1657869781519973448
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:23:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="127955797"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:23:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E5C9F40104F7;
	Fri, 15 Jul 2022 16:22:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/24] soc: renesas: Kconfig: Explicitly select PM
 and PM_GENERIC_DOMAINS configs
Date: Fri, 15 Jul 2022 08:22:25 +0100
Message-Id: <20220715072244.2298757-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:23:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8791

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b89acaf8cad188d9a1387d3049ae036a10d9a1f3 upstream.

Explicitly select PM and PM_GENERIC_DOMAINS configs for ARCH_R9A07G044
and ARCH_R9A07G054 configs.  PM and PM_GENERIC_DOMAINS configs are
required for RZ/{G2L,V2L} SoC without these configs the SMARC EVK's
won't boot.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220221222450.5393-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index bddf91db18fe..3469021427dd 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -281,11 +281,15 @@ config ARCH_R8A774B1
 
 config ARCH_R9A07G044
 	bool "ARM64 Platform support for RZ/G2L"
+	select PM
+	select PM_GENERIC_DOMAINS
 	help
 	  This enables support for the Renesas RZ/G2L SoC variants.
 
 config ARCH_R9A07G054
 	bool "ARM64 Platform support for RZ/V2L"
+	select PM
+	select PM_GENERIC_DOMAINS
 	help
 	  This enables support for the Renesas RZ/V2L SoC variants.
 
-- 
2.25.1


