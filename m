Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9945DFD8754
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:36:57 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73933.1773747409055251321
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:36:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VOk8M+eh;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso51165215e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747407; x=1774352207; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy5D7HpDu0srQQF4RKlzvQiFDMbR+asG0TimiC4sf10=;
        b=VOk8M+ehZSjEF+4Ki6p2lWwvTIUSKGYfbgO8GPU4K0rbRryRV6Cnte+M8C1dr8p5yn
         eogozaDnhV1+2vAVq9wAP3MitDVB/ih7mQeF1OvlGvQmjL/QEGjCPLifw9cr5bUc/j8I
         Gq8LJKEiSVqUFx+ZXkUrxf9PHFvc5o1RrV4WvOvKgOD9e3usuNVwJ1/0qPFb5+bz91AS
         lsvWjE/unbNlx8c7dF1MJTYsCUfz5YY2sfw0A87aqfMN3LMlO6oJoo9/UvL33JrgGCrz
         htOQfHQSB5b9Pkil4oN9I0Q9Cd1qxiSIdHo78zX+VoObChkm3jKiOdBvSv+Z+PJRRB9L
         87rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747407; x=1774352207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uy5D7HpDu0srQQF4RKlzvQiFDMbR+asG0TimiC4sf10=;
        b=PW5Gp3+cUTiq6BkUe213EiXzYVNNHtdr9rPM9bB6H0QnP2/tXCp13tdOqkBvwqR0oQ
         ATR+/n+p3nLWFLAc3pRFxUPPORPDruZqg8yKITSLT+e1W3LxWEwNFQh3zu9aWYLbNHfZ
         3KoKgO4kYO4/nxe/gSYedWsLsbvvA2nQu7h5d5YDo70ZjTi0p8kj2Dx/foxIT9rKtg8A
         t/Em60xPHM9QxMG8Un7djJYscGKep8MZXKkQR/Gx06BhEkCMosPGN/1LjbYSJraHV8xA
         guEDaeyJcSODDTAW6UA8jAdgWtm3cojrzZU3q6TQjfmK1DgZewjPNN+17gKrjhoc/dG7
         gjWA==
X-Gm-Message-State: AOJu0Ywv1hNFLPCMqXWIRVfYCeMKUSU9PWdkfTFSZ8vWYk5c+M6C+b+Y
	coUjx4DOjI9ZsJ/DZrUvSs4R7grjQJ4inzkXTxZ+zY6JyvqWlF9MrE1hUz/sYg==
X-Gm-Gg: ATEYQzx4QQmrEmPj4wfHL9AyF32SlPrJI9C+0G7X3lTH3WEiZ+CTW3j0t2tKyKMIbOj
	pc/LLUIuHzJP/vsStsTsG93nlhwrA5MC8eu9aO/s5SmcH/ziKiIl+OnoLmZ4rQu2eGzEyAlq8Eu
	pNTKSB5khZYZN/xsKXExsfQ6pVprOi3BfeavUmfYUTPEZsZoHLClbqiLt4WhfZ6b+JlMA7/Fk9W
	IJ1mRLxZH53vyhozRRJggmy5MCGdCLrhp0zgP2rDOb16hT6cgsqGQyM12Dxidr405nBqGSkPmQv
	aTf97LlS08+VxvBsX/o6Z4+oNYTfq0nsEJRvXo5HgBlM/Oq/qqkiUGHNaw/1AnmBqyF2PT/twtz
	t2sjOACGMEL1PxK4tzt7+kSCQNJV9pzYkeGbDc1IwKOIuPD9iKcraMfjHyYc/CcMIKOV/QDNdPg
	R/db7/WLlMPK4boaRHnA9V8jpOD65So9+o7GaUaPAMY4zflzjw
X-Received: by 2002:a05:600c:698e:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-485566ca5cdmr276165675e9.6.1773747406992;
        Tue, 17 Mar 2026 04:36:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea97af2sm57469965e9.4.2026.03.17.04.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:36:46 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/11] usb: host: xhci-rcar: Move R-Car reg definitions
Date: Tue, 17 Mar 2026 11:36:31 +0000
Message-ID: <20260317113643.311192-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:36:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22478

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit f7acd12eba05fb9e7dba3222e2aeca5f49d38b3a ]

Move xhci-rcar reg definitions to a header file for the preparation of adding
support for RZ/G3E XHCI that has different register definitions.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250916150255.4231-5-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/host/xhci-rcar-regs.h | 49 +++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-rcar.c      | 45 +---------------------------
 2 files changed, 50 insertions(+), 44 deletions(-)
 create mode 100644 drivers/usb/host/xhci-rcar-regs.h

diff --git a/drivers/usb/host/xhci-rcar-regs.h b/drivers/usb/host/xhci-rcar-regs.h
new file mode 100644
index 000000000000..5ecbda858be0
--- /dev/null
+++ b/drivers/usb/host/xhci-rcar-regs.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __XHCI_RCAR_H
+#define __XHCI_RCAR_H
+
+/*** Register Offset ***/
+#define RCAR_USB3_AXH_STA	0x104	/* AXI Host Control Status */
+#define RCAR_USB3_INT_ENA	0x224	/* Interrupt Enable */
+#define RCAR_USB3_DL_CTRL	0x250	/* FW Download Control & Status */
+#define RCAR_USB3_FW_DATA0	0x258	/* FW Data0 */
+
+#define RCAR_USB3_LCLK		0xa44	/* LCLK Select */
+#define RCAR_USB3_CONF1		0xa48	/* USB3.0 Configuration1 */
+#define RCAR_USB3_CONF2		0xa5c	/* USB3.0 Configuration2 */
+#define RCAR_USB3_CONF3		0xaa8	/* USB3.0 Configuration3 */
+#define RCAR_USB3_RX_POL	0xab0	/* USB3.0 RX Polarity */
+#define RCAR_USB3_TX_POL	0xab8	/* USB3.0 TX Polarity */
+
+/*** Register Settings ***/
+/* AXI Host Control Status */
+#define RCAR_USB3_AXH_STA_B3_PLL_ACTIVE		0x00010000
+#define RCAR_USB3_AXH_STA_B2_PLL_ACTIVE		0x00000001
+#define RCAR_USB3_AXH_STA_PLL_ACTIVE_MASK (RCAR_USB3_AXH_STA_B3_PLL_ACTIVE | \
+					   RCAR_USB3_AXH_STA_B2_PLL_ACTIVE)
+
+/* Interrupt Enable */
+#define RCAR_USB3_INT_XHC_ENA	0x00000001
+#define RCAR_USB3_INT_PME_ENA	0x00000002
+#define RCAR_USB3_INT_HSE_ENA	0x00000004
+#define RCAR_USB3_INT_ENA_VAL	(RCAR_USB3_INT_XHC_ENA | \
+				RCAR_USB3_INT_PME_ENA | RCAR_USB3_INT_HSE_ENA)
+
+/* FW Download Control & Status */
+#define RCAR_USB3_DL_CTRL_ENABLE	0x00000001
+#define RCAR_USB3_DL_CTRL_FW_SUCCESS	0x00000010
+#define RCAR_USB3_DL_CTRL_FW_SET_DATA0	0x00000100
+
+/* LCLK Select */
+#define RCAR_USB3_LCLK_ENA_VAL	0x01030001
+
+/* USB3.0 Configuration */
+#define RCAR_USB3_CONF1_VAL	0x00030204
+#define RCAR_USB3_CONF2_VAL	0x00030300
+#define RCAR_USB3_CONF3_VAL	0x13802007
+
+/* USB3.0 Polarity */
+#define RCAR_USB3_RX_POL_VAL	BIT(21)
+#define RCAR_USB3_TX_POL_VAL	BIT(4)
+
+#endif /* __XHCI_RCAR_H */
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 567b096a24e9..18bee3189d04 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -16,6 +16,7 @@
 
 #include "xhci.h"
 #include "xhci-plat.h"
+#include "xhci-rcar-regs.h"
 #include "xhci-rzv2m.h"
 
 #define XHCI_RCAR_FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
@@ -34,50 +35,6 @@ MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V1);
 MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V2);
 MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V3);
 
-/*** Register Offset ***/
-#define RCAR_USB3_AXH_STA	0x104	/* AXI Host Control Status */
-#define RCAR_USB3_INT_ENA	0x224	/* Interrupt Enable */
-#define RCAR_USB3_DL_CTRL	0x250	/* FW Download Control & Status */
-#define RCAR_USB3_FW_DATA0	0x258	/* FW Data0 */
-
-#define RCAR_USB3_LCLK		0xa44	/* LCLK Select */
-#define RCAR_USB3_CONF1		0xa48	/* USB3.0 Configuration1 */
-#define RCAR_USB3_CONF2		0xa5c	/* USB3.0 Configuration2 */
-#define RCAR_USB3_CONF3		0xaa8	/* USB3.0 Configuration3 */
-#define RCAR_USB3_RX_POL	0xab0	/* USB3.0 RX Polarity */
-#define RCAR_USB3_TX_POL	0xab8	/* USB3.0 TX Polarity */
-
-/*** Register Settings ***/
-/* AXI Host Control Status */
-#define RCAR_USB3_AXH_STA_B3_PLL_ACTIVE		0x00010000
-#define RCAR_USB3_AXH_STA_B2_PLL_ACTIVE		0x00000001
-#define RCAR_USB3_AXH_STA_PLL_ACTIVE_MASK (RCAR_USB3_AXH_STA_B3_PLL_ACTIVE | \
-					   RCAR_USB3_AXH_STA_B2_PLL_ACTIVE)
-
-/* Interrupt Enable */
-#define RCAR_USB3_INT_XHC_ENA	0x00000001
-#define RCAR_USB3_INT_PME_ENA	0x00000002
-#define RCAR_USB3_INT_HSE_ENA	0x00000004
-#define RCAR_USB3_INT_ENA_VAL	(RCAR_USB3_INT_XHC_ENA | \
-				RCAR_USB3_INT_PME_ENA | RCAR_USB3_INT_HSE_ENA)
-
-/* FW Download Control & Status */
-#define RCAR_USB3_DL_CTRL_ENABLE	0x00000001
-#define RCAR_USB3_DL_CTRL_FW_SUCCESS	0x00000010
-#define RCAR_USB3_DL_CTRL_FW_SET_DATA0	0x00000100
-
-/* LCLK Select */
-#define RCAR_USB3_LCLK_ENA_VAL	0x01030001
-
-/* USB3.0 Configuration */
-#define RCAR_USB3_CONF1_VAL	0x00030204
-#define RCAR_USB3_CONF2_VAL	0x00030300
-#define RCAR_USB3_CONF3_VAL	0x13802007
-
-/* USB3.0 Polarity */
-#define RCAR_USB3_RX_POL_VAL	BIT(21)
-#define RCAR_USB3_TX_POL_VAL	BIT(4)
-
 /* For soc_device_attribute */
 #define RCAR_XHCI_FIRMWARE_V2   BIT(0) /* FIRMWARE V2 */
 
-- 
2.43.0


