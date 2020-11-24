Return-Path: <SRS0=UKLT=E6=lists.cip-project.org=bounce+64572+5841+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4344BC64E7A
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B0F20715
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aFgMG48y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B0F20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5841+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EHVKYY4521723xIBzMmhhVQ3; Tue, 24 Nov 2020 09:11:35 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.20.1606237777285940741
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:09:37 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63738816"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Nov 2020 02:09:36 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.254])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E95F940AC3B2;
	Wed, 25 Nov 2020 02:09:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 1/9] dt-bindings: phy: rcar-gen2: Add r8a7742 support
Date: Tue, 24 Nov 2020 17:09:24 +0000
Message-Id: <20201124170932.13588-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
References: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: DzkRIjeN145fO7BKXUeE5c2Xx4520388AA=
Content-Type: multipart/mixed; boundary="MtdIOLYz4alvSd7H0H5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606237895;
 bh=ZzDpTA97+SpJLOUoOATCIu5JB1MHstFpgACWEBnO3UE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=aFgMG48y57fufAHI5B6P6ytCcmsA6CylAb1F4xrqQgNNhpykM3rU0mm5Eauyu47Trma
 Jqoucz5uMQ5UJwU7cDZ9DVkuQRg7W1aHJ0OozxV2fVRVdQKHtFg1X+cI7XlFcylXPrnKu
 3/L5PnoLv43uEjtrvbNKa1grr0yJCMkP4oY=

--MtdIOLYz4alvSd7H0H5O

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9184450a95f6f446dc435cad9c5409c06373eaf1 upstream.

Add USB PHY support for r8a7742 SoC. Renesas RZ/G1H (R8A7742)
USB PHY is identical to the R-Car Gen2 family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
index 35c51d8bcd56..7b1672fb360f 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
@@ -4,7 +4,8 @@ This file provides information on what the device node for the R-Car generation
 2 USB PHY contains.
 
 Required properties:
-- compatible: "renesas,usb-phy-r8a7743" if the device is a part of R8A7743 SoC.
+- compatible: "renesas,usb-phy-r8a7742" if the device is a part of R8A7742 SoC.
+	      "renesas,usb-phy-r8a7743" if the device is a part of R8A7743 SoC.
 	      "renesas,usb-phy-r8a7744" if the device is a part of R8A7744 SoC.
 	      "renesas,usb-phy-r8a7745" if the device is a part of R8A7745 SoC.
 	      "renesas,usb-phy-r8a77470" if the device is a part of R8A77470 SoC.
-- 
2.17.1


--MtdIOLYz4alvSd7H0H5O
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5841): https://lists.cip-project.org/g/cip-dev/message=
/5841
Mute This Topic: https://lists.cip-project.org/mt/78481723/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MtdIOLYz4alvSd7H0H5O--
