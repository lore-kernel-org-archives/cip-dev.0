Return-Path: <SRS0=1Prx=CE=lists.cip-project.org=bounce+64572+5266+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E23AC433ED
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723962087C
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kU/+p5Mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723962087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5266+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Sju9YY4521723xYywjLzm0fI; Wed, 26 Aug 2020 04:35:17 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.10258.1598440908658796256
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 04:21:48 -0700
X-IronPort-AV: E=Sophos;i="5.76,355,1592838000"; 
   d="scan'208";a="55588068"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Aug 2020 20:21:48 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.148])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B00F5429693C;
	Wed, 26 Aug 2020 20:21:46 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 05/10] dt-bindings: i2c: renesas,iic: Document r8a774e1 support
Date: Wed, 26 Aug 2020 12:21:27 +0100
Message-Id: <20200826112132.4090-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cZ3ByTTv4jR2AJM2AKmiDRlVx4520388AA=
Content-Type: multipart/mixed; boundary="Mq9d6xOfSCKTSHVujqsu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598441717;
 bh=eFwdlc3womUlBl37g2HAeZYFWi9SPjJ6KgOx4TjGYN8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kU/+p5Mqp2lU8yaN6KpMPpGUOzGIjqDsBRbMenfMoaXIDex+wGm/8OxX3fhG39c4bQq
 8iHY+D51IpO55WUOS1084R+Pv2e+suBMhw21Hs89htad5xKQZ9uSwZo4lDJ9lWrNMxQEC
 8p9uVutDe7s70ieSifA5Je6YefF8apYnPfQ=

--Mq9d6xOfSCKTSHVujqsu

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 99f0975d760b6320dd5490bd0bc3a31900284757 upstream.

Document IIC controller for RZ/G2H (R8A774E1) SoC, which is compatible
with R-Car Gen3 SoC family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,iic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,iic.txt b/Documentation/devicetree/bindings/i2c/renesas,iic.txt
index a139e58c180e..60985537ab68 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,iic.txt
+++ b/Documentation/devicetree/bindings/i2c/renesas,iic.txt
@@ -9,6 +9,7 @@ Required properties:
 			- "renesas,iic-r8a774a1" (RZ/G2M)
 			- "renesas,iic-r8a774b1" (RZ/G2N)
 			- "renesas,iic-r8a774c0" (RZ/G2E)
+			- "renesas,iic-r8a774e1" (RZ/G2H)
 			- "renesas,iic-r8a7790" (R-Car H2)
 			- "renesas,iic-r8a7791" (R-Car M2-W)
 			- "renesas,iic-r8a7792" (R-Car V2H)
-- 
2.17.1


--Mq9d6xOfSCKTSHVujqsu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5266): https://lists.cip-project.org/g/cip-dev/message=
/5266
Mute This Topic: https://lists.cip-project.org/mt/76426359/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Mq9d6xOfSCKTSHVujqsu--
