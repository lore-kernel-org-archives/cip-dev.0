Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ECDCD98F2
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 14:35:57 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40078.1782124446000396855
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 03:34:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=ErM/0Igd;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=ZnkUWZDP;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782124015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nACALUu0nPjGj38lA0InCvBNsegQPdKco+0dwwn67f8=;
	b=ErM/0IgdZWFB6XWSaxUtjRwSw3Vk9wgcU4od8sJ5UK4BIp3Fct/VdFyi6aGfB2hhUojH7v
	yV0OrWsa8cMGPeng1NPwM3I1S2xo/sYpbm/9Xi2fMJAbYENSId/6QO9JhnVqtRi6iO++1y
	ATMBbpPg5A9/RTGoNbxQ8xF4PebKm3JZDhLgy+AczqDjWhZtgmq1lwGPsAfOsOIhon3M4B
	veyJbf8TnSrA6qwoGtnK/+olZDaOWL2nNabalH1god/FEwe4W4cJ7dHsWUWBAuaHxNZsi1
	fE4+lYGgZYyUhZhIGRxRgnLfI/QB++XCbhEJ/ok6zpvZNOhIdkHTGGodrgRzug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782124015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nACALUu0nPjGj38lA0InCvBNsegQPdKco+0dwwn67f8=;
	b=ZnkUWZDPjPSjrxGB9iw/bBvN4JG/TSaaem6CbUON0trNdnguqPpcSqj+OMlAEO37ftIWo6
	cW4uThNm3zVi8OBA==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4] ARM: fix branch predictor hardening
Date: Mon, 22 Jun 2026 12:26:34 +0200
Message-ID: <20260622102634.780100-5-bigeasy@linutronix.de>
In-Reply-To: <20260622102634.780100-1-bigeasy@linutronix.de>
References: <20260622102634.780100-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 14:35:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23251

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit fd2dee1c6e2256f726ba33fd3083a7be0efc80d3 upstream.

__do_user_fault() may be called with indeterminent interrupt enable
state, which means we may be preemptive at this point. This causes
problems when calling harden_branch_predictor(). For example, when
called from a data abort, do_alignment_fault()->do_bad_area().

Move harden_branch_predictor() out of __do_user_fault() and into the
calling contexts.

Moving it into do_kernel_address_page_fault(), we can be sure that
interrupts will be disabled here.

Converting do_translation_fault() to use do_kernel_address_page_fault()
rather than do_bad_area() means that we keep branch predictor handling
for translation faults. Interrupts will also be disabled at this call
site.

do_sect_fault() needs special handling, so detect user mode accesses
to kernel-addresses, and add an explicit call to branch predictor
hardening.

Finally, add branch predictor hardening to do_alignment() for the
faulting case (user mode accessing kernel addresses) before interrupts
are enabled.

This should cover all cases where harden_branch_predictor() is called,
ensuring that it is always has interrupts disabled, also ensuring that
it is called early in each call path.

Reviewed-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Tested-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/alignment.c |  4 ++++
 arch/arm/mm/fault.c     | 39 ++++++++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index f8dd0b3cc8e04..ee264737be6d2 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -22,6 +22,7 @@
=20
 #include <asm/cp15.h>
 #include <asm/system_info.h>
+#include <asm/system_misc.h>
 #include <asm/unaligned.h>
 #include <asm/opcodes.h>
=20
@@ -809,6 +810,9 @@ do_alignment(unsigned long addr, unsigned int fsr, stru=
ct pt_regs *regs)
 	int thumb2_32b =3D 0;
 	int fault;
=20
+	if (addr >=3D TASK_SIZE && user_mode(regs))
+		harden_branch_predictor();
+
 	if (interrupts_enabled(regs))
 		local_irq_enable();
=20
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 47eecdf29a831..87ed5da30e44f 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -199,9 +199,6 @@ __do_user_fault(unsigned long addr, unsigned int fsr, u=
nsigned int sig,
 {
 	struct task_struct *tsk =3D current;
=20
-	if (addr > TASK_SIZE)
-		harden_branch_predictor();
-
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig =3D=3D SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig =3D=3D SIGBUS))) {
@@ -252,8 +249,10 @@ do_kernel_address_page_fault(struct mm_struct *mm, uns=
igned long addr,
 		/*
 		 * Fault from user mode for a kernel space address. User mode
 		 * should not be faulting in kernel space, which includes the
-		 * vector/khelper page. Send a SIGSEGV.
+		 * vector/khelper page. Handle the branch predictor hardening
+		 * while interrupts are still disabled, then send a SIGSEGV.
 		 */
+		harden_branch_predictor();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	} else {
 		/*
@@ -423,16 +422,20 @@ do_page_fault(unsigned long addr, unsigned int fsr, s=
truct pt_regs *regs)
  * We enter here because the first level page table doesn't contain
  * a valid entry for the address.
  *
- * If the address is in kernel space (>=3D TASK_SIZE), then we are
- * probably faulting in the vmalloc() area.
+ * If this is a user address (addr < TASK_SIZE), we handle this as a
+ * normal page fault. This leaves the remainder of the function to handle
+ * kernel address translation faults.
  *
- * If the init_task's first level page tables contains the relevant
- * entry, we copy the it to this task.  If not, we send the process
- * a signal, fixup the exception, or oops the kernel.
+ * Since user mode is not permitted to access kernel addresses, pass these
+ * directly to do_kernel_address_page_fault() to handle.
  *
- * NOTE! We MUST NOT take any locks for this case. We may be in an
- * interrupt or a critical region, and should only copy the information
- * from the master page table, nothing more.
+ * Otherwise, we're probably faulting in the vmalloc() area, so try to fix
+ * that up. Note that we must not take any locks or enable interrupts in
+ * this case.
+ *
+ * If vmalloc() fixup fails, that means the non-leaf page tables did not
+ * contain an entry for this address, so handle this via
+ * do_kernel_address_page_fault().
  */
 #ifdef CONFIG_MMU
 static int __kprobes
@@ -498,7 +501,8 @@ do_translation_fault(unsigned long addr, unsigned int f=
sr,
 	return 0;
=20
 bad_area:
-	do_bad_area(addr, fsr, regs);
+	do_kernel_address_page_fault(current->mm, addr, fsr, regs);
+
 	return 0;
 }
 #else					/* CONFIG_MMU */
@@ -518,7 +522,16 @@ do_translation_fault(unsigned long addr, unsigned int =
fsr,
 static int
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
+	/*
+	 * If this is a kernel address, but from user mode, then userspace
+	 * is trying bad stuff. Invoke the branch predictor handling.
+	 * Interrupts are disabled here.
+	 */
+	if (addr >=3D TASK_SIZE && user_mode(regs))
+		harden_branch_predictor();
+
 	do_bad_area(addr, fsr, regs);
+
 	return 0;
 }
 #endif /* CONFIG_ARM_LPAE */
--=20
2.53.0


