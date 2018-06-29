From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 29 Jun 2018 14:59:00 +0100
Subject: [cip-dev] [PATCH  1/3] dt-bindings: timer: renesas,
	cmt: Document r8a774[35] CMT support
In-Reply-To: <1530280742-6540-1-git-send-email-biju.das@bp.renesas.com>
References: <1530280742-6540-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1530280742-6540-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Document SoC specific compatible strings for r8a7743 and r8a7745.
No driver change is needed as the fallback strings will activate
the right code.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 24d79d738b6fed977f44cae2ca277a49a7aa5f70)
( Backported dt-bindings)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index 1a05c1b..ed3dbf6 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -44,6 +44,10 @@ Required Properties:
 
     - "renesas,cmt-48-r8a73a4" for the r8a73a4 48-bit CMT
 		(CMT[01])
+    - "renesas,cmt-48-r8a7743" for the r8a7743 48-bit CMT
+		(CMT[01])
+    - "renesas,cmt-48-r8a7745" for the r8a7745 48-bit CMT
+		(CMT[01])
     - "renesas,cmt-48-r8a7790" for the r8a7790 48-bit CMT
 		(CMT[01])
     - "renesas,cmt-48-r8a7791" for the r8a7791 48-bit CMT
-- 
2.7.4
