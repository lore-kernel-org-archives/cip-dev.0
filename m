Return-Path: <SRS0=vgJy=CL=lists.cip-project.org=bounce+64572+5370+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CE9C2BBD0
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13EB2137B
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hX1dP/3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13EB2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5370+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ilOlYY4521723xfx7vCddKpa; Wed, 02 Sep 2020 09:06:41 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.11123.1599062722942469002
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 09:05:23 -0700
X-IronPort-AV: E=Sophos;i="5.76,383,1592838000"; 
   d="scan'208";a="56196958"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2020 01:05:22 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E86B040065AE;
	Thu,  3 Sep 2020 01:05:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 1/9] dt-bindings: watchdog: renesas,wdt: Document r8a7742 support
Date: Wed,  2 Sep 2020 17:05:06 +0100
Message-Id: <20200902160517.5181-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
References: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: G51KI9MQDhc2jdifnsDX4xmNx4520388AA=
Content-Type: multipart/mixed; boundary="bx6ZsxBaGy0GSHAuAYuM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599062801;
 bh=cOxcsBl7fct1jbBWP52t1iKJSMhJSqLhoejzfVtbbpk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=hX1dP/3OkmYAG6oHsFL7VfFAXttdwz7mudv3FlJJQwxn1ZCqqvyDAA33E4eoGqMcubR
 4ZKG5NhoGQpD4niQ0+K07sB6fr8SLQ/eCODGnW9mWdvj5nXLAiM1T/399yVdDXNe5jqC8
 AuSwdvpiQrNLHZtcY0+CAZ3/2cWcmid5GxM=

--bx6ZsxBaGy0GSHAuAYuM

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 06c3b7a60b4b248ed12229ea39399be0501532de upstream.

RZ/G1H (R8A7742) watchdog implementation is compatible with R-Car Gen2,
therefore add relevant documentation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rob Herring <robh@kernel.org>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index 050bcf0e3e00..0541781344af 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -5,6 +5,7 @@ Required properties:
 		fallback compatible string when compatible with the generic
 		version.
 	       Examples with soctypes are:
+		 - "renesas,r8a7742-wdt" (RZ/G1H)
 		 - "renesas,r8a7743-wdt" (RZ/G1M)
 		 - "renesas,r8a7744-wdt" (RZ/G1N)
 		 - "renesas,r8a7745-wdt" (RZ/G1E)
-- 
2.17.1


--bx6ZsxBaGy0GSHAuAYuM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5370): https://lists.cip-project.org/g/cip-dev/message=
/5370
Mute This Topic: https://lists.cip-project.org/mt/76585837/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--bx6ZsxBaGy0GSHAuAYuM--
