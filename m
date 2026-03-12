Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C214D1067055
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:32 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24577.1773329731499113434
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fMWkBsT9;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so9811395e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329729; x=1773934529; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA+09xarHrmxyzELVEdIWGABzrqnDxJIAUfMhJ+SW2A=;
        b=fMWkBsT9lsSRVrZVhtN866/vuOrOJgK75kl3nnKKvrwpCwZGvs/WTKPI25c0MBL5Eq
         kgiNmYBuxGzrPbTsrjc3Z2mgtDjzF2c35vBcFgNbdhzXuUV913g/YUcESF52HfGacXgO
         F3Sywj042ockIQskHubik1zz/IUSwVCizE+vBBzH80od6BihWzxQzyGaopqPtnJUWfUR
         Te72iQxiB24VfRufoQ8Aw72ChE13Rk0G4XkH5ZnUCH0OXRMBDzg1g/PebWxgIEJYiJ17
         8pL4fP0FZKy8qT+rTSbnhVDDvlbknlStXP50IOvTwaHLez0a2mx1cCkooI0s8BfChgPI
         mMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329729; x=1773934529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dA+09xarHrmxyzELVEdIWGABzrqnDxJIAUfMhJ+SW2A=;
        b=UFaXCaclbSYkGE3FOkuRQl2rmdoBlDkzkQopa8qOPXJhTeJ6YG7liNclymjH0YAuds
         By8rJwdtOng7xp/88iQ7oK6PKfkerCEf2az1sQqZEEqZLRLwymeAe3tgb1N4XnRweiSb
         CxkD85n4yCfs3V8FoiHxEC3baZEXhcNKa6zBXR0381rUXHYNnbSLXHJYPWARgkVpEde9
         3g6XDUbcoC4yhbSPqu32Vs6206y/4XjobzPRT15BiS9Q9TdDHSZ1uieAoFNqdQSB7OeI
         kxvCdkpaS0F5NsMPHTcWVg0XLdiUaL1G7b6Nzm5muuoeWp/11l83CRpwOmHp+FtENZEm
         TUFw==
X-Gm-Message-State: AOJu0Yznr2VvSCLH8AS+rGGQfqiX2g3ymvabSa5I4G3QctGUgCTizsty
	c2Y8WAbE7pDlqi07BheohFmCsThr2niuCM9PnNUtX+DeYCWawGBfzb5NBHGWhA==
X-Gm-Gg: ATEYQzwjERbQyO43XTHw8G7q77NIaoELrRA9R23tSitjSo0+bIeWRa+yDyGEvCrVCnH
	JMJsdr6ELE394uGC5Sxo8W++rCaUR9NZeA9ASPc8dHpY6dNvFrknJCCZkq/pfkRo7IfBZVhhSzs
	zlQuC4XLpdxoV2H1wRto8yYk/+ocDu1Hwij/P34Qt5R+gZCEL9S1GzmHucEp4smcRxsVzLRna9/
	2/4h/yAlcnZa+QMX4XpqVj/X+dg6ry4wna1/FukeGvgsT3Nnso0sV1rlHOjVfXD6GJHp8KXGF+z
	GJ8vH8XDe2+xrA4VClJgNbhr/ytAWdKC2cuy2kyA+NvFzySpHb94ZS4OHEwOaEnkDJRHxPiTRdU
	MljGhOoQqonicozNM2QDyzOWRPwjU56hcJYJ4ITbHy5JqZHdHWUARWQfbuzkNCqjs7JlRucM2Qv
	kOmggxfee/wEEpM2K5/gsgvMeT8Ez38urjnhuHG9Gnz9IzkAk=
X-Received: by 2002:a05:600c:a010:b0:485:3b50:fe54 with SMTP id 5b1f17b1804b1-4854b0e705emr118120375e9.11.1773329729362;
        Thu, 12 Mar 2026 08:35:29 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:29 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/11] dt-bindings: phy: renesas: Document Renesas RZ/G3E USB3.0 PHY
Date: Thu, 12 Mar 2026 15:35:12 +0000
Message-ID: <20260312153522.1131675-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22363

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


