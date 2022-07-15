Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1567DCCA47C
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:23:14 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.3708.1657869781519973448
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:23:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="127955810"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:23:05 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id ECBD540083E1;
	Fri, 15 Jul 2022 16:23:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/24] ASoC: sh: Make SND_SOC_RZ depend on
 ARCH_RZG2L
Date: Fri, 15 Jul 2022 08:22:27 +0100
Message-Id: <20220715072244.2298757-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:23:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8793

commit cc691ba94cf8d6c586076ed489bb9d385a2650ad upstream.

The SSI block is identical on Renesas RZ/G2L, RZ/G2UL and RZ/V2L SoC's, so
instead of adding dependency for each SoC's add dependency on ARCH_RZG2L.
The ARCH_RZG2L config option is already selected by ARCH_R9A07G043,
ARCH_R9A07G044 and ARCH_R9A07G054.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220423164443.146299-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index f19bd15c0900..96d9d7160f30 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -46,7 +46,7 @@ config SND_SOC_RCAR
 
 config SND_SOC_RZ
 	tristate "RZ/G2L series SSIF-2 support"
-	depends on ARCH_R9A07G044 || COMPILE_TEST
+	depends on ARCH_RZG2L || COMPILE_TEST
 	help
 	  This option enables RZ/G2L SSIF-2 sound support.
 
-- 
2.25.1


