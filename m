Return-Path: <SRS0=1eha=EP=lists.cip-project.org=bounce+64572+5779+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774F1C4741F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C3B206C0
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 15:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Iyk1G0BY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C3B206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5779+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pwPVYY4521723xryxTeVjFVU; Mon, 09 Nov 2020 07:50:27 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.13504.1604937015956466828
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 07:50:27 -0800
X-IronPort-AV: E=Sophos;i="5.77,463,1596466800"; 
   d="scan'208";a="62129284"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Nov 2020 00:50:26 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C4E1440065C9;
	Tue, 10 Nov 2020 00:50:25 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 10/14] dt-bindings: can: rcar_can: Add r8a7742 support
Date: Mon,  9 Nov 2020 15:50:07 +0000
Message-Id: <20201109155011.10291-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aMZir6dr4pLBu6FavgnwIxfgx4520388AA=
Content-Type: multipart/mixed; boundary="qIDG4K9VJyxPpr09ra8h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604937027;
 bh=gDpcGJw/Kx+hlb7KGJ1h3yYt234VC/he+ixOZQR6MXQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Iyk1G0BYg6irirFujay3OHVVEAxj6q+7SKdp9WDv0wxQqk2n9/UuQ/Sdz6wdqVs5OM4
 h0XpKu6sTwUSI8aBS7ucPxrPNYlMTw06khlTeZiUxslarNxL1t+nF6rcwI5slC9GApPwL
 wvB8AOwV6x/w7HdMng4DKpsWmpclStlHfi4=

--qIDG4K9VJyxPpr09ra8h

commit df73446a2882a4336cad473d8eb9d895e49f092b upstream.

Document RZ/G1H (r8a7742) SoC specific bindings. The R8A7742 CAN module
is identical to R-Car Gen2 family.

No driver change is needed due to the fallback compatible value
"renesas,rcar-gen2-can".

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200816190732.6905-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/can/rcar_can.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index fbad4d514a41..1a179e578541 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -2,7 +2,8 @@ Renesas R-Car CAN controller Device Tree Bindings
 -------------------------------------------------
 
 Required properties:
-- compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
+- compatible: "renesas,can-r8a7742" if CAN controller is a part of R8A7742 SoC.
+	      "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
 	      "renesas,can-r8a7744" if CAN controller is a part of R8A7744 SoC.
 	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
 	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
-- 
2.17.1


--qIDG4K9VJyxPpr09ra8h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5779): https://lists.cip-project.org/g/cip-dev/message=
/5779
Mute This Topic: https://lists.cip-project.org/mt/78138437/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qIDG4K9VJyxPpr09ra8h--
