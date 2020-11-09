Return-Path: <SRS0=DU/8=EP=lists.cip-project.org=bounce+64572+5772+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFA8C5517A
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CD92074F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RqWurggR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CD92074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5772+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6zcJYY4521723xiOE0q1GdOv; Mon, 09 Nov 2020 07:50:18 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.13504.1604937015956466828
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:18 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="62129272"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:17 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AAC9E40078A1;
	Tue, 10 Nov 2020 00:50:16 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 03/14] spi: renesas,rspi: Add r8a7742 to the compatible list
Date: Mon,  9 Nov 2020 15:50:00 +0000
Message-Id: <20201109155011.10291-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Nk3yBqkgvID8tlmwZt6cWgIRx4520388AA=
Content-Type: multipart/mixed; boundary="vs6TjBJeV4fllQ3Grl2o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937018;
 bh=umYmnS6Srr/ByHTgpk3VYHAvCCSBKDepa96wSS+T4eQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=RqWurggRAm1OyOmh8teVaxxPtOLix/7Av9u+pdtPgBS2807nV1nhZBlQEidT/fr+tQs
 nnBBSszTl3eEhQY5Did0xYOqHsuwDgc6j1KkUmI0E+T6agAN0zciqR/CLyIYDkGO7YgSX
 DcVplt+BvehHgLKB94mhfi6NMFZY301F1QU=

--vs6TjBJeV4fllQ3Grl2o

commit 08f9793efd3decae75e60bfec2e6068f2d4180df upstream.

Document RZ/G1H (R8A7742) SoC specific bindings. The R8A7742 qspi module
is identical to R-Car Gen2 family.

No driver change is needed due to the fallback compatible value
"renesas,qspi".

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200812150048.27721-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[PL: Patched text version of bindings file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
index 2f1a3dc069e7..6a30a2112b8e 100644
--- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -11,6 +11,7 @@ Required properties:
 		     Examples with soctypes are:
 		        - "renesas,rspi-sh7757" (SH)
 			- "renesas,rspi-r7s72100" (RZ/A1H)
+			- "renesas,qspi-r8a7742" (RZ/G1H)
 			- "renesas,qspi-r8a7743" (RZ/G1M)
 			- "renesas,qspi-r8a7744" (RZ/G1N)
 			- "renesas,qspi-r8a7745" (RZ/G1E)
-- 
2.17.1


--vs6TjBJeV4fllQ3Grl2o
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5772): https://lists.cip-project.org/g/cip-dev/message=
/5772
Mute This Topic: https://lists.cip-project.org/mt/78138427/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vs6TjBJeV4fllQ3Grl2o--
