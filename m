From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 20 Nov 2019 16:47:18 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 4/6] dt-bindings: timer: renesas,
	cmt: Document r8a77470 CMT support
In-Reply-To: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
References: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574268440-33507-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 2bbaf54216448486def1153486778a975a73041d upstream.

Document SoC specific compatible strings for r8a77470. No driver change
is needed as the fallback strings will activate the right code.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[biju: backported to 4.4-cip kernel]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index ed3dbf6..f070152 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -48,6 +48,8 @@ Required Properties:
 		(CMT[01])
     - "renesas,cmt-48-r8a7745" for the r8a7745 48-bit CMT
 		(CMT[01])
+    - "renesas,cmt-48-r8a77470" for the r8a77470 48-bit CMT
+		(CMT[01])
     - "renesas,cmt-48-r8a7790" for the r8a7790 48-bit CMT
 		(CMT[01])
     - "renesas,cmt-48-r8a7791" for the r8a7791 48-bit CMT
-- 
2.7.4
