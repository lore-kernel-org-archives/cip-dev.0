Return-Path: <SRS0=IBTo=CG=lists.cip-project.org=bounce+64572+5309+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A534C43461
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:49 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E6B208D5
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="o0JrpoTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E6B208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5309+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id K7IKYY4521723xVz0BeCyZGv; Fri, 28 Aug 2020 09:07:48 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.45771.1598629350683270340
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:38 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804741"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:38 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9E954400C9FD;
	Sat, 29 Aug 2020 00:42:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 19/30] dt-bindings: pinctrl: sh-pfc: Document r8a7742 PFC support
Date: Fri, 28 Aug 2020 16:41:44 +0100
Message-Id: <20200828154155.5827-20-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: z4JfWlNVBorpp6pshhNw6ljFx4520388AA=
Content-Type: multipart/mixed; boundary="R1grXy47DOny5egkmU94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630868;
 bh=AJ9tVj3f/l/KERKiGYbs8ypQvL69PVTOxJe4ogAFlF0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=o0JrpoTKb3z6Fkn6lg7CurDqPJkblKNyj/C1T7zU3ZpP9b6uigwVytn8k1N7Acxmd50
 88I+nWmuz4abpREUUHvh0fBNpeUaPJOVfGKQdrBJji7Uwq1HQCA6U/zRPlL+fi9dodSOj
 fAE7OWvR2O3brzFzMZ17JOUH2ThhRGt5aVs=

--R1grXy47DOny5egkmU94

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit baf674bf717f8224f33e453e1df92a96c4d6ce48 upstream.

Document PFC support for the RZ/G1H (R8A7742) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1588542414-14826-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
index f2008d0e5fd2..90c9bf8beca2 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -13,6 +13,7 @@ Required Properties:
     - "renesas,pfc-emev2": for EMEV2 (EMMA Mobile EV2) compatible pin-controller.
     - "renesas,pfc-r8a73a4": for R8A73A4 (R-Mobile APE6) compatible pin-controller.
     - "renesas,pfc-r8a7740": for R8A7740 (R-Mobile A1) compatible pin-controller.
+    - "renesas,pfc-r8a7742": for R8A7742 (RZ/G1H) compatible pin-controller.
     - "renesas,pfc-r8a7743": for R8A7743 (RZ/G1M) compatible pin-controller.
     - "renesas,pfc-r8a7744": for R8A7744 (RZ/G1N) compatible pin-controller.
     - "renesas,pfc-r8a7745": for R8A7745 (RZ/G1E) compatible pin-controller.
-- 
2.17.1


--R1grXy47DOny5egkmU94
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5309): https://lists.cip-project.org/g/cip-dev/message=
/5309
Mute This Topic: https://lists.cip-project.org/mt/76477092/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--R1grXy47DOny5egkmU94--
