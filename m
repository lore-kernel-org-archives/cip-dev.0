Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093CECCA47C
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:23:34 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.3871.1657869794050960984
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:23:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="127955859"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:23:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A724740104F7;
	Fri, 15 Jul 2022 16:23:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 14/24] ASoC: sh: rz-ssi: Drop SSIFSR_TDC and
 SSIFSR_RDC macros
Date: Fri, 15 Jul 2022 08:22:34 +0100
Message-Id: <20220715072244.2298757-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:23:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8800

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 17a1fef58c65ec9c9a15dd60386712567ff28d45 upstream.

The mask values of SSIFSR_TDC and SSIFSR_RDC macros are incorrect and
they are unused in the file so just drop them.

Reported-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220426074922.13319-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 7a9de98b7857..b787a788ad79 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -59,9 +59,7 @@
 #define SSIFSR_RDC_MASK		0x3f
 #define SSIFSR_RDC_SHIFT	8
 
-#define SSIFSR_TDC(x)		(((x) & 0x1f) << 24)
 #define SSIFSR_TDE		BIT(16)
-#define SSIFSR_RDC(x)		(((x) & 0x1f) << 8)
 #define SSIFSR_RDF		BIT(0)
 
 #define SSIOFR_LRCONT		BIT(8)
-- 
2.25.1


