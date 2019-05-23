From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 23 May 2019 10:48:47 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip] dt-bindings: Add vendor prefix for
	Silicon Linux.
Message-ID: <1558604927-22333-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 295768f6207e412e145487c87993481774c55411 upstream.

Add Silicon Linux to the list of devicetree vendor prefixes.

Website: http://www.si-linux.co.jp

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Andreas F?rber <afaerber@suse.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc51..b77f359 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -338,6 +338,7 @@ sgx	SGX Sensortech
 sharp	Sharp Corporation
 shimafuji	Shimafuji Electric, Inc.
 si-en	Si-En Technology Ltd.
+si-linux	Silicon Linux Corporation
 sifive	SiFive, Inc.
 sigma	Sigma Designs, Inc.
 sii	Seiko Instruments, Inc.
-- 
2.7.4
