Return-Path: <SRS0=mevU=CE=lists.cip-project.org=bounce+64572+5265+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A780C433EA
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB592083B
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dChiElt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB592083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5265+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UGEWYY4521723xwhxXmHggHf; Wed, 26 Aug 2020 04:35:16 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.10257.1598440900783637680
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 04:21:46 -0700
X-IronPort-AV: E=Sophos;i="5.76,355,1592838000"; 
   d="scan'208";a="55371146"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Aug 2020 20:21:46 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.148])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4990C4296934;
	Wed, 26 Aug 2020 20:21:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 04/10] dt-bindings: i2c: renesas,i2c: Document r8a774e1 support
Date: Wed, 26 Aug 2020 12:21:26 +0100
Message-Id: <20200826112132.4090-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PEfth4RmoynANmPQ5jLyjt2ox4520388AA=
Content-Type: multipart/mixed; boundary="Nw8MSfjsKSXgBmOQNEjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598441716;
 bh=O2u2ZTdLHQeuKkhYHmy0b+gilxwCBEYYM/Ln5rQHZP8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dChiElt6AkosRHrcjpGvcx6fVHToQHlR+6LOeX3c+WPqHziP0jUEBtNPt2xmZ9t9j0a
 ACwQHSpsHHSYNP1pHt1Jj+GUyHD5wNVIEUtF1AEZ/Ygr6zbklrDdBSYd+CZcXc9HGxZoA
 n80hBd59ieJGSwhok1YoMYXQCRtFy2qfgk4=

--Nw8MSfjsKSXgBmOQNEjp

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 471fb8c55c24a1b50a07d7708aa2d7c202ec896e upstream.

Document i2c controller for RZ/G2H (R8A774E1) SoC, which is compatible
with R-Car Gen3 SoC family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,i2c.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,i2c.txt b/Documentation/devicetree/bindings/i2c/renesas,i2c.txt
index efb1c11e3c30..fe0ecbfd9078 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/renesas,i2c.txt
@@ -7,6 +7,7 @@ Required properties:
 	"renesas,i2c-r8a774a1" if the device is a part of a R8A774A1 SoC.
 	"renesas,i2c-r8a774b1" if the device is a part of a R8A774B1 SoC.
 	"renesas,i2c-r8a774c0" if the device is a part of a R8A774C0 SoC.
+	"renesas,i2c-r8a774e1" if the device is a part of a R8A774E1 SoC.
 	"renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
 	"renesas,i2c-r8a7779" if the device is a part of a R8A7779 SoC.
 	"renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
-- 
2.17.1


--Nw8MSfjsKSXgBmOQNEjp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5265): https://lists.cip-project.org/g/cip-dev/message=
/5265
Mute This Topic: https://lists.cip-project.org/mt/76426358/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Nw8MSfjsKSXgBmOQNEjp--
