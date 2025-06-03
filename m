Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5F8C5AE59
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:20:17 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web10.7002.1748942415426155210
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:20:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LzNr+QFw;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-acb5ec407b1so845617366b.1
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942414; x=1749547214; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Reo6KcsJ/mjLequuPMD8JFrkY+r5qz3DNelQ1/P83fw=;
        b=LzNr+QFwaJHB17ZgcP7SKDy9Zb3P/tZzjtX8uGGs8ti6FsmyqkUX7Oe1YF/W/OTl9l
         8KXfmP6iemxQTXAXIeR56URYy+WHvQeAOExog4LDjM5AL6olwIOtrcILCskp+Jg5Sqba
         mnQy1LKB7J8Y/p6IYoJtGRROCkHeZEpgrSkBGdbnYWBtIJy01OGjmoF/TTg9PGEE6xKg
         tNZXdSD6UACSji4FJn70byUIvdbgdHIKgLkekJoZaTA5wDpDu4/SCF1v9KKyYYhQSyRO
         gQiygIOvytmfS2S9JyHvOSV3PO4mi9AEkBhADE6/wH7QLObgelCj20DDW2OiaxX/+YJM
         m+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942414; x=1749547214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Reo6KcsJ/mjLequuPMD8JFrkY+r5qz3DNelQ1/P83fw=;
        b=gGInjFnx/GgLz+I+NqueUQaY55pUhrpgzRooY3vCALRPj6LEJd2hqlnsTWfVycSG/t
         rDru5NurCljWg/9Mr4FOXY6P3QKgL6yTVfMIwyiyg9AjkX/tytoeYWhJwv/AbRyyHrU8
         VYsUPuyedlqGSnUN1ASY8UbW8Tmsff8hBd5rAGaCy4fGA5mJjyWPShex8H8QtcDWGNuq
         Tf6itDQLzdXcwKcs7rqMvTt3nERnHb/n+PzfCREfbr1ITGYvjue9QhtXxISPyFIpkl6h
         2adksXT7Zq8KNodl23mEiCk/L2U5DXWKkRnsGvEf6zNKpP1+wpAwGJ8ZOIILdKYWG19A
         YzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgwQ4nOs0nqarbuwlZqGE1kObiGnRjUI3p7JuK+QIadDQmMNYf47T+dFJJ4YmldHw7DRobUSKy@lists.cip-project.org
X-Gm-Message-State: AOJu0YxWp/hgi4Zyg2sIGMhQ3UjJf3vQIMvgMPO9gSHQGh7pXzSDg/ys
	Bk28+ODSnKuQBiYTOE0WLpQOzxKx+ncYKOVk4bOO47SzIGWfj4ORxOmtAAg2XT9Y+cw=
X-Gm-Gg: ASbGnctnOfJ+LaoWo1ibfnkdia2nPl3cY8C+FI5jb1pKrXI0BiqyWE4w4hGUazeBpgo
	ssqLhaof9lAv6VqJtadIOIJicVAWsFr8XXW9Oz7FTXXWJot5jiOnl2VXArBQ3LZqgjw3uOVeaIj
	F7l9oqh50CmF15j8Q5zePjTxW2vP8XgcQULRVzxRLvwWXXb3vK7w3EDJLIMhf5OxhXLgua7G+Vn
	jy2Uxr8xeSTHUmyObYm82JQTwEODPIW9VVVjnBk2R/X6FwWJk+LkCryfP9e+UTTzqFgOvxPGfwS
	Vwkjh6y9dmww866tcAFIqp+yyooX8dQP/IBsqaelhXd1LXXy/wfFFZO+PlR+bIH/9/aEQl0d7RP
	Oj1HCRVjxt6P1Vzdu
X-Google-Smtp-Source: AGHT+IGkA27E6QHZ27aX97mDsb5ND74CCyUI3UOUWHJxxQB332ia4U3eebbmgtfmiRC7oZrlqsYm5g==
X-Received: by 2002:a17:907:2cc7:b0:ad9:6350:c1e2 with SMTP id a640c23a62f3a-adb36c114efmr1526156766b.49.1748942413808;
        Tue, 03 Jun 2025 02:20:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2e220548sm817017266b.109.2025.06.03.02.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:20:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 5/7] arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe different switches
Date: Tue,  3 Jun 2025 12:20:03 +0300
Message-ID: <20250603092005.3917850-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:20:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18988

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 02760e35b5a62f0ca24e792817d720a2c8ddd409 upstream.

There are different switches available on both the RZ/G3S SMARC Module and
RZ SMARC Carrier II boards. These switches are used to route different SoC
signals to different parts available on board.

These switches are described in device trees through macros. These macros
are set accordingly such that the resulted compiled dtb to describe the
on-board switches states.

The SCIF1 depends on the state of the SW_CONFIG3 and SW_OPT_MUX4 switches.
SCIF1 can be enabled through a device tree overlay. To manage all switches
in a unified state and allow users to configure the output device tree, add
a file that contains all switch definitions and states.

Commit prepares the code to enable SCIF1 on the RZ/G3S overlay.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250120130936.1080069-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 20 +-----------
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 7ae319d941ac..7c40532fc869 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -9,25 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
-/*
- * On-board switches' states:
- * @SW_OFF: switch's state is OFF
- * @SW_ON:  switch's state is ON
- */
-#define SW_OFF		0
-#define SW_ON		1
-
-/*
- * SW_CONFIG[x] switches' states:
- * @SW_CONFIG2:
- *	SW_OFF - SD0 is connected to eMMC
- *	SW_ON  - SD0 is connected to uSD0 card
- * @SW_CONFIG3:
- *	SW_OFF - SD2 is connected to SoC
- *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
- */
-#define SW_CONFIG2	SW_OFF
-#define SW_CONFIG3	SW_ON
+#include "rzg3s-smarc-switches.h"
 
 / {
 	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
new file mode 100644
index 000000000000..5c27c043afef
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * On-board switches for the Renesas RZ/G3S SMARC Module and RZ SMARC Carrier II
+ * boards.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#ifndef __RZG3S_SMARC_SWITCHES_H__
+#define __RZG3S_SMARC_SWITCHES_H__
+
+/*
+ * On-board switches' states:
+ * @SW_OFF: switch's state is OFF
+ * @SW_ON:  switch's state is ON
+ */
+#define SW_OFF		0
+#define SW_ON		1
+
+/*
+ * SW_CONFIG[x] switches' states:
+ * @SW_CONFIG2:
+ *	SW_OFF - SD0 is connected to eMMC
+ *	SW_ON  - SD0 is connected to uSD0 card
+ * @SW_CONFIG3:
+ *	SW_OFF - SD2 is connected to SoC
+ *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
+ */
+#define SW_CONFIG2	SW_OFF
+#define SW_CONFIG3	SW_ON
+
+#endif /* __RZG3S_SMARC_SWITCHES_H__ */
-- 
2.43.0


