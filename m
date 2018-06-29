From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:39:14 +0100
Subject: [cip-dev] [PATCH 73/86] of: add vendor prefix for Silicon Storage
	Technology Inc.
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-74-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add Silicon Storage Technology Inc. to the list of devicetree
vendor prefixes.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Rob Herring <robh@kernel.org>
(cherry picked from commit 0bf4b3fadb5663959605d584410412dce53406cc)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0e72c2c..12e4560 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -219,6 +219,7 @@ solomon        Solomon Systech Limited
 sony	Sony Corporation
 spansion	Spansion Inc.
 sprd	Spreadtrum Communications Inc.
+sst	Silicon Storage Technology, Inc.
 st	STMicroelectronics
 ste	ST-Ericsson
 stericsson	ST-Ericsson
-- 
2.7.4
