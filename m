Return-Path: <SRS0=ZlEc=FE=lists.cip-project.org=bounce+64572+5892+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFD7C64E90
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E62120855
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mojyLS6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E62120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5892+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SWwEYY4521723x07hCl5ZFVn; Mon, 30 Nov 2020 06:19:26 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web08.60534.1606745960970067062
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 06:19:22 -0800
X-IronPort-AV: E=Sophos;i="5.78,381,1599490800"; 
   d="scan'208";a="64366338"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Nov 2020 23:19:21 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AC7464A31DA3;
	Mon, 30 Nov 2020 23:19:20 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 02/11] dt-bindings: arm: renesas: Convert 'renesas,prr' to json-schema
Date: Mon, 30 Nov 2020 14:19:07 +0000
Message-Id: <20201130141916.8211-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: npn2SQXObrmNyE9gWmG8PonCx4520388AA=
Content-Type: multipart/mixed; boundary="SqeEDQah53WEynso5qUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606745966;
 bh=QM+J80PFLVLmr4Om42PNkCsKDIpRe0SYSRkXF6hilcI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=mojyLS6YHc4qcgELsH8s+cxSG9HZBmIYy4Sdd5R7dxes7np0O+HGHemNCKN8F2SakVn
 E5SaDKRjmu90JP/S2wG+5L/Dpfmuk+mCCO6I+WM9VOCjQNNj1kTVp4fNKMqRObUCXSjka
 yh+Ac++wi8+rcY+q+51i9MpKm35Qmtlskpk=

--SqeEDQah53WEynso5qUC

From: Simon Horman <horms+renesas@verge.net.au>

commit 09f156d97e530c2ac631620f7b29508ff5cc4e6f upstream.

Convert Renesas Product Register bindings documentation to json-schema.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20190908120528.9392-1-horms+renesas@verge.net.au
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Initially in upstream commit 5384f45cd9714287f198771bfb057eda799af9a8
("ARM: shmobile: Document DT bindings for Product Register" added DT
documentation later this was moved into separate file (renesas,prr.txt) in
commit 74791d15fd7c405511e3cc097c2f043171ecbdb0 ("dt-bindings: arm:
renesas: Move 'renesas,prr' binding to its own doc") and finally this was
converted into json-schema so using the same commit to backport]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/arm/renesas,prr.yaml  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.yaml

diff --git a/Documentation/devicetree/bindings/arm/renesas,prr.yaml b/Documentation/devicetree/bindings/arm/renesas,prr.yaml
new file mode 100644
index 000000000000..1f80767da38b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/renesas,prr.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/renesas,prr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas Product Register
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+  - Magnus Damm <magnus.damm@gmail.com>
+
+description: |
+  Most Renesas ARM SoCs have a Product Register or Boundary Scan ID
+  Register that allows to retrieve SoC product and revision information.
+  If present, a device node for this register should be added.
+
+properties:
+  compatible:
+    enum:
+      - renesas,prr
+      - renesas,bsid
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    prr: chipid@ff000044 {
+        compatible = "renesas,prr";
+        reg = <0xff000044 4>;
+    };
-- 
2.17.1


--SqeEDQah53WEynso5qUC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5892): https://lists.cip-project.org/g/cip-dev/message=
/5892
Mute This Topic: https://lists.cip-project.org/mt/78608801/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SqeEDQah53WEynso5qUC--
