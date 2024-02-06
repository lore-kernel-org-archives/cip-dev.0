Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A48C4829A
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 22:12:56 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.4835.1707253886634051728
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 13:11:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OXTrcr1R;
 spf=pass (domain: gmail.com, ip: 209.85.210.169, mailfrom: schmitzmic@gmail.com)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e065abd351so41166b3a.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 13:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707253886; x=1707858686; darn=lists.cip-project.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zkqg+eFzaY2S/u8Ml2dXeOowbMrMt0zE1hQJncnSBIw=;
        b=OXTrcr1RLDF+gL32A/Fs339XG4sKXccpixRSLqC/vvI+8YzqPXpI9zRrqw5ydnzimn
         eakN8kDd4ttSiA2ASzK+1A2Vf2/d4/A/WfOY5KIAt6IBYvBO5yRKq85dM+iu7x1WvfM4
         4JLD63rl9gGcahBttmFeShUrj0WyThLAcTgGkyS2FFIMSyZao7h3gNJxQXl9GAO57YP0
         P9MEEzB5bGhpGMmLKVLn19L4/YXNpeWk0sABrJken1/YLxDD9xchsFMdj6Pi3rynC07n
         EGoGUPTB2AjRPFBUm0f6spwoRq1yoHrs0KQR5JuiWqq5gjPNZxV5UXCZzNBtmqifXLY4
         bYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707253886; x=1707858686;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkqg+eFzaY2S/u8Ml2dXeOowbMrMt0zE1hQJncnSBIw=;
        b=beVkUjV82SxuRHY3t3guG7g6XRrmwdGtcKEUorKl9T9YzbO6mv493Qrisox5K8VDhQ
         SZIlmLFi8L5rm5+blkTdIM25biV6b3BfuvXkKSEFen/Xwl+tCtrZGR0EUeyAJKHxdFEO
         LccpuWMQo2aqcDAswgewxLgff1seKk4zQ+vI1V1DMX6/PYtvnjCi5qzElaBF4kFwnSF3
         tXEwf+LUkwsuG9mi5EftMS7pgF8VmqE8U1HFSZkbP6aH973GZ+c4MnaRpzi9BIwBDC5a
         w+Oyg6LQMmoZThOQ+ggQM014ARdo3tLJZpqZhybPO0WRISZhIrAIFuQLAcEyY6XIOkJi
         htoA==
X-Gm-Message-State: AOJu0YxNdIdn99VDMLiC4VBJBKKhX7oOgz0b8/p3S/FcQoWvmWYH6uG6
	WPRnRDPG/3LUP3uDkTEMwu5ebfx8loDTKQ5rA1zxHzvUzyngPI57
X-Google-Smtp-Source: AGHT+IHVQ6lQbWQxawf9YzN908IdwFWfGcgu1QyaGqWhcZZ+hyKQ3AhUppBt4m1p5n9wNO92InqghA==
X-Received: by 2002:a05:6a20:9687:b0:19e:3af0:af33 with SMTP id hp7-20020a056a20968700b0019e3af0af33mr2705294pzc.60.1707253886059;
        Tue, 06 Feb 2024 13:11:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/gWOh6hWcEOWt/LTJnuUAkv84xiNF15vuAuNc/rWcB6ssZo5cnk4AXBZlL9ldX3sAQwkDX0aJoO5DxHWva+VaByxiFMnH9soE95IAiWNW/iRCoXV/5Mvx6RxKK91zKyDx+p/jCsvSljMcnWKf5bJg6g+K/C2ppajYV7DdJiBtAsPXxggI3zp8PvG1hlH1Czgb33h4lTBOVCgsxixW0SWzjQ==
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id x15-20020aa79a4f000000b006ddc133f1d3sm2411449pfj.194.2024.02.06.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:11:25 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 1DC8C36032D; Wed,  7 Feb 2024 10:11:22 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org
Cc: geert@linux-m68k.org,
	uli@fpond.eu,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	cip-dev@lists.cip-project.org,
	Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v3 4/8] m68k: Handle arrivals of multiple signals correctly
Date: Wed,  7 Feb 2024 10:11:00 +1300
Message-Id: <20240206211104.26421-5-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240206211104.26421-1-schmitzmic@gmail.com>
References: <20240206211104.26421-1-schmitzmic@gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 22:12:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14836

From: Al Viro <viro@zeniv.linux.org.uk>

commit 4bb0bd81ce5e97092dfda6a106d414b703ec0ee8 upstream.

When we have several pending signals, have entered with the kernel
with large exception frame *and* have already built at least one
sigframe, regs->stkadj is going to be non-zero and regs->format/sr/pc
are going to be junk - the real values are in shifted exception stack
frame we'd built when putting together the first sigframe.

If that happens, subsequent sigframes are going to be garbage.
Not hard to fix - just need to find the "adjusted" frame first
and look for format/vector/sr/pc in it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Finn Thain <fthain@linux-m68k.org>
Link: https://lore.kernel.org/r/YP2dBIAPTaVvHiZ6@zeniv-ca.linux.org.uk
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401310920.sBSI4BHj-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
[MSch: Minor v4.4 backport merge conflict fixes]
Cc: <cip-dev@lists.cip-project.org> # 4.4
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/kernel/signal.c | 100 +++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 55 deletions(-)

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index af1c4f330aef..644c2ddc8aac 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -465,7 +465,7 @@ static inline void save_fpu_state(struct sigcontext *sc, struct pt_regs *regs)
 
 	if (CPU_IS_060 ? sc->sc_fpstate[2] : sc->sc_fpstate[0]) {
 		fpu_version = sc->sc_fpstate[0];
-		if (CPU_IS_020_OR_030 &&
+		if (CPU_IS_020_OR_030 && !regs->stkadj &&
 		    regs->vector >= (VEC_FPBRUC * 4) &&
 		    regs->vector <= (VEC_FPNAN * 4)) {
 			/* Clear pending exception in 68882 idle frame */
@@ -528,7 +528,7 @@ static inline int rt_save_fpu_state(struct ucontext __user *uc, struct pt_regs *
 		if (!(CPU_IS_060 || CPU_IS_COLDFIRE))
 			context_size = fpstate[1];
 		fpu_version = fpstate[0];
-		if (CPU_IS_020_OR_030 &&
+		if (CPU_IS_020_OR_030 && !regs->stkadj &&
 		    regs->vector >= (VEC_FPBRUC * 4) &&
 		    regs->vector <= (VEC_FPNAN * 4)) {
 			/* Clear pending exception in 68882 idle frame */
@@ -788,18 +788,24 @@ badframe:
 	return 0;
 }
 
+static inline struct pt_regs *rte_regs(struct pt_regs *regs)
+{
+	return (void *)regs + regs->stkadj;
+}
+
 static void setup_sigcontext(struct sigcontext *sc, struct pt_regs *regs,
 			     unsigned long mask)
 {
+	struct pt_regs *tregs = rte_regs(regs);
 	sc->sc_mask = mask;
 	sc->sc_usp = rdusp();
 	sc->sc_d0 = regs->d0;
 	sc->sc_d1 = regs->d1;
 	sc->sc_a0 = regs->a0;
 	sc->sc_a1 = regs->a1;
-	sc->sc_sr = regs->sr;
-	sc->sc_pc = regs->pc;
-	sc->sc_formatvec = regs->format << 12 | regs->vector;
+	sc->sc_sr = tregs->sr;
+	sc->sc_pc = tregs->pc;
+	sc->sc_formatvec = tregs->format << 12 | tregs->vector;
 	save_a5_state(sc, regs);
 	save_fpu_state(sc, regs);
 }
@@ -807,6 +813,7 @@ static void setup_sigcontext(struct sigcontext *sc, struct pt_regs *regs,
 static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *regs)
 {
 	struct switch_stack *sw = (struct switch_stack *)regs - 1;
+	struct pt_regs *tregs = rte_regs(regs);
 	greg_t __user *gregs = uc->uc_mcontext.gregs;
 	int err = 0;
 
@@ -827,9 +834,9 @@ static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *
 	err |= __put_user(sw->a5, &gregs[13]);
 	err |= __put_user(sw->a6, &gregs[14]);
 	err |= __put_user(rdusp(), &gregs[15]);
-	err |= __put_user(regs->pc, &gregs[16]);
-	err |= __put_user(regs->sr, &gregs[17]);
-	err |= __put_user((regs->format << 12) | regs->vector, &uc->uc_formatvec);
+	err |= __put_user(tregs->pc, &gregs[16]);
+	err |= __put_user(tregs->sr, &gregs[17]);
+	err |= __put_user((tregs->format << 12) | tregs->vector, &uc->uc_formatvec);
 	err |= rt_save_fpu_state(uc, regs);
 	return err;
 }
@@ -846,15 +853,14 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 			struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
-	int fsize = frame_extra_sizes(regs->format);
+	struct pt_regs *tregs = rte_regs(regs);
+	int fsize = frame_extra_sizes(tregs->format);
 	struct sigcontext context;
 	int err = 0, sig = ksig->sig;
 
 	if (fsize < 0) {
-#ifdef DEBUG
-		printk ("setup_frame: Unknown frame format %#x\n",
-			regs->format);
-#endif
+		pr_debug("setup_frame: Unknown frame format %#x\n",
+			 tregs->format);
 		return -EFAULT;
 	}
 
@@ -865,7 +871,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 
 	err |= __put_user(sig, &frame->sig);
 
-	err |= __put_user(regs->vector, &frame->code);
+	err |= __put_user(tregs->vector, &frame->code);
 	err |= __put_user(&frame->sc, &frame->psc);
 
 	if (_NSIG_WORDS > 1)
@@ -890,36 +896,28 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 
 	push_cache ((unsigned long) &frame->retcode);
 
-	/*
-	 * Set up registers for signal handler.  All the state we are about
-	 * to destroy is successfully copied to sigframe.
-	 */
-	wrusp ((unsigned long) frame);
-	regs->pc = (unsigned long) ksig->ka.sa.sa_handler;
-	adjustformat(regs);
-
 	/*
 	 * This is subtle; if we build more than one sigframe, all but the
 	 * first one will see frame format 0 and have fsize == 0, so we won't
 	 * screw stkadj.
 	 */
-	if (fsize)
+	if (fsize) {
 		regs->stkadj = fsize;
-
-	/* Prepare to skip over the extra stuff in the exception frame.  */
-	if (regs->stkadj) {
-		struct pt_regs *tregs =
-			(struct pt_regs *)((ulong)regs + regs->stkadj);
-#ifdef DEBUG
-		printk("Performing stackadjust=%04x\n", regs->stkadj);
-#endif
-		/* This must be copied with decreasing addresses to
-                   handle overlaps.  */
+		tregs = rte_regs(regs);
+		pr_debug("Performing stackadjust=%04lx\n", regs->stkadj);
 		tregs->vector = 0;
 		tregs->format = 0;
-		tregs->pc = regs->pc;
 		tregs->sr = regs->sr;
 	}
+
+	/*
+	 * Set up registers for signal handler.  All the state we are about
+	 * to destroy is successfully copied to sigframe.
+	 */
+	wrusp ((unsigned long) frame);
+	tregs->pc = (unsigned long) ksig->ka.sa.sa_handler;
+	adjustformat(regs);
+
 	return 0;
 }
 
@@ -927,7 +925,8 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 			   struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
-	int fsize = frame_extra_sizes(regs->format);
+	struct pt_regs *tregs = rte_regs(regs);
+	int fsize = frame_extra_sizes(tregs->format);
 	int err = 0, sig = ksig->sig;
 
 	if (fsize < 0) {
@@ -978,36 +977,27 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 
 	push_cache ((unsigned long) &frame->retcode);
 
-	/*
-	 * Set up registers for signal handler.  All the state we are about
-	 * to destroy is successfully copied to sigframe.
-	 */
-	wrusp ((unsigned long) frame);
-	regs->pc = (unsigned long) ksig->ka.sa.sa_handler;
-	adjustformat(regs);
-
 	/*
 	 * This is subtle; if we build more than one sigframe, all but the
 	 * first one will see frame format 0 and have fsize == 0, so we won't
 	 * screw stkadj.
 	 */
-	if (fsize)
+	if (fsize) {
 		regs->stkadj = fsize;
-
-	/* Prepare to skip over the extra stuff in the exception frame.  */
-	if (regs->stkadj) {
-		struct pt_regs *tregs =
-			(struct pt_regs *)((ulong)regs + regs->stkadj);
-#ifdef DEBUG
-		printk("Performing stackadjust=%04x\n", regs->stkadj);
-#endif
-		/* This must be copied with decreasing addresses to
-                   handle overlaps.  */
+		tregs = rte_regs(regs);
+		pr_debug("Performing stackadjust=%04lx\n", regs->stkadj);
 		tregs->vector = 0;
 		tregs->format = 0;
-		tregs->pc = regs->pc;
 		tregs->sr = regs->sr;
 	}
+
+	/*
+	 * Set up registers for signal handler.  All the state we are about
+	 * to destroy is successfully copied to sigframe.
+	 */
+	wrusp ((unsigned long) frame);
+	tregs->pc = (unsigned long) ksig->ka.sa.sa_handler;
+	adjustformat(regs);
 	return 0;
 }
 
-- 
2.17.1


