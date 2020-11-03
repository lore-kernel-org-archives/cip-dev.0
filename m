Return-Path: <SRS0=D4c3=EJ=lists.cip-project.org=bounce+64572+5722+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF24AC388F9
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23FD22226
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="FIDGt1nI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23FD22226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5722+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qno6YY4521723xm4GsGvkrIh; Tue, 03 Nov 2020 09:33:51 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.810.1604424820973392125
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 09:33:50 -0800
X-IronPort-AV: E=Sophos;i="5.77,448,1596466800"; 
   d="scan'208";a="61561042"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2020 02:33:50 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 401A14009F7A;
	Wed,  4 Nov 2020 02:33:49 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 09/17] dt-bindings: display: renesas,lvds: Document r8a774e1 bindings
Date: Tue,  3 Nov 2020 17:33:28 +0000
Message-Id: <20201103173336.2829-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: L1vMEWlxoe2GiUP7OCN1gvhSx4520388AA=
Content-Type: multipart/mixed; boundary="t3eoFjbynaoaFhYwvWVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604424831;
 bh=MKlx5Lh0yZ0IEWPsf4d9JAURZGvyLmYODIAi6WKL2eI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=FIDGt1nI7koPlu4C2ejn/29q3WwDhJz00JbiGas/+7W+VU8OCfIzB/GGFnFYIoJ9CxJ
 inYxap9ZcIJ8Z8ADzSbTUSWYZazrNPHGCBUv1dNzHmj5ftG4pLPA12qzS8pzADWSy3MhO
 EFueiKT7wnrkiFmob6u5ebmS7PPg8Z+96+E=

--t3eoFjbynaoaFhYwvWVH

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 45d6ec79dd42258ada43fedf3bb00c04ae7c17eb upstream.

Document the RZ/G2H (R8A774E1) LVDS bindings.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[PL: Patched text version of bindings file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/display/bridge/renesas,lvds.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
index 10e2e8e9eb20..f60a10e649eb 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
@@ -10,6 +10,7 @@ Required properties:
   - "renesas,r8a7743-lvds" for R8A7743 (RZ/G1M) compatible LVDS encoders
   - "renesas,r8a774a1-lvds" for R8A774A1 (RZ/G2M) compatible LVDS encoders
   - "renesas,r8a774c0-lvds" for R8A774C0 (RZ/G2E) compatible LVDS encoders
+  - "renesas,r8a774e1-lvds" for R8A774E1 (RZ/G2H) compatible LVDS encoders
   - "renesas,r8a7790-lvds" for R8A7790 (R-Car H2) compatible LVDS encoders
   - "renesas,r8a7791-lvds" for R8A7791 (R-Car M2-W) compatible LVDS encoders
   - "renesas,r8a7793-lvds" for R8A7793 (R-Car M2-N) compatible LVDS encoders
-- 
2.17.1


--t3eoFjbynaoaFhYwvWVH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5722): https://lists.cip-project.org/g/cip-dev/message=
/5722
Mute This Topic: https://lists.cip-project.org/mt/78011700/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--t3eoFjbynaoaFhYwvWVH--
