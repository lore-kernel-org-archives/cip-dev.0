From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:13:50 +0200
Subject: [cip-dev] [PATCH 08/14] efi/capsule: Remove pr_debug() on ENOMEM or
	EFAULT
In-Reply-To: <cover.1504120436.git.jan.kiszka@siemens.com>
References: <cover.1504120436.git.jan.kiszka@siemens.com>
Message-ID: <918df7a26ab93ce1ef4faaccd77b73d5bf1da2db.1504120436.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 7367633f0bfd783ae5838141f3af88bba6c45eb9 upstream.

Both cases are not worth a debug log message - the error code is telling
enough.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi at vger.kernel.org
Link: http://lkml.kernel.org/r/20170602135207.21708-4-ard.biesheuvel at linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/capsule-loader.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 91e91f7a8807..7b57dda2417d 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -88,10 +88,8 @@ static ssize_t efi_capsule_setup_info(struct capsule_info *cap_info,
 	temp_page = krealloc(cap_info->pages,
 			     pages_needed * sizeof(void *),
 			     GFP_KERNEL | __GFP_ZERO);
-	if (!temp_page) {
-		pr_debug("%s: krealloc() failed\n", __func__);
+	if (!temp_page)
 		return -ENOMEM;
-	}
 
 	cap_info->pages = temp_page;
 	cap_info->header_obtained = true;
@@ -111,10 +109,8 @@ static ssize_t efi_capsule_submit_update(struct capsule_info *cap_info)
 
 	cap_hdr_temp = vmap(cap_info->pages, cap_info->index,
 			VM_MAP, PAGE_KERNEL);
-	if (!cap_hdr_temp) {
-		pr_debug("%s: vmap() failed\n", __func__);
+	if (!cap_hdr_temp)
 		return -ENOMEM;
-	}
 
 	ret = efi_capsule_update(cap_hdr_temp, cap_info->pages);
 	vunmap(cap_hdr_temp);
@@ -171,7 +167,6 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 	if (!cap_info->page_bytes_remain) {
 		page = alloc_page(GFP_KERNEL);
 		if (!page) {
-			pr_debug("%s: alloc_page() failed\n", __func__);
 			ret = -ENOMEM;
 			goto failed;
 		}
@@ -184,7 +179,6 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 
 	kbuff = kmap(page);
 	if (!kbuff) {
-		pr_debug("%s: kmap() failed\n", __func__);
 		ret = -ENOMEM;
 		goto failed;
 	}
@@ -193,7 +187,6 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 	/* Copy capsule binary data from user space to kernel space buffer */
 	write_byte = min_t(size_t, count, cap_info->page_bytes_remain);
 	if (copy_from_user(kbuff, buff, write_byte)) {
-		pr_debug("%s: copy_from_user() failed\n", __func__);
 		ret = -EFAULT;
 		goto fail_unmap;
 	}
-- 
2.12.3
