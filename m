From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:13:48 +0200
Subject: [cip-dev] [PATCH 06/14] efi/capsule: Allocate whole capsule into
	virtual memory
In-Reply-To: <cover.1504120436.git.jan.kiszka@siemens.com>
References: <cover.1504120436.git.jan.kiszka@siemens.com>
Message-ID: <061853f3503a7b71d174cf585068e7f728137b05.1504120436.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Austin Christ <austinwc@codeaurora.org>

commit 6862e6ad95e984991a6ceec592cf67831658f928 upstream.

According to UEFI 2.6 section 7.5.3, the capsule should be in contiguous
virtual memory and firmware may consume the capsule immediately. To
correctly implement this functionality, the kernel driver needs to vmap
the entire capsule at the time it is made available to firmware.

The virtual allocation of the capsule update has been changed from kmap,
which was only allocating the first page of the update, to vmap, and
allocates the entire data payload.

Signed-off-by: Austin Christ <austinwc@codeaurora.org>
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
Reviewed-by: Lee, Chun-Yi <jlee@suse.com>
Cc: <stable@vger.kernel.org> # v4.7
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kweh Hock Leong <hock.leong.kweh@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi at vger.kernel.org
Link: http://lkml.kernel.org/r/1470912120-22831-3-git-send-email-matt at codeblueprint.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/capsule-loader.c | 8 +++++---
 drivers/firmware/efi/capsule.c        | 6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index c99c24bc79b0..9ae6c116c474 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/efi.h>
+#include <linux/vmalloc.h>
 
 #define NO_FURTHER_WRITE_ACTION -1
 
@@ -108,14 +109,15 @@ static ssize_t efi_capsule_submit_update(struct capsule_info *cap_info)
 	int ret;
 	void *cap_hdr_temp;
 
-	cap_hdr_temp = kmap(cap_info->pages[0]);
+	cap_hdr_temp = vmap(cap_info->pages, cap_info->index,
+			VM_MAP, PAGE_KERNEL);
 	if (!cap_hdr_temp) {
-		pr_debug("%s: kmap() failed\n", __func__);
+		pr_debug("%s: vmap() failed\n", __func__);
 		return -EFAULT;
 	}
 
 	ret = efi_capsule_update(cap_hdr_temp, cap_info->pages);
-	kunmap(cap_info->pages[0]);
+	vunmap(cap_hdr_temp);
 	if (ret) {
 		pr_err("%s: efi_capsule_update() failed\n", __func__);
 		return ret;
diff --git a/drivers/firmware/efi/capsule.c b/drivers/firmware/efi/capsule.c
index 61e51249ef40..1106773468b2 100644
--- a/drivers/firmware/efi/capsule.c
+++ b/drivers/firmware/efi/capsule.c
@@ -194,9 +194,9 @@ efi_capsule_update_locked(efi_capsule_header_t *capsule,
  * map the capsule described by @capsule with its data in @pages and
  * send it to the firmware via the UpdateCapsule() runtime service.
  *
- * @capsule must be a virtual mapping of the first page in @pages
- * (@pages[0]) in the kernel address space. That is, a
- * capsule_header_t that describes the entire contents of the capsule
+ * @capsule must be a virtual mapping of the complete capsule update in the
+ * kernel address space, as the capsule can be consumed immediately.
+ * A capsule_header_t that describes the entire contents of the capsule
  * must be at the start of the first data page.
  *
  * Even though this function will validate that the firmware supports
-- 
2.12.3
