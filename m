Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508B9CD343C
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 06:57:19 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33677.1777964233665143602
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 23:57:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=HRwSAVjT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20260505065711b509173ea90002075b-y5uytk@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260505065711b509173ea90002075b
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 08:57:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=TwBov2T5LGa3K21A+52yeOG5Zgj+BQy/dYB4iFGRFJU=;
 b=HRwSAVjTWGUSSfEW32Z//YieD3jTTZo6MFdwOCO/il3s2lADdyW7kELq+JDT73ng548gdc
 +fYRvme67ise6MQkM51UbILvBX2kebW9eQTtplBSxarESIWzKLKgmvhOA/k+I4S+a8jZpvQr
 RemK7/1anJNiF6waYQCnjSU0gYwwJHmUqYvRnimAhccNpqFvGzcsBbsouPuoZFrblvsuXKLF
 crKvW85OtoQmYX9myOSvxd27iXUl45I49ilRzPapU3zkPafq8wnzuR7A3QLJhtGxUfNoUJxx
 ZHO04huTAmVuruSYwdkO8bDWx/7t5tMZfSUDEJjcTFXgGaPpyL9ptEnQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	Sebastian Siewior <bigeasy@linutronix.de>
Subject: [RFC][PATCH 6.12.y-cip 07/12] ARM: move vmalloc() lazy-page table population
Date: Tue,  5 May 2026 08:57:01 +0200
Message-ID: <8fbde6337abb9b8f82d16f67ebfeaeb64fff872a.1777964226.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1777964226.git.jan.kiszka@siemens.com>
References: <cover.1777964226.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 06:57:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22874

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit 78900204851708bbe761c3acf641ad60f15c922f ]

Split the vmalloc() lazy-page table population from
do_translation_fault() into a new vmalloc_fault() function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.c | 126 ++++++++++++++++++++++++--------------------
 1 file changed, 68 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index dd78cbef87c85..fabaefa26bb1c 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -262,6 +262,70 @@ static inline bool ttbr0_usermode_access_allowed(struct pt_regs *regs)
 }
 #endif
 
+/*
+ * Handle a vmalloc fault, copying the non-leaf page table entries from
+ * init_mm.pgd. Any kernel context can trigger this, so we must not sleep
+ * or enable interrupts. Having two CPUs execute this for the same page is
+ * no problem, we'll just copy the same data twice.
+ *
+ * Returns false on failure.
+ */
+static bool __kprobes __maybe_unused vmalloc_fault(unsigned long addr)
+{
+	unsigned int index;
+	pgd_t *pgd, *pgd_k;
+	p4d_t *p4d, *p4d_k;
+	pud_t *pud, *pud_k;
+	pmd_t *pmd, *pmd_k;
+
+	index = pgd_index(addr);
+
+	pgd = cpu_get_pgd() + index;
+	pgd_k = init_mm.pgd + index;
+
+	p4d = p4d_offset(pgd, addr);
+	p4d_k = p4d_offset(pgd_k, addr);
+
+	if (p4d_none(*p4d_k))
+		return false;
+	if (!p4d_present(*p4d))
+		set_p4d(p4d, *p4d_k);
+
+	pud = pud_offset(p4d, addr);
+	pud_k = pud_offset(p4d_k, addr);
+
+	if (pud_none(*pud_k))
+		return false;
+	if (!pud_present(*pud))
+		set_pud(pud, *pud_k);
+
+	pmd = pmd_offset(pud, addr);
+	pmd_k = pmd_offset(pud_k, addr);
+
+#ifdef CONFIG_ARM_LPAE
+	/*
+	 * Only one hardware entry per PMD with LPAE.
+	 */
+	index = 0;
+#else
+	/*
+	 * On ARM one Linux PGD entry contains two hardware entries (see page
+	 * tables layout in pgtable.h). We normally guarantee that we always
+	 * fill both L1 entries. But create_mapping() doesn't follow the rule.
+	 * It can create inidividual L1 entries, so here we have to call
+	 * pmd_none() check for the entry really corresponded to address, not
+	 * for the first of pair.
+	 */
+	index = (addr >> SECTION_SHIFT) & 1;
+#endif
+	if (pmd_none(pmd_k[index]))
+		return false;
+
+	copy_pmd(pmd, pmd_k);
+
+	return true;
+}
+
 static int __kprobes
 do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
 			     unsigned int fsr, struct pt_regs *regs)
@@ -497,10 +561,9 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
  * directly to do_kernel_address_page_fault() to handle.
  *
  * Otherwise, we're probably faulting in the vmalloc() area, so try to fix
- * that up. Note that we must not take any locks or enable interrupts in
- * this case.
+ * that up via vmalloc_fault().
  *
- * If vmalloc() fixup fails, that means the non-leaf page tables did not
+ * If vmalloc_fault() fails, that means the non-leaf page tables did not
  * contain an entry for this address, so handle this via
  * do_kernel_address_page_fault().
  */
@@ -509,65 +572,12 @@ static int __kprobes
 do_translation_fault(unsigned long addr, unsigned int fsr,
 		     struct pt_regs *regs)
 {
-	unsigned int index;
-	pgd_t *pgd, *pgd_k;
-	p4d_t *p4d, *p4d_k;
-	pud_t *pud, *pud_k;
-	pmd_t *pmd, *pmd_k;
-
 	if (addr < TASK_SIZE)
 		return do_page_fault(addr, fsr, regs);
 
-	if (user_mode(regs))
-		goto bad_area;
-
-	index = pgd_index(addr);
-
-	pgd = cpu_get_pgd() + index;
-	pgd_k = init_mm.pgd + index;
-
-	p4d = p4d_offset(pgd, addr);
-	p4d_k = p4d_offset(pgd_k, addr);
-
-	if (p4d_none(*p4d_k))
-		goto bad_area;
-	if (!p4d_present(*p4d))
-		set_p4d(p4d, *p4d_k);
-
-	pud = pud_offset(p4d, addr);
-	pud_k = pud_offset(p4d_k, addr);
-
-	if (pud_none(*pud_k))
-		goto bad_area;
-	if (!pud_present(*pud))
-		set_pud(pud, *pud_k);
-
-	pmd = pmd_offset(pud, addr);
-	pmd_k = pmd_offset(pud_k, addr);
-
-#ifdef CONFIG_ARM_LPAE
-	/*
-	 * Only one hardware entry per PMD with LPAE.
-	 */
-	index = 0;
-#else
-	/*
-	 * On ARM one Linux PGD entry contains two hardware entries (see page
-	 * tables layout in pgtable.h). We normally guarantee that we always
-	 * fill both L1 entries. But create_mapping() doesn't follow the rule.
-	 * It can create inidividual L1 entries, so here we have to call
-	 * pmd_none() check for the entry really corresponded to address, not
-	 * for the first of pair.
-	 */
-	index = (addr >> SECTION_SHIFT) & 1;
-#endif
-	if (pmd_none(pmd_k[index]))
-		goto bad_area;
-
-	copy_pmd(pmd, pmd_k);
-	return 0;
+	if (!user_mode(regs) && vmalloc_fault(addr))
+		return 0;
 
-bad_area:
 	do_kernel_address_page_fault(current->mm, addr, fsr, regs);
 
 	return 0;
-- 
2.47.3


