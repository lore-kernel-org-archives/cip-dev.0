From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:01 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 02/32] media: dt-bindings: media:
	renesas-fcp: Add RZ/G2 support
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b8eb83457e79fc745abea3abcd6c95b1428a05ee upstream.

Document RZ/G2 support.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/bindings/media/renesas,fcp.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,fcp.txt b/Documentation/devicetree/bindings/media/renesas,fcp.txt
index 3ec9180..79c3739 100644
--- a/Documentation/devicetree/bindings/media/renesas,fcp.txt
+++ b/Documentation/devicetree/bindings/media/renesas,fcp.txt
@@ -2,8 +2,9 @@ Renesas R-Car Frame Compression Processor (FCP)
 -----------------------------------------------
 
 The FCP is a companion module of video processing modules in the Renesas R-Car
-Gen3 SoCs. It provides data compression and decompression, data caching, and
-conversion of AXI transactions in order to reduce the memory bandwidth.
+Gen3 and RZ/G2 SoCs. It provides data compression and decompression, data
+caching, and conversion of AXI transactions in order to reduce the memory
+bandwidth.
 
 There are three types of FCP: FCP for Codec (FCPC), FCP for VSP (FCPV) and FCP
 for FDP (FCPF). Their configuration and behaviour depend on the module they
-- 
2.7.4
