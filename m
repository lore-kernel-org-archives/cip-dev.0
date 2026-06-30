Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF3C43638
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:07 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19088.1782820145070170075
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fldugWXS;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4926bd21aa1so29396235e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820143; x=1783424943; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gf0fIMBNtwOjsZz3zsyVW9jY8NCJ1r3wJLQ4T1o9He8=;
        b=fldugWXS2UJRr170K6W7p4qWuQ4Uz8+JoaBLPF2BNNCheOP0bc/U1TV3NG48vYmrOW
         00PiiUiTcNDaefY6gaaEnwUhD4q6oi62pO+hjyXW/Fddfg/FuW4h4rWgykFuyYoHy5gR
         pPDeBQL30IuQb4cKNcjf7UYqhmOTPdkxi6VM2WuTy8fBqJ+Lf9/Nz0TjUpxDLBUbX6Pa
         PtjPB3Bw2cUJfh7vb0YQWY8smdEB5tSazJd2YdvVNQvYrqAbyv3q+eOiblFtnS907e6T
         sn7kkDXu/YoPWG/UCqpnYFRUO8sumJTjTio8fQEjllzqp5zoDeMeBN2vTvHQeTghKc9s
         eGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820143; x=1783424943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gf0fIMBNtwOjsZz3zsyVW9jY8NCJ1r3wJLQ4T1o9He8=;
        b=g6Iak4C6MCiy9zjBkDrmILkmyRj1gr11q3knRjtP7dI0Ibt/pnG3iBnwkvThY4DomK
         BfAcPqoJJlPPiGmuo5rL7dWp3X0UYmjOfFSbtbFsRBM+vQkw1BEPljy5q+fDykXOqNbY
         ftWY79h0/yVWIuuh09sv7i1L2eq08XDp0Jafuss+DTi+aC7lMZWZRkCgI5jbu6Bm3wnx
         JJTZIVFs5+xL4n1jFKLaSvX7cjMAhZrRrgfAHPSRwdNxy6UWPjSP0/MsHbSKEBTgCgNT
         d4WpYr6YHZgKu5znTfmyBjYKL0vYVq9NU946CVL+D0eEpCVISAKACsojlgbyC2dxHFuN
         m8bg==
X-Gm-Message-State: AOJu0YxU05Avy6Us0lOXcLPdGMKYx37U1XIMJ1U7ysZuih+5ntahyzRM
	g3Au+TaUsM4uYmOULjoknK4SFmA5WWNTd1Os/Z0BFVYpsx4uPnBz4jXimYs1ekOl
X-Gm-Gg: AfdE7clGAqPbkyypa7la0jOcgl2JmmOg+sHJxC+7Shoy+NQuqlZTSZwrILO41cimLhb
	GN/9wb5KoTYrR8ggpfRtg9sWaMtrJaJaA+BhyLTopK/Mlhv8QBeOhPLhMtVN6dSYrBQSryEAZTA
	OhNVit2hJ+knCwfrBhGt14WqiSqhck76qO9KUbKnOEZb2KOGRjfLg+OxAVLui1nl5BSXMyLVeyi
	V7ql2b8KaX0zw23oUXvgaC28ZgQmPX9NUFUqXeDh2T26CHIm1H2Uj44LRkyoHPf6nMoTCnHbK0E
	lonLQvfRGzwoxPqWkNOXe4xmSk9XJqLjO/xuzs5/7SMhAJZ1mdSd7hGzazKS2O9zqJzJ9/SrCEH
	AzBnHlMwLYkKNVr1WGs4tWHzi7CkNV1l9oYUVefEnIqoTkLtdlJoHPJk+VxZPLE+TDLXYz7+PIE
	n2ZGzG3shb0vz7LzCKG+P48fFT2sKJfe6wbZ8xVA==
X-Received: by 2002:a05:600c:1f82:b0:493:a435:d870 with SMTP id 5b1f17b1804b1-493bdaa9743mr3654575e9.27.1782820143279;
        Tue, 30 Jun 2026 04:49:03 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:49:03 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 36/39] arm64: dts: renesas: Add initial device tree for RZ/G3L SMARC EVK board
Date: Tue, 30 Jun 2026 12:47:55 +0100
Message-ID: <20260630114813.92739-37-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23360

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit abe27c6b2e9adff7ada54ce434207c87abe40f5d ]

Add the initial device tree for the Renesas RZ/G3L SMARC EVK board.

Added placeholders to avoid compilation error with the common code in
renesas-smarc2.dtsi.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260324114329.268249-12-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 +
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 37 +++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 6f626da866ea..258966035b38 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -141,6 +141,8 @@ dtb-$(CONFIG_ARCH_R9A08G045) += r9a08g045s33-smarc-pmod1-type-3a.dtbo
 r9a08g045s33-smarc-pmod1-type-3a-dtbs := r9a08g045s33-smarc.dtb r9a08g045s33-smarc-pmod1-type-3a.dtbo
 dtb-$(CONFIG_ARCH_R9A08G045) += r9a08g045s33-smarc-pmod1-type-3a.dtb
 
+dtb-$(CONFIG_ARCH_R9A08G046) += r9a08g046l48-smarc.dtb
+
 dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
 
 dtb-$(CONFIG_ARCH_R9A09G047) += r9a09g047e57-smarc.dtb
diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
new file mode 100644
index 000000000000..86db86335d5e
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3L SMARC EVK board
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+
+/* Add place holder to avoid compilation error with renesas-smarc2.dtsi */
+#define KEY_1_GPIO		1
+#define KEY_2_GPIO		2
+#define KEY_3_GPIO		3
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "r9a08g046l48.dtsi"
+#include "rzg3l-smarc-som.dtsi"
+#include "renesas-smarc2.dtsi"
+
+/ {
+	model = "Renesas SMARC EVK version 2 based on r9a08g046l48";
+	compatible = "renesas,smarc2-evk", "renesas,rzg3l-smarcm",
+		     "renesas,r9a08g046l48", "renesas,r9a08g046";
+
+	aliases {
+		serial3 = &scif0;
+	};
+};
+
+&keys {
+	status = "disabled";
+
+	/delete-node/ key-1;
+	/delete-node/ key-2;
+	/delete-node/ key-3;
+};
-- 
2.43.0


