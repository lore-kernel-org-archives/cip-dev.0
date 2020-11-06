Return-Path: <SRS0=Y+aq=EM=lists.cip-project.org=bounce+64572+5756+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBE6C2D0A3
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:51:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1682087E
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IGnwF5+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1682087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5756+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hNTqYY4521723xqPRdcPdVY4; Fri, 06 Nov 2020 01:51:56 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.9517.1604656315663802830
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2020 01:51:55 -0800
X-IronPort-AV: E=Sophos;i="5.77,456,1596466800"; 
   d="scan'208";a="61866313"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2020 18:51:54 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E97084266628;
	Fri,  6 Nov 2020 18:51:53 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 1/8] dt-bindings: PCI: pci-rcar-gen2: Add device tree support for r8a7742
Date: Fri,  6 Nov 2020 09:51:44 +0000
Message-Id: <20201106095151.25880-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0ltAfYYzf0z2goMteNkRvhLnx4520388AA=
Content-Type: multipart/mixed; boundary="niv9sCz0VA51t3BtQnYg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604656316;
 bh=qDj7JGSQyXoogxoWePQMBZgrmYcMfQkTVUHPfQoiG+E=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IGnwF5+QUJcleWHG/tmYtFAGIrn0QcN6q2WLWZfpbvYl8hyLKRbU+NFtMYaC9qqczgu
 HwPblijb7IUMkDrmlEbc0Nx+Ylfld2TknFIL1YCoUBfUDJz/XXsqhYbb9/36x9MSV5oo8
 YjShnF+fKP4XNpjV8PVLXvtMRNVtho5rXvQ=

--niv9sCz0VA51t3BtQnYg

commit c6233c504974f131445a21891de725d1ac4d116c upstream.

Add internal PCI bridge support for r8a7742 SoC. The Renesas RZ/G1H
(R8A7742) internal PCI bridge is identical to the R-Car Gen2 family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index 8ea3ec0c535a..7857d87646cf 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -6,7 +6,8 @@ AHB. There is one bridge instance per USB port connected to the internal
 OHCI and EHCI controllers.
 
 Required properties:
-- compatible: "renesas,pci-r8a7743" for the R8A7743 SoC;
+- compatible: "renesas,pci-r8a7742" for the R8A7742 SoC;
+	      "renesas,pci-r8a7743" for the R8A7743 SoC;
 	      "renesas,pci-r8a7744" for the R8A7744 SoC;
 	      "renesas,pci-r8a7745" for the R8A7745 SoC;
 	      "renesas,pci-r8a7790" for the R8A7790 SoC;
-- 
2.17.1


--niv9sCz0VA51t3BtQnYg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5756): https://lists.cip-project.org/g/cip-dev/message=
/5756
Mute This Topic: https://lists.cip-project.org/mt/78070980/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--niv9sCz0VA51t3BtQnYg--
