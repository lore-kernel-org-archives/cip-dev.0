Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F225C5B559
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:57 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.6983.1748942390451095701
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Liq8VsoJ;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6049431b409so9668148a12.3
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942389; x=1749547189; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oseWGXSaYZaX7/sRyz4uwLhrpBQ8Sfnn9D3nj5Zzl10=;
        b=Liq8VsoJDcvC7Zt2woLScxEcBxYa+fDjtOwVV59kF9+RkvTOHsj2BZa1cA9kvC6n7l
         3d+hObVzJpU5930h+RqSovJrMDMCfTAKjEpLJFlO7M2YALKyVEQC1LMlSvPjgBVUT4TC
         MXvE27YPjlNb9XVq9OfJNLXcVRsKK1GRCitfNI2AZ1UqiqtPXrE/d9w9O61WpT+cIuCd
         R+FYWCtO+C/aNu/7tIbTav5onxrKIzTt3s8rD1t3aIxPoD0vw3OMdWiTPZJI5CMuerRV
         jEqIly0gOH5Ah5G/0ge8AYT+h6fa5IstibjKJwbL2YUrlg2QTB2rOfAXJ8m+CxlcIlpr
         zOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942389; x=1749547189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oseWGXSaYZaX7/sRyz4uwLhrpBQ8Sfnn9D3nj5Zzl10=;
        b=qjV4dDZYMva3+GAkbFMruwq7p+artKxDD1U5CcQPVxjhhRmdnyPsOauXkvn5uWkNm4
         OSMjoRyeFBcTB/gcPzViaZWoF7ILvxopuxXJCshnbLUWc1N46jNES28waj66ym7bfhcC
         UYR8IeOzKaXGFiNCaprmA275MQZT4xRX3XqScPSiAV8QnH7Mamq7LksJ3hHuzKxzqg37
         yNqoJ6HZIB2HfaQzUKB78agqt7z30O5EFvWWBS+yINh3wv3NAsK6Nqaz3WF0GcjFsG/u
         REOzP3bZjX64PfzbbymxnB9R/dh8iiVoDeicGKbRQSrTVkuwZeSZ2cvt4fdgBF4WEBbo
         WFiA==
X-Forwarded-Encrypted: i=1; AJvYcCVA8JgZm2uhmRcgzaUL2NJi7Yjcp/GVLSpO346JOWVI6PfLvOQxFnLNZeyYsC4PPOZN0WKVXt1/@lists.cip-project.org
X-Gm-Message-State: AOJu0YxSlBeq755obaHpCGrEFOzmeRT72KDR04Ck55yhLHVsdDs5jzBD
	hb0kyj/azYR5hUdgerkE5odnQv56sN0rpXE2powjyCIS7z7XZzJyDpVtZJbH4qYaKVc=
X-Gm-Gg: ASbGncs83I0MPjcVbDtA3S1E+qCdY/e8HotU4uBX5aC0H8CTI6ivsPC4g73Ego7fdjE
	jyzzMzET1awKpgMy7NhmoctTHi3gFDHkAAT8xmi2QXRemAK1Wfzu/3Pw+JhqB+fksaeEw469LpB
	54zlwFsFHTfWbW8tCFS5RNi1idLpjISsRd5iMkB0od0r2sgQtOLj/WQr46eK6rx+XW7Txej+Fm0
	F1q9cas+Ttnl839Cl+f63kO++OT6jZTm7gu8ecTQURluSN5wF+5cKWuxSUnavnXyLIu49QPUMB6
	or12dh1z+VX+fBcXcIcA+VEAW3pmlE4BBd9Dx3Z3e26HtTa1kenOdFyvHWoW2dGaufVPKc/TRXX
	UQVjw8g==
X-Google-Smtp-Source: AGHT+IGbwD53+GmAMfiIQ0ZCIu4QNTHyFD12y1zcN9V4csOLCl5uHg6b5k/NRHIi8VOVQADi6Zv0sQ==
X-Received: by 2002:a05:6402:2692:b0:602:225e:1d46 with SMTP id 4fb4d7f45d1cf-605b7512d80mr10926373a12.3.1748942388854;
        Tue, 03 Jun 2025 02:19:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5c5casm7301944a12.25.2025.06.03.02.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 6/8] arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe different switches
Date: Tue,  3 Jun 2025 12:19:38 +0300
Message-ID: <20250603091940.3917581-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18980

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
[claudiu.beznea: fixed conflict in rzg3s-smarc-som.dtsi by keeping the
 newly introduced header]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 20 +-----------
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index bdf1507fd2d0..942f9a5fc543 100644
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
-#define SW_CONFIG2	SW_ON
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


