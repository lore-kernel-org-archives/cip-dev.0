Return-Path: <SRS0=/oRx=EJ=lists.cip-project.org=bounce+64572+5729+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D2C388F9
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:34:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8948022264
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="FZARH9yW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8948022264
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5729+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3XthYY4521723x3h804bfECC; Tue, 03 Nov 2020 09:34:00 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.810.1604424820973392125
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 09:33:59 -0800
X-IronPort-AV: E=Sophos;i="5.77,448,1596466800"; 
   d="scan'208";a="61561061"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2020 02:33:59 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5799440061A2;
	Wed,  4 Nov 2020 02:33:58 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 16/17] dt-bindings: sound: renesas, rsnd: Document r8a774e1 bindings
Date: Tue,  3 Nov 2020 17:33:35 +0000
Message-Id: <20201103173336.2829-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 87VHE4flDFQHa9d42xUMHoJUx4520388AA=
Content-Type: multipart/mixed; boundary="e1nVaUvwToQI5qUUZMN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604424840;
 bh=ag3E/F/Zfc9ayFf9H4GDUe4aIRF2jelVEA0v8QPce9w=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=FZARH9yWyCl/AJiNdUzAbteQb7+61ejAyx9hi5TbldCL7Gcj+6R7LeLAFlBM8X0I18u
 oTQqt1xk30rbbSeEw0lhB1TlTmvgJaavvlomBmV8x/qD+8lF8N+U+NgiUl+cUywPsHThJ
 tYbEm+yPK03I6dDGgcy0/5WLL2PSb248skw=

--e1nVaUvwToQI5qUUZMN5

commit 92e37407811b98a7eb54eb6a6b3d65847a46e0e6 upstream.

Document SoC specific bindings for RZ/G2H (r8a774e1) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1594919915-5225-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index a65c97d92008..438e6c19694e 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -347,6 +347,7 @@ Required properties:
 				    - "renesas,rcar_sound-r8a774a1" (RZ/G2M)
 				    - "renesas,rcar_sound-r8a774b1" (RZ/G2N)
 				    - "renesas,rcar_sound-r8a774c0" (RZ/G2E)
+				    - "renesas,rcar_sound-r8a774e1" (RZ/G2H)
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
 				    - "renesas,rcar_sound-r8a7779" (R-Car H1)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
-- 
2.17.1


--e1nVaUvwToQI5qUUZMN5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5729): https://lists.cip-project.org/g/cip-dev/message=
/5729
Mute This Topic: https://lists.cip-project.org/mt/78011711/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--e1nVaUvwToQI5qUUZMN5--
