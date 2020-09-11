Return-Path: <SRS0=UQYw=CU=lists.cip-project.org=bounce+64572+5442+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7524AC2D0E3
	for <cip-dev@archiver.kernel.org>; Fri, 11 Sep 2020 12:39:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66C522204
	for <cip-dev@archiver.kernel.org>; Fri, 11 Sep 2020 12:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UZfhe4yk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66C522204
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5442+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xSwHYY4521723xIUwusxhPOX; Fri, 11 Sep 2020 05:39:58 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.6921.1599827526358857457
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2020 05:32:06 -0700
X-IronPort-AV: E=Sophos;i="5.76,415,1592838000"; 
   d="scan'208";a="57039939"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2020 21:32:05 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.232])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 325844263CB6;
	Fri, 11 Sep 2020 21:32:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 1/4] dt-bindings: ASoC: renesas,rsnd: Add r8a7742 support
Date: Fri, 11 Sep 2020 13:31:58 +0100
Message-Id: <20200911123201.7820-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200911123201.7820-1-biju.das.jz@bp.renesas.com>
References: <20200911123201.7820-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: T5sOerSlReIU4reLNdnG1SKCx4520388AA=
Content-Type: multipart/mixed; boundary="I2XvYn9EIPPT23TdQBg8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599827998;
 bh=hQ4yn7Aunf31HHkLjis1N6sqzwMtiJi2xRQeZKKQqXY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UZfhe4ykjq71y78FI5+s4/UMg1CHWHSQr4c4E7JuThf1E6wmEQupS95bkcUeHBRpzSx
 dre5HaDKqXreTKrFtY3BKs/mAmNdIm+gfju4n/euVhjO/lwep9hE7DZMvj4lGGYKmUA4H
 gU24zDNzo9weJ1pv20Fd/QVLLPYEczANp6Q=

--I2XvYn9EIPPT23TdQBg8

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b6f10d3f2e6dfccf58c54e81c8af586b66a80ce4 upstream.

Document RZ/G1H (R8A7742) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1590526904-13855-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 23656d187f3a..bf07aa156a6a 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -6,6 +6,7 @@ Required properties:
 				  "renesas,rcar_sound-gen2" if generation2 (or RZ/G1)
 				  "renesas,rcar_sound-gen3" if generation3
 				  Examples with soctypes are:
+				    - "renesas,rcar_sound-r8a7742" (RZ/G1H)
 				    - "renesas,rcar_sound-r8a7743" (RZ/G1M)
 				    - "renesas,rcar_sound-r8a7744" (RZ/G1N)
 				    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
-- 
2.17.1


--I2XvYn9EIPPT23TdQBg8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5442): https://lists.cip-project.org/g/cip-dev/message=
/5442
Mute This Topic: https://lists.cip-project.org/mt/76778358/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--I2XvYn9EIPPT23TdQBg8--
