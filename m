Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85E7D3B7E5
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:42:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40132.1766997764468157589
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:42:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: cW5aWI1LTumfYiJ5Sy7Xpw==
X-CSE-MsgGUID: QidUbku7SnKMA8d5ho+ZbQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2025 17:42:43 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AA8974005E3A;
	Mon, 29 Dec 2025 17:42:42 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12-y.cip 2/5] dt-bindings: net: renesas-gbeth: Add support for RZ/V2N (R9A09G056) SoC
Date: Mon, 29 Dec 2025 08:42:34 +0000
Message-ID: <20251229084237.3634-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229084237.3634-1-ovidiu.panait.rb@renesas.com>
References: <20251229084237.3634-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:42:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21244

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 6b466efc6365e904b4b7eb65218a5b2969f978e2 upstream.

Document support for the GBETH IP found on the Renesas RZ/V2N (R9A09G056)
SoC. The GBETH controller on the RZ/V2N SoC is functionally identical to
the one found on the RZ/V2H(P) (R9A09G057) SoC, so `renesas,rzv2h-gbeth`
will be used as a fallback compatible.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250507173551.100280-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
index ee8fbb6c7994..23e39bcea96b 100644
--- a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
@@ -15,6 +15,7 @@ select:
       contains:
         enum:
           - renesas,r9a09g047-gbeth
+          - renesas,r9a09g056-gbeth
           - renesas,r9a09g057-gbeth
           - renesas,rzv2h-gbeth
   required:
@@ -25,6 +26,7 @@ properties:
     items:
       - enum:
           - renesas,r9a09g047-gbeth # RZ/G3E
+          - renesas,r9a09g056-gbeth # RZ/V2N
           - renesas,r9a09g057-gbeth # RZ/V2H(P)
       - const: renesas,rzv2h-gbeth
       - const: snps,dwmac-5.20
-- 
2.51.0


