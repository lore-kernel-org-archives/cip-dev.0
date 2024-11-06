Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D0D59F4D
	for <webhook@archiver.kernel.org>; Wed,  6 Nov 2024 16:03:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.49213.1730909006885987649
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Nov 2024 08:03:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,263,1725289200"; 
   d="scan'208";a="224054134"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Nov 2024 01:03:26 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.72])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6E52B401404E;
	Thu,  7 Nov 2024 01:03:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/5] media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G2UL CSI-2 block
Date: Wed,  6 Nov 2024 16:03:04 +0000
Message-ID: <20241106160307.10263-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106160307.10263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241106160307.10263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Nov 2024 16:03:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17187

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 77b023ba4f45ce2bf26edb095b4a81829c9e621b upstream.

Document the CSI-2 block which is part of CRU found in Renesas RZ/G2UL
SoC.

The CSI-2 block on the RZ/G2UL SoC is identical to one found on the
RZ/G2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240605154115.263447-2-biju.das.jz@bp.renesas.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
index 67eea2ac1d226..7faa12fecd5bb 100644
--- a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043-csi2       # RZ/G2UL
           - renesas,r9a07g044-csi2       # RZ/G2{L,LC}
           - renesas,r9a07g054-csi2       # RZ/V2L
       - const: renesas,rzg2l-csi2
-- 
2.43.0


