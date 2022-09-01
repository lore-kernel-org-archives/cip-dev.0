Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07116ECAAD1
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 08:02:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.9633.1662019324823500464
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 01:02:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,280,1654527600";
   d="scan'208";a="131322182"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 17:02:09 +0900
Received: from localhost.localdomain (unknown [10.226.92.226])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0D0E940083EF;
	Thu,  1 Sep 2022 17:02:06 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 12/13] dt-bindings: iio: adc: Document Renesas
 RZ/G2UL ADC
Date: Thu,  1 Sep 2022 09:01:27 +0100
Message-Id: <20220901080128.2147891-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901080128.2147891-1-biju.das.jz@bp.renesas.com>
References: <20220901080128.2147891-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 08:02:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9416

commit 153415feda2eec936e29be6d1e7f74375c5d6d0d upstream.

Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost identical
to RZ/G2L, but it has 2 analog input channels compared to 8 channels
on the RZ/G2L.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220515060337.16513-2-biju.das.jz@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index d66c24cae1e1..61c6157cf5a9 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043-adc   # RZ/G2UL
           - renesas,r9a07g044-adc   # RZ/G2L
           - renesas,r9a07g054-adc   # RZ/V2L
       - const: renesas,rzg2l-adc
@@ -76,16 +77,35 @@ patternProperties:
     properties:
       reg:
         description: |
-          The channel number. It can have up to 8 channels numbered from 0 to 7.
-        items:
-          - minimum: 0
-            maximum: 7
+          The channel number.
 
     required:
       - reg
 
     additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043-adc
+    then:
+      patternProperties:
+        "^channel@[2-7]$": false
+        "^channel@[0-1]$":
+          properties:
+            reg:
+              minimum: 0
+              maximum: 1
+    else:
+      patternProperties:
+        "^channel@[0-7]$":
+          properties:
+            reg:
+              minimum: 0
+              maximum: 7
+
 additionalProperties: false
 
 examples:
-- 
2.25.1


