Return-Path: <SRS0=r7Zk=CM=lists.cip-project.org=bounce+64572+5396+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E82C433E2
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469D6206EB
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Epghkw6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469D6206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5396+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id m95oYY4521723xdbc5a8nnME; Thu, 03 Sep 2020 07:43:07 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.15617.1599144186096464858
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:43:07 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56297547"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2020 23:43:06 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DCA0742D18DA;
	Thu,  3 Sep 2020 23:43:05 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 1/6] dt-bindings: net: renesas,ether: Document R8A7742 SoC
Date: Thu,  3 Sep 2020 15:42:58 +0100
Message-Id: <20200903144303.13275-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: h1sbvjtQNlKEOSMNO0ZKE5bAx4520388AA=
Content-Type: multipart/mixed; boundary="mWLWGMSoFG4I9N4zjlxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599144187;
 bh=X5iOW1pLlQ/bHaojb3KYlQ0XhPURCSQRMAjbK8lSBFM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Epghkw6JdWD98/gWe+vWMjiF60Z9+gEIKo7Z1SQoQxS1DENtxkLvuwpHZ8uouHQiu0h
 4sXKZFtlWcbzA5yuEnN7US2cwZAloFynPTngz3n7Y+a998gic3+DzFFADba2vWhcqirBk
 JxrH7uuwP+ouBHAZNUtXW4XS+Pz6Fbp9Fgw=

--mWLWGMSoFG4I9N4zjlxw

commit 75d728ed2b1e48b9801b6856147bbe26c28f3143 upstream.

Document RZ/G1H (R8A7742) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
[PL: Patched text version of bindings file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/sh_eth.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/sh_eth.txt b/Documentation/devicetree/bindings/net/sh_eth.txt
index 0115c85a2425..ead74a50ca02 100644
--- a/Documentation/devicetree/bindings/net/sh_eth.txt
+++ b/Documentation/devicetree/bindings/net/sh_eth.txt
@@ -5,6 +5,7 @@ interface contains.
 
 Required properties:
 - compatible: "renesas,gether-r8a7740" if the device is a part of R8A7740 SoC.
+	      "renesas,ether-r8a7742"  if the device is a part of R8A7742 SoC.
 	      "renesas,ether-r8a7743"  if the device is a part of R8A7743 SoC.
 	      "renesas,ether-r8a7745"  if the device is a part of R8A7745 SoC.
 	      "renesas,ether-r8a7778"  if the device is a part of R8A7778 SoC.
-- 
2.17.1


--mWLWGMSoFG4I9N4zjlxw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5396): https://lists.cip-project.org/g/cip-dev/message=
/5396
Mute This Topic: https://lists.cip-project.org/mt/76608366/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mWLWGMSoFG4I9N4zjlxw--
