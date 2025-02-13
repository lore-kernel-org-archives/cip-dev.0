Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FC1C0219D
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 08:14:59 +0000 (UTC)
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mx.groups.io with SMTP id smtpd.web10.5953.1739431473360861867
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Feb 2025 23:24:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=aAatJcU8;
 spf=none, err=SPF record not found (domain: linux-m68k.org, ip: 202.12.124.151, mailfrom: fthain@linux-m68k.org)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 42BD8114011B;
	Thu, 13 Feb 2025 02:24:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 13 Feb 2025 02:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1739431472; x=1739517872; bh=r29dMPQRv+Gn3SilhPT9HklbBYac
	hEKIULVz8FVwt98=; b=aAatJcU8MVcwlYQfRJJewVuUBG5Lo5Y9kjsfYa2X1Kjn
	y39vSYPIQrNAInReHI5LFANC8Gv6BAZ4vhUuLR7FSkCrsNag1ThNuSXp9ma/x6eh
	VerXHJfbQAjrwpRCaHdjTmYtxlcLlaqeWt0RRM6O/UkIco5pptME/Uyz3YOoSsK1
	hoa6dFe4rajdJGQfqXZ0Ry6mVxvv4UY289NhA0EXJMrtDgiZcy059Z/XFZtTRmbK
	Tx9zEJ3ziSAqwFmI3K+XX03S+W1muworEP+sLqtVOR10uoGiQzfPaEXHJtIcQPbF
	XAtcMqYSBcTaSXU/SuTP1x54ixfxQJ/lyWgpmV8NaA==
X-ME-Sender: <xms:L56tZ8SRB8uVZnwXokuMmtGkFOTuuFaCn_KcT0DcJtong-ijxBOxZQ>
    <xme:L56tZ5xE1d9mFatdKJ16DPlMp8lLK32Jkrlp6p3qGWaQv9zXc_-_WpZ-WryqPpe-A
    fdZMv9i6qKMywyMmz4>
X-ME-Received: <xmr:L56tZ522omhBSQiziDA73PH9dQkmbU_yyK8r-t-MAQiGMjnJlAO7MNbPn47Fow_4ArtGNc3mORYQC-kWyalHVSB9lVWiMWf3Qi8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhho
    mhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepheetuddufffgfeekkeejudeivdfgfedtleetkeduleek
    ueefhfevueekkeeftdeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvghnthhrhi
    drshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    fhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhosghuhhhirhhouddrihifrghmrght
    shhusehtohhshhhisggrrdgtohdrjhhppdhrtghpthhtohepphgrvhgvlhesuggvnhigrd
    guvgdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhr
    tghpthhtohepshgthhhmihhtiihmihgtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    hiphdquggvvheslhhishhtshdrtghiphdqphhrohhjvggtthdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:L56tZwA7-IAJV3rwJSdrYzCA899HJ7ElpqLUCJQivTST_jL6CZrPfQ>
    <xmx:L56tZ1jj9o6U3Dm24y43-ki4x018NGz1rj238TS6LpsXXEnKksSXJg>
    <xmx:L56tZ8p4ZhVE3jYqL-IceG8ANuJNfRYOe-t2qTVB3iVgc1yHbReKYw>
    <xmx:L56tZ4h7_CV6BEcZ51xGkeXdjecx3Qzpd4gq9kGe10o0zCL0HT283g>
    <xmx:MJ6tZza8CkFY5bhQ_PkeAi547Eq1WANr4pJ4dRo0RJAFGxk9gg7uTN3u>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 02:24:29 -0500 (EST)
Date: Thu, 13 Feb 2025 18:24:25 +1100
Message-ID: <ae36f60ef22ffab915673f0c6854c812@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Michael Schmitz <schmitzmic@gmail.com>, cip-dev@lists.cip-project.org, linux-m68k@lists.linux-m68k.org
Subject: [PATCH 4.19.y-cip] m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Feb 2025 08:14:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17825

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 50e43a57334400668952f8e551c9d87d3ed2dfef ]

We get there when sigreturn has performed obscene acts on kernel stack;
in particular, the location of pt_regs has shifted.  We are about to call
syscall_trace(), which might stop for tracer.  If that happens, we'd better
have task_pt_regs() returning correct result...

Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: bd6f56a75bb2 ("m68k: Missing syscall_trace() on sigreturn")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Finn Thain <fthain@linux-m68k.org>
Link: https://lore.kernel.org/r/YP2dMWeV1LkHiOpr@zeniv-ca.linux.org.uk
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 417d8f0e8962..0d03b4f2077b 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -182,6 +182,8 @@ ENTRY(ret_from_signal)
 	movel	%curptr@(TASK_STACK),%a1
 	tstb	%a1@(TINFO_FLAGS+2)
 	jge	1f
+	lea	%sp@(SWITCH_STACK_SIZE),%a1
+	movel	%a1,%curptr@(TASK_THREAD+THREAD_ESP0)
 	jbsr	syscall_trace
 1:	RESTORE_SWITCH_STACK
 	addql	#4,%sp

