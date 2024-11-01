Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6E8E6B26B
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 12:58:25 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.36911.1730465904326430753
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Nov 2024 05:58:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,249,1725289200"; 
   d="scan'208";a="227643688"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Nov 2024 21:58:24 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.182])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 40FBC40078C4;
	Fri,  1 Nov 2024 21:58:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 15/28] media: rzg2l-cru: fix a test for timeout
Date: Fri,  1 Nov 2024 12:57:33 +0000
Message-ID: <20241101125746.33222-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Nov 2024 12:58:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17150

From: Dan Carpenter <error27@gmail.com>

commit 94ae11885fae1717f2017cb96ceef5d0f6d6dd4a upstream.

The test for if the loop timed out is wrong and Smatch complains:

    drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:411 rzg2l_csi2_mipi_link_disable()
    warn: should this be 'timeout == -1'

Let's change it to a preop loop instead of a post op loop.

Fixes: 51e8415e39a9 ("media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 306c5d3a9fb6e..e73c44385cd5e 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -399,7 +399,7 @@ static void rzg2l_csi2_mipi_link_disable(struct rzg2l_csi2 *csi2)
 	rzg2l_csi2_write(csi2, CSI2nRTCT, CSI2nRTCT_VSRST);
 
 	/* Make sure CSI2nRTST.VSRSTS bit is cleared */
-	while (timeout--) {
+	while (--timeout) {
 		if (!(rzg2l_csi2_read(csi2, CSI2nRTST) & CSI2nRTST_VSRSTS))
 			break;
 		usleep_range(100, 200);
-- 
2.43.0


