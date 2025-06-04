Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E65CC5B552
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 10:24:01 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.13296.1749032632770182446
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 03:23:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SQ/GgbSy;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adb5fd85996so649637866b.2
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749032631; x=1749637431; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzI350RpZEDPfoORYpWiGr8SAF3q4RVQOG3yLP0RaTo=;
        b=SQ/GgbSyH6wdEe5f5N0mXa84oHKDxBwPBl9wynRXIGa6ajvl+pwqeFtiPy+Thx1byw
         aWaC5+qUnfF83gXs3T8i6IiZYTpYpOKLfL9XuKYrp2et31LG7gC9RqnX4MGUC1if1Ywx
         a0IOsKEa2/Tvxq9KMxN3CbtjQWb9jmzj/Nj3JnVymF+MzG+I2qli/GInM4Zm3u/FHR4A
         bils1eKPcsRAR2s8zCLzM0olXM0HuAzkcOgAsQfDpuOm10DDE9wr3MARN9KHCU7sqTPa
         ktbpt/pl3Aksdc4o+ijdQvCQKOf58HVByRK2M46yr564SrDdLxeaxgjPjUca5dqgWoJ/
         3fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032631; x=1749637431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzI350RpZEDPfoORYpWiGr8SAF3q4RVQOG3yLP0RaTo=;
        b=k9EuhKnzwowExC4Rf4HMt3RPUhDebwiHo4XldvfJGE8yTZC6Fd8IU7lr+H6CGq/qCj
         fMHVCbfYPtSH7SpFu4OgsVMR84waqRW+sJOhW4VEXQXb5aegxgwoSjWfa45q2lrxkMd0
         RlqFYeDRyfUhqyKurPrYVywvXwmyr/As8ivbBkwKvyV97MQxzmujEJUADVl2P/sEK7zS
         eH+mgv0NYcGBQnwFJH0F7ABGshCG0rZrQSF5DqQWNTvoCW41TcNruoThWhBYJ9TXLkH2
         bI3eHoyCFF8dy+4/Ot03jdNXi0GNeH1eKoyLPH3mnJK5v/JirpbJ6l4xV59A0rpZdpRI
         CWfg==
X-Forwarded-Encrypted: i=1; AJvYcCVzeFOcnEQtXeZQ632ix1pm8pdmKJPonjewnYYL7a5YbrVqXEEKljiGjU96QmeGuR+Z6Or20hNb@lists.cip-project.org
X-Gm-Message-State: AOJu0YypH/+ehkyhL3Xy/eJkDdq5OzT/gCGM2YNL1ylfxOQxpEj0K6PX
	1vgShKlPr9psWtypKewM63SclZ9vuBYSDhlGRAEpkdtA9tRQPTQFmxUuwsB9MDw95s2KDjcbKth
	sfiKh
X-Gm-Gg: ASbGncuzwMYkJpwPXFzEweTkHg+3LeYnkXpuJ+j9qpGMgyWpivixpEHDqYIFHbf2hwS
	aAXHNS4UtaDxEs8XsmdkCEd9ZkxKj0mw2LHr4136nyxJuuDXMIEhThmBuowScdkMkvcHkMh9K/f
	uhzP7y2ijXILdtfnBsU7tc1OhRVe13miLdie71MKete0FcyQpxaXsERhCDgTRcftyHMUKtl6o4T
	2MD6QG1QrmZOQ8bCCuJyPQ4Ty+n7XHtdnwoYccXoOPTNMrmCP8isYnH6LCRkhpzW/adCPmUI8uS
	vq+t7MZreJQtaKHt+JIXEf2D0THcM0NwAvKGdgDBMuAuwTeP5+hGE5JNstBb9i1VPOCj4MwkAPy
	OIICkbA==
X-Google-Smtp-Source: AGHT+IFFDlx/i9lkjraXZgzDWUr1Rflr8IgxdgVVfMeAbdrI1cB6tDmWQY3nW2tcaeIKxu59i6Ogzg==
X-Received: by 2002:a17:907:7294:b0:ad8:99e7:171 with SMTP id a640c23a62f3a-addf8cffd75mr181731566b.21.1749032631100;
        Wed, 04 Jun 2025 03:23:51 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e760sm1087375166b.52.2025.06.04.03.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:23:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 6/8] arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe different switches
Date: Wed,  4 Jun 2025 13:23:39 +0300
Message-ID: <20250604102341.2524186-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 10:24:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19007

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

Changes in v2:
- none


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


