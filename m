Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D704E98E1D
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 10:28:04 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32635.1771842482931291190
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Feb 2026 02:28:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 2hg4hzBdRYGRyScUd6ezDA==
X-CSE-MsgGUID: CHXGyN2YS1yQKoH8UJ1R3g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Feb 2026 19:28:02 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.12])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2DB6F401A62A;
	Mon, 23 Feb 2026 19:28:00 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 1/4] dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2N SoC
Date: Mon, 23 Feb 2026 10:27:54 +0000
Message-ID: <20260223102758.119908-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223102758.119908-1-ovidiu.panait.rb@renesas.com>
References: <20260223102758.119908-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Feb 2026 10:28:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21913

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a92b9efaf2cff15a28723f592ee21df0561e58c3 upstream.

Add a compatible string for the Renesas RZ/V2N SoC variants that include a
Mali-G31 GPU. These variants share the same restrictions on interrupts,
clocks, and power domains as the RZ/G2L SoC, so extend the existing schema
validation accordingly.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250502162540.165962-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 3090e2ab6bd1..3bb9cac178fe 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -25,6 +25,7 @@ properties:
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
               - renesas,r9a09g047-mali
+              - renesas,r9a09g056-mali
               - renesas,r9a09g057-mali
               - rockchip,px30-mali
               - rockchip,rk3568-mali
@@ -144,6 +145,7 @@ allOf:
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
               - renesas,r9a09g047-mali
+              - renesas,r9a09g056-mali
               - renesas,r9a09g057-mali
     then:
       properties:
-- 
2.34.1


