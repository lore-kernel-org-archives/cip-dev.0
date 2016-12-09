From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:34:30 +0000
Subject: [cip-dev] [PATCH 4.4-cip 04/23] x86/microcode/intel: Change
 checksum variables to u32
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243670.1860.160.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Chris Bainbridge <chris.bainbridge@gmail.com>

commit bc864af13f34d19c911f5691d87bdacc9ce109f5 upstream.

Microcode checksum verification should be done using unsigned 32-bit
values otherwise the calculation overflow results in undefined
behaviour.

This is also nicely documented in the SDM, section "Microcode Update
Checksum":

  "To check for a corrupt microcode update, software must perform a
  unsigned DWORD (32-bit) checksum of the microcode update. Even though
  some fields are signed, the checksum procedure treats all DWORDs as
  unsigned. Microcode updates with a header version equal to 00000001H
  must sum all DWORDs that comprise the microcode update. A valid
  checksum check will yield a value of 00000000H."

but for some reason the code has been using ints from the very
beginning.

In practice, this bug possibly manifested itself only when doing the
microcode data checksum - apparently, currently shipped Intel microcode
doesn't have an extended signature table for which we do checksum
verification too.

  UBSAN: Undefined behaviour in arch/x86/kernel/cpu/microcode/intel_lib.c:105:12
  signed integer overflow:
  -1500151068 + -2125470173 cannot be represented in type 'int'
  CPU: 0 PID: 0 Comm: swapper Not tainted 4.5.0-rc5+ #495
  ...
  Call Trace:
   dump_stack
   ? inotify_ioctl
   ubsan_epilogue
   handle_overflow
   __ubsan_handle_add_overflow
   microcode_sanity_check
   get_matching_model_microcode.isra.2.constprop.8
   ? early_idt_handler_common
   ? strlcpy
   ? find_cpio_data
   load_ucode_intel_bsp
   load_ucode_bsp
   ? load_ucode_bsp
   x86_64_start_kernel

[ Expand and massage commit message. ]
Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: hmh at hmh.eng.br
Link: http://lkml.kernel.org/r/1456834359-5132-1-git-send-email-chris.bainbridge at gmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 arch/x86/kernel/cpu/microcode/intel_lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel_lib.c b/arch/x86/kernel/cpu/microcode/intel_lib.c
index b96896bcbdaf..99ca2c935777 100644
--- a/arch/x86/kernel/cpu/microcode/intel_lib.c
+++ b/arch/x86/kernel/cpu/microcode/intel_lib.c
@@ -49,7 +49,7 @@ int microcode_sanity_check(void *mc, int print_err)
 	unsigned long total_size, data_size, ext_table_size;
 	struct microcode_header_intel *mc_header = mc;
 	struct extended_sigtable *ext_header = NULL;
-	int sum, orig_sum, ext_sigcount = 0, i;
+	u32 sum, orig_sum, ext_sigcount = 0, i;
 	struct extended_signature *ext_sig;
 
 	total_size = get_totalsize(mc_header);
@@ -85,8 +85,8 @@ int microcode_sanity_check(void *mc, int print_err)
 
 	/* check extended table checksum */
 	if (ext_table_size) {
-		int ext_table_sum = 0;
-		int *ext_tablep = (int *)ext_header;
+		u32 ext_table_sum = 0;
+		u32 *ext_tablep = (u32 *)ext_header;
 
 		i = ext_table_size / DWSIZE;
 		while (i--)
@@ -102,7 +102,7 @@ int microcode_sanity_check(void *mc, int print_err)
 	orig_sum = 0;
 	i = (MC_HEADER_SIZE + data_size) / DWSIZE;
 	while (i--)
-		orig_sum += ((int *)mc)[i];
+		orig_sum += ((u32 *)mc)[i];
 	if (orig_sum) {
 		if (print_err)
 			pr_err("aborting, bad checksum\n");
-- 
2.10.2



-- 
Ben Hutchings
Software Developer, Codethink Ltd.
