Return-Path: <SRS0=mhf6=CK=lists.cip-project.org=bounce+64572+5358+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10B2C28E83
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55E620707
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="O3FvYdLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55E620707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5358+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NIdkYY4521723xy4oO2xfGUk; Tue, 01 Sep 2020 04:45:11 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.11107.1598960480272809138
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2020 04:41:34 -0700
X-IronPort-AV: E=Sophos;i="5.76,378,1592838000"; 
   d="scan'208";a="56086800"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2020 20:41:34 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.50])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C0BEC400752B;
	Tue,  1 Sep 2020 20:41:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 09/10] dt-bindings: power: renesas,apmu: Document r8a7742 support
Date: Tue,  1 Sep 2020 12:41:13 +0100
Message-Id: <20200901114114.3465-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
References: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: B08QTsd3XThIJFEwNxZBkqzux4520388AA=
Content-Type: multipart/mixed; boundary="cAziSr1jvlOE3Wigt3i1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598960711;
 bh=RcHWSnxmOTFkGiAwwgrffbrmBf9nALYRCMSX7C7jDAM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=O3FvYdLKcFDybuiV/vf1d8LDozexDAvEjC3KTDCXNU0Ne70BAD4wT5StCAjQG/tfsXM
 07jrp1C2CkJXjecmclhuKWhl921MOH+4G3uYesT8MTZrNs4YeHU9lWWwMpIYjGkKW1+dz
 e92AiZoTrd73tMB5S00+cFjM70cRXaweZQE=

--cAziSr1jvlOE3Wigt3i1

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a08790960382c24d92af43a34626ed0f3899d299 upstream.

Document APMU and SMP enable method for RZ/G1H (also known as r8a7742)
SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/power/renesas,apmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.txt b/Documentation/devicetree/bindings/power/renesas,apmu.txt
index 21157fb60f36..8ffb21e20bc4 100644
--- a/Documentation/devicetree/bindings/power/renesas,apmu.txt
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.txt
@@ -7,6 +7,7 @@ Required properties:
 
 - compatible: Should be "renesas,<soctype>-apmu", "renesas,apmu" as fallback.
 	      Examples with soctypes are:
+		- "renesas,r8a7742-apmu" (RZ/G1H)
 		- "renesas,r8a7743-apmu" (RZ/G1M)
 		- "renesas,r8a7744-apmu" (RZ/G1N)
 		- "renesas,r8a7745-apmu" (RZ/G1E)
-- 
2.17.1


--cAziSr1jvlOE3Wigt3i1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5358): https://lists.cip-project.org/g/cip-dev/message=
/5358
Mute This Topic: https://lists.cip-project.org/mt/76554014/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--cAziSr1jvlOE3Wigt3i1--
