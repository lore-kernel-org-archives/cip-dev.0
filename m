Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6305C48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 22:12:46 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.4832.1707253879073683986
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 13:11:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=emUWwE4r;
 spf=pass (domain: gmail.com, ip: 209.85.214.177, mailfrom: schmitzmic@gmail.com)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7881b1843so54910135ad.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 13:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707253878; x=1707858678; darn=lists.cip-project.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I2CG33VPPpXBW0bT6gJ7H7D26BUksG/NvgMt6SM3LZM=;
        b=emUWwE4rG8Ftdg74cqpsULthWdnyBvAnYE6tFZTMQHNJUdqYuMWoMzGwQzLZM0hH12
         JPN7k667HNPlmratxntaWqo5BfxXUIFBwgYcjGESUO1FBbLntOYqSCZU6qQU+pqKgyGo
         3Y2Rk/PJV3G7HDtZ86jNmd9JuGjns1qDxIwBgLxD994jjbNFQV1dPKzSUcIsXqTVb1X1
         XKHMmOEFz2G464Jc9O/8hfBlCa/06qVI3VzAeIaqih5vM3ljGlWWFEP7MYpKocXzT4aK
         s2wKdiT83pJDDvcTeY+Kj17L523JPNTJUvBy3lidIygsYkmMNdfkz6yfCWkFTqy+9sP9
         BX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707253878; x=1707858678;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2CG33VPPpXBW0bT6gJ7H7D26BUksG/NvgMt6SM3LZM=;
        b=m5MyP5aVq54n/G7h/5qHdjUOo+97aKG6gMF99w/ryZIm1HpaGOBxbH9V2dYnZPLhQP
         B2NRvrTi4W3Kt3cDkzxjk/Hn0lsGOjHJ9mMuss0DvvKt8ntnS6WRz1yCEing9zdSWor+
         /2lENTpX+g3fmSfZktCruY8W1X75DVfi2lgZ6bH1/hvhpDVxSqj3+MTJP8QUbLv7Gp6q
         lvRDzAzdyn5kZkyKUe6AXIK7r6ZY5Z2kUm6Cn2/k7UEet1C0IL7kXeumNH2Rp5/2LpNV
         3Lyzpmz73D28Q1NUqC4Dynx+Gq/cKEPcGGd0HMsurthFERCwv298AHDVSJVaBOXsoo0L
         jjcA==
X-Gm-Message-State: AOJu0Yy0xtaUNV1NEb+OjWcgKckdmV9m24yAzhwgVXWWdu0zzpvmFyY7
	48xCvp8KflocAWJVlgDUU/6uBv7kuBjl8qsn5M6+1NOhK5yGV48K
X-Google-Smtp-Source: AGHT+IGVeb5RZpfylDVMc7uFzF0bFVYLKe4HdkLjmpP7649rzmcsyMIf+ArF8LarY9xNjUUvum2wXQ==
X-Received: by 2002:a17:90b:1bc2:b0:296:a746:67f5 with SMTP id oa2-20020a17090b1bc200b00296a74667f5mr713716pjb.44.1707253878470;
        Tue, 06 Feb 2024 13:11:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5VIR9m9MMf8pmz/Juke+rIkiaThYJzHJEqOC6aLZ9e2M+FwS4sPB2eyROhKpqeAHdIkbPQy2JINmb71r9IAgdX4igZZDAs3slsD2qWziJjP51PAEccx8LWS+M1b2XHsOAQW8nETQFLTVwyfZMKjNLdGW+H0GH+lVta8YAKMl8wyRejRxG5qCyXKC1LrSmpMtYgEZQW89ZewsAwjsJPJbWycuIzCPX40cyUwyZW1iWp8JE37FBsk/fcw==
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090a468600b002961ccd55e4sm2143578pjf.31.2024.02.06.13.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:11:17 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id B2A2036031F; Wed,  7 Feb 2024 10:11:13 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org
Cc: geert@linux-m68k.org,
	uli@fpond.eu,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	Michael Schmitz <schmitzmic@gmail.com>,
	stable@vger.kernel.org,
	cip-dev@lists.cip-project.org
Subject: [PATCH v3 1/8] m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()
Date: Wed,  7 Feb 2024 10:10:57 +1300
Message-Id: <20240206211104.26421-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240206211104.26421-1-schmitzmic@gmail.com>
References: <20240206211104.26421-1-schmitzmic@gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 22:12:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14834

commit 3f90f9ef2dda316d64e420d5d51ba369587ccc55 upstream.

If 020/030 support is enabled, get_io_area() leaves an IO_SIZE gap
between mappings which is added to the vm_struct representing the
mapping.  __ioremap() uses the actual requested size (after alignment),
while __iounmap() is passed the size from the vm_struct.

On 020/030, early termination descriptors are used to set up mappings of
extent 'size', which are validated on unmapping. The unmapped gap of
size IO_SIZE defeats the sanity check of the pmd tables, causing
__iounmap() to loop forever on 030.

On 040/060, unmapping of page table entries does not check for a valid
mapping, so the umapping loop always completes there.

Adjust size to be unmapped by the gap that had been added in the
vm_struct prior.

This fixes the hang in atari_platform_init() reported a long time ago,
and a similar one reported by Finn recently (addressed by removing
ioremap() use from the SWIM driver.

Tested on my Falcon in 030 mode - untested but should work the same on
040/060 (the extra page tables cleared there would never have been set
up anyway).

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
[geert: Minor commit description improvements]
[geert: This was fixed in 2.4.23, but not in 2.5.x]
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stable@vger.kernel.org
Cc: <cip-dev@lists.cip-project.org> # 4.4
---
 arch/m68k/mm/kmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/mm/kmap.c b/arch/m68k/mm/kmap.c
index 6e4955bc542b..fcd52cefee29 100644
--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -88,7 +88,8 @@ static inline void free_io_area(void *addr)
 	for (p = &iolist ; (tmp = *p) ; p = &tmp->next) {
 		if (tmp->addr == addr) {
 			*p = tmp->next;
-			__iounmap(tmp->addr, tmp->size);
+			/* remove gap added in get_io_area() */
+			__iounmap(tmp->addr, tmp->size - IO_SIZE);
 			kfree(tmp);
 			return;
 		}
-- 
2.17.1


