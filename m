Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1196BD3E2CF
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 20:04:35 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.2546.1730145864859774087
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Oct 2024 13:04:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,239,1725289200"; 
   d="scan'208";a="223233460"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Oct 2024 05:04:24 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.179])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 06082408CD1D;
	Tue, 29 Oct 2024 05:04:22 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 17/27] media: platform: rzg2l-cru: rzg2l-csi2: Enclose the macro in parentheses
Date: Mon, 28 Oct 2024 20:03:39 +0000
Message-ID: <20241028200349.9620-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Oct 2024 20:04:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17100

commit e5f29bb9c4350dd9692f3b98eb8538dbbebccbaf upstream.

Fix the below error reported by checkpatch:

ERROR: Macros with complex values should be enclosed in parentheses
					CSIDPHYSKW0_UTIL_DL1_SKW_ADJ(1) | \
					CSIDPHYSKW0_UTIL_DL2_SKW_ADJ(1) | \
					CSIDPHYSKW0_UTIL_DL3_SKW_ADJ(1)

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index b413ad7ff6388..3f874edcabed8 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -81,10 +81,10 @@
 #define CSIDPHYSKW0_UTIL_DL1_SKW_ADJ(x)	(((x) & 0x3) << 4)
 #define CSIDPHYSKW0_UTIL_DL2_SKW_ADJ(x)	(((x) & 0x3) << 8)
 #define CSIDPHYSKW0_UTIL_DL3_SKW_ADJ(x)	(((x) & 0x3) << 12)
-#define CSIDPHYSKW0_DEFAULT_SKW		CSIDPHYSKW0_UTIL_DL0_SKW_ADJ(1) | \
-					CSIDPHYSKW0_UTIL_DL1_SKW_ADJ(1) | \
-					CSIDPHYSKW0_UTIL_DL2_SKW_ADJ(1) | \
-					CSIDPHYSKW0_UTIL_DL3_SKW_ADJ(1)
+#define CSIDPHYSKW0_DEFAULT_SKW		(CSIDPHYSKW0_UTIL_DL0_SKW_ADJ(1) | \
+					 CSIDPHYSKW0_UTIL_DL1_SKW_ADJ(1) | \
+					 CSIDPHYSKW0_UTIL_DL2_SKW_ADJ(1) | \
+					 CSIDPHYSKW0_UTIL_DL3_SKW_ADJ(1))
 
 #define VSRSTS_RETRIES			20
 
-- 
2.43.0


