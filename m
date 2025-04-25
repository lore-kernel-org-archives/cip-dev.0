Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C574C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:15:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5127.1745583315086150994
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 05:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 5JFbnYbrQTaYf2Z5GkFcQQ==
X-CSE-MsgGUID: 8+K4KrZgRdCRWWhruYaZLw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Apr 2025 21:15:14 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E53A842D7EC8;
	Fri, 25 Apr 2025 21:15:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 12/21] dt-bindings: mmc: renesas,sdhi: Group single const value items into an enum list
Date: Fri, 25 Apr 2025 13:14:36 +0100
Message-ID: <20250425121445.62818-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 12:15:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18634

commit 493d2b2969d477802310e8e215cf1924f95a7284 upstream.

Group single const value items into an enum list.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20240430145937.133643-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index d71cc993d5f04..26441c4265fae 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -12,16 +12,13 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - items:
-          - const: renesas,sdhi-sh73a0  # R-Mobile APE6
-      - items:
-          - const: renesas,sdhi-r7s72100 # RZ/A1H
-      - items:
-          - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
-      - items:
-          - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
-      - items:
-          - const: renesas,sdhi-r8a7740 # R-Mobile A1
+      - enum:
+          - renesas,sdhi-mmc-r8a77470 # RZ/G1C
+          - renesas,sdhi-r7s72100 # RZ/A1H
+          - renesas,sdhi-r7s9210 # SH-Mobile AG5
+          - renesas,sdhi-r8a73a4 # R-Mobile APE6
+          - renesas,sdhi-r8a7740 # R-Mobile A1
+          - renesas,sdhi-sh73a0  # R-Mobile APE6
       - items:
           - enum:
               - renesas,sdhi-r8a7778 # R-Car M1
@@ -40,8 +37,6 @@ properties:
               - renesas,sdhi-r8a7793  # R-Car M2-N
               - renesas,sdhi-r8a7794  # R-Car E2
           - const: renesas,rcar-gen2-sdhi # R-Car Gen2 and RZ/G1
-      - items:
-          - const: renesas,sdhi-mmc-r8a77470 # RZ/G1C (SDHI/MMC IP)
       - items:
           - enum:
               - renesas,sdhi-r8a774a1  # RZ/G2M
-- 
2.43.0


