Return-Path: <SRS0=GfRj=EM=lists.cip-project.org=bounce+64572+5759+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B26C55178
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:52:01 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844B92087E
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aFFbo5CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844B92087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5759+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Jb3MYY4521723xLMwyF4FbOt; Fri, 06 Nov 2020 01:51:59 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web08.9517.1604656315663802830
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2020 01:51:59 -0800
X-IronPort-AV: E=Sophos;i="5.77,456,1596466800"; 
   d="scan'208";a="61866349"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2020 18:51:58 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D27944266629;
	Fri,  6 Nov 2020 18:51:57 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 4/8] ata: sata_rcar: add gen[23] fallback compatibility strings
Date: Fri,  6 Nov 2020 09:51:47 +0000
Message-Id: <20201106095151.25880-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qUixo1Q4dnVhYYcGcmkdHzerx4520388AA=
Content-Type: multipart/mixed; boundary="9shfhMawlbnJZNa2KJPm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604656319;
 bh=MzhfiyyCtg4vpQB482zm3GtavHDfATw/G4ZCsFKpIq0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=aFFbo5CD6YzK8UBNDYK9X3zgtPIfRMnklB9faBjyzPI1LHD+8HlA0yQypYcaWaxN9Z7
 L+Z0QDrDvXf1DK9jDts7khvVKAze6zRYpOVE/fs5CqwlAO6wzLmB+eEgfEAbnI5Dfyahj
 CnSOQXFn9LlR6fhgBbwOawJtJZ97BeK/QcI=

--9shfhMawlbnJZNa2KJPm

From: Simon Horman <horms+renesas@verge.net.au>

commit 6ac1d1532c888b030acb3b4ac82425448cb15198 upstream.

Add fallback compatibility string for R-Car Gen 2 and 3.

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, e.g. Gen 1 and 2. But beyond that its not clear what the relationship
between IP blocks might be. For example, I believe that r8a7790 is older
than r8a7791 but that doesn't imply that the latter is a descendant of the
former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme being adopted for
drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
[PL: Dropped R-Car Gen3 support]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 13 ++++++++++---
 drivers/ata/sata_rcar.c                             |  4 ++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index 2493a5a31655..ee0a4b6d615f 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -1,13 +1,20 @@
 * Renesas R-Car SATA
 
 Required properties:
-- compatible		: should contain one of the following:
+- compatible		: should contain one or more of the following:
 			  - "renesas,sata-r8a7779" for R-Car H1
-			    ("renesas,rcar-sata" is deprecated)
 			  - "renesas,sata-r8a7790-es1" for R-Car H2 ES1
 			  - "renesas,sata-r8a7790" for R-Car H2 other than ES1
 			  - "renesas,sata-r8a7791" for R-Car M2-W
 			  - "renesas,sata-r8a7793" for R-Car M2-N
+			  - "renesas,rcar-gen2-sata" for a generic R-Car Gen2 compatible device
+			  - "renesas,rcar-sata" is deprecated
+
+			  When compatible with the generic version nodes
+			  must list the SoC-specific version corresponding
+			  to the platform first followed by the generic
+			  version.
+
 - reg			: address and length of the SATA registers;
 - interrupts		: must consist of one interrupt specifier.
 - clocks		: must contain a reference to the functional clock.
@@ -15,7 +22,7 @@ Required properties:
 Example:
 
 sata0: sata@ee300000 {
-	compatible = "renesas,sata-r8a7791";
+	compatible = "renesas,sata-r8a7791", "renesas,rcar-gen2-sata";
 	reg = <0 0xee300000 0 0x2000>;
 	interrupt-parent = <&gic>;
 	interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 4199f7a39be0..a3fee38a3635 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -856,6 +856,10 @@ static struct of_device_id sata_rcar_match[] = {
 		.compatible = "renesas,sata-r8a7793",
 		.data = (void *)RCAR_GEN2_SATA
 	},
+	{
+		.compatible = "renesas,rcar-gen2-sata",
+		.data = (void *)RCAR_GEN2_SATA
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sata_rcar_match);
-- 
2.17.1


--9shfhMawlbnJZNa2KJPm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5759): https://lists.cip-project.org/g/cip-dev/message=
/5759
Mute This Topic: https://lists.cip-project.org/mt/78070983/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9shfhMawlbnJZNa2KJPm--
