Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB73CCFA09
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18623.1762169774650115223
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:36:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: NnyxhrypQ1W9Eht5VkPF5A==
X-CSE-MsgGUID: 1twwU6u0SB2/Lqzr4gGmYQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Nov 2025 20:36:36 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3276C4009A16;
	Mon,  3 Nov 2025 20:36:34 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.1.y-cip 15/25] dt-bindings: net: renesas-gbeth: Add support for RZ/G3E (R9A09G047) SoC
Date: Mon,  3 Nov 2025 12:35:48 +0100
Message-ID: <20251103113608.36240-16-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:36:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20307

[ Upstream commit 31b928210df1097eaa5e8cb51e2ff79989ebe57e ]

Document support for the GBETH IP found on the Renesas RZ/G3E (R9A09G047) SoC.
The GBETH block on RZ/G3E is equivalent in functionality to the GBETH found on
RZ/V2H(P) (R9A09G057).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20250611061204.15393-1-john.madieu.xa@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../devicetree/bindings/net/renesas,r9a09g057-gbeth.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,r9a09g057-gbeth.yaml b/Documentation/devicetree/bindings/net/renesas,r9a09g057-gbeth.yaml
index 02a6793c26f5..91f637b048ab 100644
--- a/Documentation/devicetree/bindings/net/renesas,r9a09g057-gbeth.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,r9a09g057-gbeth.yaml
@@ -14,6 +14,7 @@ select:
     compatible:
       contains:
         enum:
+          - renesas,r9a09g047-gbeth
           - renesas,r9a09g057-gbeth
           - renesas,rzv2h-gbeth
   required:
@@ -23,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a09g047-gbeth # RZ/G3E
           - renesas,r9a09g057-gbeth # RZ/V2H(P)
       - const: renesas,rzv2h-gbeth
       - const: snps,dwmac-5.20
-- 
2.25.1


