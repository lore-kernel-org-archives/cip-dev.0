Return-Path: <SRS0=EIow=EJ=lists.cip-project.org=bounce+64572+5720+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76484C55178
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C03822226
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="J/KT4OCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C03822226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5720+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IZ39YY4521723x3pRGYIlIrV; Tue, 03 Nov 2020 09:33:48 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.807.1604424828101556546
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 09:33:48 -0800
X-IronPort-AV: E=Sophos;i="5.77,448,1596466800"; 
   d="scan'208";a="61344821"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Nov 2020 02:33:47 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9937040061A2;
	Wed,  4 Nov 2020 02:33:46 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 07/17] dt-bindings: display: renesas,dw-hdmi: Add r8a774e1 support
Date: Tue,  3 Nov 2020 17:33:26 +0000
Message-Id: <20201103173336.2829-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4a68lOP0FNjLNLYJnnmHOe5Mx4520388AA=
Content-Type: multipart/mixed; boundary="C6qVXwVPRw0DMQa7AT7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604424828;
 bh=DdFumCJY7Dqa4LacvwJGUds30tI4ueSmLOFLpjOhhIQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=J/KT4OCEI/ls4B6lRYD8JwtmEDyNX6zt4mRilTFWvoj05b3hJhMzKxYh22n65CCw8nB
 PZmLNY+ten6szoOSLrn1DSjHlYnm/EGd1A+XPF3le9mjv7NW1cNPbgc5Kh5TbiyTfb38p
 amtZQtxBOm6Q14dh0Z9h2m7tSYPLnhsNiSk=

--C6qVXwVPRw0DMQa7AT7a

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 0c905a0a30d16c43efc381a29f509fbff606b91d upstream.

Document RZ/G2H (R8A774E1) SoC bindings.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[PL: Manually applied changes to binding document]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/display/bridge/renesas,dw-hdmi.txt       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
index db680413e89c..9b02bd66124d 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
@@ -13,6 +13,7 @@ Required properties:
 
 - compatible : Shall contain one or more of
   - "renesas,r8a774a1-hdmi" for R8A774A1 (RZ/G2M) compatible HDMI TX
+  - "renesas,r8a774e1-hdmi" for R8A774E1 (RZ/G2H) compatible HDMI TX
   - "renesas,r8a7795-hdmi" for R8A7795 (R-Car H3) compatible HDMI TX
   - "renesas,r8a7796-hdmi" for R8A7796 (R-Car M3-W) compatible HDMI TX
   - "renesas,r8a77965-hdmi" for R8A77965 (R-Car M3-N) compatible HDMI TX
-- 
2.17.1


--C6qVXwVPRw0DMQa7AT7a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5720): https://lists.cip-project.org/g/cip-dev/message=
/5720
Mute This Topic: https://lists.cip-project.org/mt/78011698/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--C6qVXwVPRw0DMQa7AT7a--
