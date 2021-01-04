Return-Path: <SRS0=wBlI=GH=lists.cip-project.org=bounce+64572+5985+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B39C433DB
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 09:58:56 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F4F20780
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 09:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F4F20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5985+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 26PzYY4521723xX4JI1XDklT; Mon, 04 Jan 2021 01:58:54 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.11613.1609754333365145018
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 01:58:53 -0800
X-IronPort-AV: E=Sophos;i="5.78,473,1599490800"; 
   d="scan'208";a="67766545"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Jan 2021 18:58:49 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D270740083D9;
	Mon,  4 Jan 2021 18:58:48 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip] dt-bindings: pci: rcar-pci-ep: Document missing interrupts property
Date: Mon,  4 Jan 2021 09:58:48 +0000
Message-Id: <20210104095848.7111-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gGTxSsWPy6cVvXv8V8OaUyUJx4520388AA=
Content-Type: multipart/mixed; boundary="z4CGbY5Uul5HV3BNXcX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609754334;
 bh=5hcaG3npxOsoh1a07C+O4mAVloa7FcP/7df2CdniNwU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vx4v4R1h/kCLenlTnnZXlHdCTfJWuO5UE0caEki+PKwUrdVH4C63ttiEcSYB8kz6r+s
 YltN5ll87Iyk9a/y368HqqG71fBuHE2taOzMf/xToy3IZc5eIDyPyj5xc42Xy6dKqPTEA
 H89VK2V4H/mbKvQg8alvmAz7gIQ0AdKjsb4=

--z4CGbY5Uul5HV3BNXcX6

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit f3c6c120614cfb02827ee7bbe6c4240847cc5f12 upstream.

The R-Car PCIe controller does not use interrupts when configured
for endpoint mode, hence the bindings do not document the interrupts
property.  However, all DTS files provide interrupts properties, and
thus fail to validate.

Fix this by documenting the interrupts property.

Fixes: 4c0f80920923f103 ("dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20201209101231.2206479-1-geert+renesas@glider.be
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
index a059c96c294b..10e186c676ae 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
@@ -32,6 +32,10 @@ properties:
       - const: memory2
       - const: memory3
 
+  interrupts:
+    minItems: 3
+    maxItems: 3
+
   power-domains:
     maxItems: 1
 
@@ -53,6 +57,7 @@ required:
   - compatible
   - reg
   - reg-names
+  - interrupts
   - resets
   - power-domains
   - clocks
@@ -62,6 +67,7 @@ required:
 examples:
   - |
     #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/r8a774c0-sysc.h>
 
      pcie0_ep: pcie-ep@fe000000 {
@@ -73,6 +79,9 @@ examples:
                   <0x30000000 0x8000000>,
                   <0x38000000 0x8000000>;
             reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
+            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
             resets = <&cpg 319>;
             power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
             clocks = <&cpg CPG_MOD 319>;
-- 
2.17.1


--z4CGbY5Uul5HV3BNXcX6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5985): https://lists.cip-project.org/g/cip-dev/message=
/5985
Mute This Topic: https://lists.cip-project.org/mt/79420973/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--z4CGbY5Uul5HV3BNXcX6--
