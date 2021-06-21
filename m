Return-Path: <SRS0=c3GV=LP=lists.cip-project.org=bounce+64572+6561+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF34C48BC2
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B753060FF2
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B753060FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6561+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ePtMYY4521723xnNKOXQ63gc; Mon, 21 Jun 2021 10:09:57 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.50359.1624295389824735430
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 10:09:51 -0700
X-IronPort-AV: E=Sophos;i="5.83,289,1616425200"; 
   d="scan'208";a="84957110"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jun 2021 02:09:49 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 51C90400C4D4;
	Tue, 22 Jun 2021 02:09:48 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 5.10.y-cip 16/16] dt-bindings: pci: rcar-pci-ep: Document missing interrupts property
Date: Mon, 21 Jun 2021 18:09:25 +0100
Message-Id: <20210621170925.11328-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: j07tqz5s08OaTNnkddKyAPw1x4520388AA=
Content-Type: multipart/mixed; boundary="g4Yn31DmzlsW0MApms6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624295397;
 bh=Ll/oVi1fL3o1YK1QtjIeuILKWCYdWGu8SyGuuA90nmo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cJlNSZf8ij5qIThhay0oMpYMN4VUboXJKftUYz+VTcKRaVJ/kZntHqllV8BdeNv1mTq
 lfnox+5mUlGNsLYmQgWMzJ9cky0esnvElQuvuXrzU32y11tRJMRg9ECa7UaXGciVO4YtW
 trla4yKn3mebBrVRTklyrDRKtTLZo/JMS+k=

--g4Yn31DmzlsW0MApms6G

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
index 84eeb7fe6e01..295840cf612f 100644
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
@@ -64,6 +69,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/r8a774c0-sysc.h>
 
      pcie0_ep: pcie-ep@fe000000 {
@@ -75,6 +81,9 @@ examples:
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


--g4Yn31DmzlsW0MApms6G
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6561): https://lists.cip-project.org/g/cip-dev/message=
/6561
Mute This Topic: https://lists.cip-project.org/mt/83693892/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--g4Yn31DmzlsW0MApms6G--
