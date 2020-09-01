Return-Path: <SRS0=wGqO=CK=lists.cip-project.org=bounce+64572+5353+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312F8C2BBDB
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05069206FA
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ji+TXFx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05069206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5353+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NcyHYY4521723xeWCCcJHgje; Tue, 01 Sep 2020 04:45:12 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.11107.1598960480272809138
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2020 04:41:25 -0700
X-IronPort-AV: E=Sophos;i="5.76,378,1592838000"; 
   d="scan'208";a="56086787"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2020 20:41:25 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.50])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8B898400618C;
	Tue,  1 Sep 2020 20:41:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 04/10] dt-bindings: i2c: renesas, iic: Document r8a7742 support
Date: Tue,  1 Sep 2020 12:41:08 +0100
Message-Id: <20200901114114.3465-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
References: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: IJ0Eaty5tpnazq30keyNJLRIx4520388AA=
Content-Type: multipart/mixed; boundary="XnTQuLY2GHLoHng5WK2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598960712;
 bh=t6xTH87S79O8K3IXbS4sp69F1sGVLguk01qHwypk1Es=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ji+TXFx+Y7vvn3n/yfCSV6mWun6BQc7pgalgVzRgWCcQc05dr4TRYPMtmvw2/+3pkMu
 COieWl5ve/O6hs8kckEv5zsDDF1VyyANAcCNF0vdt1cpXIK+w0m0HWnsJWah3Pd23bwtK
 Pa1TyVA3nVkpvZS4PT/Dvgo1DYxlcodyoRc=

--XnTQuLY2GHLoHng5WK2k

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 90f90af71876914f03e4740e263c4738b703fa89 upstream.

Document IIC controller for RZ/G1H (R8A7742) SoC, which is compatible
with R-Car Gen2 SoC family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
[biju: Pacthed the changes from renamed file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index f4727c6ea01e..348d87c5cd06 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible      :
 			- "renesas,iic-r8a73a4" (R-Mobile APE6)
 			- "renesas,iic-r8a7740" (R-Mobile A1)
+			- "renesas,iic-r8a7742" (RZ/G1H)
 			- "renesas,iic-r8a7743" (RZ/G1M)
 			- "renesas,iic-r8a7744" (RZ/G1N)
 			- "renesas,iic-r8a7745" (RZ/G1E)
-- 
2.17.1


--XnTQuLY2GHLoHng5WK2k
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5353): https://lists.cip-project.org/g/cip-dev/message=
/5353
Mute This Topic: https://lists.cip-project.org/mt/76554009/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--XnTQuLY2GHLoHng5WK2k--
