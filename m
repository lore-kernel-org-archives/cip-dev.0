Return-Path: <SRS0=iu8n=EJ=lists.cip-project.org=bounce+64572+5717+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85292C5517A
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00E022226
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PhkuBJFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00E022226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5717+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pllRYY4521723xeWZJhJqxT0; Tue, 03 Nov 2020 09:33:44 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.810.1604424820973392125
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 09:33:44 -0800
X-IronPort-AV: E=Sophos;i="5.77,448,1596466800"; 
   d="scan'208";a="61561030"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2020 02:33:43 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AD4FB40061A2;
	Wed,  4 Nov 2020 02:33:42 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 04/17] dt-bindings: display: renesas,du: Document r8a774e1 bindings
Date: Tue,  3 Nov 2020 17:33:23 +0000
Message-Id: <20201103173336.2829-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tIYUnDXmnmQVWfbiGP3AMbi9x4520388AA=
Content-Type: multipart/mixed; boundary="C82oHznv5xwyCgohcuc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604424824;
 bh=ws0wrvujmNxCHnOQ4qY2Im5SVnd66givV2QLT/SdAP0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PhkuBJFS7sHqDzoBOaE3QJAWMu4R92/emSWCKpxAZ/hrO0h8g14daxlN68hCqWZbKcG
 e/Igr2FcPwpujszoxbTL2kySMu0m+gL+Lz7toWuI5T58iJr8ifoMWWZneGAStPcRoTJOP
 I4ywSqVU061Dm9KxkWZblkIUAWOcoAK/DPA=

--C82oHznv5xwyCgohcuc6

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 4b6f2b971e8d142474b7ab7e6d3c23e38d83057f upstream.

Document the RZ/G2H (a.k.a. r8a774e1) SoC in the R-Car DU bindings.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
index 8f9d65c8912b..9282d79aba9f 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.txt
+++ b/Documentation/devicetree/bindings/display/renesas,du.txt
@@ -7,6 +7,7 @@ Required Properties:
     - "renesas,du-r8a7745" for R8A7745 (RZ/G1E) compatible DU
     - "renesas,du-r8a774a1" for R8A774A1 (RZ/G2M) compatible DU
     - "renesas,du-r8a774c0" for R8A774C0 (RZ/G2E) compatible DU
+    - "renesas,du-r8a774e1" for R8A774E1 (RZ/G2H) compatible DU
     - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
     - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
     - "renesas,du-r8a7791" for R8A7791 (R-Car M2-W) compatible DU
@@ -55,6 +56,7 @@ corresponding to each DU output.
  R8A7745 (RZ/G1E)       DPAD 0         DPAD 1         -              -
  R8A774A1 (RZ/G2M)      DPAD 0         HDMI 0         LVDS 0         -
  R8A774C0 (RZ/G2E)      DPAD 0         LVDS 0         LVDS 1         -
+ R8A774E1 (RZ/G2H)      DPAD 0         HDMI 0         LVDS 0         -
  R8A7779 (R-Car H1)     DPAD 0         DPAD 1         -              -
  R8A7790 (R-Car H2)     DPAD 0         LVDS 0         LVDS 1         -
  R8A7791 (R-Car M2-W)   DPAD 0         LVDS 0         -              -
-- 
2.17.1


--C82oHznv5xwyCgohcuc6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5717): https://lists.cip-project.org/g/cip-dev/message=
/5717
Mute This Topic: https://lists.cip-project.org/mt/78011694/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--C82oHznv5xwyCgohcuc6--
