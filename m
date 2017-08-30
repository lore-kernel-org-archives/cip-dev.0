From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:13:52 +0200
Subject: [cip-dev] [PATCH 10/14] efi/capsule: Adjust return type of
	efi_capsule_setup_info()
In-Reply-To: <cover.1504120436.git.jan.kiszka@siemens.com>
References: <cover.1504120436.git.jan.kiszka@siemens.com>
Message-ID: <7452bbd08d42bed92938078b1484ccdad81d0176.1504120436.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 41b0c376951417d1b37448957b30f766b10d3090 upstream.

We actually expect int at the caller and never return any size
information.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi at vger.kernel.org
Link: http://lkml.kernel.org/r/20170602135207.21708-6-ard.biesheuvel at linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/capsule-loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 3fb91e1597a9..37d3f6ec2d28 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -53,8 +53,8 @@ static void efi_free_all_buff_pages(struct capsule_info *cap_info)
  * @kbuff: a mapped first page buffer pointer
  * @hdr_bytes: the total received number of bytes for efi header
  **/
-static ssize_t efi_capsule_setup_info(struct capsule_info *cap_info,
-				      void *kbuff, size_t hdr_bytes)
+static int efi_capsule_setup_info(struct capsule_info *cap_info,
+				  void *kbuff, size_t hdr_bytes)
 {
 	efi_capsule_header_t *cap_hdr;
 	size_t pages_needed;
-- 
2.12.3
