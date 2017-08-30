From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:13:49 +0200
Subject: [cip-dev] [PATCH 07/14] efi/capsule: Fix return code on failing
	kmap/vmap
In-Reply-To: <cover.1504120436.git.jan.kiszka@siemens.com>
References: <cover.1504120436.git.jan.kiszka@siemens.com>
Message-ID: <d3f806f040566cc76aa6220a009214c3bcf65636.1504120436.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit fb153dc53f0eb8e8ad6a69f773e44c2d12daa5d0 upstream.

If kmap or vmap fail, it means we ran out of memory. There are no
user-provided addressed involved that would justify EFAULT.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi at vger.kernel.org
Link: http://lkml.kernel.org/r/20170602135207.21708-3-ard.biesheuvel at linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/capsule-loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 9ae6c116c474..91e91f7a8807 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -113,7 +113,7 @@ static ssize_t efi_capsule_submit_update(struct capsule_info *cap_info)
 			VM_MAP, PAGE_KERNEL);
 	if (!cap_hdr_temp) {
 		pr_debug("%s: vmap() failed\n", __func__);
-		return -EFAULT;
+		return -ENOMEM;
 	}
 
 	ret = efi_capsule_update(cap_hdr_temp, cap_info->pages);
@@ -185,7 +185,7 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 	kbuff = kmap(page);
 	if (!kbuff) {
 		pr_debug("%s: kmap() failed\n", __func__);
-		ret = -EFAULT;
+		ret = -ENOMEM;
 		goto failed;
 	}
 	kbuff += PAGE_SIZE - cap_info->page_bytes_remain;
-- 
2.12.3
