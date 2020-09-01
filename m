Return-Path: <SRS0=DMKM=CK=lists.cip-project.org=bounce+64572+5352+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966B9C2D0A5
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1D720707
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lW/h1/sE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1D720707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5352+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ltKcYY4521723xXSw1jWjlF5; Tue, 01 Sep 2020 04:45:12 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.11106.1598960479890530571
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2020 04:41:23 -0700
X-IronPort-AV: E=Sophos;i="5.76,378,1592838000"; 
   d="scan'208";a="55870258"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2020 20:41:23 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.50])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AF5A6400752B;
	Tue,  1 Sep 2020 20:41:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 03/10] dt-bindings: i2c: renesas, i2c: Document r8a7742 support
Date: Tue,  1 Sep 2020 12:41:07 +0100
Message-Id: <20200901114114.3465-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
References: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HKeIExJwdF13EvOILTMe1BJex4520388AA=
Content-Type: multipart/mixed; boundary="TgQd6FFnmDEfV4C5F4a6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598960712;
 bh=g3Nsmte9UJZeyCULZZYMpj0f7jLc0g+EmKA8E6rwyH4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lW/h1/sExxk5L9j2cD3lARvOK9CRb88Mf+yD5mwqiRTgTysxhkoUP6HHh28bLGDipVO
 TKaSdKFh3VtvMmE1Myfessp6jnkUMyII7yYw/SsdxwAMlVsRB6b5igG1hXnVjPLZLutvT
 SNoser1AbHTN+Xd5Z8uBWQG73/GXeeRocjA=

--TgQd6FFnmDEfV4C5F4a6

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 315148547563856f48907633cf89da4dd680f72a upstream.

Document i2c controller for RZ/G1H (R8A7742) SoC, which is compatible
with R-Car Gen2 SoC family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
[biju: Patched the changes from renamed file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index 0d1aa9e4c292..3587816115db 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -2,6 +2,7 @@ I2C for R-Car platforms
 
 Required properties:
 - compatible:
+	"renesas,i2c-r8a7742" if the device is a part of a R8A7742 SoC.
 	"renesas,i2c-r8a7743" if the device is a part of a R8A7743 SoC.
 	"renesas,i2c-r8a7744" if the device is a part of a R8A7744 SoC.
 	"renesas,i2c-r8a7745" if the device is a part of a R8A7745 SoC.
-- 
2.17.1


--TgQd6FFnmDEfV4C5F4a6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5352): https://lists.cip-project.org/g/cip-dev/message=
/5352
Mute This Topic: https://lists.cip-project.org/mt/76554008/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--TgQd6FFnmDEfV4C5F4a6--
