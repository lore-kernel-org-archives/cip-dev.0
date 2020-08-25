Return-Path: <SRS0=UW13=CD=lists.cip-project.org=bounce+64572+5249+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30824C433EA
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:42:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025A620786
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="t+WMMa6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025A620786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5249+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id akLVYY4521723xrOwm6aIas7; Tue, 25 Aug 2020 06:41:59 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.13297.1598361736502564135
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 06:22:16 -0700
X-IronPort-AV: E=Sophos;i="5.76,352,1592838000"; 
   d="scan'208";a="55269203"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Aug 2020 22:22:15 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 854884004950;
	Tue, 25 Aug 2020 22:22:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 09/10] can: rcar_can: Remove unused platform data support
Date: Tue, 25 Aug 2020 14:21:55 +0100
Message-Id: <20200825132156.7839-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KXTrLnIXclJMdzTyocGFFol6x4520388AA=
Content-Type: multipart/mixed; boundary="9vOAC82HhhcDtlF6O9HD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598362919;
 bh=7ernKvmNdCNvsbOn3RtuIhkHRkbb/30zHcpshzrITmc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=t+WMMa6ssQs7Ib5Iez3MQ7caWXqDWX1u//QU8XC/s7gCEJDp1jRlkh7ltxUdWW3LWjR
 gXQVif2FIvCPsCKBPi6aqauj59QnSApk0RmZLLvXc9zKipHehiAIIMAIM81QA9g9AFi9Z
 ruJLaC22qIjbMZzJIJ/07nNeAyH22Z2qBJM=

--9vOAC82HhhcDtlF6O9HD

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 30cc0ed73e3390af7c5573b159826e8162f09fe7 upstream.

All R-Car platforms use DT for describing CAN controllers. R-Car CAN
platform data support was never used in any upstream kernel.

Move the Clock Select Register settings enum into the driver, and remove
platform data support and the corresponding header file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c       | 22 +++++++++-------------
 include/linux/can/platform/rcar_can.h | 18 ------------------
 2 files changed, 9 insertions(+), 31 deletions(-)
 delete mode 100644 include/linux/can/platform/rcar_can.h

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 771a46083739..bfb674193a21 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -19,11 +19,17 @@
 #include <linux/can/led.h>
 #include <linux/can/dev.h>
 #include <linux/clk.h>
-#include <linux/can/platform/rcar_can.h>
 #include <linux/of.h>
 
 #define RCAR_CAN_DRV_NAME	"rcar_can"
 
+/* Clock Select Register settings */
+enum CLKR {
+	CLKR_CLKP1 = 0, /* Peripheral clock (clkp1) */
+	CLKR_CLKP2 = 1, /* Peripheral clock (clkp2) */
+	CLKR_CLKEXT = 3, /* Externally input clock */
+};
+
 #define RCAR_SUPPORTED_CLOCKS	(BIT(CLKR_CLKP1) | BIT(CLKR_CLKP2) | \
 				 BIT(CLKR_CLKEXT))
 
@@ -740,7 +746,6 @@ static const char * const clock_names[] = {
 
 static int rcar_can_probe(struct platform_device *pdev)
 {
-	struct rcar_can_platform_data *pdata;
 	struct rcar_can_priv *priv;
 	struct net_device *ndev;
 	struct resource *mem;
@@ -749,17 +754,8 @@ static int rcar_can_probe(struct platform_device *pdev)
 	int err = -ENODEV;
 	int irq;
 
-	if (pdev->dev.of_node) {
-		of_property_read_u32(pdev->dev.of_node,
-				     "renesas,can-clock-select", &clock_select);
-	} else {
-		pdata = dev_get_platdata(&pdev->dev);
-		if (!pdata) {
-			dev_err(&pdev->dev, "No platform data provided!\n");
-			goto fail;
-		}
-		clock_select = pdata->clock_select;
-	}
+	of_property_read_u32(pdev->dev.of_node, "renesas,can-clock-select",
+			     &clock_select);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
diff --git a/include/linux/can/platform/rcar_can.h b/include/linux/can/platform/rcar_can.h
deleted file mode 100644
index a43dcd0cf79e..000000000000
--- a/include/linux/can/platform/rcar_can.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _CAN_PLATFORM_RCAR_CAN_H_
-#define _CAN_PLATFORM_RCAR_CAN_H_
-
-#include <linux/types.h>
-
-/* Clock Select Register settings */
-enum CLKR {
-	CLKR_CLKP1 = 0,	/* Peripheral clock (clkp1) */
-	CLKR_CLKP2 = 1,	/* Peripheral clock (clkp2) */
-	CLKR_CLKEXT = 3	/* Externally input clock */
-};
-
-struct rcar_can_platform_data {
-	enum CLKR clock_select;	/* Clock source select */
-};
-
-#endif	/* !_CAN_PLATFORM_RCAR_CAN_H_ */
-- 
2.17.1


--9vOAC82HhhcDtlF6O9HD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5249): https://lists.cip-project.org/g/cip-dev/message=
/5249
Mute This Topic: https://lists.cip-project.org/mt/76406714/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--9vOAC82HhhcDtlF6O9HD--
