Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC522D15D94
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:38:17 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18215.1764776292894303297
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 07:38:13 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: k/91SM49THGms9S3BAFJGA==
X-CSE-MsgGUID: w86VKXC/TyKeRXftTYT/QA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Dec 2025 00:38:12 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DB1A1401008C;
	Thu,  4 Dec 2025 00:38:10 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 07/12] dt-bindings: mmc: renesas,sdhi: Document RZ/V2N support
Date: Wed,  3 Dec 2025 15:37:52 +0000
Message-ID: <20251203153757.32977-8-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 15:38:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20820

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8e127dbbf6c363e6b4bb486d631d936fd6d1646d upstream.

Add SDHI bindings for the Renesas RZ/V2N (a.k.a R9A09G056) SoC. Use
`renesas,sdhi-r9a09g057` as a fallback since the SD/MMC block on
RZ/V2N is identical to the one on RZ/V2H(P), allowing reuse of the
existing driver without modifications.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250326143945.82142-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index d7473e99fbd2..a2153ef41b6d 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -67,7 +67,9 @@ properties:
               - renesas,sdhi-r9a09g011 # RZ/V2M
           - const: renesas,rzg2l-sdhi
       - items:
-          - const: renesas,sdhi-r9a09g047 # RZ/G3E
+          - enum:
+              - renesas,sdhi-r9a09g047 # RZ/G3E
+              - renesas,sdhi-r9a09g056 # RZ/V2N
           - const: renesas,sdhi-r9a09g057 # RZ/V2H(P)
 
   reg:
-- 
2.51.0


