From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:13:54 +0200
Subject: [cip-dev] [PATCH 12/14] efi/capsule-loader: Redirect calls to
	efi_capsule_setup_info() via weak alias
In-Reply-To: <cover.1504120436.git.jan.kiszka@siemens.com>
References: <cover.1504120436.git.jan.kiszka@siemens.com>
Message-ID: <643351f334592960d2fa1a2d2eecf9c8df25745f.1504120436.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 3fabd628d5ea24b02ddb1230ffca1df0f779f84e upstream.

To allow platform specific code to hook into the capsule loading
routines, indirect calls to efi_capsule_setup_info() via a weak alias
of __efi_capsule_setup_info(), allowing platforms to redefine the former
but still use the latter.

Tested-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi at vger.kernel.org
Link: http://lkml.kernel.org/r/20170602135207.21708-9-ard.biesheuvel at linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/capsule-loader.c | 56 +++++++++++++++++------------------
 include/linux/efi.h                   | 12 ++++++++
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 5b012a467d7d..f7fdeab0bc37 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -20,16 +20,6 @@
 
 #define NO_FURTHER_WRITE_ACTION -1
 
-struct capsule_info {
-	efi_capsule_header_t	header;
-	int			reset_type;
-	long			index;
-	size_t			count;
-	size_t			total_size;
-	struct page		**pages;
-	size_t			page_bytes_remain;
-};
-
 /**
  * efi_free_all_buff_pages - free all previous allocated buffer pages
  * @cap_info: pointer to current instance of capsule_info structure
@@ -46,28 +36,13 @@ static void efi_free_all_buff_pages(struct capsule_info *cap_info)
 	cap_info->index = NO_FURTHER_WRITE_ACTION;
 }
 
-/**
- * efi_capsule_setup_info - obtain the efi capsule header in the binary and
- *			    setup capsule_info structure
- * @cap_info: pointer to current instance of capsule_info structure
- * @kbuff: a mapped first page buffer pointer
- * @hdr_bytes: the total received number of bytes for efi header
- **/
-static int efi_capsule_setup_info(struct capsule_info *cap_info,
-				  void *kbuff, size_t hdr_bytes)
+int __efi_capsule_setup_info(struct capsule_info *cap_info)
 {
 	size_t pages_needed;
 	int ret;
 	void *temp_page;
 
-	/* Only process data block that is larger than efi header size */
-	if (hdr_bytes < sizeof(efi_capsule_header_t))
-		return 0;
-
-	/* Reset back to the correct offset of header */
-	kbuff -= cap_info->count;
-	memcpy(&cap_info->header, kbuff, sizeof(cap_info->header));
-	pages_needed = ALIGN(cap_info->header.imagesize, PAGE_SIZE) / PAGE_SIZE;
+	pages_needed = ALIGN(cap_info->total_size, PAGE_SIZE) / PAGE_SIZE;
 
 	if (pages_needed == 0) {
 		pr_err("invalid capsule size");
@@ -84,7 +59,6 @@ static int efi_capsule_setup_info(struct capsule_info *cap_info,
 		return ret;
 	}
 
-	cap_info->total_size = cap_info->header.imagesize;
 	temp_page = krealloc(cap_info->pages,
 			     pages_needed * sizeof(void *),
 			     GFP_KERNEL | __GFP_ZERO);
@@ -97,6 +71,30 @@ static int efi_capsule_setup_info(struct capsule_info *cap_info,
 }
 
 /**
+ * efi_capsule_setup_info - obtain the efi capsule header in the binary and
+ *			    setup capsule_info structure
+ * @cap_info: pointer to current instance of capsule_info structure
+ * @kbuff: a mapped first page buffer pointer
+ * @hdr_bytes: the total received number of bytes for efi header
+ *
+ * Platforms with non-standard capsule update mechanisms can override
+ * this __weak function so they can perform any required capsule
+ * image munging. See quark_quirk_function() for an example.
+ **/
+int __weak efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
+				  size_t hdr_bytes)
+{
+	/* Only process data block that is larger than efi header size */
+	if (hdr_bytes < sizeof(efi_capsule_header_t))
+		return 0;
+
+	memcpy(&cap_info->header, kbuff, sizeof(cap_info->header));
+	cap_info->total_size = cap_info->header.imagesize;
+
+	return __efi_capsule_setup_info(cap_info);
+}
+
+/**
  * efi_capsule_submit_update - invoke the efi_capsule_update API once binary
  *			       upload done
  * @cap_info: pointer to current instance of capsule_info structure
@@ -186,7 +184,7 @@ static ssize_t efi_capsule_write(struct file *file, const char __user *buff,
 
 	/* Setup capsule binary info structure */
 	if (cap_info->header.headersize == 0) {
-		ret = efi_capsule_setup_info(cap_info, kbuff,
+		ret = efi_capsule_setup_info(cap_info, kbuff - cap_info->count,
 					     cap_info->count + write_byte);
 		if (ret)
 			goto fail_unmap;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 5a0b8f7a54c8..b386097e45bc 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -129,6 +129,18 @@ typedef struct {
 #define EFI_CAPSULE_POPULATE_SYSTEM_TABLE	0x00020000
 #define EFI_CAPSULE_INITIATE_RESET		0x00040000
 
+struct capsule_info {
+	efi_capsule_header_t	header;
+	int			reset_type;
+	long			index;
+	size_t			count;
+	size_t			total_size;
+	struct page		**pages;
+	size_t			page_bytes_remain;
+};
+
+int __efi_capsule_setup_info(struct capsule_info *cap_info);
+
 /*
  * Allocation types for calls to boottime->allocate_pages.
  */
-- 
2.12.3
