Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5DCF6498
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 02:12:16 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.45466.1727662130170462946
 for <cip-dev@lists.cip-project.org>;
 Sun, 29 Sep 2024 19:08:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VkT+Yc3B;
 spf=pass (domain: gmail.com, ip: 209.85.214.180, mailfrom: schmitzmic@gmail.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b58f2e1f4so8887065ad.2
        for <cip-dev@lists.cip-project.org>; Sun, 29 Sep 2024 19:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727662129; x=1728266929; darn=lists.cip-project.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/70Zs3YHFHg9RhOzKW5Rn7Mss8iTVJTOhn7H6pZSJvg=;
        b=VkT+Yc3BwuSyvzaUf7U6nRhhZdi8+qR21AU5/VmllcxW5fVzK7nfrOH09NTSz2+yH4
         2Cr5gMHCpi56UdVcbFqjN+QDDEXvV85bHaihoccuGPTxan7Rtv3Ik7/apMrdzflQhQt0
         RrV4PVS85hajHKzRVTDn9BDHbuASaS5j345pdGGIoO4hn5uZtCJJrUMqSIT8EBeoTdy1
         r+iF5X3o0JeWAFcDbayEteov1xiXEGmBb/N/guC7lLhUZxjVeOC1OLfUI0bM6nQNr2dX
         /tu+aWf8ua/Bz5BunMSID4A6A2CUYc5NorfKdIMbS3NLGT3wSCq854zCDqZ3hKF5mCiX
         HOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727662129; x=1728266929;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/70Zs3YHFHg9RhOzKW5Rn7Mss8iTVJTOhn7H6pZSJvg=;
        b=rvRIsvRqtBy6aTJT9zch/ryPptUKwCBJ2IUF69GHCUeYSxCRHM+uXE47L0FC9frtdq
         xId5zX1dQxNqnCmOBQjMCXNb02cgq/HXMq74uLK3XfmmUwVBT6saw1sKkZAvOP50lsNp
         m6e0PuOpyG9YpkJB37TTAvj0eJTqkeZwfahvVcpVQ7dQVewhq9FgfHmFOgKQHaaPtU0k
         /DNYxe68++79+btWyaygzEjXISqbYt0AEXRwfDa9Dvxqt4wYGh+XEWBCiJ566ICKF68/
         f0DUHeM8p1/EaOmQ+Vc/+6vHRHPz/7DPhXqqMVsRy2EEB5IWu2gDCjPUXL66yK6RBOxK
         4Qvg==
X-Gm-Message-State: AOJu0Yz77eXcodpU1QbG32rgQLGIUEqSo83e1tkCwY7ZUswfro9rsXxB
	Hu2ehIXL4CP2ZhPSk4/Pl79UtWo9XBgLZWUcd9QmAdzGDqXS6klVG0ZQXg==
X-Google-Smtp-Source: AGHT+IF5049lFqXnzcP9ynG6rXNLrZJr15+AT37SC24CuRYmHNihPseVPyS0lZtO2D0o43hS8656yg==
X-Received: by 2002:a17:902:e5cf:b0:1fa:1dd8:947a with SMTP id d9443c01a7336-20b37b91636mr141715945ad.46.1727662129435;
        Sun, 29 Sep 2024 19:08:49 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-238-248-82-fibre.sparkbb.co.nz. [125.238.248.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0ef3asm44954785ad.121.2024.09.29.19.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 19:08:48 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 84CC43603D9; Mon, 30 Sep 2024 15:08:44 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: uli@fpond.eu
Cc: cip-dev@lists.cip-project.org,
	linux-m68k@vger.kernel.org,
	geert@linux-m68k.org,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v4 2/2] m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
Date: Mon, 30 Sep 2024 15:08:40 +1300
Message-Id: <20240930020840.15226-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240930020840.15226-1-schmitzmic@gmail.com>
References: <20240930020840.15226-1-schmitzmic@gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Sep 2024 02:12:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16933

From: Al Viro <viro@zeniv.linux.org.uk>

[Upstream commit 50e43a57334400668952f8e551c9d87d3ed2dfef]

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
Cc: <cip-dev@lists.cip-project.org> # 4.4
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index b54ac7aba850..dbeba043b703 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -173,6 +173,8 @@ ENTRY(ret_from_signal)
 	movel	%curptr@(TASK_STACK),%a1
 	tstb	%a1@(TINFO_FLAGS+2)
 	jge	1f
+	lea	%sp@(SWITCH_STACK_SIZE),%a1
+	movel	%a1,%curptr@(TASK_THREAD+THREAD_ESP0)
 	jbsr	syscall_trace
 1:	RESTORE_SWITCH_STACK
 	addql	#4,%sp
-- 
2.17.1


