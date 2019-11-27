From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 13:46:53 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 15/22] dt-bindings: mmc: renesas_sdhi:
	add R-Car Gen[123] fallback compatibility strings
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574862420-42606-16-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 54839d012d5f98cde2fa102fdcd22e1da661d138 upstream.

Add fallback compatibility strings for R-Car Gen 1, 2 and 3.

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, f.e. Gen 1 and 2. But beyond that its not clear what the relationship
between IP blocks might be. For example, I believe that r8a7790 is older
than r8a7791 but that doesn't imply that the latter is a descendant of the
former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme is being adopted for
drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 1d23a43..25f06e6 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -24,6 +24,13 @@ Required properties:
 		"renesas,sdhi-r8a7792" - SDHI IP on R8A7792 SoC
 		"renesas,sdhi-r8a7793" - SDHI IP on R8A7793 SoC
 		"renesas,sdhi-r8a7794" - SDHI IP on R8A7794 SoC
+		"renesas,rcar-gen1-sdhi" - a generic R-Car Gen1 SDHI controller
+		"renesas,rcar-gen2-sdhi" - a generic R-Car Gen2 or RZ/G1
+					   SDHI controller
+
+		When compatible with the generic version, nodes must list
+		the SoC-specific version corresponding to the platform
+		first followed by the generic version.
 
 Optional properties:
 - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
-- 
2.7.4
