Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB6C7115B
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 09:13:55 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.37847.1750217921745067492
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 20:38:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J8S2bZFE;
 spf=pass (domain: gmail.com, ip: 209.85.210.178, mailfrom: zaq14760@gmail.com)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747e41d5469so6823464b3a.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 20:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750217921; x=1750822721; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Crp3CEYLqrLG+apC2mAZnpDNJDCfTEyqUeeXu58j3U=;
        b=J8S2bZFENC1buhKdvanztp6Rcac6CMW4Ki6EHQo3GX9rNIcnkUcoPnHwlwlSlvB9uO
         fmQrAvilGgudUwU/Qds7ApfqMc7v0OsgF9sQOi1UGrU9VaSSM4/YP1K2wVBGJqLmN12b
         Xmo0h+Utb2S96MhY6O6kdSpXqK/BOE0NtPU4lCGE8sHvz3/i63EDT3geZh9j5mVxgiea
         IGh7SG7KAF0ZJTctaDrAXRexjcptMgkbPNNfDyHZraNF6AXACe9imKlvyAK/zgSzuj1M
         W8HMFXgUd/X962C/nIKeYatVOcUupKA34r2x3IbqkcXHseAqVy9QQ6PqgqVm0jlJ1eA5
         /M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750217921; x=1750822721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Crp3CEYLqrLG+apC2mAZnpDNJDCfTEyqUeeXu58j3U=;
        b=H/6HsxKzrtS2tNv9EtcvKC0KOGCyCNbmP8JrALc2TBQE2f8kUBYsNC9YgRE5cHfXIe
         7IaVDP+Mvi8uNXeoU2fbsjQSiBSV0phYk6zd36O/PIUTilqI1j1BBBfpkPIHkT34xIdN
         9TAi3waSHuB/myhMgZIjzNBT5ps88rTkdNbt9ddcV+DYXu2sBqLHmhNjoilN1X75SNH2
         e3FgdwfJb6SCOpyYLWfqrGz8/uqbhOdmTy8ZRbR1sLFNwjfBzzLm1UQBrdiZOCEbxK+g
         DCqSeoTt5WaB6Q9/zEdeQlm7LzeBKft3GIb+9hI+hC330Nbn2eApfd+Lh86HaiaWr500
         gwmg==
X-Gm-Message-State: AOJu0Yz1xN7+Hd/9xKEN9M0NeX0OEA/bKYmu62KwZVYlSWJcFd0+4Fej
	z3/kAhifrYZnkNLCMJQR72pAfKi/ftBPZy45WrEzDEaoAukKlt9ryMwRLFWle2PB
X-Gm-Gg: ASbGncutroLsSu7OJX9c1PJGEiM8hvOanxDpFjjDRnuN8A7O23lQMdH04gZ+FouMKfQ
	M4HqPWSk75gLveseVjxlVJUhsGX6bOLY8YQ13ejlX5YBmqkuHtVawIjSFUBkptYr3BN/FrDJQK6
	bGeSp/2vrR/vxCt3dwnxYyWf4Vb84l3xNLE7o3PO2uIzXCHb1yMlk59Kjtx6C2WQ5a7me64nNUF
	I5lXguocTDdDtHpVWRykjqPMMkB8RzGzKe04J8gUP6CiMPHhHQ4QwZ49QQlzvutBPZ9x02Yfmc5
	4G0kN0waC+foBunEIrzOWF1PXtfao3d5G+Pgs9LJF9lISTQ8XwRuft4wIzJSwQ7lR6h4iTXWETf
	nvaVIFgi1sG/y5FKug0P+SiK3Z3BKh+xpCOEvwxU=
X-Google-Smtp-Source: AGHT+IHbSHvGm0QbeCyiMDx7nSJ6QOKwx2BCtI7rOP0KbnpEARCZ0sIVhZ9/sbhyMcG5HjU83gpjww==
X-Received: by 2002:a05:6a00:893:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-7489cffb9ddmr24650502b3a.24.1750217920668;
        Tue, 17 Jun 2025 20:38:40 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900822b7sm10147934b3a.101.2025.06.17.20.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:38:40 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: drm@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	noralf@tronnes.org,
	robh+dt@kernel.org,
	krzk@kernel.org,
	zaq14760@gmail.com,
	onlywig@gmail.com
Subject: [PATCH 3/3] dt-bindings: display: Add MAYQUEEN PIXPAPER e-ink panel
Date: Wed, 18 Jun 2025 11:37:31 +0800
Message-Id: <20250618033731.171812-4-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618033731.171812-1-zaq14760@gmail.com>
References: <20250618033731.171812-1-zaq14760@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jun 2025 09:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19126

The binding is for the MAYQUEEN PIXPAPER e-ink display panel,
controlled via an SPI interface.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 .../bindings/display/mayqueen,pixpaper.yaml   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml

diff --git a/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
new file mode 100644
index 000000000..f7c33957e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mayqueen,pixpaper.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAYQUEEN PIXPAPER e-ink display panel
+
+maintainers:
+  - LC Wang <zaq14760@gmail.com>
+
+description: |
+  The PIXPAPER is an e-ink display panel controlled via an SPI interface.
+  The panel has a resolution of 122x250 pixels and requires GPIO pins for
+  reset, busy, and data/command control.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: mayqueen,pixpaper
+
+  reg:
+    maxItems: 1
+    description: SPI chip select number for the device.
+
+  spi-max-frequency:
+    default: 1000000
+    description: Maximum SPI clock frequency in Hz.
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO for the panel reset pin.
+
+  busy-gpios:
+    maxItems: 1
+    description: GPIO for the panel busy pin.
+
+  dc-gpios:
+    maxItems: 1
+    description: GPIO for the data/command pin.
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - busy-gpios
+  - dc-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        display@0 {
+            compatible = "mayqueen,pixpaper";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            reset-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
+            busy-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+            dc-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.34.1


