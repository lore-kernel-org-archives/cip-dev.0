Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCB2CD12B1
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.32309.1711527518675942679
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NIVCK0ls;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41495ac5b91so918285e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527517; x=1712132317; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghXDC+ZbHpX7uDYtrrmmbxqKhRZcnO2sAVGG5DmBwIY=;
        b=NIVCK0ls7K9tHZujbbIbCcn+20/Vt2AoBMqIW2wkGbiIAS+Cm3I4tovJU4S9OQU+RC
         MNX3Avw667Xomdc5ShjBYHv1IafPAb1C+6dGLRatxTyQPkqLtkkrSgEVfb7aNdUNQtv9
         aeg0y3/6WkEwFa8VF3UzCzbwL3cKKOL5zg6n6Z5mq9w1LD9OniUfzrEGa2cjfUvQOoVT
         10BaMqx/AkYd1R+ff1aaHFB7ddZqVma+SAv5voRdtfnLb5qdVj84lEeVgc8xku+M8PgE
         h/lpNIxu2W7uDf3Nd++D+BsTrlPcN9UcPgeVhX1yEtkHnXK+czAIu8/tywJs6XhQd5Uf
         YNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527517; x=1712132317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghXDC+ZbHpX7uDYtrrmmbxqKhRZcnO2sAVGG5DmBwIY=;
        b=LuUcx93SN4WLEu5U2aoFZ06dWfRz/pHveck+2XfG6IrtyTH0RG2OJpXTmx53yuVXaX
         gR/EJqL3zC308zGQTRSWY63CAXG9wxXUrQjjg42VXZ3EZjKJpepG2T6nXBvjZvGyPyM/
         udTOsh9PK9WpZesHm8IPM2W7WU0mdQrPaNHhJE3itvc9mpeYCUJTYmT7HjYLc9Qys2eb
         gy+pcP5/plsIou+Cs1uzBB//umWqrzfTBkhzM610mXw7VBlfqPC2OSqGbSfSEnzOuclR
         K+XnbC4mjAxQtj4+4oKS9HE2jfNZowoX5zespXpbAydGhsTtgwWIKXLj7SGBbC6AyHVJ
         VLIg==
X-Gm-Message-State: AOJu0Yx8v5p481E77Y++JAbKqMUSm01u0/La6rvGoemsx9lMll5lQ9ai
	SXfGoKxj7+8stB7cVBV/VyTKfTIJ/fWlxetAfk7SL2zFnEoyDyEzofjNOPTBb10=
X-Google-Smtp-Source: AGHT+IFjrn71id4pzVds+sAu0or3YxUKgXWVRxZ3xQzija+An2NMrGjcgLPdAZKuT3LNRLVjvUGNPA==
X-Received: by 2002:a05:600c:3508:b0:413:38ee:69e7 with SMTP id h8-20020a05600c350800b0041338ee69e7mr466750wmq.36.1711527517155;
        Wed, 27 Mar 2024 01:18:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:36 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 33/36] dt-bindings: interrupt-controller: Add macros for NMI and IRQ0-7 interrupts present on RZ/G2L SoC
Date: Wed, 27 Mar 2024 10:17:53 +0200
Message-Id: <20240327081756.2228036-34-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15450

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 80c4ece67b4050559e4e2417e77bbfd57e8b3899 upstream.

Add macros for NMI and IRQ0-7 interrupts which map to SPI0-8 present on
RZ/G2L (and alike) SoC's so that these can be used in the first cell of
interrupt specifiers.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220722151155.21100-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../interrupt-controller/irqc-rzg2l.h         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/interrupt-controller/irqc-rzg2l.h

diff --git a/include/dt-bindings/interrupt-controller/irqc-rzg2l.h b/include/dt-bindings/interrupt-controller/irqc-rzg2l.h
new file mode 100644
index 000000000000..34ce778885a1
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/irqc-rzg2l.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for Renesas RZ/G2L family IRQC bindings.
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __DT_BINDINGS_IRQC_RZG2L_H
+#define __DT_BINDINGS_IRQC_RZG2L_H
+
+/* NMI maps to SPI0 */
+#define RZG2L_NMI	0
+
+/* IRQ0-7 map to SPI1-8 */
+#define RZG2L_IRQ0	1
+#define RZG2L_IRQ1	2
+#define RZG2L_IRQ2	3
+#define RZG2L_IRQ3	4
+#define RZG2L_IRQ4	5
+#define RZG2L_IRQ5	6
+#define RZG2L_IRQ6	7
+#define RZG2L_IRQ7	8
+
+#endif /* __DT_BINDINGS_IRQC_RZG2L_H */
-- 
2.39.2


