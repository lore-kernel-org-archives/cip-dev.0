Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AFDCF649D
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 02:12:16 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.45780.1727662128613269013
 for <cip-dev@lists.cip-project.org>;
 Sun, 29 Sep 2024 19:08:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Z962nq0u;
 spf=pass (domain: gmail.com, ip: 209.85.214.177, mailfrom: schmitzmic@gmail.com)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b7463dd89so8324455ad.2
        for <cip-dev@lists.cip-project.org>; Sun, 29 Sep 2024 19:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727662128; x=1728266928; darn=lists.cip-project.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CvQR9NlqnSvjNRqlsibsJF+A4Kkive+UIK1D/WGRuuo=;
        b=Z962nq0uRt6iCrxysAvHxY5xR/V5Zpj4uKGp3BNHP/1sX0VN/txl0UddMJ5uzeWjFD
         PdVcJYG2ZNy9biZ9GEVPzwOyo/wVM+lgNfOKo+aiN4oSzTKUd2fjM4f6PgysWWA7tjQz
         GCvfCpqxzbUQYdNhApAqBHjsTBJUetNq34oFmK61I2QNpyT0SWl+ANOCvI15+lClY9IS
         1L7BFcVpHAyYpcxePvpoRRwm0iVfJ358XH5EL3foqXYJnyIvlukNAwSb5DPphrCE7cQH
         f3geUV+q5nK3ZOea+K/4Hab2WWtfQ6E3aasKrASi/dPzONV+Mhua7dh0qvrPAROX28Ui
         ITkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727662128; x=1728266928;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvQR9NlqnSvjNRqlsibsJF+A4Kkive+UIK1D/WGRuuo=;
        b=vy6nb3+C5p2XkfTMoMXgHdegaES7/rsFlm4YmK2KGiUfJVhlyBI7kQ/JbE5R7OZwIB
         CJWFR+/Q2So6OSsaj6X9VUQG57UTtDujsE9xvNd8LFcWPOEYqHg6Fe+CaT+sa1mrci6y
         pC9dts51n+GznPPWsbL9lkLmwnMhIIZ6jY7ywBHFEhVkxYy7o70f8QyxSFBRJGI83eQS
         2hjDx418ILZa1VY9pGb6hZvV+LBZjzbFZ0Wz2ZiZghdUpYMpvkZFhCR1Yee2Cjl4TIZB
         cVMS7aErLplJTyP1iTipCJCClgIoc/JZcWJ/IwX18Na0j0nsmS9W5X0sSxnbmKCxKmgY
         ATgw==
X-Gm-Message-State: AOJu0Ywvq2l+qaXIp4ptAtuNW/TLT397F6XCVIK/vgTnuRBFnph/9JVm
	2d+381QdgJoHjjhvHkxy9BYTa/6xKZCSaXNBYdvf4rIj274adp5exsjPiQ==
X-Google-Smtp-Source: AGHT+IFDpAA7nLwVVKm4anXKrEbJhZJxmu4Os0b+pCNZkTzzINc90mmFwpSULS01+oFFV1wOy7wO6w==
X-Received: by 2002:a17:902:f54e:b0:20b:5c94:da0e with SMTP id d9443c01a7336-20b5c94ddb6mr72780925ad.51.1727662127794;
        Sun, 29 Sep 2024 19:08:47 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-238-248-82-fibre.sparkbb.co.nz. [125.238.248.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d67757sm45027845ad.36.2024.09.29.19.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 19:08:47 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id CDFB2360370; Mon, 30 Sep 2024 15:08:43 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: uli@fpond.eu
Cc: cip-dev@lists.cip-project.org,
	linux-m68k@vger.kernel.org,
	geert@linux-m68k.org,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v4 1/2] m68k: Handle arrivals of multiple signals correctly
Date: Mon, 30 Sep 2024 15:08:39 +1300
Message-Id: <20240930020840.15226-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240930020840.15226-1-schmitzmic@gmail.com>
References: <20240930020840.15226-1-schmitzmic@gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Sep 2024 02:12:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16932

From: Al Viro <viro@zeniv.linux.org.uk>

[Upstream commit 4bb0bd81ce5e97092dfda6a106d414b703ec0ee8]

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


