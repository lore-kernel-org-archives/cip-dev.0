Return-Path: <SRS0=4RgJ=E6=lists.cip-project.org=bounce+64572+5850+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11305C63798
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:41:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114E6206C0
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="inzg08cZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114E6206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5850+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hzddYY4521723x1gEPDke5ax; Tue, 24 Nov 2020 09:41:50 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.417.1606239265329471357
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:34:25 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63740785"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Nov 2020 02:34:24 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.254])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 062DC40B67B8;
	Wed, 25 Nov 2020 02:34:22 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH] dt-bindings: PCI: rcar: Add device tree support for r8a7742
Date: Tue, 24 Nov 2020 17:34:21 +0000
Message-Id: <20201124173421.14576-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cjREmE6KhfQbEVcLTafHbnGHx4520388AA=
Content-Type: multipart/mixed; boundary="prKQIqYclxNTPRB8egrc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606239710;
 bh=Nh0wWzTTbBwveexMUWTKspj5riZtByIO1mrJ4TxPI5U=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=inzg08cZpd6vOtVEbeUA+XepOvmcrQc1uTeKI1wHP9a1hM0U+ZNxYLYfCWXzm9+v0aX
 +1QJZ+dtPQiGb9Uu6WEMnx7WcBdKavxrc0TtikteRHgplIu+JzMNAsKFtVyRdVHpktgbg
 kl+Am8jwixqmi3Cr87zGUOSMkc5wL9s0Jsw=

--prKQIqYclxNTPRB8egrc

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit	d16d538ff49145b153976bd8e124116d369db266 upstream.

Add support for r8a7742. The Renesas RZ/G1H (R8A7742) PCIe controller
is identical to the R-Car Gen2 family.

Link: https://lore.kernel.org/r/20200810174156.30880-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index bedfdc122543..8a3d8b5be515 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -1,7 +1,8 @@
 * Renesas R-Car PCIe interface
 
 Required properties:
-compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
+compatible: "renesas,pcie-r8a7742" for the R8A7742 SoC;
+	    "renesas,pcie-r8a7743" for the R8A7743 SoC;
 	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
 	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
 	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
-- 
2.17.1


--prKQIqYclxNTPRB8egrc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5850): https://lists.cip-project.org/g/cip-dev/message=
/5850
Mute This Topic: https://lists.cip-project.org/mt/78482468/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--prKQIqYclxNTPRB8egrc--
