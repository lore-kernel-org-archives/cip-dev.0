Return-Path: <SRS0=GoUL=CG=lists.cip-project.org=bounce+64572+5305+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21308C2BB4D
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:49 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83596208C9
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DMBD+1rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83596208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5305+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lqEYYY4521723xwUWaIQE1ZH; Fri, 28 Aug 2020 09:07:48 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.45771.1598629350683270340
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:30 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804730"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:30 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8366B400C9FD;
	Sat, 29 Aug 2020 00:42:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 15/30] dt-bindings: serial: renesas,scif: Document r8a7742 bindings
Date: Fri, 28 Aug 2020 16:41:40 +0100
Message-Id: <20200828154155.5827-16-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RZfsPQi6aR334StKWV2k41bex4520388AA=
Content-Type: multipart/mixed; boundary="zH8cxyLSPdXpm2gUieKh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630868;
 bh=5ikR/wg+ck6aJOB534eTauMZ1dbqjnrtX8kNijyRllA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DMBD+1rbjSuhGwCA05Yj4LSQEoUxh/2xZ3vpc7W94PIi62rWQxXRsZX4RkUbMKHZ5oQ
 gII/2zdnDfjNCYDtH0GWDHAi+YvuXA0H33O9Ti80HaRh3P/t2lsHjgcOQxOanavMEsvSf
 TRYy0XqODt9oMd16RKQ03qYb/Tj/DcVBu9o=

--zH8cxyLSPdXpm2gUieKh

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8908a822663f6958f56174120de383ff955874be upstream.

RZ/G1H (R8A7742) SoC also has the R-Car gen2 compatible SCIF ports,
so document the SoC specific bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index c57622ef52eb..14768b504d13 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -9,6 +9,7 @@ Required properties:
     - "renesas,scifb-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFB compatible UART.
     - "renesas,scifa-r8a7740" for R8A7740 (R-Mobile A1) SCIFA compatible UART.
     - "renesas,scifb-r8a7740" for R8A7740 (R-Mobile A1) SCIFB compatible UART.
+    - "renesas,scif-r8a7742" for R8A7742 (RZ/G1H) SCIF compatible UART.
     - "renesas,scifa-r8a7742" for R8A7742 (RZ/G1H) SCIFA compatible UART.
     - "renesas,scif-r8a7743" for R8A7743 (RZ/G1M) SCIF compatible UART.
     - "renesas,scifa-r8a7743" for R8A7743 (RZ/G1M) SCIFA compatible UART.
-- 
2.17.1


--zH8cxyLSPdXpm2gUieKh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5305): https://lists.cip-project.org/g/cip-dev/message=
/5305
Mute This Topic: https://lists.cip-project.org/mt/76477088/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--zH8cxyLSPdXpm2gUieKh--
