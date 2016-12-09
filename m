From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:36:53 +0000
Subject: [cip-dev] [PATCH 4.4-cip 16/23] UBSAN: fix typo in format string
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243813.1860.172.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>

commit 901d805c33fc4c029fc6b2d94ee5fb7d30278045 upstream.

handle_object_size_mismatch() used %pk to format a kernel pointer with
pr_err().  This seemed to be a misspelling for %pK, but using this to
format a kernel pointer does not make much sence here.

Therefore use %p instead, like in handle_missaligned_access().

Link: http://lkml.kernel.org/r/20160730083010.11569-1-nicolas.iooss_linux at m4x.org
Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 lib/ubsan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 8799ae5e2e42..fb0409df1bcf 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -308,7 +308,7 @@ static void handle_object_size_mismatch(struct type_mismatch_data *data,
 		return;
 
 	ubsan_prologue(&data->location, &flags);
-	pr_err("%s address %pk with insufficient space\n",
+	pr_err("%s address %p with insufficient space\n",
 		type_check_kinds[data->type_check_kind],
 		(void *) ptr);
 	pr_err("for an object of type %s\n", data->type->type_name);
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
