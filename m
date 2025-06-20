Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FEAC7115D
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 04:25:16 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.2298.1750404080925994858
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Jun 2025 00:21:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=O3QF3tqO;
 spf=pass (domain: gmail.com, ip: 209.85.214.180, mailfrom: zaq14760@gmail.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236377f00easo19694225ad.1
        for <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 00:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750404080; x=1751008880; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oen3S8vgE8gK573zXTn8V0hMlW2RlWgNC9WkX1jI8W0=;
        b=O3QF3tqOejy/RaHxnnEuq1XuL1xjVFYAHMBwyT3XZjgcvnaSfv0C+ttHLtyTBhWk5f
         FHFrbOyUvqEAK8kNgrq08YVmxiGydCFD9peIoZijf46k2/b2ceh/coJMR/RkTtbVGZz5
         6DmMvTZnqbqhn5MZilBBfkn7VLs5uW2Ht3K4xor/iOa9b4bOgfscbAAgcsdLm87HEugM
         7lcFqFhhtGCQrDjyKiEEpp0J4fnUG6sxJ4Dau0xJppVmzprzWrtJRD2wStYnEpS29fZO
         s9/2OT7QUg127KCTPOww9Pro2r2352qlDcbplZocPZkIfjjcCi1mUpI4W54LfgE5vnJ1
         j+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750404080; x=1751008880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oen3S8vgE8gK573zXTn8V0hMlW2RlWgNC9WkX1jI8W0=;
        b=W6m+EkSy9ASp018sS/ITHzOugEbX7htm9MPSJhG/C9X/2ES5yA8PcsVFtqVgMk28y+
         kKls8V6LegQgoOs8PGcAiqXqJ25Xd0dePd76FZxHPcZxXhpKMRbwMZ75AYAHtA445Qwr
         JrfRcUrJ92t4kElEMFczlnFTCqUCo07v2ytdj5tJkpnpSMH4HcwT7gOzjJ6QNW7tvn7j
         AlM3MkVpuAuOLSjp15i0O2wBs971BKLIF3bYFI8lAWoBx85yeKRFFOJ88tTT+ljduGi0
         gNJzuJwNUjlmxvvMLB5mf//tgfl07EijAuN8ep+/OiWwLroARqNitwqp61xD8xhYorxT
         QLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlUw/cOG8Kx+IJ2jpi+nj65jpNxrLVPLeejhJ68cHNovgAOIm4vFERXiNlLfZRJAl2uiIfE6KD@lists.cip-project.org
X-Gm-Message-State: AOJu0Ywn1otwNSaDXC9jhwwcFjDUs86jwu7PzhXfveF/AFn0WQRwNP6g
	iX5LR+qlqGZT/TiU7R20S+NPiwe/5WF9smr+O7cf6Ws0fwz4L5DoESEg
X-Gm-Gg: ASbGncsxu9NwBJt31cNmygNS8ozkhcezGBr7mvq5IizTZM83Vd7oZ0Kq8AR2e9DAK2p
	PbmNV/L7gsB9XOv1i/QSlRDD8m2OO8nf1QOEcGZnRJMZu6BptGAmWNH2Qmd2WpBT3JHTblD70UT
	+vYpn3LN23TqkbZnYJSeL6KGewCnBT8peb7hw1gPamB+kc5EHL2T6zIDFZOn9Gu76IpzMdASFQO
	ZwPaTEEot+yf6SvTcybqm/nfLHlP8/G83aVdOSQu55TV6FwbnwJa9sNgISzyIdNwOGCDybyBORn
	TWDJQO851bvEaiP8/3elrIxjZgALb37+KX8NceHTgSPRzPBUphC1jJ55sOCDr/x3FOzIc1Dwlcp
	zz+Gi6DvcCvgqhOwL0B8VSneo4DVhd+VEFwUSmJA=
X-Google-Smtp-Source: AGHT+IE8jrR/FSPE0WL/k2eesLgwqY6RHFRbkfuT5XzExyxmxHU7R8/3OD6P1TLNyHI+u6mn/V1tJw==
X-Received: by 2002:a17:903:18e:b0:237:7802:da30 with SMTP id d9443c01a7336-237d9a74d4amr29327045ad.31.1750404080163;
        Fri, 20 Jun 2025 00:21:20 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83cf981sm11431995ad.59.2025.06.20.00.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 00:21:19 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: conor@kernel.org
Cc: drm@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	noralf@tronnes.org,
	robh+dt@kernel.org,
	krzk@kernel.org,
	zaq14760@gmail.com,
	onlywig@gmail.com,
	cip-dev@lists.cip-project.org
Subject: [PATCH v2 3/3] dt-bindings: display: Add MAYQUEEN PIXPAPER e-ink panel
Date: Fri, 20 Jun 2025 15:18:27 +0800
Message-Id: <20250620071825.741903-2-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620035310.735055-1-lcwang@ieiworld.com>
References: <20250620035310.735055-1-lcwang@ieiworld.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 04:25:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19160

The binding is for the MAYQUEEN PIXPAPER e-ink display panel,
controlled via an SPI interface.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 .../bindings/display/mayqueen,pixpaper.yaml   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml

diff --git a/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
new file mode 100644
index 000000000000..dd7a84dea147
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mayqueen,pixpaper.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mayqueen Pixpaper e-ink display panel
+
+maintainers:
+  - LC Wang <zaq14760@gmail.com>
+
+description:
+  The Pixpaper is an e-ink display panel controlled via an SPI interface.
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
+
+  spi-max-frequency:
+    maximum: 1000000
+    default: 1000000
+
+  reset-gpios:
+    maxItems: 1
+
+  busy-gpios:
+    maxItems: 1
+
+  dc-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - busy-gpios
+  - dc-gpios
+
+unevaluatedProperties: false
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


