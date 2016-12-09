From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:33:58 +0000
Subject: [cip-dev] [PATCH 4.4-cip 02/23] ubsan: cosmetic fix to Kconfig text
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243638.1860.158.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yang Shi <yang.shi@linaro.org>

commit 7707535ab95e2231b6d7f2bfb4f27558e83c4dc2 upstream.

When enabling UBSAN_SANITIZE_ALL, the kernel image size gets increased
significantly (~3x).  So, it sounds better to have some note in Kconfig.

And, fixed a typo.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 lib/Kconfig.ubsan | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 49518fb48cab..e07c1ba9ba13 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -18,6 +18,8 @@ config UBSAN_SANITIZE_ALL
 	  This option activates instrumentation for the entire kernel.
 	  If you don't enable this option, you have to explicitly specify
 	  UBSAN_SANITIZE := y for the files/directories you want to check for UB.
+	  Enabling this option will get kernel image size increased
+	  significantly.
 
 config UBSAN_ALIGNMENT
 	bool "Enable checking of pointers alignment"
@@ -25,5 +27,5 @@ config UBSAN_ALIGNMENT
 	default y if !HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
 	  This option enables detection of unaligned memory accesses.
-	  Enabling this option on architectures that support unalligned
+	  Enabling this option on architectures that support unaligned
 	  accesses may produce a lot of false positives.
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
