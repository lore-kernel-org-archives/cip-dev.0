Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2828C71155
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 06:16:54 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.70.1750391601644607681
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 20:53:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=S4+YRpXl;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: zaq14760@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23649faf69fso12684525ad.0
        for <cip-dev@lists.cip-project.org>; Thu, 19 Jun 2025 20:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750391601; x=1750996401; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zk73xpM/6pu5NWnf3cetMa8ItGExnxBDcRFM7cGPPQ=;
        b=S4+YRpXlKjR6mPF/TtxdSwnNKeBInaUitdD3/AKYdGV2L05e6d8bOwv6pdOhlo2Xru
         j1JxL/CDMnqI2cr78OvnxwcwrhVkpYepjRMBpp7L9yQwbqbH4ZTVpGk9FHbUw3W8B8pn
         eqhMKW93F8Soiab0ggRRy4k+UwEiTu7gw/ipWyfKC9TWZOopXQqlCpT+gbz+MYvU5qHX
         NUt25Iaz/p8333OBFF+4cs2gHXomSYf937TS40CZN0cmqAjB4IoCpMT4BYb2eIIQoL+j
         o78UBfeXFFjobHKf4rfD6u4pE0CLcoY6TthfG0pFJTQVdAvo7QxK6zHqIajKEWAL/HW4
         w2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750391601; x=1750996401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Zk73xpM/6pu5NWnf3cetMa8ItGExnxBDcRFM7cGPPQ=;
        b=CyA7GT0uGbr2k1WZLxC976V6rKpHPerfJq07xBas4og2kw+XppqPlg5OrhFeWdyHnA
         D+BxKQuATK7p6ADh/QsR2YmLnKoUfXmoFNKRE8g72C36m0W+kbiKxcfnyvFZpRDW09SO
         fQYqKasdBEEZEupGMmHtnczsPaJix9CzVcj3Q19tZkSIG7HuYvSf1PGSxFzQBcHrhbM2
         4aiAleHs96SpBzHW6pBkdzVT/jHj2WGOatBYGpeRc21WDVYB+4izW95XbI7txMm4ReOL
         HxTCs+3gF3lA7G3f8lmogQk8INXgYxmvXiQ0BXj3KsV7Vue8aQivdvsW45pN6H8guNSC
         re/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0b02wgzHrA5diM4bE/wtyXzEoBAlf1Tk1LbEVBLzadS7t5lKYADLpqouKwlCe73yPzcgVsydH@lists.cip-project.org
X-Gm-Message-State: AOJu0YyUy4CN3dkquFzhG+9c6I5x1cJhyTXEToluwRRhuWUMiGQUx7/u
	wUetfzfrrdswdUHyDG7PgMp4HxZhgEr+FLHt9rcGScxH76b/u4wqaO+u
X-Gm-Gg: ASbGncuuKDD9Fs17Ja9y19f4a0DTvWLTTsF7Ny8ptZbm9sQ/+mAK36ppWooR4BFbyfu
	eHbjg2sPrG8CC/GEyvLRYAWx+Ocx7AG1sFo0tdOhcLC9v8sOu6uMbxeZwLO2tGPEF7bzN9An7uK
	DfeTr1IZ+8IvST9mWEvD3ZrpFfjBLiDFuKPFAcDOHpNWaDslGP2eFiP8fh1yMnDikySIQSNUu4r
	EigWxJodCFy+JZfoyGMt3DhV8rDXVQFEJVVuB2anSJLnLck+gpS7yTjOvW4fU/qREGUsjiPKiJU
	e/2kqb02PiGIX8gynPFo8P1iNkhFXTj3TP5Xds/QfjDI5sHggzdMLe/zydoM0KxNHvnu9uFb083
	hWvHzyURLQsVr+EBKKFIE6FbMwA5FFvKEVZcAkZ+kouEztvEHW/s=
X-Google-Smtp-Source: AGHT+IGxBam6gm0EgetXwwC30SC/9yFNrq5vdQq8RURaa3hshoHwVo5E2TM2bvabLDoswxDxgPRQ/A==
X-Received: by 2002:a17:903:2285:b0:235:eb71:a386 with SMTP id d9443c01a7336-237d9b8e9d5mr18655585ad.50.1750391601041;
        Thu, 19 Jun 2025 20:53:21 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86ef84fsm6969405ad.216.2025.06.19.20.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 20:53:20 -0700 (PDT)
From: lcwang <zaq14760@gmail.com>
X-Google-Original-From: lcwang <lcwang@ieiworld.com>
To: conor@kernel.org
Cc: drm@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	noralf@tronnes.org,
	robh+dt@kernel.org,
	krzk@kernel.org,
	zaq14760@gmail.com,
	onlywig@gmail.com,
	cip-dev@lists.cip-project.org
Subject: [PATCH 3/3] dt-bindings: display: Add Mayqueen Pixpaper e-ink panel
Date: Fri, 20 Jun 2025 11:53:10 +0800
Message-Id: <20250620035310.735055-2-lcwang@ieiworld.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620035310.735055-1-lcwang@ieiworld.com>
References: <20250619-earlobe-skiing-25605816a861@spud>
 <20250620035310.735055-1-lcwang@ieiworld.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jun 2025 06:16:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19153

From: LiangCheng Wang <zaq14760@gmail.com>

The binding is for the Mayqueen Pixpaper e-ink display panel,
controlled via an SPI interface.

Changes in v2:
- Corrected capitalization in the title.
- Removed unnecessary '|' from description.
- Removed redundant description lines for standard properties
- Added 'maximum: 1000000' for spi-max-frequency property definition
- Changed 'additionalProperties: false' to 'unevaluatedProperties: false'.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 .../bindings/display/mayqueen,pixpaper.yaml   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml

diff --git a/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
new file mode 100644
index 000000000000..cd27f8ba5ae1
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
+  - LiangCheng Wang <zaq14760@gmail.com>
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


