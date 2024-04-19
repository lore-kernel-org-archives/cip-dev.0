Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A5FC07C79
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:51 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.18452.1713526783389680342
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=cqwHcrEu;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571bddddbc2so1562137a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526781; x=1714131581; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBvc5l+iPrDrls25A38Egov3dW25kkff7eJQdDPc3cQ=;
        b=cqwHcrEuS0xKzAGLavQyoaF9hnsuAMUSuK3ktfWq5F9pS8czkHeOx54vl7GvI/P1kE
         8wLVnhZXFa69NSlUrUJo3xxcZhl92o9kHuUZI6g/P6OvaOEYMJETJZhIEU1jT8tQwSFs
         S1BrpWt4NfbCKfNMVRyTlwexvUvRWQ3NufJnfU2rXzFssD3GEgJNp9NlVPdIhjwScmtE
         lxa8W9y/yI+nZ8mAHLUhQ8cRZXKZE11r5pnDq5iruDPtLnyh8OspiszNZ0zkRg6Ec18K
         pQ/YS3nVO7uc1CwvHDFzjvdM7+/un/JNJMDoRXEoTftiKjfQ7Df3PlSCBrAjBG4ErDZX
         1M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526781; x=1714131581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBvc5l+iPrDrls25A38Egov3dW25kkff7eJQdDPc3cQ=;
        b=jDkbBwgUMpDPPpkPBThs4z2frXXEz8rAAa43to2lIIpAIkw/rIpNqifVQSxYJYjjFj
         AzOKT9CzdkL2YVvCHzHZN/dadmkSVKHpWxc1a1ScpU6CmJCdecT4oLpuj4fKE+3QUtlU
         ErWieMvGt/5zk8pYe22+4zCjfRyiJSvhQp2JN/K33nU+bgur0xo4R1F0NiQa5KAjd8ba
         46jwRn1U5numybNc+JQRWIHFB7oBUpcIAsHwaJaAtBvvQqVEtjU+A08FesStzW0ewnGA
         WeW7vxJkg3g2QEJUobvZstSRqTr8rAVxwn5ETAU+QeuWmTpuy8ea9TYJjUiO5q4SdVSy
         uz1w==
X-Gm-Message-State: AOJu0YxHP3PiLVjtUu2Ujav7kSzhMgWfqoFvJhdg3prWsLvHFO593DuQ
	8xthmKuYnHEbkvnYQxShVLzT5NKwDQaqvC9UzKrER2cfy3DVkGXVU0CXphGLNzA=
X-Google-Smtp-Source: AGHT+IG6r1bDMQ5jsgnl7IzpQAdM+F5UpRVqLoRqW3KZo8FBjQWEmqwSvbLXCjtvXiApGijfOhwAgA==
X-Received: by 2002:a50:9508:0:b0:568:b622:f225 with SMTP id u8-20020a509508000000b00568b622f225mr1273838eda.30.1713526781427;
        Fri, 19 Apr 2024 04:39:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 38/44] arm64: dts: renesas: Add initial device tree for RZ/G3S SMARC EVK board
Date: Fri, 19 Apr 2024 14:38:36 +0300
Message-Id: <20240419113842.3675543-39-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15689

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 177e2ee9a967d410b6daeff7a5b85f96bb833a2e upstream.

Add the initial device tree for the Renesas RZ/G3S SMARC EVK board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-28-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile           |  2 ++
 .../boot/dts/renesas/r9a08g045s33-smarc.dts    | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 0699b51c1247..7b0f06600f20 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -85,6 +85,8 @@ dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
 
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
 
+dtb-$(CONFIG_ARCH_R9A08G045) += r9a08g045s33-smarc.dtb
+
 dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
 
 dtb-$(CONFIG_ARCH_RCAR_GEN3) += draak-ebisu-panel-aa104xd12.dtbo
diff --git a/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts
new file mode 100644
index 000000000000..6b57e0e02dbe
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3S SMARC EVK board
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+
+#include "r9a08g045s33.dtsi"
+#include "rzg3s-smarc-som.dtsi"
+#include "rzg3s-smarc.dtsi"
+
+/ {
+	model = "Renesas SMARC EVK version 2 based on r9a08g045s33";
+	compatible = "renesas,smarc2-evk", "renesas,rzg3s-smarcm",
+		     "renesas,r9a08g045s33", "renesas,r9a08g045";
+};
-- 
2.39.2


