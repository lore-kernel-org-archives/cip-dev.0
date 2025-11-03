Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C696CCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18623.1762169774650115223
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:36:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: vMwl5jEdRqG6+wzoOuZE5Q==
X-CSE-MsgGUID: fJ4h1jHkSSidp3hA+OSQXQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Nov 2025 20:36:38 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E1D5D4009A16;
	Mon,  3 Nov 2025 20:36:36 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.1.y-cip 16/25] dt-bindings: net: Rename renesas,r9a09g057-gbeth.yaml
Date: Mon,  3 Nov 2025 12:35:49 +0100
Message-ID: <20251103113608.36240-17-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:36:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20308

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit d53320aeef18ece4999c0cf07cb802d1dd990885 ]

The DT bindings file "renesas,r9a09g057-gbeth.yaml" applies to a whole
family of SoCs, and uses "renesas,rzv2h-gbeth" as a fallback compatible
value.  Hence rename it to the more generic "renesas,rzv2h-gbeth.yaml".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/721f6e0e09777e0842ecaca4578bc50c953d2428.1750838954.git.geert+renesas@glider.be
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../{renesas,r9a09g057-gbeth.yaml => renesas,rzv2h-gbeth.yaml}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/net/{renesas,r9a09g057-gbeth.yaml => renesas,rzv2h-gbeth.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/net/renesas,r9a09g057-gbeth.yaml b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/net/renesas,r9a09g057-gbeth.yaml
rename to Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
index 91f637b048ab..ee8fbb6c7994 100644
--- a/Documentation/devicetree/bindings/net/renesas,r9a09g057-gbeth.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/net/renesas,r9a09g057-gbeth.yaml#
+$id: http://devicetree.org/schemas/net/renesas,rzv2h-gbeth.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: GBETH glue layer for Renesas RZ/V2H(P) (and similar SoCs)
-- 
2.25.1


