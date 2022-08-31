Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D96ECAAD4
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:37:57 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1132.1661963868517984676
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:37:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="133250198"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2022 01:37:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 58801402172B;
	Thu,  1 Sep 2022 01:37:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/10] dt-bindings: arm: renesas: Document Renesas
 RZ/G2UL SMARC EVK
Date: Wed, 31 Aug 2022 17:37:27 +0100
Message-Id: <20220831163735.2112470-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831163735.2112470-1-biju.das.jz@bp.renesas.com>
References: <20220831163735.2112470-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:37:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9351

commit 05d39fc06cee5b11b195d0d5fec55d01da2781cb upstream.

Document the Renesas SMARC EVK board which is based on the Renesas
RZ/G2UL Type-1 (R9A07G043U11) SoC.  The SMARC EVK consists of an
RZ/G2UL Type-1 SoM module and a SMARC carrier board.  The SoM module
sits on top of the carrier board.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220402073234.24625-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 00260c208bb6..75e00f50ee5e 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -301,6 +301,8 @@ properties:
 
       - description: RZ/G2UL (R9A07G043)
         items:
+          - enum:
+              - renesas,smarc-evk # SMARC EVK
           - enum:
               - renesas,r9a07g043u11 # RZ/G2UL Type-1
               - renesas,r9a07g043u12 # RZ/G2UL Type-2
-- 
2.25.1


