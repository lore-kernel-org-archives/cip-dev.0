Return-Path: <SRS0=m7B6=GH=lists.cip-project.org=bounce+64572+5989+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF1CC433E0
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:20:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB331207B3
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB331207B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5989+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id k0zaYY4521723xBmuw9K6qPP; Mon, 04 Jan 2021 02:20:05 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.11577.1609755604685686066
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 02:20:04 -0800
X-IronPort-AV: E=Sophos;i="5.78,473,1599490800"; 
   d="scan'208";a="67767851"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Jan 2021 19:20:03 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F369D400388B;
	Mon,  4 Jan 2021 19:20:02 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 2/2] dt-bindings: PCI: rcar-pci-host: Document r8a774e1 bindings
Date: Mon,  4 Jan 2021 10:19:59 +0000
Message-Id: <20210104101959.8182-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210104101959.8182-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210104101959.8182-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aPAbk5VXDAJzxDvQotDT4bQUx4520388AA=
Content-Type: multipart/mixed; boundary="trNT2to8ABloW5ONwK0m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609755605;
 bh=5uT70vQdAKRWNT9H1AGgHVZy7B9SzakZBzVHlE+Lzvc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jFVurhOB99Y8h/a5kmghUMZfDRYY02RwBbvK1LtZrpyNMl0cscBvT68C8Pxxzj0fWZk
 A4hVocsn19ZG2d3lSN/RCza4J4VtJv6VUdXFZqKvKE10dcU1dHvRjT4C1KpZLVBOVCCPV
 s0xNPQxt1nRCjzw7JIwdUWA3qR2gm7EIFxc=

--trNT2to8ABloW5ONwK0m

commit 64fc0a030987eec45c5362618bacdef7227783d5 upstream.

Document the RZ/G2H (a.k.a. R8A774E1) SoC in the R-Car PCIe bingings.

[shimoda: minor change the subject and description]

Link: https://lore.kernel.org/r/1604455096-13923-4-git-send-email-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
[PL: Patched text version of binding file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index a59c2ee141ec..5f3b88511dc3 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -5,6 +5,7 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
 	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
 	    "renesas,pcie-r8a774b1" for the R8A774B1 SoC;
 	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
+	    "renesas,pcie-r8a774e1" for the R8A774E1 SoC;
 	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
 	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
 	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
-- 
2.17.1


--trNT2to8ABloW5ONwK0m
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5989): https://lists.cip-project.org/g/cip-dev/message=
/5989
Mute This Topic: https://lists.cip-project.org/mt/79421231/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--trNT2to8ABloW5ONwK0m--
