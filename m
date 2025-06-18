Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE03C7115C
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 09:13:55 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.38105.1750218592248944131
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 20:49:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EXctGM2U;
 spf=pass (domain: gmail.com, ip: 209.85.214.180, mailfrom: zaq14760@gmail.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2363e973db1so2421655ad.0
        for <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 20:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750218591; x=1750823391; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Crp3CEYLqrLG+apC2mAZnpDNJDCfTEyqUeeXu58j3U=;
        b=EXctGM2Uy83sG0dLP07MtO8z8S91OEkwOZxUCui6pIrzI/gQOyo0WKXx3WBFF5LrcL
         HWv4kb9V64Mv+sW4K3vp79x8Uvczu66j2k2wKtWaD3B09XJKOBB4y7lMeJxlWNWcKRzj
         WvE/jWcuH0XPiib9Mth7lMpc3DncMcNrv7JUaUPr2ajYFvQNg0DmWJ4T+5RqQc8MmCyY
         QR8BPmdzIIM4cVc06RHtwjXVJV9V5t23Of8ikV7+UYcOzipc/4ES/4kWk3Kou0OYJT9K
         mQaP4163Sl2XfRthelAu5aVOKkj6B8TlR7S5yWVeH2DsodLvYw+TDTZGfJhGQxTO4IlE
         nEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750218591; x=1750823391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Crp3CEYLqrLG+apC2mAZnpDNJDCfTEyqUeeXu58j3U=;
        b=oYdxqlWF+VuWETZ4H6eYbDCPmL4JP9HfMsyl+W8bzjaGiJDLITBI9kI9CGrxFNcQkx
         /fRxFsyWEFc4+YyysEvLIIA/Wwyim6Mt8nqGI3qF5G7k7SSKFrfTzgT1y4MqJJi3LCoy
         0lCNNppbqp1OxQJmVFEK2vdQ/XIqTx89GKTKmxCC8bRz2w51eGnEFZgMLX2JuY2AlqP1
         t5NwEFHuOmhPNdbKrjXTGE9PeTdu9XnAdmU5bymD5KVyymNS9VlqYxIAudnsYARYK4nA
         tbCATZ7R42k/IYJavi3gvqwAgQKutcPIvWDzgkAISo5DDkK96MtsE7hXpdeIlU9j2Nq1
         I7oQ==
X-Gm-Message-State: AOJu0Ywhk4R/mWRCgUt9UGh0HKjfxTTW81Z7HsH1ZLhZ72HVeHAAeDZb
	IUz3/9/p+YSWZlSoG+UlXE44hEZpq3+THUQpLFy8ByQu6A4JkRaXOgVsawQX3cTJ
X-Gm-Gg: ASbGncuuf/2/5sIhgDKiaUeW+bMBGZwUoPCycw42OP/ytltOW0RwqPiY7GIXSPsi9Gn
	cLiUVHF4DJ4pqT+V9d5XqiE28PemgPHZOSjsKsCkvL0NOiHTGeqa0p5+uaIiMC2yTnKrwKpgv+d
	KEk1rsXJtyzjHosndhHss5vmeeHPMI8KfunbXOZxdGxedFmCh9cTRVMEdjQPqS29GEOcamWy62h
	Pbz9smhifbOIZ9sUqJeY8QOB5IIk+iqnssBf1hlBkTe/M2q6FlW1tYu7zmEsTw2dQn7BwyLT/Af
	9//zMYtaupv3I62yKfbrE4ut1DnagfT7snh9cOT194wkS3YV+x+UW8mHRcU+bdsn0alQyqvmPI4
	+9aM0a2BMThmTy3u9w/b8mZfSHx+K6FyWnBlFgX8=
X-Google-Smtp-Source: AGHT+IHbh93ZFfxvSAelhKz+a+nejv/JYZrkAogjMFdOMKtc/mynIFhBnCtf+5R6YwJYdXzQo1sAhA==
X-Received: by 2002:a17:902:d548:b0:234:325:500b with SMTP id d9443c01a7336-237c20f843amr17338045ad.22.1750218591134;
        Tue, 17 Jun 2025 20:49:51 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236736cb4f9sm63418405ad.138.2025.06.17.20.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:49:50 -0700 (PDT)
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
Date: Wed, 18 Jun 2025 11:49:36 +0800
Message-Id: <20250618034936.172150-4-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618034936.172150-1-zaq14760@gmail.com>
References: <20250618034936.172150-1-zaq14760@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jun 2025 09:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19130

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


