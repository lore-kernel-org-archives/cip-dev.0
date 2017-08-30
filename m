From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:13:45 +0200
Subject: [cip-dev] [PATCH 03/14] x86/efi: Force EFI reboot to process
	pending capsules
In-Reply-To: <cover.1504120436.git.jan.kiszka@siemens.com>
References: <cover.1504120436.git.jan.kiszka@siemens.com>
Message-ID: <5bf9526467655ef151fd8ce59c91f5473f8f86e5.1504120436.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Matt Fleming <matt@codeblueprint.co.uk>

commit 87615a34d561ef59bd0cffc73256a21220dfdffd upstream.

If an EFI capsule has been sent to the firmware we must match the type
of EFI reset against that required by the capsule to ensure it is
processed correctly.

Force an EFI reboot if a capsule is pending for the next reset.

Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kweh Hock Leong <hock.leong.kweh@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: joeyli <jlee@suse.com>
Cc: linux-efi at vger.kernel.org
Link: http://lkml.kernel.org/r/1461614832-17633-29-git-send-email-matt at codeblueprint.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/reboot.c | 9 +++++++++
 include/linux/efi.h      | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index f660d63f40fe..01d9e1edda07 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -535,6 +535,15 @@ static void native_machine_emergency_restart(void)
 	mode = reboot_mode == REBOOT_WARM ? 0x1234 : 0;
 	*((unsigned short *)__va(0x472)) = mode;
 
+	/*
+	 * If an EFI capsule has been registered with the firmware then
+	 * override the reboot= parameter.
+	 */
+	if (efi_capsule_pending(NULL)) {
+		pr_info("EFI capsule is pending, forcing EFI reboot.\n");
+		reboot_type = BOOT_EFI;
+	}
+
 	for (;;) {
 		/* Could also try the reset bit in the Hammer NB */
 		switch (reboot_type) {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4899c679622d..5a0b8f7a54c8 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1004,6 +1004,12 @@ static inline bool efi_enabled(int feature)
 }
 static inline void
 efi_reboot(enum reboot_mode reboot_mode, const char *__unused) {}
+
+static inline bool
+efi_capsule_pending(int *reset_type)
+{
+	return false;
+}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);
-- 
2.12.3
