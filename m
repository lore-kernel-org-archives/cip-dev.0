From: chris.paterson2@renesas.com (Chris Paterson)
Date: Thu, 20 Jul 2017 09:48:53 +0100
Subject: [cip-dev] [PATCH 1/3] of: Add vendor prefix for iWave Systems
	Technologies Pvt. Ltd
In-Reply-To: <1500540535-18905-1-git-send-email-chris.paterson2@renesas.com>
References: <1500540535-18905-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1500540535-18905-2-git-send-email-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

This patch adds vendor prefix for iWave Systems Technologies Pvt. Ltd.
Website: http://www.iwavesystems.com/

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
(cherry picked from commit 9b6782e7f0efc2bf483e000b95fc7c06322a0703)
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Conflicts:
	Documentation/devicetree/bindings/vendor-prefixes.txt

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d4..6264752 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -119,6 +119,7 @@ intercontrol	Inter Control Group
 invensense	InvenSense Inc.
 isee	ISEE 2007 S.L.
 isil	Intersil
+iwave  iWave Systems Technologies Pvt. Ltd.
 jedec	JEDEC Solid State Technology Association
 karo	Ka-Ro electronics GmbH
 keymile	Keymile GmbH
-- 
1.9.1
