Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ADCFD874D
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:36:57 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73935.1773747411126394444
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:36:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HKNoXIRP;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so59424825e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747409; x=1774352209; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA+09xarHrmxyzELVEdIWGABzrqnDxJIAUfMhJ+SW2A=;
        b=HKNoXIRPIiP7R7tGrMfNcLhVXlwIclOecOZj8EIBNFJ9IsnslB1RAU2YCoPcTKClEH
         3iFBOyhT2JpQaxw3dyau1pALRnL5j1g5MAYwSWV9PBlTVAUkWfb7PEy1l6raybOhm7hk
         jL1Qjiikm69KpepBOM0ohj4jRUaHD1dxDHvZKaok94msT/hCsBDJkw/YGL0Fzvz9gTkK
         lO3rayPoOqTc1PD6dnFFKnMitLRiGYffch7vdB3wnROofbJb8SQqJasXaWGCRwEUUDth
         yJI+H12l22zPJxYijDe2IdoqU8jJsJhd2IMmTl0J24FznWOKCgzQ6IDbZ5b1vjTAOJNi
         FFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747409; x=1774352209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dA+09xarHrmxyzELVEdIWGABzrqnDxJIAUfMhJ+SW2A=;
        b=RdzL5MFhN/Y0P5Owbml12RenWmMsrwzXQFk0iTpTkMTB1ISQPscNqoH+ifya2BLADk
         GeJqnfsUErJwFkAixkbefboYYIlVr882cO+kJ2qDxwvntvcPskbMpYlZzYQ9R7T9AtO4
         qUt3O1e/R/xwLprzl6fSYkgMt5iNMa/M2SeFOb5lyeNaaYILp20qESEEzRUoZFUac10q
         uNFrepLXowdSaEB5YTfUzNYRM/8MZZjqwl1yBgc9zNUUN1ExcCgH7ylABsFRocL+aKTL
         7P/bsOkEPmoDuZFQnmG75LTAtMpgZ9XtIn85aWg7AbS6Ar6C/8Cqkqan0IoQjTAQWIr7
         j5HA==
X-Gm-Message-State: AOJu0YyYr0gndKKauomRTcH6S9kWtJjgU1I9Gw8xdDTq74MW7G9cfOgL
	wgXOCXdCjOQYiRFBfVUN9xqTl1eipC0ze2xVxB7j0l4v0rqE0Yn/Ub8JczR+gw==
X-Gm-Gg: ATEYQzziyQAjkjDODb53wMhxACSS6l+Wp+ySu0X0qNXrW6N0MonKV529eRmAtZg1vV2
	LH+hrqciQd4wNz+RTG3dgECnmqP9sLKdAjegqWupLDs7fYFCvXie6oZ/UAIltAncv4hbRl7cl00
	/2srXGoGcAcMQ/wlqWgB/H0wHQEtZ8nuN/YFz13unJEXOwIlihT2/m2dfwPa2NTmiA+12CzQNhV
	dH364D7lP7GubRMjEPke59HmRk99CMGPh5boTV36c5qfRFcuN3tVOha4e5wvFxRU8JsNGiTn2pc
	/XaIwlxE1ZLOEW3e6LUC9xiQR1tYYeEq3OWLmRe86bVFRL5AkG/2F6RbB3kWbg1DjdmfvZrOgUE
	a0lWu3RlOgSdvvZmRXpa4Jt4LT2p0LJD062V8NEhfM10y+xFf9fzIengSJ+fmIJS3RwJzPf2XCg
	NQ7p/0CA5/RzKxPeQX/qYXz/RG3LUioz5fT82PW+gGvSm+XaNR
X-Received: by 2002:a05:600c:45d5:b0:485:4535:73d with SMTP id 5b1f17b1804b1-485566cfb8amr265372055e9.2.1773747409042;
        Tue, 17 Mar 2026 04:36:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea97af2sm57469965e9.4.2026.03.17.04.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:36:48 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 07/11] dt-bindings: phy: renesas: Document Renesas RZ/G3E USB3.0 PHY
Date: Tue, 17 Mar 2026 11:36:34 +0000
Message-ID: <20260317113643.311192-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:36:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22481

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 4f816512aaa1fa3b74df7473ef771ebef511255e ]

Document Renesas RZ/G3E USB3.0 PHY. This IP is connected between
USB3HOST and PHY module. The main functions of the module are
as follows:
 - Reset control
 - Control of PHY input pins
 - Monitoring of PHY output pins

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251029084037.108610-2-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/phy/renesas,rzg3e-usb3-phy.yaml  | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml
new file mode 100644
index 000000000000..b86dc7a291a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/renesas,rzg3e-usb3-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3E USB 3.0 PHY
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+properties:
+  compatible:
+    const: renesas,r9a09g047-usb3-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB bus clock
+      - description: USB 2.0 PHY reference clock
+      - description: USB 3.0 PHY reference clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: core
+      - const: ref_alt_clk_p
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+
+    usb-phy@15870000 {
+        compatible = "renesas,r9a09g047-usb3-phy";
+        reg = <0x15870000 0x10000>;
+        clocks = <&cpg CPG_MOD 0xb0>, <&cpg CPG_CORE 13>, <&cpg CPG_CORE 12>;
+        clock-names = "pclk", "core", "ref_alt_clk_p";
+        power-domains = <&cpg>;
+        resets = <&cpg 0xaa>;
+        #phy-cells = <0>;
+    };
-- 
2.43.0


