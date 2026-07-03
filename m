Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B598C4450B
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90789.1783076377365864445
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=IJ41Q8pd;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4745492ed3aso290261f8f.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076375; x=1783681175; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4q36YAJqBbnie2bdXu1m0IxU5dZpr9BBO7rbpGL/Vg=;
        b=IJ41Q8pdvBvD1VkBGzTNyhiuM0btLOjhWlm73nA6PXBARJZesS8mFUV9yyh5Iq8Dy/
         XadAikLTx6bnIMXuX32e73qy6s3QFtr8YzrVdh5DlhnLSqA0Wm8QvGsFWCW1z0jiPH1l
         D8BXrFY09bz9eDineP0UR4T7q6xSg5wIXHcD7tUZqMr2LfUd5WDtQ4HCc0HLd/XKukac
         rYMZJafTwOK7Tzv6hBXrtpwa4rG84tgKwE42IHeAH9zpG0h42hDmoplE5IgMqeOvJdhg
         UEY0J8kEcocUDWls+HbsUf9e9eaj1MbclJIDVXnka8jGShCgQe+ovV9I4mpr8FxKndjZ
         8tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076375; x=1783681175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4q36YAJqBbnie2bdXu1m0IxU5dZpr9BBO7rbpGL/Vg=;
        b=PGG471YrdNUeaz6Vc9es0WWTvRzI5eacAnmoZPC3O4yrMAcQeq3i/GQ8Kii6CiDU+l
         Ha3oJxIJldJG7K0LSZfSNhu3b7vec1qEEeEbCzTySkZGX9OeZ3EMj+AghCjDWZhpD/Yp
         eMV5ltE2TPZ+HogHJs8ntmxP8Tfe9sCBoF7zBiuim4JZiUHY1KBOQYXe055aLSF+6icc
         4IpDxun2eav7J5Y8/RlfaE3XZ00nr79CTdpl/RcOKZi9LV7NIQIRe9nBWCRHedHSEbDk
         qdygaDTr9Nn487bsikpQONaQTEf9pPBsXei8xmjF3ZS3nr8022zobgfpE8+zEElJck09
         n6+A==
X-Gm-Message-State: AOJu0YzaEs6eYNa687KC1Q5bJtX2tq8DNOICAAttyLz/889MchDEY82d
	3deV0U+lXds2gT9lVCo71HG78/kEZZkwhpEfQDsIHiJHZe3eNzjOve0b66YID0+E
X-Gm-Gg: AfdE7cmiTh1sWio+d5PdwTv6VHMHYdEV5LlkAP1+QIc6not1JbtF4hGGho0v5/tyuov
	713/DNqBRwN2nmGUEplUaj9y2Pi8YigJoa7kufvgqsftolf6txyj4zTdRxzIbD/MrQSqnBqiVn/
	w1vAvUZh40xRWOmKIodAfSz8qIb5zJbb++hBEMPstUXugaUF1/qjbZOf2oFNmr5hfbNbWGjy3yf
	n1FJNNvOn8hg5aMZ/0P4z6TwK6C1TipM4Ezw+fKv14efu1a6K9eyl/IzHn+6WfsLdonfe/NOfg8
	C4oUY1DeOLoLVRF8DIDuN54CZxmttqWYvyKdvKHu6fUXmcOkff96CN1gCjS9++5T3sdtEhNV/eA
	5mwHE84LqCL9mwQXQKGFVhAuSggsLGafpF0RPwgxpOzoDn1PNu8sqTuZ34qc918zQq9w4s00RGa
	/OxVv9JgxlYq6sUBq1JcOE
X-Received: by 2002:a05:6000:4203:b0:470:3edf:e2a7 with SMTP id ffacd0b85a97d-4775918f8a9mr14116809f8f.37.1783076375473;
        Fri, 03 Jul 2026 03:59:35 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:35 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 23/23] arm64: dts: renesas: r9a08g046l48-smarc: Add gpio keys
Date: Fri,  3 Jul 2026 11:59:14 +0100
Message-ID: <20260703105923.251255-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23442

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 662ce0d73322d17614b86b641aa0ff27a254c87b ]

RZ/G3L SMARC EVK  has 3 user buttons called USER_SW1, USER_SW2 and
USER_SW3.  Instantiate the gpio-keys driver for these buttons by
removing place holders and replacing proper pins for the buttons.

USER_SW{1,2,3} are configured as wakeup-sources, so they can wake up the
system during s2idle.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260528070239.33352-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 26 ++++++++++++++-----
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     | 17 ++++++++++++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
index 0ae052238b3b..ef00e316fbde 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
@@ -7,10 +7,18 @@
 
 /dts-v1/;
 
-/* Add place holder to avoid compilation error with renesas-smarc2.dtsi */
-#define KEY_1_GPIO		1
-#define KEY_2_GPIO		2
-#define KEY_3_GPIO		3
+/* Switch selection settings */
+#define RZ_BOOT_MODE3		1
+#define SW_DPI_EN		0
+#define SW_GPIO4		1
+
+#define PMOD_GPIO4		0
+#define PMOD_GPIO6		0
+#define PMOD_GPIO7		0
+
+#define KEY_1_GPIO		RZG3L_GPIO(J, 3)
+#define KEY_2_GPIO		RZG3L_GPIO(6, 4)
+#define KEY_3_GPIO		RZG3L_GPIO(6, 5)
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
@@ -30,11 +38,17 @@ aliases {
 };
 
 &keys {
-	status = "disabled";
-
+#if !RZ_BOOT_MODE3 || !SW_GPIO4 || PMOD_GPIO4
 	/delete-node/ key-1;
+#endif
+
+#if SW_DPI_EN || PMOD_GPIO6
 	/delete-node/ key-2;
+#endif
+
+#if SW_DPI_EN || PMOD_GPIO7
 	/delete-node/ key-3;
+#endif
 };
 
 &pinctrl {
diff --git a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
index f53e6332e2f4..1e4c929d7081 100644
--- a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
@@ -5,6 +5,23 @@
  * Copyright (C) 2026 Renesas Electronics Corp.
  */
 
+/*
+ * Please set the below switch position on the SoM and the corresponding macro
+ * on the board DTS:
+ *
+ * Switch position SYS.5, Macro SW_DPI_EN:
+ *      0 - Select multiple SMARC signals active
+ *      1 - Select LCD
+ *
+ * Switch position BOOT.1, Macro RZ_BOOT_MODE3:
+ *      0 - Select JTAG enabled
+ *      1 - Select SDIO {CD,IOVS,PWEN} and GPIO4 Active
+ *
+ * Switch position SW_GPIO4, Macro SW_GPIO4:
+ *      0 - Select RZ_VBAT_TAMPER (position 2-1)
+ *      1 - Select GPIO4 (position 2-3)
+ */
+
 / {
 	compatible = "renesas,rzg3l-smarcm", "renesas,r9a08g046l48", "renesas,r9a08g046";
 
-- 
2.43.0


