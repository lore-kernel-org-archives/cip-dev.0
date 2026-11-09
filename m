Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3867.1794223246742082011
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 03:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=d6Jznfd3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-202611091120443359a081ae000207d1-bovoaf@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202611091120443359a081ae000207d1
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Nov 2026 12:20:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ouwkoIQ70w6jOaxUadEJqvtCKLYPT1o/6muVbN1RxvQ=;
 b=d6Jznfd3YK41xzMyAA7FVc8H07BKRUwSNneyTJUiHCfOEOeJETTu++AH/nZIt5j91ugdf2
 LDBfDo6932F2w1o0XyS9nzv4LsZMhy+oW7+68WpyempTWefb+q/SFRddMSLKhF4sNB4X+y+o
 ZWCc3VuHTR53SLgrFq6hToYY4AZikZmtlAhEoQ8O9Uaf+Jb7LOC2EeB12khJ8LGhw3Hr4prk
 cHi66PvOjJSbJN0X5b9+/yestNrZmZICNR9vkPZmFDVAR/IwCVDVvpHKb+OA3BFomOa3tMTZ
 waJ4Ms5EFMF4dANAA/cKfbR979D3Ltx3jXVvudWrFL3/8T2byKgEWt0A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: Daniel Wagner <wagi@monom.org>,
	Bryan Brattlof <bb@ti.com>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Pasquale Nieddu <pasquale.nieddu@siemens.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.12.y-cip v2 5/6] ARM: 9426/1: vfp: Move sending signals outside of vfp_state_hold()ed section.
Date: Mon,  9 Nov 2026 12:20:40 +0100
Message-ID: <6ff6f122d350818a87c4fe1e3c18f55de222e3ca.1794223241.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1794223241.git.jan.kiszka@siemens.com>
References: <cover.1794223241.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 11:20:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24702
Content-Type: text/plain; charset="utf-8"

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit c0b5195bad63b18022f2776372fccd3ae9177705 ]

VFP_bounce() is invoked from within vfp_support_entry() and may send a
signal. Sending a signal uses spinlock_t which becomes a sleeping lock
on PREEMPT_RT and must not be acquired within a preempt-disabled
section.

Move the vfp_raise_sigfpe() block outside of the vfp_state_hold() section.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/vfp/vfpmodule.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 28dafae7758b8..d44867fc0c5ee 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -268,7 +268,7 @@ static void vfp_panic(char *reason, u32 inst)
 /*
  * Process bitmask of exception conditions.
  */
-static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_regs *regs)
+static int vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr)
 {
 	int si_code = 0;
 
@@ -276,8 +276,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_
 
 	if (exceptions == VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		vfp_raise_sigfpe(FPE_FLTINV, regs);
-		return;
+		return FPE_FLTINV;
 	}
 
 	/*
@@ -305,8 +304,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_
 	RAISE(FPSCR_OFC, FPSCR_OFE, FPE_FLTOVF);
 	RAISE(FPSCR_IOC, FPSCR_IOE, FPE_FLTINV);
 
-	if (si_code)
-		vfp_raise_sigfpe(si_code, regs);
+	return si_code;
 }
 
 /*
@@ -352,6 +350,8 @@ static u32 vfp_emulate_instruction(u32 inst, u32 fpscr, struct pt_regs *regs)
 static void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
 {
 	u32 fpscr, orig_fpscr, fpsid, exceptions;
+	int si_code2 = 0;
+	int si_code = 0;
 
 	pr_debug("VFP: bounce: trigger %08x fpexc %08x\n", trigger, fpexc);
 
@@ -397,8 +397,8 @@ static void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
 		 * unallocated VFP instruction but with FPSCR.IXE set and not
 		 * on VFP subarch 1.
 		 */
-		 vfp_raise_exceptions(VFP_EXCEPTION_ERROR, trigger, fpscr, regs);
-		return;
+		si_code = vfp_raise_exceptions(VFP_EXCEPTION_ERROR, trigger, fpscr);
+		goto exit;
 	}
 
 	/*
@@ -422,14 +422,14 @@ static void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
 	 */
 	exceptions = vfp_emulate_instruction(trigger, fpscr, regs);
 	if (exceptions)
-		vfp_raise_exceptions(exceptions, trigger, orig_fpscr, regs);
+		si_code2 = vfp_raise_exceptions(exceptions, trigger, orig_fpscr);
 
 	/*
 	 * If there isn't a second FP instruction, exit now. Note that
 	 * the FPEXC.FP2V bit is valid only if FPEXC.EX is 1.
 	 */
 	if ((fpexc & (FPEXC_EX | FPEXC_FP2V)) != (FPEXC_EX | FPEXC_FP2V))
-		return;
+		goto exit;
 
 	/*
 	 * The barrier() here prevents fpinst2 being read
@@ -441,7 +441,13 @@ static void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
  emulate:
 	exceptions = vfp_emulate_instruction(trigger, orig_fpscr, regs);
 	if (exceptions)
-		vfp_raise_exceptions(exceptions, trigger, orig_fpscr, regs);
+		si_code = vfp_raise_exceptions(exceptions, trigger, orig_fpscr);
+exit:
+	vfp_state_release();
+	if (si_code2)
+		vfp_raise_sigfpe(si_code2, regs);
+	if (si_code)
+		vfp_raise_sigfpe(si_code, regs);
 }
 
 static void vfp_enable(void *unused)
@@ -773,6 +779,7 @@ static int vfp_support_entry(struct pt_regs *regs, u32 trigger)
 		 * replay the instruction that trapped.
 		 */
 		fmxr(FPEXC, fpexc);
+		vfp_state_release();
 	} else {
 		/* Check for synchronous or asynchronous exceptions */
 		if (!(fpexc & (FPEXC_EX | FPEXC_DEX))) {
@@ -794,10 +801,10 @@ static int vfp_support_entry(struct pt_regs *regs, u32 trigger)
 			}
 		}
 bounce:		regs->ARM_pc += 4;
+		/* VFP_bounce() will invoke vfp_state_release() */
 		VFP_bounce(trigger, fpexc, regs);
 	}
 
-	vfp_state_release();
 	return 0;
 }
 
-- 
2.47.3

