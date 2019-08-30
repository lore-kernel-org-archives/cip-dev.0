From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 30 Aug 2019 08:31:55 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 2/5] dt-bindings: Add vendor prefix for
	HopeRun
In-Reply-To: <1567150318-36833-1-git-send-email-biju.das@bp.renesas.com>
References: <1567150318-36833-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567150318-36833-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 9d79b2f1aed4909988ecd8b370c7919856639699 upstream.

Add "Jiangsu HopeRun Software Co., Ltd." to the list of devicetree
vendor prefixes as "hoperun".

Website: http://www.hoperun.com/en

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[ Backported to 4.19 ]
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b77f359..4ec999c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -162,6 +162,7 @@ hit	Hitachi Ltd.
 hitex	Hitex Development Tools
 holt	Holt Integrated Circuits, Inc.
 honeywell	Honeywell
+hoperun	Jiangsu HopeRun Software Co., Ltd.
 hp	Hewlett Packard
 holtek	Holtek Semiconductor, Inc.
 hwacom	HwaCom Systems Inc.
-- 
2.7.4
