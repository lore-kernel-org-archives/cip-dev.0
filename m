Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBC8C0219D
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 08:14:49 +0000 (UTC)
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mx.groups.io with SMTP id smtpd.web11.5829.1739431340488429172
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Feb 2025 23:22:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=kNWS3SbL;
 spf=none, err=SPF record not found (domain: linux-m68k.org, ip: 202.12.124.152, mailfrom: fthain@linux-m68k.org)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61B9F25401C9;
	Thu, 13 Feb 2025 02:22:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 13 Feb 2025 02:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1739431339; x=1739517739; bh=Kpjd1dlpYPRSKTDwyzlMgPlazmO2
	anW6vzHpGHs+Oh4=; b=kNWS3SbLGWStOPPJO0SlYTz/8fzOGsrAa8oGcFfNYl9u
	Kz8Le1WruD8VVgeAeSxgyFR+UJobntfUJ6mdIYPr9lESwIjpEEBd/cChXh7MQaa+
	U9UPipSb+jogXv/se/VFuhMDUssu6XAsRrpcyVU4s7h/n+YxQ5sw4mVWsQjYmtbx
	NzBp+uwpQa92Majo5w+eD4/PXaaCt4M7XQCYKGkodR+ImwOFsXnh0qSDZZ6RH8xe
	bZ5bqgreFM+fllPCFMl8AIm1VyZrcHGaJ2hzlJtbscV2EtIRFkZpEf2doc3IjkfN
	RoTB+tkMxkMO0NuCiZldjfceMjAeGyGbHM/2XGWOrg==
X-ME-Sender: <xms:qp2tZ-G_e1GLOCDuYbe7P7ziLbAvzBQnlBcq6ZZ38fEqUiA_SlVzVg>
    <xme:qp2tZ_X0dikGXoLbRWDhgnIlK_K1Y9F_wOc-zt6xVaolnGQwyj0wiVtn4wdFxEC98
    mJRWg70x1yFpf6ELbE>
X-ME-Received: <xmr:qp2tZ4LC9sYoTxP4JCrVilNTFKm-XQM6FbOwtXtlQP6m9zQQjNJxvRCvz8kPSjTwSwq_bv-xHGeqEVm-goasgQtFG2iuSjLIvwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhho
    mhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
    eqnecuggftrfgrthhtvghrnheptdfhleduudejjefgvdetfeeijedtfeeukeduteeuffeu
    veejieevhefgleeuffffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshhkvghlvg
    htohhnrdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhope
    ehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehulhhisehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpth
    htohepshgthhhmihhtiihmihgtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghiphdq
    uggvvheslhhishhtshdrtghiphdqphhrohhjvggtthdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:qp2tZ4EJjbplaQNIYZ3kr3rM8sOibNq6tJXmIrHNISop_i9cacW1Mg>
    <xmx:qp2tZ0W2xgEhyuQw5FoFzbijqUWLFiOciZIQ4PaIozCinECBswiHCA>
    <xmx:qp2tZ7M14KccSDU79SWSJXLIlDTY0oyAXxixXr5ugFZhOqzwtkd0Cg>
    <xmx:qp2tZ71AVxh_yAxQL-XP4PoaH6ay7WPSsFFDc_MQXF_xxWjcRphvwQ>
    <xmx:q52tZyxKt2fgswWk9zY3cEpkpoyJ6O0lLjKhKfuQs52TkS3t4VZfzeDF>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 02:22:16 -0500 (EST)
Date: Thu, 13 Feb 2025 18:22:09 +1100
Message-ID: <72a512bd5463ee04f4840f49cee2f3c3@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: Ulrich Hecht <uli@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Michael Schmitz <schmitzmic@gmail.com>, cip-dev@lists.cip-project.org, linux-m68k@lists.linux-m68k.org
Subject: [PATCH 4.4.y-cip] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Feb 2025 08:14:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17823

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit a3616a3c02722d1edb95acc7fceade242f6553ba ]

In the fpsp040 code when copyin or copyout fails call
force_sigsegv(SIGSEGV) instead of do_exit(SIGSEGV).

This solves a couple of problems.  Because do_exit embeds the ptrace
stop PTRACE_EVENT_EXIT a complete stack frame needs to be present for
that to work correctly.  There is always the information needed for a
ptrace stop where get_signal is called.  So exiting with a signal
solves the ptrace issue.

Further exiting with a signal ensures that all of the threads in a
process are killed not just the thread that malfunctioned.  Which
avoids confusing userspace.

To make force_sigsegv(SIGSEGV) work in fpsp040_die modify the code to
save all of the registers and jump to ret_from_exception (which
ultimately calls get_signal) after fpsp040_die returns.

v2: Updated the branches to use gas's pseudo ops that automatically
    calculate the best branch instruction to use for the purpose.

v1: https://lkml.kernel.org/r/87a6m8kgtx.fsf_-_@disp2133
Link: https://lkml.kernel.org/r/87tukghjfs.fsf_-_@disp2133
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
[ Pass 'current' to force_sigsegv() as was done prior to v5.3 ]
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/fpsp040/skeleton.S | 3 ++-
 arch/m68k/kernel/traps.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index 31a9c634c81e..081922c72daa 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -502,7 +502,8 @@ in_ea:
 	.section .fixup,"ax"
 	.even
 1:
-	jbra	fpsp040_die
+	jbsr	fpsp040_die
+	jbra	.Lnotkern
 
 	.section __ex_table,"a"
 	.align	4
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 35f706d836c5..c6f18dc5884b 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1155,7 +1155,7 @@ asmlinkage void set_esp0(unsigned long ssp)
  */
 asmlinkage void fpsp040_die(void)
 {
-	do_exit(SIGSEGV);
+	force_sigsegv(SIGSEGV, current);
 }
 
 #ifdef CONFIG_M68KFPU_EMU

