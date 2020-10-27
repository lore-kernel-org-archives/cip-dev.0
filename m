Return-Path: <SRS0=b6Pr=EC=lists.cip-project.org=bounce+64572+5677+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87486C5517A
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:29 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B6F20727
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="l/nhhFUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B6F20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5677+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GSI9YY4521723xsIRtN9x3M5; Tue, 27 Oct 2020 09:56:28 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.68.1603817787144133912
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Oct 2020 09:56:27 -0700
X-IronPort-AV: E=Sophos;i="5.77,424,1596466800"; 
   d="scan'208";a="60743169"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2020 01:56:25 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B95BD40A85CA;
	Wed, 28 Oct 2020 01:56:24 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 1/5] dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and r8a774b1
Date: Tue, 27 Oct 2020 16:56:18 +0000
Message-Id: <20201027165622.28777-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: I7t1ptWiU32hDQuuQqwivvfRx4520388AA=
Content-Type: multipart/mixed; boundary="bUqmynO9IkPmxABjLPMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603817788;
 bh=M3dMoqyzK7cUI1nu/KYIKBUdL2LDlnoSGTzKRlzAqQA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=l/nhhFUFvCJzOSZ/Npy2NdV3qPNl7N/M6hmF3hYHEbT4qOFusT10mb7AHj58MY12KAi
 yTmprw6fBVQvwTezSKGFk9KUA0UAS9gN2v5A1FJX5als0dqVT9kd4JDzQkJMrQAcGAvrD
 4z+Ts4F46VoGxGG1r/Ep22+TJ38I4jLEI9U=

--bUqmynO9IkPmxABjLPMl

commit 2de82ec8667465236e15f8c6af7cecf8da63fc60 upstream.

Document the support for R-Car PCIe EP on R8A774A1 and R8A774B1 SoC
devices.

Also constify "renesas,rcar-gen3-pcie-ep" so that it can be used as
fallback compatible string for R-Car Gen3 and RZ/G2 devices as the
PCIe module is identical.

Link: https://lore.kernel.org/r/20200814173037.17822-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
index aa483c7f27fd..70c45f72ab20 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
@@ -14,8 +14,11 @@ maintainers:
 properties:
   compatible:
     items:
-      - const: renesas,r8a774c0-pcie-ep
-      - const: renesas,rcar-gen3-pcie-ep
+      - enum:
+          - renesas,r8a774a1-pcie-ep     # RZ/G2M
+          - renesas,r8a774b1-pcie-ep     # RZ/G2N
+          - renesas,r8a774c0-pcie-ep     # RZ/G2E
+      - const: renesas,rcar-gen3-pcie-ep # R-Car Gen3 and RZ/G2
 
   reg:
     maxItems: 5
-- 
2.17.1


--bUqmynO9IkPmxABjLPMl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5677): https://lists.cip-project.org/g/cip-dev/message=
/5677
Mute This Topic: https://lists.cip-project.org/mt/77842960/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bUqmynO9IkPmxABjLPMl--
