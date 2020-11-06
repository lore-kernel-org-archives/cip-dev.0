Return-Path: <SRS0=LUdO=EM=lists.cip-project.org=bounce+64572+5761+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDCFC5517A
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:52:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C3B20A8B
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="n7q/7Ozc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C3B20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5761+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wOJXYY4521723xD5JUgxrewG; Fri, 06 Nov 2020 01:52:02 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web08.9517.1604656315663802830
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2020 01:52:01 -0800
X-IronPort-AV: E=Sophos;i="5.77,456,1596466800"; 
   d="scan'208";a="61866358"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2020 18:52:01 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 739524266629;
	Fri,  6 Nov 2020 18:52:00 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 6/8] dt-bindings: ata: renesas,rcar-sata: Add r8a7742 support
Date: Fri,  6 Nov 2020 09:51:49 +0000
Message-Id: <20201106095151.25880-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: tTXOg1u5lNfq4SZckwYTvhV2x4520388AA=
Content-Type: multipart/mixed; boundary="XSt57toU9c4RORv11lBJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604656322;
 bh=jz24E6q+B56VJfv7UC1Kumxe7M7ZYTzVxUDqN2WlUgo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=n7q/7OzcKt3zK1gN2evNAf4BHH/9dwI+n5Q1dClCDT0HrwZ9zxPYVz1Hy7iZMQY0D8c
 UZbYWAqVe7uDtZt2ytW/MDcjfUQGOu6QQZpdDdchQK9Tx+AvNTnVKyQNh54USILgKNkOW
 ysh9mmrUJqeVTAwrcLnl4YW4vuu0aqOXEAg=

--XSt57toU9c4RORv11lBJ

commit 33e70291d1ded119313ac1c20346a1f9f3b3b66f upstream.

Document SATA support for the RZ/G1H, which is compatible with
R-Car Gen2 SoC family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
[PL: Manually applied changes to text version of binding file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index ee0a4b6d615f..2c3a2eba0258 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible		: should contain one or more of the following:
+			  - "renesas,sata-r8a7742" for RZ/G1H
 			  - "renesas,sata-r8a7779" for R-Car H1
 			  - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
 			  - "renesas,sata-r8a7790" for R-Car H2 other than ES1
-- 
2.17.1


--XSt57toU9c4RORv11lBJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5761): https://lists.cip-project.org/g/cip-dev/message=
/5761
Mute This Topic: https://lists.cip-project.org/mt/78070986/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XSt57toU9c4RORv11lBJ--
