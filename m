Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331B5C5B559
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:17 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.6969.1748942353239590157
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=AJ6rbZWj;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604f5691bceso9666828a12.0
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942352; x=1749547152; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oseWGXSaYZaX7/sRyz4uwLhrpBQ8Sfnn9D3nj5Zzl10=;
        b=AJ6rbZWjkW6Qg7t7NsLuVTLIG8Xk7Fuk2/Q84RG/MLDMOrFOec+Ky98IRjpKmKBO/Y
         EPlq9QCzRnJHk4sJv7ptBAyxHQncjPeuYy03sWM6gFjR4PQiIf7Hh6aABwUhb1TYHV7g
         pSvhnujjHXoTw+i/cR6C4/T/h7KsYEtVoOxovPOeap7nwNRXHfRQYjBrDJVGbDnysLsD
         SYG9y1iNdo0p8STM0CB7zzjh8Ri7tJR6kuznJqCF9rx2QF34Uq7GL0fHADCjgd1mQav1
         Q6Wzh1tktQtrucYIBRmzIdWluuslTYm93n3RFLss7rTBM4O1eI1IKl7AoRuSv4d3o7iA
         sHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942352; x=1749547152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oseWGXSaYZaX7/sRyz4uwLhrpBQ8Sfnn9D3nj5Zzl10=;
        b=h5QMcq+U66+UMOMPAs9pg4+Sq3oAGbxuxBiKFRBV9Tnq64Avfmi6Hwaui5F06LLs92
         TD9zmeIhsrXWgCHs35CTQ3z22RcJVIWwqy5lVZRZ3Qw6XV7IuhrYUBbUx6Qo/1UQYp9y
         vS6nffPFT3lzDx38ek5F+pPy1TLiF0ZbZQByESEwR8WbBQlcAKLbi6t/HRgC4OQUAcJn
         QwhfM9X5OVYAtK0P4MtFZXbaWzNynzgGKCwVkAcs8gzLYPQgq5QJLOx+2kDUSWr/qLLF
         TCfNDCYrEo566WykhfypejkXnEzHUOh4zdQ1SYx6VmISQK0nKD6z82AexfbqhKyhfu1r
         SNMw==
X-Forwarded-Encrypted: i=1; AJvYcCXRmcTEHTpQ+jeq0rLUruwvFRIrcAsVF24G1JvVVR4BFAgaf46VU5GiAfKCtAIRzlRAG5YtVH1q@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz14eINibpnptf5uLNEtnQKDzrKHhC+03EGTWCwhL2GL1KgM9SB
	ExSmOeRQtJRQosdv/KcFRPW7eJZCaPqKquxBBrqEMPzmpWZa3PBH5ceQ1fM+k3oHDS8=
X-Gm-Gg: ASbGncv6KeGEnrKlzbsDvqTjMoAhx27RuRY46Hbkr7KPm2p2j2g1P+6zlZ4mDtu6smB
	S/3tG5vmp09sWVJ03G5VCj0i853HuKVjxdNJ8Qf9CjCcHamVWQA3OQN1oY+4snkmissT9abCsbL
	BlSbhyE4E7VvyMN0wqcXei2JgOP3gvleAeemu6gvPnDacP5LXXvhtN0DnUbDQl6QZq7mgJ6qWDI
	F0m0XNfPH45d6aYa3sgN/xfsGLblqxavy83ZrV6ic1sYILPkeJZ6/5ginWa1av9Gj6j+fNhfKk7
	MNt8c73EGmCXdeKPm04j6UDjJf7NBd1ILdkKdH1OP24vjQGjdIW1wk4HDudBopFaePSUw+T76qG
	kV74xEg==
X-Google-Smtp-Source: AGHT+IH/oXd/NTpajqhyQh0mBstdOXKZLD6SAua8ol8L8p79gd7+vs3e1E5Boe+64TFx1g+NkmTsuQ==
X-Received: by 2002:a17:907:9725:b0:adb:4917:3c08 with SMTP id a640c23a62f3a-adb4917431fmr1151419566b.34.1748942351594;
        Tue, 03 Jun 2025 02:19:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fecd2sm918093866b.36.2025.06.03.02.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 6/8] arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe different switches
Date: Tue,  3 Jun 2025 12:19:01 +0300
Message-ID: <20250603091903.3917202-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18971

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


