From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:13:43 +0200
Subject: [cip-dev] [PATCH 01/14] efi: Move efi_status_to_err() to
	drivers/firmware/efi/
In-Reply-To: <cover.1504120436.git.jan.kiszka@siemens.com>
References: <cover.1504120436.git.jan.kiszka@siemens.com>
Message-ID: <da99d306c14f65a0092415fc581b57b2446c642c.1504120436.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Matt Fleming <matt@codeblueprint.co.uk>

commit 806b0351c9ff9890c1ef0ba2c46237baef49ac79 upstream.

Move efi_status_to_err() to the architecture independent code as it's
generally useful in all bits of EFI code where there is a need to
convert an efi_status_t to a kernel error value.

Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kweh Hock Leong <hock.leong.kweh@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: joeyli <jlee@suse.com>
Cc: linux-efi at vger.kernel.org
Link: http://lkml.kernel.org/r/1461614832-17633-27-git-send-email-matt at codeblueprint.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/efi.c  | 33 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/vars.c | 33 ---------------------------------
 include/linux/efi.h         |  2 ++
 3 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 3b52677f459a..33d60992a580 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -663,3 +663,36 @@ u64 __weak efi_mem_attributes(unsigned long phys_addr)
 	}
 	return 0;
 }
+
+int efi_status_to_err(efi_status_t status)
+{
+	int err;
+
+	switch (status) {
+	case EFI_SUCCESS:
+		err = 0;
+		break;
+	case EFI_INVALID_PARAMETER:
+		err = -EINVAL;
+		break;
+	case EFI_OUT_OF_RESOURCES:
+		err = -ENOSPC;
+		break;
+	case EFI_DEVICE_ERROR:
+		err = -EIO;
+		break;
+	case EFI_WRITE_PROTECTED:
+		err = -EROFS;
+		break;
+	case EFI_SECURITY_VIOLATION:
+		err = -EACCES;
+		break;
+	case EFI_NOT_FOUND:
+		err = -ENOENT;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 6f182fd91a6d..38e36526ba02 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -318,39 +318,6 @@ check_var_size(u32 attributes, unsigned long size)
 	return fops->query_variable_store(attributes, size);
 }
 
-static int efi_status_to_err(efi_status_t status)
-{
-	int err;
-
-	switch (status) {
-	case EFI_SUCCESS:
-		err = 0;
-		break;
-	case EFI_INVALID_PARAMETER:
-		err = -EINVAL;
-		break;
-	case EFI_OUT_OF_RESOURCES:
-		err = -ENOSPC;
-		break;
-	case EFI_DEVICE_ERROR:
-		err = -EIO;
-		break;
-	case EFI_WRITE_PROTECTED:
-		err = -EROFS;
-		break;
-	case EFI_SECURITY_VIOLATION:
-		err = -EACCES;
-		break;
-	case EFI_NOT_FOUND:
-		err = -ENOENT;
-		break;
-	default:
-		err = -EINVAL;
-	}
-
-	return err;
-}
-
 static bool variable_is_present(efi_char16_t *variable_name, efi_guid_t *vendor,
 				struct list_head *head)
 {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 47be3ad7d3e5..774e9a0d49f1 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -999,6 +999,8 @@ static inline void
 efi_reboot(enum reboot_mode reboot_mode, const char *__unused) {}
 #endif
 
+extern int efi_status_to_err(efi_status_t status);
+
 /*
  * Variable Attributes
  */
-- 
2.12.3
