Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D053EC071DB
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:58 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web11.15292.1713514736913619579
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P2xJQC0u;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a526a200879so214604466b.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514735; x=1714119535; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5oyNifRdRvSRNh5qaJ2VWlKtPeDHcZUJmI1cVYbRHk=;
        b=P2xJQC0uFnrSUyp1sS91bAteuUtV/ecBF0eF7pUGkD0RkC2FDr9xjFbOAmnED0A3j/
         zz184lxTG3C5I6VuyXPgEg21YOBdO0+G9DNkvCiQFk7n+hWe4hYufZWEeD5e3Wr4gbDu
         B5/vRD9OpBcSozE8u1ZOkuoXTw6pOuWjbwOfbokuEuZgL4t3hdrpI6ywBhDuGmiOXmJs
         w3/wHOJhpvDhxQGoNEtWUODVwUoXkL6sb/RxlD7ow/kxcI2tZjYLpK0q4Z83TkhgqcSt
         x5wY3+svC4b9shq+GWNh4sBD6TCwJi1BWmgn2B3jf4fHRPRxKksM3vLjjsTWGcTu9VAS
         ofHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514735; x=1714119535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5oyNifRdRvSRNh5qaJ2VWlKtPeDHcZUJmI1cVYbRHk=;
        b=pycwx6ALXCPHN+PKJU6so7XSeipCo9UlKfDBzV/uTIsSlfddPwNsEeL/bXOx3voclY
         zgq3g85sMuWZP+Os1qUjgjAIjlUFrKfs9OjAMRnF1b8vz8D5SAipuE8W69ag8QdNgGyI
         FK6geSdEmzwgEi6WUWaJZq9nOlUd24AXPbPM91/FDRuId8jehu9fc74ZICh+5oRSFGg6
         zBayGoaZVPce7qVIA50IudOuKbliPs4AkoRN+aaPGehHJoloYqeybvHxPQqUprHMRK2h
         kCLjg8T7zUCklruKmM0OlCTH2Sj3qsHAfVS+NjqzsAghxkgy4jmqJ8InMTAmGjiPpgZx
         bh7A==
X-Gm-Message-State: AOJu0YxpG4y+z68EnB7HftO5xasHDEh5zajB7k8SvCb2SX+rPJIJp+id
	lQUVRyJKlWwLlK8vkCy34Gw84M8x5PSZ3VFMDxSfjM1rExX9kTydRMVhMIvll9Q=
X-Google-Smtp-Source: AGHT+IGOHM+DZfDGEIwbg0Jq13z88Ayu+o/nZAHsLM9oksN4zBkSON0m9D++BA7rFaR0Bo2z0GEJYQ==
X-Received: by 2002:a17:907:bb97:b0:a55:661d:8ab1 with SMTP id xo23-20020a170907bb9700b00a55661d8ab1mr979029ejc.39.1713514735362;
        Fri, 19 Apr 2024 01:18:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:54 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 47/53] arm64: dts: renesas: Add initial device tree for RZ/G3S SMARC EVK board
Date: Fri, 19 Apr 2024 11:17:36 +0300
Message-Id: <20240419081742.3496709-48-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15634

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
index 44eafef2ea0a..1814400549c5 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -64,4 +64,6 @@ dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
 
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
 
+dtb-$(CONFIG_ARCH_R9A08G045) += r9a08g045s33-smarc.dtb
+
 dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
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


