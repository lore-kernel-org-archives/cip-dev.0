From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:22:08 +0100
Subject: [cip-dev] [PATCH 4.19.y 14/29] media: dt-bindings: rcar-vin: Add
	R8A774C0 support
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-15-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 73960b787c615b41333600e1291f6a47ff7db21c upstream.

Add the compatible string for RZ/G2E (a.k.a. R8A774C0) to the list
of SoCs supported by rcar-vin driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 2f42005..2dc9e32 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -7,11 +7,12 @@ family of devices.
 Each VIN instance has a single parallel input that supports RGB and YUV video,
 with both external synchronization and BT.656 synchronization for the latter.
 Depending on the instance the VIN input is connected to external SoC pins, or
-on Gen3 platforms to a CSI-2 receiver.
+on Gen3 and RZ/G2 platforms to a CSI-2 receiver.
 
  - compatible: Must be one or more of the following
    - "renesas,vin-r8a7743" for the R8A7743 device
    - "renesas,vin-r8a7745" for the R8A7745 device
+   - "renesas,vin-r8a774c0" for the R8A774C0 device
    - "renesas,vin-r8a7778" for the R8A7778 device
    - "renesas,vin-r8a7779" for the R8A7779 device
    - "renesas,vin-r8a7790" for the R8A7790 device
@@ -58,10 +59,10 @@ The per-board settings Gen2 platforms:
     - data-enable-active: polarity of CLKENB signal, see [1] for
       description. Default is active high.
 
-The per-board settings Gen3 platforms:
+The per-board settings Gen3 and RZ/G2 platforms:
 
-Gen3 platforms can support both a single connected parallel input source
-from external SoC pins (port at 0) and/or multiple parallel input sources
+Gen3 and RZ/G2 platforms can support both a single connected parallel input
+source from external SoC pins (port at 0) and/or multiple parallel input sources
 from local SoC CSI-2 receivers (port at 1) depending on SoC.
 
 - renesas,id - ID number of the VIN, VINx in the documentation.
-- 
2.7.4
