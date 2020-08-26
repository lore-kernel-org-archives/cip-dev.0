Return-Path: <SRS0=7uVw=CE=lists.cip-project.org=bounce+64572+5268+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484F1C433EB
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B52F2083B
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rst+1NO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B52F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5268+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id COKEYY4521723xJW3wyF9CH2; Wed, 26 Aug 2020 04:35:16 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.10260.1598440912320910289
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 04:21:52 -0700
X-IronPort-AV: E=Sophos;i="5.76,355,1592838000"; 
   d="scan'208";a="55371150"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Aug 2020 20:21:51 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.148])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5B62D429693C;
	Wed, 26 Aug 2020 20:21:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 07/10] spi: renesas,sh-msiof: Add r8a774e1 support
Date: Wed, 26 Aug 2020 12:21:29 +0100
Message-Id: <20200826112132.4090-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: YlPisymubF5uohqmeqBrcJPwx4520388AA=
Content-Type: multipart/mixed; boundary="LkJTuTnufp2bwWm6PyOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598441716;
 bh=RkqQTEWGXcAafyoIDHUOw6jdfOI3RJJDK5SSytaKAGs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rst+1NO8JoiH3Bg/VNUXkHMKXrwvvWWC0XK/Tk2nGVQANrhcliRvJPLQwDRiYqzRw9q
 O4LMkU+kb41uNTcrD/+MfsnGtFjZxOQjxLBNYooBaIjG3MxbQEtlCchE2t3CSAUwqU6o6
 nEylPvfbpKB/n0wHv3/mdO1zgCmRVoYoLjE=

--LkJTuTnufp2bwWm6PyOy

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b4f7f5f5470588e45e5d004f1dc4887af20f18c0 upstream.

Document RZ/G2H (R8A774E1) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1594811350-14066-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index 5d6360dc8e51..ed6a9b407a0a 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -6,6 +6,7 @@ Required properties:
 			 "renesas,msiof-r8a774a1" (RZ/G2M)
 			 "renesas,msiof-r8a774b1" (RZ/G2N)
 			 "renesas,msiof-r8a774c0" (RZ/G2E)
+			 "renesas,msiof-r8a774e1" (RZ/G2H)
 			 "renesas,msiof-r8a7790" (R-Car H2)
 			 "renesas,msiof-r8a7791" (R-Car M2-W)
 			 "renesas,msiof-r8a7792" (R-Car V2H)
-- 
2.17.1


--LkJTuTnufp2bwWm6PyOy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5268): https://lists.cip-project.org/g/cip-dev/message=
/5268
Mute This Topic: https://lists.cip-project.org/mt/76426361/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--LkJTuTnufp2bwWm6PyOy--
