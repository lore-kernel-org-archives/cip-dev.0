Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86736C3ABC9
	for <webhook@archiver.kernel.org>; Sun, 18 May 2025 23:41:39 +0000 (UTC)
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mx.groups.io with SMTP id smtpd.web11.9229.1747387667574357926
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 May 2025 02:27:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=hA912So5;
 spf=none, err=SPF record not found (domain: linux-m68k.org, ip: 103.168.172.145, mailfrom: fthain@linux-m68k.org)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4471A1380417;
	Fri, 16 May 2025 05:27:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 16 May 2025 05:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1747387666; x=1747474066; bh=Kpjd1dlpYPRSKTDwyzlMgPlazmO2
	anW6vzHpGHs+Oh4=; b=hA912So5ClnzbPClaC8NbxtYoJCiS+3BkXsTTosZvPGx
	KxC7MuxOpIykSodpezlaz2Mn4trZIXB6zQn2NPwk4NiqiqX/FiGbzMj2KpudAVCV
	GcyoW0FpzslZTblj/+tsqGAft4tVcUluUkxy8E6+7hPdEjdAr//CT89DBjwrBkMH
	SjQKeaDF9EZ9wZFyAef8dSBmAQod/3OrFL/xynahuRJGfLv9DDbUXHH+R6cyMpJE
	GWUcAP3bfRSoaPIINGe3inq79g/ViLg1gOnRiDtRJmYWfKhzmj1sFgagwDXTKl9G
	gzhr096eQowfBUeID/j7e9DHxpg2g2Dvdpc7egCHQw==
X-ME-Sender: <xms:EAUnaHkfIMmb_EHZ0NK2wqZ-pVqrvtjX3819vC1p_2OWF7seqTQkTg>
    <xme:EAUnaK04driUOW4-6iYDwToIrKpbTu30hf2XkAiNeY3kEl6b6M0e2IOlDvWKWV-1z
    P01RPZp23_5KP5FbYg>
X-ME-Received: <xmr:EAUnaNrnHf4C-57JyiT58aY8SnJCqguFHysG_xLgBqsZnPbR1wDbcwRMvWxjTwrMUGFM8Sgybs5GWCjbS6sEpNfTKJl8gzJGzfo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffkhffvvefusedttdhjtddttddtnecuhfhr
    ohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorh
    hgqeenucggtffrrghtthgvrhhnpedthfeluddujeejgfdvteefieejtdefueekudetueff
    ueevjeeiveehgfelueffffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhskhgvlh
    gvthhonhdrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtoh
    epiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhosghuhhhirhhouddrihif
    rghmrghtshhusehtohhshhhisggrrdgtohdrjhhppdhrtghpthhtohepphgrvhgvlhesug
    gvnhigrdguvgdprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhm
    pdhrtghpthhtohepshgthhhmihhtiihmihgtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghiphdquggvvheslhhishhtshdrtghiphdqphhrohhjvggtthdrohhrghdprhgtphht
    thhopehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:EAUnaPn_5B424QGthSJFLAscFvja3TmYWr84LY47wTOANgXjYbwQzQ>
    <xmx:EQUnaF13Sgk1ewVeYDzzFgexWU39zPaAGlKiy1B7Io_E0EBCHuYlUg>
    <xmx:EQUnaOv8lAzvW2s4GAfcRyHTK70veswGzA_G330PynRvkYLbSp-D0A>
    <xmx:EQUnaJVj7JveIgies1YAnBKxAJ0JVUQK6gVY0BHcCU1KV5bFn6SgDQ>
    <xmx:EgUnaLUojtlx9f33YS2aTDeDwp5Z_PK34N81DnTWlDWa2XF9uQ41qK-D>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 05:27:43 -0400 (EDT)
Date: Fri, 16 May 2025 19:28:12 +1000
Message-ID: <288cd2e42b6d4cbf77822cce3b348d6f@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
Cc: Eric W. Biederman <ebiederm@xmission.com>, Michael Schmitz <schmitzmic@gmail.com>, cip-dev@lists.cip-project.org, linux-m68k@lists.linux-m68k.org
Subject: [PATCH RESEND 4.19.y-cip] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 18 May 2025 23:41:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18922

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


