Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F79C7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:19:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6183.1682061521328276104
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156787074"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:50 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0D4E541AA65A;
	Fri, 21 Apr 2023 16:18:48 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 31/33] pinctrl: renesas: Select PINCTRL_RZG2L if ARCH_RZG2L is enabled
Date: Fri, 21 Apr 2023 08:17:27 +0100
Message-Id: <20230421071729.130347-32-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:19:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11304

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 1db28b78b35de7a6828091c9d5d7a179f3681680 upstream.

GPIO (PINCTRL) block is identical on Renesas RZ/G2L, RZ/G2UL and RZ/V2L
SoC's, so instead of selecting PINCTRL_RZG2L config for each SoC select
PINCTRL_RZG2L config option if ARCH_RZG2L is enabled. The ARCH_RZG2L
config option is already selected by ARCH_R9A07G043, ARCH_R9A07G044 and
ARCH_R9A07G054.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220406075318.14385-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 0d2f985918bb..9d41d133819c 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -36,9 +36,7 @@ config PINCTRL_RENESAS
 	select PINCTRL_PFC_R8A77980 if ARCH_R8A77980
 	select PINCTRL_PFC_R8A77990 if ARCH_R8A77990
 	select PINCTRL_PFC_R8A77995 if ARCH_R8A77995
-	select PINCTRL_RZG2L if ARCH_R9A07G043
-	select PINCTRL_RZG2L if ARCH_R9A07G044
-	select PINCTRL_RZG2L if ARCH_R9A07G054
+	select PINCTRL_RZG2L if ARCH_RZG2L
 	select PINCTRL_PFC_SH7203 if CPU_SUBTYPE_SH7203
 	select PINCTRL_PFC_SH7264 if CPU_SUBTYPE_SH7264
 	select PINCTRL_PFC_SH7269 if CPU_SUBTYPE_SH7269
-- 
2.25.1


