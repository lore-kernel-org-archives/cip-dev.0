Return-Path: <SRS0=iN3O=EE=lists.cip-project.org=bounce+64572+5690+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C84C55179
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 11:46:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AFB207DE
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 11:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mZEYF1kK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AFB207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5690+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uxn8YY4521723xwgFUW0a0Z3; Thu, 29 Oct 2020 04:46:08 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.7371.1603971967194797491
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2020 04:46:07 -0700
X-IronPort-AV: E=Sophos;i="5.77,429,1596466800"; 
   d="scan'208";a="61161059"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Oct 2020 20:46:05 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CEA7442E288E;
	Thu, 29 Oct 2020 20:46:04 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 1/4] dt-bindings: ata: sata_rcar: Add r8a774b1 support
Date: Thu, 29 Oct 2020 11:45:59 +0000
Message-Id: <20201029114602.9107-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201029114602.9107-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201029114602.9107-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XT7ktfFkLNS31LwfSBdrE7hDx4520388AA=
Content-Type: multipart/mixed; boundary="WPzZBerJq2eAbRylH7iP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603971968;
 bh=iw3cW+EtrzWteMlBhiWFhg5c4tMTqBlnIUlOAyp84Ug=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=mZEYF1kKZdUX922ER6ftdLGGB/K0bMPZzmLP8tEouUodneeBP3x4QBZh8xye+mW1ZuS
 DeXJK9jyghSye7RhZp7eD3vFbDJsfOn4nSiNOUnUyRxKr8ZGN3HB8mzkqy/Dh6GUmMHoQ
 ZlCkHBlmg1cEAhmME99FCxbMVfRjlMixbnE=

--WPzZBerJq2eAbRylH7iP

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit b00e14c536574fb3e45aa0cf899e67fc3ac51d06 upstream.

Document SATA support for the RZ/G2N, no driver change required.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index 4268e17d2411..a2fbdc91570d 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible		: should contain one or more of the following:
+			  - "renesas,sata-r8a774b1" for RZ/G2N
 			  - "renesas,sata-r8a7779" for R-Car H1
 			  - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
 			  - "renesas,sata-r8a7790" for R-Car H2 other than ES1
@@ -9,8 +10,10 @@ Required properties:
 			  - "renesas,sata-r8a7793" for R-Car M2-N
 			  - "renesas,sata-r8a7795" for R-Car H3
 			  - "renesas,sata-r8a77965" for R-Car M3-N
-			  - "renesas,rcar-gen2-sata" for a generic R-Car Gen2 compatible device
-			  - "renesas,rcar-gen3-sata" for a generic R-Car Gen3 compatible device
+			  - "renesas,rcar-gen2-sata" for a generic R-Car Gen2
+			     compatible device
+			  - "renesas,rcar-gen3-sata" for a generic R-Car Gen3 or
+			     RZ/G2 compatible device
 			  - "renesas,rcar-sata" is deprecated
 
 			  When compatible with the generic version nodes
-- 
2.17.1


--WPzZBerJq2eAbRylH7iP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5690): https://lists.cip-project.org/g/cip-dev/message=
/5690
Mute This Topic: https://lists.cip-project.org/mt/77885349/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WPzZBerJq2eAbRylH7iP--
