From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:21:54 +0100
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 27/41] pinctrl: sh-pfc: Add missing
	#include <linux/errno.h>
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566991328-25476-28-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 2f9f5094f8b7a1da8852c4a50b205232e62d72dc upstream.

Source files using -Exxx error codes should include <linux/errno.h>.
On ARM, this header file is included indirectly; on SuperH, it is not,
leading to "error: ?EINVAL? undeclared" failures when enabling
compile-testing later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c    | 1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c     | 1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c     | 1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c     | 1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 1 +
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    | 1 +
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    | 1 +
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    | 1 +
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    | 1 +
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
index cb4c907..f548ccf 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77470.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
 
+#include <linux/errno.h>
 #include <linux/kernel.h>
 
 #include "sh_pfc.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index d2fd6e87..7b4c11b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -21,6 +21,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 332cb96..c4ffb40 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -9,6 +9,7 @@
  * as published by the Free Software Foundation.
  */
 
+#include <linux/errno.h>
 #include <linux/kernel.h>
 
 #include "sh_pfc.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 7b8dfee..985d5ae 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -10,6 +10,7 @@
  * as published by the Free Software Foundation.
  */
 
+#include <linux/errno.h>
 #include <linux/kernel.h>
 
 #include "core.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index c75d48f..ab5a94e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -8,6 +8,7 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/errno.h>
 #include <linux/kernel.h>
 
 #include "core.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index d27a9c7..b1aa5c1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -8,6 +8,7 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/sys_soc.h>
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
index 7fe0f9f..aedb431 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7796.c
@@ -14,6 +14,7 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/errno.h>
 #include <linux/kernel.h>
 
 #include "core.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 77661cb..3ebfd85 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -12,6 +12,7 @@
  * Copyright (C) 2015  Renesas Electronics Corporation
  */
 
+#include <linux/errno.h>
 #include <linux/kernel.h>
 
 #include "core.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
index ed08cce..5582f41 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77970.c
@@ -15,6 +15,7 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
index 246ab41..04d51b1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77980.c
@@ -12,6 +12,7 @@
  * Copyright (C) 2015 Renesas Electronics Corporation
  */
 
+#include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index 7e7d70f..a3f22ff 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2016-2017 Renesas Electronics Corp.
  */
 
+#include <linux/errno.h>
 #include <linux/kernel.h>
 
 #include "core.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index a4d7f20..b3e65dd 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -14,6 +14,7 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/errno.h>
 #include <linux/kernel.h>
 
 #include "core.h"
-- 
2.7.4
