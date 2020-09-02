Return-Path: <SRS0=H1/e=CL=lists.cip-project.org=bounce+64572+5376+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DADC433E2
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80650207EA
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Zr4TleeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80650207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5376+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id t4aLYY4521723x0bGJaewMMv; Wed, 02 Sep 2020 09:06:42 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11147.1599062725125566061
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 09:05:32 -0700
X-IronPort-AV: E=Sophos;i="5.76,383,1592838000"; 
   d="scan'208";a="55980495"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 01:05:32 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AA91E40062CD;
	Thu,  3 Sep 2020 01:05:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 4/9] dt-bindings: thermal: rcar-thermal: Add device tree support for r8a7742
Date: Wed,  2 Sep 2020 17:05:11 +0100
Message-Id: <20200902160517.5181-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
References: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2Y5HBaKDggZzdO0vELyB7Ar8x4520388AA=
Content-Type: multipart/mixed; boundary="QWDdBa4hRtQPhGVypgtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599062802;
 bh=r8qrNqCHv80mtlCxl9lRceB8o14JH9WOIs/8g0leNW4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Zr4TleeIonkOBCjDusf2oPotaYmK3dNfMpyREwm+1ZTQA1FSTotJFxW0fecclkHARkU
 KOU0fwrAr0QLem6l5pcDJL1otMuRn8VyNG0In6/ABS6kbgdwZp/5H1DnmYv6PipSrTABe
 h8CWs0ECt5g2NNImQ4oev+8EFvPw9skGugM=

--QWDdBa4hRtQPhGVypgtn

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit fafcc40fd5261db9de1cef34f9a0694bad507504 upstream.

Add thermal sensor support for r8a7742 SoC. The Renesas RZ/G1H
(r8a7742) thermal sensor module is identical to the R-Car Gen2 family.

No driver change is needed due to the fallback compatible value
"renesas,rcar-gen2-thermal".

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
index 1e0f8377a949..0772137fa6cc 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
@@ -6,6 +6,7 @@ Required properties:
 			   "renesas,rcar-thermal" (without thermal-zone) as fallback.
 			  Examples with soctypes are:
 			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
+			    - "renesas,thermal-r8a7742" (RZ/G1H)
 			    - "renesas,thermal-r8a7743" (RZ/G1M)
 			    - "renesas,thermal-r8a7744" (RZ/G1N)
 			    - "renesas,thermal-r8a7779" (R-Car H1)
-- 
2.17.1


--QWDdBa4hRtQPhGVypgtn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5376): https://lists.cip-project.org/g/cip-dev/message=
/5376
Mute This Topic: https://lists.cip-project.org/mt/76585843/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--QWDdBa4hRtQPhGVypgtn--
