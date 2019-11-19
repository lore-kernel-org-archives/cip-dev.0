From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:38 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 13/17] dt-bindings: timer: renesas,
	cmt: Document r8a7744 CMT
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-14-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 7c4189c75b0b40bfe559b185e30847398e9ac206 upstream.

Document SoC specific compatible strings for r8a7744. No driver change
is needed as the fallback strings will activate the right code.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
[biju: backported to 4.4 kernel]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index ed3dbf6..1821efd 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -46,6 +46,8 @@ Required Properties:
 		(CMT[01])
     - "renesas,cmt-48-r8a7743" for the r8a7743 48-bit CMT
 		(CMT[01])
+    - "renesas,cmt-48-r8a7744" for the r8a7744 48-bit CMT
+		(CMT[01])
     - "renesas,cmt-48-r8a7745" for the r8a7745 48-bit CMT
 		(CMT[01])
     - "renesas,cmt-48-r8a7790" for the r8a7790 48-bit CMT
-- 
2.7.4
