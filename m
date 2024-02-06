Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65A9C4829A
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 22:13:06 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.4721.1707253888541034001
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 13:11:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FjrcPNQo;
 spf=pass (domain: gmail.com, ip: 209.85.215.177, mailfrom: schmitzmic@gmail.com)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d3907ff128so5309568a12.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 13:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707253888; x=1707858688; darn=lists.cip-project.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dGqIsAq8M3OyZBp1sy4dZz2sGDg3iZRmY3s8GmeRm7w=;
        b=FjrcPNQoz1ij1Dj0NynUg09d2pJ0TCvWxs1REpCHi2u94VN4uT39fsa7AoR6+gBm3y
         24/101uTDRcCqU4FDYPqSSBxOJ7d1nRbY6owKzrP94m72RwBDqXw6lXfIFqlHuv42GRh
         6H0UOLdpulwMk3OJSnSwBZhTkEge0PP0PfNP8qzzk8uYqAj0cn3HXEDX5sqC/43oMPEb
         r0AK4L7XLlFY59czFW6g8DKvQsu9W+TrT0cR9+i1Zelu5DpqRF2pZpQ93EujS/vBTRKd
         Hg/n6l7thxZXYt+H7MT8M6d2E4e2bmMww/CglMYRrHtVQlBOwuuYjYvRu3b3e2SrZJrW
         axSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707253888; x=1707858688;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGqIsAq8M3OyZBp1sy4dZz2sGDg3iZRmY3s8GmeRm7w=;
        b=G9AOND++sdperUGCmTrFy5u6iqO4XNUV2AOASe7MR4gsShjgQZwXEhRO/U9WcJAPCw
         kzxZ4faLatBmiFbsHJlKHGzHeoO2TUgPkOiSD95KO+T82LrcrL8Ywyl4RLybmxKLs17/
         fLTAZb9zUBnf+OzI8H2JKO0KkQ6oCOAebIbBSeL8+rgXs5w1P+RnmElBFmiloV+3PTOd
         fjxASP1GjXZgloAOwKozWzoKP38shHvUhKz9YbYv9K1HMDmYU8ymbylss6FmgqI3750y
         Ylw+2XeNi6wK8c7sfaZT1Ui/LIO4Ku9J20csHHd3WI0G24rSW8e6OUPRXnI5UuSTDlhv
         XsYQ==
X-Gm-Message-State: AOJu0YwPrs1Z7bDj+AJi8kHo6KJGFx4dzXZdQxUn5f6XB2P+uUqmQgbs
	cXSQeFwZb9RDNi1S3rzmUQwp7Jq9LfcX/d33wPVinRJSVRws7VXU
X-Google-Smtp-Source: AGHT+IH+QT+iIUzRQ5L3D+fdqUUCQUSYHYayCHZOru0HudI73qg4Za4o4/+PZss825mYq5VG/3ntuA==
X-Received: by 2002:a05:6a20:94cf:b0:19c:a887:e945 with SMTP id ht15-20020a056a2094cf00b0019ca887e945mr3285646pzb.45.1707253887962;
        Tue, 06 Feb 2024 13:11:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUWgSG2vQUtABNHYDEEK8r/AD4F8FwL0+d86HtZAXEtm3maMn8ROfffQrMoZVXb9Lu8mdYaRgx0Qb5Nun3d+DwZWB449TREWxZzmdwQ1P+Vb3uVgSU4PogZFhvvXhHQPYhArLaoZIqQ/NQn0EFr/DBLWS2MfsJi2e5OA8XeQJcnhfEsQaRpQUL2NyJNTppzGz5ihi6ET26WKPZx6Ztksf6rRQ==
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id p12-20020a62ab0c000000b006dffb3e4d78sm2434433pff.85.2024.02.06.13.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:11:26 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id DD91236035C; Wed,  7 Feb 2024 10:11:22 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org
Cc: geert@linux-m68k.org,
	uli@fpond.eu,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	cip-dev@lists.cip-project.org,
	Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v3 5/8] m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
Date: Wed,  7 Feb 2024 10:11:01 +1300
Message-Id: <20240206211104.26421-6-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240206211104.26421-1-schmitzmic@gmail.com>
References: <20240206211104.26421-1-schmitzmic@gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 22:13:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14837

From: Al Viro <viro@zeniv.linux.org.uk>

commit 50e43a57334400668952f8e551c9d87d3ed2dfef upstream.

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


