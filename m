From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:35:09 +0000
Subject: [cip-dev] [PATCH 4.4-cip 07/23] ubsan: fix tree-wide
 -Wmaybe-uninitialized false positives
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243709.1860.163.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

commit dde5cf39d4d2cce71f2997c37210dd624d0e4bf6 upstream.

-fsanitize=* options makes GCC less smart than usual and increase number
of 'maybe-uninitialized' false-positives. So this patch does two things:

 * Add -Wno-maybe-uninitialized to CFLAGS_UBSAN which will disable all
   such warnings for instrumented files.

 * Remove CONFIG_UBSAN_SANITIZE_ALL from all[yes|mod]config builds. So
   the all[yes|mod]config build goes without -fsanitize=* and still with
   -Wmaybe-uninitialized.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 lib/Kconfig.ubsan      | 5 +++++
 scripts/Makefile.ubsan | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index e07c1ba9ba13..39494af9a84a 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -13,6 +13,11 @@ config UBSAN_SANITIZE_ALL
 	bool "Enable instrumentation for the entire kernel"
 	depends on UBSAN
 	depends on ARCH_HAS_UBSAN_SANITIZE_ALL
+
+	# We build with -Wno-maybe-uninitilzed, but we still want to
+	# use -Wmaybe-uninitilized in allmodconfig builds.
+	# So dependsy bellow used to disable this option in allmodconfig
+	depends on !COMPILE_TEST
 	default y
 	help
 	  This option activates instrumentation for the entire kernel.
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 8ab68679cfb5..77ce538268b5 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -14,4 +14,8 @@ ifdef CONFIG_UBSAN
 ifdef CONFIG_UBSAN_ALIGNMENT
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=alignment)
 endif
+
+      # -fsanitize=* options makes GCC less smart than usual and
+      # increase number of 'maybe-uninitialized false-positives
+      CFLAGS_UBSAN += $(call cc-option, -Wno-maybe-uninitialized)
 endif
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
