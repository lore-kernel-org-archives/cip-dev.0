Return-Path: <SRS0=SCii=D6=lists.cip-project.org=bounce+64572+5661+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B18CC55179
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B839920797
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QuV61LEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B839920797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5661+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2uYZYY4521723xtBAeHyLow0; Fri, 23 Oct 2020 09:58:13 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.12445.1603472289888512488
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 09:58:12 -0700
X-IronPort-AV: E=Sophos;i="5.77,409,1596466800"; 
   d="scan'208";a="60634050"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Oct 2020 01:58:12 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5F3DA400F935;
	Sat, 24 Oct 2020 01:58:11 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 3/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller
Date: Fri, 23 Oct 2020 17:58:02 +0100
Message-Id: <20201023165805.1910-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dMtQuxnLihtYNMbwis6zppHdx4520388AA=
Content-Type: multipart/mixed; boundary="gwcdu3bG0je7fChWfqNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603472293;
 bh=CA6wca9NWx2tNRWDt4vH/pbuiH9w99AKSosiIJGuCwo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QuV61LEN48PsQti0DHsm/loKPTwsvXP1iT4s8nWrmyrmP1P4JizClhChKQv3s+7bkqM
 xJE/lTyAqj1GguRwlJWLNodzTRmxagKkncvbzhg2ixORV77z9eczwNvODI2OWM8Yl6jRi
 DJT/SItH8ai+KD04NORp/SgPb+ymGqubUP0=

--gwcdu3bG0je7fChWfqNs

commit 4c0f80920923f1033e9fe048f44b6e1ffe18c58d upstream.

This patch adds the bindings for the R-Car PCIe endpoint driver.

Link: https://lore.kernel.org/r/1588854799-13710-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/pci/rcar-pci-ep.yaml  | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
new file mode 100644
index 000000000000..aa483c7f27fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Renesas Electronics Europe GmbH - https://www.renesas.com/eu/en/
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rcar-pci-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car PCIe Endpoint
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
+
+properties:
+  compatible:
+    items:
+      - const: renesas,r8a774c0-pcie-ep
+      - const: renesas,rcar-gen3-pcie-ep
+
+  reg:
+    maxItems: 5
+
+  reg-names:
+    items:
+      - const: apb-base
+      - const: memory0
+      - const: memory1
+      - const: memory2
+      - const: memory3
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pcie
+
+  max-functions:
+    minimum: 1
+    maximum: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - resets
+  - power-domains
+  - clocks
+  - clock-names
+  - max-functions
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
+    #include <dt-bindings/power/r8a774c0-sysc.h>
+
+     pcie0_ep: pcie-ep@fe000000 {
+            compatible = "renesas,r8a774c0-pcie-ep",
+                         "renesas,rcar-gen3-pcie-ep";
+            reg = <0xfe000000 0x80000>,
+                  <0xfe100000 0x100000>,
+                  <0xfe200000 0x200000>,
+                  <0x30000000 0x8000000>,
+                  <0x38000000 0x8000000>;
+            reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
+            resets = <&cpg 319>;
+            power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+            clocks = <&cpg CPG_MOD 319>;
+            clock-names = "pcie";
+            max-functions = /bits/ 8 <1>;
+    };
-- 
2.17.1


--gwcdu3bG0je7fChWfqNs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5661): https://lists.cip-project.org/g/cip-dev/message=
/5661
Mute This Topic: https://lists.cip-project.org/mt/77756295/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gwcdu3bG0je7fChWfqNs--
