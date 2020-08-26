Return-Path: <SRS0=vpp2=CE=lists.cip-project.org=bounce+64572+5270+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37061C433F7
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:18 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088D92083B
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NsTRKK/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088D92083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5270+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sq2mYY4521723xCysCRJjo6F; Wed, 26 Aug 2020 04:35:17 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.10258.1598440908658796256
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 04:21:55 -0700
X-IronPort-AV: E=Sophos;i="5.76,355,1592838000"; 
   d="scan'208";a="55588077"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Aug 2020 20:21:55 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.148])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 125B8429693C;
	Wed, 26 Aug 2020 20:21:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 09/10] dt-bindings: watchdog: renesas,wdt: Document r8a774e1 support
Date: Wed, 26 Aug 2020 12:21:31 +0100
Message-Id: <20200826112132.4090-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: g346uChDE4MSHKUoVB2gyinBx4520388AA=
Content-Type: multipart/mixed; boundary="mPp6sSuwWcELBolZynpn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598441717;
 bh=4+L4TtaIf4JpLoSfg+NBwdE0U0fcQo+3JyQwUBlRvgQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NsTRKK/LnEDb6Zb+Q+nxrHdLflRpL8Lxi4Q2zAoGlH0LM/ILE09rgSs4163LwNNFC2M
 blSdIh/ZibLVoKfaeBlJWSR+BzcnQScdi6UU+sUVyd8AkdjIUl6spQ/4pIItEr4j39p0k
 /LVX947oOO9FIhVclYX07npzjYXiVHVhTvo=

--mPp6sSuwWcELBolZynpn

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d821ab28dfd2fa85a9aed133e9bfd368c156cc04 upstream.

RZ/G2H (a.k.a. R8A774E1) watchdog implementation is compatible
with R-Car Gen3, therefore add the relevant documentation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1594811350-14066-17-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas,wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
index 71f419d5c0c3..e673059667c3 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
@@ -10,6 +10,7 @@ Required properties:
 		 - "renesas,r8a774a1-wdt" (RZ/G2M)
 		 - "renesas,r8a774b1-wdt" (RZ/G2N)
 		 - "renesas,r8a774c0-wdt" (RZ/G2E)
+		 - "renesas,r8a774e1-wdt" (RZ/G2H)
 	         - "renesas,r8a7790-wdt" (R-Car H2)
 	         - "renesas,r8a7791-wdt" (R-Car M2-W)
 	         - "renesas,r8a7792-wdt" (R-Car V2H)
-- 
2.17.1


--mPp6sSuwWcELBolZynpn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5270): https://lists.cip-project.org/g/cip-dev/message=
/5270
Mute This Topic: https://lists.cip-project.org/mt/76426363/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mPp6sSuwWcELBolZynpn--
