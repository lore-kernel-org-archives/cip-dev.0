Return-Path: <SRS0=R6QG=CL=lists.cip-project.org=bounce+64572+5380+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5FBC433E7
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DD0208C7
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dXyYeK6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DD0208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5380+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UkpLYY4521723xu1haXJEqSP; Wed, 02 Sep 2020 09:06:43 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11147.1599062725125566061
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 09:05:40 -0700
X-IronPort-AV: E=Sophos;i="5.76,383,1592838000"; 
   d="scan'208";a="55980503"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 01:05:39 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8C41940065AE;
	Thu,  3 Sep 2020 01:05:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 7/9] spi: renesas,sh-msiof: Add r8a7742 support
Date: Wed,  2 Sep 2020 17:05:15 +0100
Message-Id: <20200902160517.5181-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
References: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sm437qhEkEwgTaZAiS50LeDCx4520388AA=
Content-Type: multipart/mixed; boundary="stD0so8LmR3wccdXMVcQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599062803;
 bh=t6h7Uhpyyg4o4iyE5dbMk4aCimyGEsW2ZOqpCzfVglA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dXyYeK6OD5BYRAits1I7dY34itND+SV/Cb7ODG6ahFycHROzSnGkY3ycpf5lOdNp1KX
 Ha6GwqO1U1szWTnJtEvM8oCaknNGAeRGRdAR4N6JOC/auXzgoTF43W4bO+05WfbanDh7Q
 w/g9bvzOFUfvLWrfvi6drcMI8xAfBR8urFc=

--stD0so8LmR3wccdXMVcQ

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 6383b118efafff8cce8fc8fa5b7e893a523b698f upstream.

Document RZ/G1H (R8A7742) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1591736054-568-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index 7a20ec6a595e..80aa70517dd2 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -1,7 +1,8 @@
 Renesas MSIOF spi controller
 
 Required properties:
-- compatible           : "renesas,msiof-r8a7743" (RZ/G1M)
+- compatible           : "renesas,msiof-r8a7742" (RZ/G1H)
+			 "renesas,msiof-r8a7743" (RZ/G1M)
 			 "renesas,msiof-r8a7745" (RZ/G1E)
 			 "renesas,msiof-r8a7790" (R-Car H2)
 			 "renesas,msiof-r8a7791" (R-Car M2-W)
-- 
2.17.1


--stD0so8LmR3wccdXMVcQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5380): https://lists.cip-project.org/g/cip-dev/message=
/5380
Mute This Topic: https://lists.cip-project.org/mt/76585847/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--stD0so8LmR3wccdXMVcQ--
