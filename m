Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D635FC48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 22:13:06 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.4837.1707253890225818726
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 13:11:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=epdBGFrd;
 spf=pass (domain: gmail.com, ip: 209.85.214.179, mailfrom: schmitzmic@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d72f71f222so49801525ad.1
        for <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 13:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707253889; x=1707858689; darn=lists.cip-project.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zEkVGjcaygh1vK+ux9W8nA0sI6zRg3ppOKoN4fJJ6BY=;
        b=epdBGFrd04HY2yWT+r0B8d/u9yVD6KubHgHuuVBphzApifSw21AshTAwy6u0pwTtj6
         L3ObSG0zlKbvloLhku5Z28S4Ijg05sYE9AXLa05ctgJK+yMch6oPIA/NVBsj3+OTfHR5
         wXMI+Q/g1tsdZNZ2+YyMNJ4qiR3PknUFvuUolbnSiWyn9XXyiUVaKbGGuHuVaJSafP9d
         cbnaa4kbW8ZWhj59GrVhPPMxEJo8Tro6AELucyUCY4N/o1wXy5VHTsN+7VWsNBG10GvT
         LwuwWH1DsbHzflMjWPWCwqFRPSGQ2kO4HJPzk0Bj0AEwoFGPMAUDeGDKa5X4p68qjl/3
         uPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707253889; x=1707858689;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEkVGjcaygh1vK+ux9W8nA0sI6zRg3ppOKoN4fJJ6BY=;
        b=TJCMxKYxGo7UtS6PXzyiNn+wzyJ9aHCsIVxzf8OxSwlOUZLcMa9mnPuiEO4ZGfHtyS
         BcSK1Wmvl4sfTTvCkTIHQwtrNCEuUVmwBZaQqWTGsrJQK78jBeg6SxaIvXPqxWwcSlk7
         VO1Rt7aIAbat+yhCRYeQiUYGdGAjZWTBd1PXzw0Cpb8tF40hVFFjPuLsIT/jYr6m9Ti+
         o2RJNtClQQ7kCTdVTBOR5gXs9rGCNWNZTcLLSkKrcOO/okt4drGbzjsZTKe1aHJnQbXW
         H7D6zoB87AhzaRaIO+Q/7Rhp2Ib+0cAbVPs0soLYOEzOAZ38cveUhtBIiBsX5kfKniSV
         cd8A==
X-Gm-Message-State: AOJu0Yyf6O4x40iy30r10RfOrEtCauJOVmnuYa52Km8LmLSrmIuJ9FPw
	lJ2r78oGcwmlHSUFpsLWw40ycnu+3JFBmUoDU9yTSDRZCNCC7x2Z
X-Google-Smtp-Source: AGHT+IEVQDpeGqRX22t/ElsW8RVyxONGy4C+c2+QfoHZNzG1ccDB+F+iYeDyXg7VzHseI/q1LvZGrA==
X-Received: by 2002:a17:902:efd2:b0:1d8:cd7b:85fa with SMTP id ja18-20020a170902efd200b001d8cd7b85famr2318976plb.68.1707253889636;
        Tue, 06 Feb 2024 13:11:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzLlR6223QIn6MzrC/9SXgXI21u6PCORwYuzJgobLZeAKGj3zgYW6clQvx+D3k2gsVQFSo9c5fPJU2Cqo435rbDD4pCeEJ3nvWskbpszt9OwiELhBLTdIr1tu/eS35/sh5PcjWOYhZgXzzdBzY7Pcj1kNjioeOZL23QNLJyJi9YuZdVHOpNnlAeOn6ns0UIik+D+LjDENvXdLZMbV9IVzbuQ==
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id mg3-20020a170903348300b001d91b617718sm2360050plb.98.2024.02.06.13.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:11:28 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 59652360444; Wed,  7 Feb 2024 10:11:24 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org
Cc: geert@linux-m68k.org,
	uli@fpond.eu,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	cip-dev@lists.cip-project.org,
	Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v3 7/8] m68k: fix livelock in uaccess
Date: Wed,  7 Feb 2024 10:11:03 +1300
Message-Id: <20240206211104.26421-8-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240206211104.26421-1-schmitzmic@gmail.com>
References: <20240206211104.26421-1-schmitzmic@gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 22:13:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14838

From: Al Viro <viro@zeniv.linux.org.uk>

commit bd75497a77ccae9a5e1b0f1a3fa8283d67b21f4c upstream.

m68k equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
to page tables.  In such case we must *not* return to the faulting insn -
that would repeat the entire thing without making any progress; what we need
instead is to treat that as failed (user) memory access.

Tested-by: Finn Thain <fthain@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[MSch: v4.4 backport compile errors fixes]
Cc: <cip-dev@lists.cip-project.org> # 4.4
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 6a94cdd0c830..f94df64c3784 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -139,8 +139,11 @@ good_area:
 	fault = handle_mm_fault(mm, vma, address, flags);
 	pr_debug("handle_mm_fault returns %d\n", fault);
 
-	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
+		if (!user_mode(regs))
+			goto no_context;
 		return 0;
+	}
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
-- 
2.17.1


