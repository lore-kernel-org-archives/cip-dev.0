Return-Path: <SRS0=I10h=IH=lists.cip-project.org=bounce+64572+6228+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,
	SPF_PASS,T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C63AC433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A3F64F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A3F64F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6228+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GWt1YY4521723xCMJWKzyq1v; Tue, 09 Mar 2021 08:37:17 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:15 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591008"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:15 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 397F240A2DC7;
	Wed, 10 Mar 2021 01:37:14 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 12/40] media: dt-bindings: media: i2c: Add IMX219 CMOS sensor binding
Date: Tue,  9 Mar 2021 16:36:28 +0000
Message-Id: <20210309163656.20944-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3VvuwrsJo6zl2KrKpMlmzhC1x4520388AA=
Content-Type: multipart/mixed; boundary="ls0wudRoc134RHLOsz1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307837;
 bh=+t0A8Hz0rwJdY2ZI0nBgzW1Lvp0EOrxrz083MRiLO1w=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DJ30XfKb6SpRJUKGoya/rkfVbw6Std6a5FbwvE90AMTfv59SKigIBlMMos4xgmHYq4N
 FkWEXMPSxoLPXDqKbvIYJmwkP6mdJyaPJEoGDI7bVG0lVlvP2y0/TdCtQcb55XM6GNXow
 OURzkhrOu5NyX0RecBCUoLNbdCfGIx8xq7Q=

--ls0wudRoc134RHLOsz1B

From: Andrey Konovalov <andrey.konovalov@linaro.org>

commit 9d730f2cf4c0391785855dd231577d2de2594df9 upstream.

Add YAML device tree binding for IMX219 CMOS image sensor, and
the relevant MAINTAINERS entries.

Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[PL: manually applied changes to MAINTAINERS file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/media/i2c/imx219.yaml | 114 ++++++++++++++++++
 MAINTAINERS                                   |   8 ++
 2 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx219.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/imx219.yaml b/Documentation/devicetree/bindings/media/i2c/imx219.yaml
new file mode 100644
index 000000000000..32d6b693274f
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx219.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/imx219.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony 1/4.0-Inch 8Mpixel CMOS Digital Image Sensor
+
+maintainers:
+  - Dave Stevenson <dave.stevenson@raspberrypi.com>
+
+description: |-
+  The Sony imx219 is a 1/4.0-inch CMOS active pixel digital image sensor
+  with an active array size of 3280H x 2464V. It is programmable through
+  I2C interface. The I2C address is fixed to 0x10 as per sensor data sheet.
+  Image data is sent through MIPI CSI-2, which is configured as either 2 or
+  4 data lanes.
+
+properties:
+  compatible:
+    const: sony,imx219
+
+  reg:
+    description: I2C device address
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  VDIG-supply:
+    description:
+      Digital I/O voltage supply, 1.8 volts
+
+  VANA-supply:
+    description:
+      Analog voltage supply, 2.8 volts
+
+  VDDL-supply:
+    description:
+      Digital core voltage supply, 1.2 volts
+
+  reset-gpios:
+    description: |-
+      Reference to the GPIO connected to the xclr pin, if any.
+      Must be released (set high) after all supplies are applied.
+
+  # See ../video-interfaces.txt for more details
+  port:
+    type: object
+    properties:
+      endpoint:
+        type: object
+        properties:
+          data-lanes:
+            description: |-
+              The sensor supports either two-lane, or four-lane operation.
+              If this property is omitted four-lane operation is assumed.
+              For two-lane operation the property must be set to <1 2>.
+            items:
+              - const: 1
+              - const: 2
+
+          clock-noncontinuous:
+            type: boolean
+            description: |-
+              MIPI CSI-2 clock is non-continuous if this property is present,
+              otherwise it's continuous.
+
+          link-frequencies:
+            allOf:
+              - $ref: /schemas/types.yaml#/definitions/uint64-array
+            description:
+              Allowed data bus frequencies.
+
+        required:
+          - link-frequencies
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - VANA-supply
+  - VDIG-supply
+  - VDDL-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imx219: sensor@10 {
+            compatible = "sony,imx219";
+            reg = <0x10>;
+            clocks = <&imx219_clk>;
+            VANA-supply = <&imx219_vana>;   /* 2.8v */
+            VDIG-supply = <&imx219_vdig>;   /* 1.8v */
+            VDDL-supply = <&imx219_vddl>;   /* 1.2v */
+
+            port {
+                imx219_0: endpoint {
+                    remote-endpoint = <&csi1_ep>;
+                    data-lanes = <1 2>;
+                    clock-noncontinuous;
+                    link-frequencies = /bits/ 64 <456000000>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 1061db6fbc32..47986d4b599a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13565,6 +13565,14 @@ S:	Maintained
 F:	drivers/ssb/
 F:	include/linux/ssb/
 
+SONY IMX219 SENSOR DRIVER
+M:	Dave Stevenson <dave.stevenson@raspberrypi.com>
+L:	linux-media@vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Maintained
+F:	drivers/media/i2c/imx219.c
+F:	Documentation/devicetree/bindings/media/i2c/imx219.yaml
+
 SONY IMX258 SENSOR DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
-- 
2.17.1


--ls0wudRoc134RHLOsz1B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6228): https://lists.cip-project.org/g/cip-dev/message=
/6228
Mute This Topic: https://lists.cip-project.org/mt/81205355/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ls0wudRoc134RHLOsz1B--
