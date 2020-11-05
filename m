Return-Path: <SRS0=H6jN=EL=lists.cip-project.org=bounce+64572+5743+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF09C388F7
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC4F2083B
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 09:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TMMYledh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC4F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5743+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8fJLYY4521723xdDnuicg84d; Thu, 05 Nov 2020 01:50:45 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.5243.1604569842298237083
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 01:50:44 -0800
X-IronPort-AV: E=Sophos;i="5.77,453,1596466800"; 
   d="scan'208";a="61538028"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2020 18:50:43 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AAF5041572DE;
	Thu,  5 Nov 2020 18:50:42 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 2/6] dt-bindings: phy: renesas,usb3-phy: Add r8a774e1 support
Date: Thu,  5 Nov 2020 09:50:35 +0000
Message-Id: <20201105095039.4751-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZkmYSFUZzDCWddyn3kOUfyqJx4520388AA=
Content-Type: multipart/mixed; boundary="2i26E043UH7R8Zx0PdM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604569845;
 bh=zx+OmuOaBWTyUSFRqHkOQ2oybsx4PUfSAJlQ7fpaJrA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=TMMYledhtTt1qUFnL2C6AmDMUn9M1uQLr5HSTMd8XUK+bNZuAXZrXHPMpDUrXvl4vRq
 nOy1GrEH2F1NBi9fcIX5C+x/IdzSVjhLtMNTKxQH7cg0KPaWslaKn9ECj2dwMof6kdJyE
 uAzuknQNmew7+kTBLbZdoS8xW8+BTfhZRYI=

--2i26E043UH7R8Zx0PdM4

commit f13b89900d364ebb72ec2011dd0cf61b7c3bb3d5 upstream.

Document RZ/G2H (R8A774E1) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1594919915-5225-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[PL: Patched text version of binding file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
index 0fe433b9a592..ba2a6363cb2e 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
@@ -11,6 +11,8 @@ Required properties:
 	      SoC.
 	      "renesas,r8a774b1-usb3-phy" if the device is a part of an R8A774B1
 	      SoC.
+	      "renesas,r8a774e1-usb3-phy" if the device is a part of an R8A774E1
+	      SoC.
 	      "renesas,r8a7795-usb3-phy" if the device is a part of an R8A7795
 	      SoC.
 	      "renesas,r8a7796-usb3-phy" if the device is a part of an R8A7796
-- 
2.17.1


--2i26E043UH7R8Zx0PdM4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5743): https://lists.cip-project.org/g/cip-dev/message=
/5743
Mute This Topic: https://lists.cip-project.org/mt/78047672/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2i26E043UH7R8Zx0PdM4--
