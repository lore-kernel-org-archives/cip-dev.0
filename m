Return-Path: <SRS0=/rVC=DT=lists.cip-project.org=bounce+64572+5563+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9974EC43457
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387E12076E
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ryXj7QuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387E12076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5563+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rkBBYY4521723x6YJJGk4k4W; Mon, 12 Oct 2020 07:21:08 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.42187.1602512428927900524
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:40 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351976"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:40 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3D5A341F6302;
	Mon, 12 Oct 2020 23:20:39 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 43/50] dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and r8a774b1
Date: Mon, 12 Oct 2020 15:19:26 +0100
Message-Id: <20201012141933.9652-44-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: F1QWc7N6tZZQMS6S5lAEQFhIx4520388AA=
Content-Type: multipart/mixed; boundary="hjEuv03qBNVhcUSc972n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512468;
 bh=1pZUnlXXJcYRGmbmdRxI5+c3TnrYz2gge1NqmoXLq0g=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ryXj7QuWPnNNaFh8JSHCniYPm35APqogt028czejMOk5wiOEfVqKKxD37HaCAblIRzc
 FFJ04S102yrushT5kze/0ybvbIO+dqWT2VcQ7+PPr+cSlFBsVqQ+kGpew1kMjWDKTXnFJ
 Pn69SYjNlxPwij5csI5p/s94oxQqpXGee4U=

--hjEuv03qBNVhcUSc972n

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


--hjEuv03qBNVhcUSc972n
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5563): https://lists.cip-project.org/g/cip-dev/message=
/5563
Mute This Topic: https://lists.cip-project.org/mt/77461726/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hjEuv03qBNVhcUSc972n--
